#!/bin/sh

# Note: This script requires that the VAULT_ADDR and VAULT_TOKEN environment variables be set.
# Example:
# export VAULT_ADDR=http://localhost:8200
# export VAULT_TOKEN=root

echo "Enabling the vault transit secrets engine..."

# Enable the transit secret engine
vault secrets enable -path=lob_a/workshop/transit transit

# Create our customer key
vault write -f lob_a/workshop/transit/keys/customer-key

# Create our archive key to demonstrate multiple keys
vault write -f lob_a/workshop/transit/keys/archive-key

echo "Script complete."