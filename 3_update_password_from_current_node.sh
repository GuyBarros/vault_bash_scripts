#!/bin/bash


#Vault random password generator custom secret engine: https://github.com/sethvargo/vault-secrets-gen
# https://www.hashicorp.com/resources/painless-password-rotation-hashicorp-vault

# but for this demo I'll go simpler
#vault write -output-curl-string -format=json sys/tools/random format=base64 | jq .data.random_bytes
export NEWPASS=$(curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"format":"hex"}' $(echo $VAULT_ADDR)/v1/sys/tools/random | jq -r .data.random_bytes )
export CONTENT=$(curl -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Request: true" $(echo $VAULT_ADDR)/v1/servers/data/$(hostname) | jq -r .data.data )
export IPADDRESS=$( echo $CONTENT | jq -r  '.ipaddress' ) 
export PROJ_USERNAME=$( echo $CONTENT | jq -r  '.proj_username' ) 
export PROJ_PASSWORD=$( echo $CONTENT | jq -r  '.proj_password' ) 
export NOTES=$( echo $CONTENT | jq -r  '.notes' ) 
export BREAKGLASS_USERNAME=$( echo $CONTENT | jq -r  '.breakglass_username' ) 
export BREAKGLASS_PASSWORD=$( echo $CONTENT | jq -r  '.breakglass_password' ) 
echo $BREAKGLASS_USERNAME $BREAKGLASS_PASSWORD $NEWPASS

# echo "$BREAKGLASS_USERNAME:$NEWPASS" | sudo chpasswd

export BREAKGLASS_PASSWORD=$NEWPASS

curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{ "ipaddress":"'$(echo $IPADDRESS)'","breakglass_username":"'$(echo $BREAKGLASS_USERNAME)'","breakglass_password": "'$(echo $BREAKGLASS_PASSWORD)'","proj_password":"'$(echo $PROJ_PASSWORD)'","proj_username":"'$(echo $PROJ_USERNAME)'","notes":"'$(echo $NOTES)'" },"options":{}}' $(echo $VAULT_ADDR)/v1/servers/data/$(hostname)

#curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{ "ipaddress":"'$(echo $IPADDRESS)'","breakglass_username":"'$(echo $BREAKGLASS_USERNAME)'","breakglass_password": "'$(echo $BREAKGLASS_PASSWORD)'","proj_password":"'$(echo $PROJ_PASSWORD)'","proj_username":"'$(echo $PROJ_USERNAME)'","notes":"'$(echo $NOTES)'" },"options":{}}' $(echo $VAULT_ADDR)/v1/servers/data/$(hostname)

#curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{ "breakglass_password": "'$(echo $BREAKGLASS_PASSWORD)'"},"options":{}}' $(echo $VAULT_ADDR)/v1/servers/data/$(echo $HOSTNAME)

# curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Token: s.6diaU1pNFje4N1kv0AiPfz5S" -d '{"data":{ "ipaddress":"192.168.1.152","breakglass_username":"test","breakglass_password": "f41c39cc4448ee4eb931fea","proj_password":"Welcome1","proj_username":"test","notes":"this is my desktop" },"options":{}}' https://vault.eu-guystack.original.aws.hashidemos.io:8200/v1/servers/data/pop-os