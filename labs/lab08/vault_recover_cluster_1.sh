#!/bin/bash

set -euo pipefail

CLUSTER_NAME="vault-cluster-asg-1:"
CLUSTER_FILE="/root/vault_cluster_info.txt"
KEY_FILE="/root/.ssh/id_rsa"

IP_LIST=( 
  $(awk -v start="$CLUSTER_NAME" '
    $0 ~ start {in_block=1; next}
    /^$/ {in_block=0}
    in_block && $2 {print $2}
  ' "$CLUSTER_FILE") 
)

if [ "${#IP_LIST[@]}" -lt 3 ]; then
  echo "Error: Not enough IPs for Cluster 1."
  exit 1
fi

for target_ip in "${IP_LIST[@]:0:3}"; do
  echo "Connecting to $target_ip to restart Vault service..."

  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i "$KEY_FILE" ubuntu@"$target_ip" bash -s << SSH_SCRIPT
set -e
sudo sudo systemctl restart vault
sleep 2
VAULT_STATUS="\$(systemctl is-active vault)"
echo "Vault service status on \\$(hostname): \$VAULT_STATUS"
if [ "\$VAULT_STATUS" != "active" ]; then
  echo "Vault did not restart properly on \\$(hostname)"
  exit 1
fi
SSH_SCRIPT

  if [ $? -ne 0 ]; then
    echo "Error occurred on $target_ip"
    exit 1
  fi

  echo "Vault successfully restarted on $target_ip"
done

echo "Vault restart process complete for first three nodes of Cluster 1."
exec /bin/bash -l
