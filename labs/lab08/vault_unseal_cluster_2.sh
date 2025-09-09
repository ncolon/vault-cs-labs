#!/bin/bash

set -euo pipefail

CLUSTER_NAME="vault-cluster-asg-2:"
CLUSTER_FILE="/root/vault_cluster_info.txt"
KEY_FILE="/root/.ssh/id_rsa"
UNSEAL_FILE="/root/config-files/initialization-cluster2.txt"

IP_LIST=( 
  $(awk -v start="$CLUSTER_NAME" '
    $0 ~ start {in_block=1; next}
    /^$/ {in_block=0}
    in_block && $2 {print $2}
  ' "$CLUSTER_FILE") 
)

if [ "${#IP_LIST[@]}" -lt 3 ]; then
  echo "Error: Not enough IPs for Cluster 2."
  exit 1
fi

UNSEAL_KEYS=( 
  $(grep "Recovery Key" "$UNSEAL_FILE" | awk -F': ' '{print $2}' | head -n 2) 
)

if [ "${#UNSEAL_KEYS[@]}" -lt 2 ]; then
  echo "Error: Not enough unseal keys in $UNSEAL_FILE"
  exit 1
fi

for target_ip in "${IP_LIST[@]:1:2}"; do
  echo "Connecting to $target_ip..."

  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i "$KEY_FILE" ubuntu@"$target_ip" bash -s << SSH_SCRIPT
set -e
vault operator unseal '${UNSEAL_KEYS[0]}' >/dev/null
vault operator unseal '${UNSEAL_KEYS[1]}' >/dev/null
SEALED_STATUS="\$(vault status | grep Sealed)"
echo "Vault status: \$SEALED_STATUS"
if echo "\$SEALED_STATUS" | grep -q "Sealed.*false"; then
  echo "Vault on \\$(hostname) is unsealed"
else
  echo "Vault on \\$(hostname) still sealed"
  exit 1
fi
SSH_SCRIPT

  if [ $? -ne 0 ]; then
    echo "Error occurred on $target_ip"
    exit 1
  fi

  echo "Finished with $target_ip"
done

echo "Cluster 2 complete."
source ~/.bashrc
exec /bin/bash -l
