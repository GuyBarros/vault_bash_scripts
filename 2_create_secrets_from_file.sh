#!/bin/bash

INPUT=fakeservers.list
OLDIFS=$IFS
IFS=';'
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read HOSTNAME IPADDRESS PROJ_USERNAME PROJ_PASSWORD BREAKGLASS_USERNAME BREAKGLASS_PASSWORD NOTES
do
    if [ ! $HOSTNAME == "HOSTNAME" ]
    then
    curl -X PUT -H "X-Vault-Request: true" -H "X-Vault-Namespace: DataCenter1" -H "X-Vault-Token: $(echo $VAULT_TOKEN)" -d '{"data":{ "ipaddress":"'$(echo $IPADDRESS)'","breakglass_username":"'$(echo $BREAKGLASS_USERNAME)'","breakglass_password": "'$(echo $BREAKGLASS_PASSWORD)'","proj_password":"'$(echo $PROJ_PASSWORD)'","proj_username":"'$(echo $PROJ_USERNAME)'","notes":"'$(echo $NOTES)'"},"options":{}}' $(echo $VAULT_ADDR)/v1/servers/data/$(echo $HOSTNAME)
    echo "saved $HOSTNAME" in vault
    fi
done < $INPUT
IFS=$OLDIFS
