#Password Policy definition
tee example_policy.hcl <<EOF
length=20

rule "charset" {
  charset = "abcdefghijklmnopqrstuvwxyz"
  min-chars = 1
}

rule "charset" {
  charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  min-chars = 1
}

rule "charset" {
  charset = "0123456789"
  min-chars = 1
}

rule "charset" {
  charset = "!@#$%^&*"
  min-chars = 1
}
EOF

#create password policy
vault write sys/policies/password/example policy=@example_policy.hcl

#test random password generation
vault read -field password sys/policies/password/example/generate

#Generate a random password while save it to KVv2
vault kv put kv/robosyed generated_password=$(vault read -field password sys/policies/password/example/generate) 

#mount transit secrets engine
vault secrets mount transit

#create exportable transit key 
vault write transit/keys/test3 exportable=true type=rsa-2048

#Generate a random password while save it to KVv2 with a transit RSA2048 public/private key pair
  #test get public key
  #vault read -field=keys -format=json  transit/keys/test2 | jq '.["1"]."public_key"'
  #test get private key
  #vault read  -field=keys -format=json transit/export/encryption-key/test2/1  | jq '.["1"]'
#base64 enconding is needed to deal with newlines in the certificates
vault kv put kv/robosyed generated_password=$(vault read -field password sys/policies/password/example/generate) public_key=$(vault read -field=keys -format=json  transit/keys/test3 | jq '.["1"]."public_key"' | base64 ) private_key=$(vault read  -field=keys -format=json transit/export/encryption-key/test3/1  | jq '.["1"]' | base64 )
