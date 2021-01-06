#!/usr/bin/env bash

function vault_ssh() {
export CONTENT=$(vault kv get -format=json servers/${1} | jq -r .data.data)
sshpass -p $( echo $CONTENT | jq -r  '.proj_password' ) ssh  $( echo $CONTENT | jq -r  '.proj_username' )@$( echo $CONTENT | jq -r  '.ipaddress' )
}
