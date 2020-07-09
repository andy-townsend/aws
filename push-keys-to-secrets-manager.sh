#!/bin/bash
keys_path=~/.ssh/infra-base
private_key=$(cat "$keys_path" | base64 --wrap=0)
public_key=$(cat "$keys_path.pub" | base64 --wrap=0)
json="[\"privateKey\":\"$private_key\",\"publicKey\":\"$public_key\"]"
echo $json
aws secretsmanager create-secret --region eu-west-2 --name ssh-infra-base --secret-string "$json"