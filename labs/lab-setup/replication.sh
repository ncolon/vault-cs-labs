#!/bin/bash

podman kube play vault-replication.yaml
sleep 5
podman exec -ti vault-replication-1-vault-enterprise vault operator init | sed 's/\x1b\[[0-9;]*m//g' | tr - '\r' | tee init-replication.txt
export VAULT_SEAL_KEY1=$(grep "Unseal Key 1" init-replication.txt | cut -d' ' -f4)
export VAULT_SEAL_KEY2=$(grep "Unseal Key 2" init-replication.txt | cut -d' ' -f4)
export VAULT_SEAL_KEY3=$(grep "Unseal Key 3" init-replication.txt | cut -d' ' -f4)

podman exec -ti vault-replication-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
podman exec -ti vault-replication-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
podman exec -ti vault-replication-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3

podman exec -ti vault-replication-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
podman exec -ti vault-replication-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
podman exec -ti vault-replication-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3

podman exec -ti vault-replication-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
podman exec -ti vault-replication-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
podman exec -ti vault-replication-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3
