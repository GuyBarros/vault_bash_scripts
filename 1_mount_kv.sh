# Create a KV mount in the root namespace
# vault secrets enable -version=2 -path=servers  kv  
curl -X POST -H "X-Vault-Request: true" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"type":"kv","description":"","config":{"options":null,"default_lease_ttl":"0s","max_lease_ttl":"0s","force_no_cache":false},"local":false,"seal_wrap":false,"external_entropy_access":false,"options":{"version":"2"}}' $(echo $VAULT_ADDR)/v1/sys/mounts/servers

# Create DataCenter1 NameSpace
# vault namespace create DataCenter1
curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d 'null' $(echo $VAULT_ADDR)/v1/sys/namespaces/DataCenter1

# Create a KV mount in the DataCenter1 namespace
# vault secrets enable -namespace=DataCenter1 -version=2 -path=servers  kv  
curl -X POST -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1/" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"type":"kv","description":"","config":{"options":null,"default_lease_ttl":"0s","max_lease_ttl":"0s","force_no_cache":false},"local":false,"seal_wrap":false,"external_entropy_access":false,"options":{"version":"2"}}' $(echo $VAULT_ADDR)/v1/sys/mounts/servers
