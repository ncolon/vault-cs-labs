vault policy write vso-kv-ro /root/config/vso/vso-kv-ro.policy.hcl

vault policy write agent-kv-ro /root/config/vault-agent/agent-kv-ro.policy.hcl

export ISSUER="$(kubectl get --raw /.well-known/openid-configuration | jq -r '.issuer')"

export SA_NAME=$(kubectl get --all-namespaces serviceaccount -o json | jq -r '.items[].metadata | select(.name|startswith("vault-")).name')

export SA_SECRET_NAME=$(kubectl get secrets --output=json \
    | jq -r '.items[].metadata | select(.name|startswith("vault-auth-")).name')

export SA_JWT_TOKEN=$(kubectl get secret $SA_SECRET_NAME \
    --output 'go-template={{ .data.token }}' | base64 --decode)

export SA_CA_CRT=$(kubectl config view --raw --minify --flatten \
    --output 'jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode)

# export K8S_HOST="https://$(ip -4 -o addr show | grep -i ens4 | awk '{print $4}' | cut -d "/" -f 1):6443"
export K8S_HOST="https://$(ssh -o StrictHostKeyChecking=no k8s-cluster ip -4 -o addr show | grep -i ens4 | awk '{print $4}' | cut -d "/" -f 1):6443"

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

kubectl -n default create configmap ca-pemstore --from-file=/root/config/vault/vault-server-cert.pem

sed -i "s/\$VAULT_IP/$VAULT_IP/g" /root/config/vault/svcutils.yaml
sed -i "s/\$VAULT_IP/$VAULT_IP/g" /root/config/vault-agent/agent-app-spec.yaml
sed -i "s/\$VAULT_IP/$VAULT_IP/g" /root/config/vault-agent-sidecar/agent-deploy.yaml
sed -i "s/\$VAULT_IP/$VAULT_IP/g" /root/config/vault-agent-to-vso/agent-deploy.yaml
sed -i "s/\$VAULT_IP/$VAULT_IP/g" /root/config/vso/vso-crd.yaml
sed -i "s/\$VAULT_IP/$VAULT_IP/g" /root/config/vso/vso-crd-ex.yaml

kubectl apply -f /root/config/vault/svcutils.yaml
