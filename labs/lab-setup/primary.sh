#!/bin/bash

podman kube play vault-primary.yaml
sleep 5
podman exec -ti vault-primary-1-vault-enterprise vault operator init | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | tee init-primary.txt
export VAULT_SEAL_KEY1=$(grep "Unseal Key 1" init-primary.txt | cut -d' ' -f4)
export VAULT_SEAL_KEY2=$(grep "Unseal Key 2" init-primary.txt | cut -d' ' -f4)
export VAULT_SEAL_KEY3=$(grep "Unseal Key 3" init-primary.txt | cut -d' ' -f4)

podman exec -ti vault-primary-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
podman exec -ti vault-primary-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
podman exec -ti vault-primary-1-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3
sleep 2

podman exec -ti vault-primary-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
podman exec -ti vault-primary-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
podman exec -ti vault-primary-2-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3

podman exec -ti vault-primary-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY1
podman exec -ti vault-primary-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY2
podman exec -ti vault-primary-3-vault-enterprise vault operator unseal $VAULT_SEAL_KEY3
