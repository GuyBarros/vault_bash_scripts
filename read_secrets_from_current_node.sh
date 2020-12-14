#!/bin/bash

# vault kv get -format=json -namespace=DataCenter1 servers/$(hostname)
export CONTENT=$(curl -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Request: true" $(echo $VAULT_ADDR)/v1/servers/data/$(hostname) | jq -r .data.data )

echo $CONTENT