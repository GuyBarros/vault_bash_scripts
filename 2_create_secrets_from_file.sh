#!/bin/bash

INPUT=fakeservers.list
OLDIFS=$IFS
IFS=';'
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read HOSTNAME IPADDRESS PROJ_USERNAME PROJ_PASSWORD BREAKGLASS_USERNAME BREAKGLASS_PASSWORD NOTES
do
    if [ ! $HOSTNAME == "HOSTNAME" ]
    then
    curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: $(echo $VAULT_DATACENTER)" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{ "ipaddress":"'$(echo $IPADDRESS)'","root_password":"'$(echo $ROOT_PASSWORD)'","root_username":"'$(echo $ROOT_USERNAME)'"},"options":{}}' $(echo $VAULT_ADDR)/v1/$(echo VAULT SECRET PATH)/data/$(echo $HOSTNAME)
    echo "saved $HOSTNAME" in vault
    fi
done < $INPUT
IFS=$OLDIFS
