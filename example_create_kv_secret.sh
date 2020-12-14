
# Add a Server called server1 to our servers kv store in the root namespace
# vault kv put  secret/servers/server1  ipaddress=10.0.0.1  proj_username=projadm proj_password=hunter2 breakglass_username=root  breakglass_password=swordfish notes="this is the first example of our examples so I'll make nice notes but the rest will be hello world"
curl -X PUT -H "X-Vault-Request: true"  -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{"breakglass_password":"swordfish","breakglass_username":"root","ipaddress":"10.0.0.1","notes":"this is the first example of our examples so it will be nice. notes but the rest will be hello world","proj_password":"hunter2","proj_username":"projadm"},"options":{}}' $(echo $VAULT_ADDR)/v1/secret/data/servers/server1

# Add a Server called server3 to our servers kv store in the root namespace
# vault  kv put -namespace=DataCenter1 servers/server3  ipaddress=10.0.0.3  proj_username=projadm proj_password=hunter2 breakglass_username=root  breakglass_password=swordfish notes="hello world"
curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{"breakglass_password":"swordfish","breakglass_username":"root","ipaddress":"10.0.0.3","notes":"hello world","proj_password":"hunter2","proj_username":"projadm"},"options":{}}' $(echo $VAULT_ADDR)/v1/servers/data/server3