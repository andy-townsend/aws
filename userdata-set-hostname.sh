#!/bin/bash -v

# Set up AWS CLI with current region
export AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
mkdir -p /root/.aws
echo -e "[default]\nregion=$AWS_REGION" | tee /root/.aws/config

# Get tags from the API
export FQDN=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)" "Name=key,Values=Name" --output=text | cut -f 5)

# Set hostname
if [ -n "$FQDN" ]; then
  hostnamectl set-hostname --static $FQDN
  echo 'preserve_hostname: true' | tee -a /etc/cloud/cloud.cfg
fi
