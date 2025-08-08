#!/bin/bash

test -e vault.hclic || {
    echo "Unable to find vault.hclic in $PWD."
    echo "Download the vault.hclic license file from https://ibm.biz/hc-ent-keys and place it on this folder"
    exit 1
}

if [[ $USER == "itzuser" ]] ; then
    umask 022
fi

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

podman build --build-arg ARCH=$ARCH_ALIAS -t vault-enterprise vault-image || exit 1


CERTS=certs
test -e $CERTS || mkdir $CERTS
test -e $CERTS/ca-key.pem || {
    openssl genrsa 2048 > $CERTS/ca-key.pem
    openssl req -new -x509 -nodes -days 365000 -key $CERTS/ca-key.pem -out $CERTS/ca-cert.pem \
        -subj "/C=US/ST=North Carolina/L=Raleigh/O=IBM/OU=WW CS/CN=ca.authority"
}

for CLUSTERNAME in vault-primary vault-dr vault-replication; do
    export CLUSTERNAME
    test -e ${CLUSTERNAME}.yaml && rm ${CLUSTERNAME}.yaml

    echo $CERTS

    IP_LIST="IP.1:127.0.0.1"
    if [[ ! -z $PUBLIC_IP ]] ; then
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

    for i in $(seq 1 3); do
        export INSTANCE="${CLUSTERNAME}-${i}"

        cat templates/vault.yaml.template | envsubst >> ${CLUSTERNAME}.yaml


        mkdir -p volumes/${INSTANCE}/tls volumes/${INSTANCE}/data
        chmod 755 volumes/${INSTANCE}/tls
        chmod 777 volumes/${INSTANCE}/data


        cp $CERTS/ca-cert.pem volumes/${INSTANCE}/tls/ca.pem
        cp $CERTS/${CLUSTERNAME}-tls.key volumes/${INSTANCE}/tls/tls.key
        cp $CERTS/${CLUSTERNAME}-tls.crt volumes/${INSTANCE}/tls/tls.crt

        cp vault.hclic volumes/${INSTANCE}/
        cat templates/config.hcl.template | envsubst > volumes/${INSTANCE}/config.hcl

    done


    case ${CLUSTERNAME} in
        vault-dr)
            export PORT=8210 ;;
        vault-replication)
            export PORT=8220 ;;
        *)
            export PORT=8200
            if [[ $USER == "itzuser" ]] ; then
                export PORT=12443
            fi
            ;;
    esac

    cat templates/haproxy.yaml.template | envsubst >> ${CLUSTERNAME}.yaml

    mkdir -p volumes/haproxy-${CLUSTERNAME}

    cat templates/haproxy.cfg.template | envsubst > volumes/haproxy-${CLUSTERNAME}/haproxy.cfg
    cp $CERTS/${CLUSTERNAME}-tls.crt volumes/haproxy-${CLUSTERNAME}/tls.crt
    cp $CERTS/${CLUSTERNAME}-tls.key volumes/haproxy-${CLUSTERNAME}/tls.crt.key

    chmod -R go+r volumes
done