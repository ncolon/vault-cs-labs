#!/bin/bash

BASEPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
export CLUSTERNAME=vault-primary

CERTS="${BASEPATH}/certs"
VOLUMES="${BASEPATH}/volumes"
TEMPLATES="${BASEPATH}/templates"


if [[ $USER == "itzuser" ]] ; then
    umask 022
fi

while getopts "c:u" opt; do
  case ${opt} in
    c) export CLUSTERNAME=${OPTARG} ;;
    u) export UNSEAL=true
  esac
done

function checkVaultLicense() {
  local LICENSE=$1
  test -e $LICENSE && {
    echo "INFO: vault license found: $LICENSE"
  } || {
    echo "Unable to find $LICENSE"
    echo "Download the vault.hclic license file from https://ibm.biz/hc-ent-keys and place it on $BASEPATH"
    exit 1
  }
}

function buildVaultImage() {
  ARCH=$(uname -m)
  case $ARCH in
      x86_64)
          ARCH_ALIAS=amd64
          ;;
      aarch64)
          ARCH_ALIAS=arm64
          ;;
      arm64)
          ARCH_ALIAS=arm64
          ;;
      *)
          echo "Unsupported architecture: $ARCH" && exit 1
          ;;
  esac
  echo podman build --build-arg ARCH=$ARCH_ALIAS -t vault-enterprise vault-image || exit 1
}

function generateCA() {
    local CERTS=$1
    test -e "${CERTS}" || mkdir -p "${CERTS}"
    test -e "${CERTS}/ca-cert.pem" && {
      echo "INFO: ${CERTS}/ca-cert.pem exists, skipping root CA generation"
    } || {
      echo "INFO: generating root CA"
      openssl genrsa 2048 > "${CERTS}/ca-key.pem"
      openssl req -new -x509 -nodes -days 365000 -key "${CERTS}/ca-key.pem" -out $CERTS/ca-cert.pem \
        -subj "/C=US/ST=North Carolina/L=Raleigh/O=IBM/OU=WW CS/CN=ca.authority"
    }
}

function generateCertificates() {
  local CERTS=$1
  local CLUSTERNAME=$2
  IP_LIST="IP.1:127.0.0.1"
  if [[ ! -z $PUBLIC_IP ]] ; then
    echo "INFO: PUBLIC_IP=$PUBLIC_IP, will add to IP address SAN"
    IP_LIST=$"IP.1:127.0.0.1,IP.2:$PUBLIC_IP"
  fi
  openssl req -newkey rsa:2048 -nodes -days 365000 -keyout $CERTS/${CLUSTERNAME}-tls.key -out $CERTS/${CLUSTERNAME}-tls.csr \
    -subj "/C=US/ST=North Carolina/L=Raleigh/O=IBM/OU=WW CS/CN=${CLUSTERNAME}" \
    -addext "subjectAltName=DNS.1:${CLUSTERNAME},DNS.2:${CLUSTERNAME}-1,DNS.3:${CLUSTERNAME}-2,DNS.4:${CLUSTERNAME}-3, \
            DNS.5:vault.server,DNS.6:localhost,DNS.8:haproxy-${CLUSTERNAME},${IP_LIST}" \
    -addext 'basicConstraints=critical,CA:FALSE' \
    -addext 'keyUsage=digitalSignature' \
    -addext 'extendedKeyUsage=serverAuth'
  openssl x509 -req -days 365000 -in $CERTS/${CLUSTERNAME}-tls.csr -out $CERTS/${CLUSTERNAME}-tls.crt \
      -CA $CERTS/ca-cert.pem -CAkey $CERTS/ca-key.pem -copy_extensions copy
  rm $CERTS/${CLUSTERNAME}-tls.csr
}

function generateContainerVolumes() {
  local CLUSTERNAME=$1
  test -e ${BASEPATH}/${CLUSTERNAME}.yaml && rm ${BASEPATH}/${CLUSTERNAME}.yaml
  for i in $(seq 1 3); do
    export INSTANCE="${CLUSTERNAME}-${i}"
    cat ${TEMPLATES}/vault.yaml.template | envsubst >> ${BASEPATH}/${CLUSTERNAME}.yaml
    mkdir -p ${VOLUMES}/${INSTANCE}/tls ${VOLUMES}/${INSTANCE}/data
    chmod 755 ${VOLUMES}/${INSTANCE}/tls
    chmod 777 ${VOLUMES}/${INSTANCE}/data
    cp "${CERTS}/ca-cert.pem" ${VOLUMES}/${INSTANCE}/tls/ca.pem
    cp "${CERTS}/${CLUSTERNAME}-tls.key" ${VOLUMES}/${INSTANCE}/tls/tls.key
    cp "${CERTS}/${CLUSTERNAME}-tls.crt" ${VOLUMES}/${INSTANCE}/tls/tls.crt
    cp ${BASEPATH}/vault.hclic ${VOLUMES}/${INSTANCE}/
    cat ${TEMPLATES}/config.hcl.template | envsubst > ${VOLUMES}/${INSTANCE}/config.hcl
  done
  case ${CLUSTERNAME} in
      vault-dr)
          export PORT=8210 ;;
      vault-replication)
          export PORT=8220 ;;
      *)
          export PORT=8200
          ;;
  esac
  cat ${TEMPLATES}/haproxy.yaml.template | envsubst >> ${BASEPATH}//${CLUSTERNAME}.yaml
  mkdir -p ${VOLUMES}/haproxy-${CLUSTERNAME}
  cat ${TEMPLATES}/haproxy.cfg.template | envsubst > ${VOLUMES}/haproxy-${CLUSTERNAME}/haproxy.cfg
  cp "${CERTS}/${CLUSTERNAME}-tls.crt" ${VOLUMES}/haproxy-${CLUSTERNAME}/tls.crt
  cp "${CERTS}/${CLUSTERNAME}-tls.key" ${VOLUMES}haproxy-${CLUSTERNAME}/tls.crt.key

  chmod -R go+r $VOLUMES
}

function unsealVaultCluster() {
  if [[ $UNSEAL == "true" ]]; then
    local CLUSTERNAME=$1
    echo "INFO: Initializing and Unsealing $CLUSTERNAME"
    podman kube play "${BASEPATH}/${CLUSTERNAME}.yaml"
    sleep 5

    local INITFILE="${BASEPATH}/init-${CLUSTERNAME}.txt"
    podman exec -ti ${CLUSTERNAME}-1-vault-enterprise vault operator init | sed 's/\x1b\[[0-9;]*m//g' | tr - '\r' | tee "${INITFILE}"
    export VAULT_SEAL_KEY1=$(grep "Unseal Key 1" "${INITFILE}" | cut -d' ' -f4)
    export VAULT_SEAL_KEY2=$(grep "Unseal Key 2" "${INITFILE}" | cut -d' ' -f4)
    export VAULT_SEAL_KEY3=$(grep "Unseal Key 3" "${INITFILE}" | cut -d' ' -f4)

    podman exec -ti ${CLUSTERNAME}-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
    podman exec -ti ${CLUSTERNAME}-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
    podman exec -ti ${CLUSTERNAME}-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3
    sleep 2

    podman exec -ti ${CLUSTERNAME}-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
    podman exec -ti ${CLUSTERNAME}-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
    podman exec -ti ${CLUSTERNAME}-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3

    podman exec -ti ${CLUSTERNAME}-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
    podman exec -ti ${CLUSTERNAME}-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
    podman exec -ti ${CLUSTERNAME}-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3
  fi
}

function vaultCLISetup() {
  echo "================================================================"
  echo "To set up your vault environment, export the following variables"
  echo "export VAULT_ADDR=https://localhost:${PORT}"
  echo "export VAULT_CACERT=\"${BASEPATH}/certs/ca-cert.pem\""
  echo "export VAULT_TLS_SERVER_NAME=vault.server"
  echo "================================================================"
  echo "export VAULT_ADDR=https://localhost:${PORT}" > $BASEPATH/$CLUSTERNAME.env
  echo "export VAULT_CACERT=\"${BASEPATH}/certs/ca-cert.pem\"" >> $BASEPATH/$CLUSTERNAME.env
  echo "export VAULT_TLS_SERVER_NAME=vault.server" >> $BASEPATH/$CLUSTERNAME.env
}

checkVaultLicense $BASEPATH/vault.hclic
buildVaultImage
generateCA $BASEPATH/certs
generateCertificates $BASEPATH/certs $CLUSTERNAME
generateContainerVolumes $CLUSTERNAME
unsealVaultCluster $CLUSTERNAME
vaultCLISetup $CLUSTERNAME
