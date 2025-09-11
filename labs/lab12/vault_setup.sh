vault policy write vso-kv-ro ./vso/vso-kv-ro.policy.hcl

vault policy write agent-kv-ro ./vault-agent/agent-kv-ro.policy.hcl

export ISSUER="$(kubectl get --raw /.well-known/openid-configuration | jq -r '.issuer')"

export SA_NAME=vault-auth
oc create sa $SA_NAME
cat <<EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: vault-token
  annotations:
    kubernetes.io/service-account.name: $SA_NAME
type: kubernetes.io/service-account-token
EOF

export SA_JWT_TOKEN=$(oc get secret vault-auth \
    --output 'go-template={{ .data.token }}' | base64 --decode)

export SA_CA_CRT=$(oc get cm kube-root-ca.crt -o jsonpath ='{.data.ca\.crt}')

export K8S_HOST=$(oc whoami --show-server)

vault auth enable kubernetes

vault write auth/kubernetes/config \
    disable_local_ca_jwt=true \
    token_reviewer_jwt="$SA_JWT_TOKEN" \
    kubernetes_host="$K8S_HOST" \
    kubernetes_ca_cert="$SA_CA_CRT" \
    issuer="$ISSUER"

vault write auth/kubernetes/role/vso \
    bound_service_account_names="$SA_NAME" \
    bound_service_account_namespaces=* \
    token_policies=vso-kv-ro \
    ttl=24h

vault write auth/kubernetes/role/agent \
    bound_service_account_names="$SA_NAME" \
    bound_service_account_namespaces=* \
    token_policies=agent-kv-ro \
    ttl=24h

oc -n default create configmap ca-pemstore --from-file=$HOME/vault-hvd-aws/labs/lab-setup/certs/ca-cert.pem

sed -i "s/\$VAULT_IP/$PUBLIC_IP/g" ./vault/svcutils.yaml
sed -i "s/\$VAULT_IP/$PUBLIC_IP/g" ./vault-agent/agent-app-spec.yaml
sed -i "s/\$VAULT_IP/$PUBLIC_IP/g" ./vault-agent-sidecar/agent-deploy.yaml
sed -i "s/\$VAULT_IP/$PUBLIC_IP/g" ./vault-agent-to-vso/agent-deploy.yaml
sed -i "s/\$VAULT_IP/$PUBLIC_IP/g" ./vso/vso-crd.yaml
sed -i "s/\$VAULT_IP/$PUBLIC_IP/g" ./vso/vso-crd-ex.yaml

oc apply -f ./vault/svcutils.yaml


oc apply -f ./vso/vso-rbac.yaml
oc adm policy add-cluster-role-to-user vso-cluster-role -z $SA_NAME