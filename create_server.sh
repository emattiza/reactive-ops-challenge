#!/bin/bash -
#===============================================================================
#
#          FILE: create_server.sh
#
#         USAGE: ./create_server.sh
#
#   DESCRIPTION: A Script to automate deployment of an EC2 instance running a
#                Dockerized web app.
#
#       OPTIONS: ---
#  REQUIREMENTS: Various AWS and Terraform ENV Variables
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Evan Mattiza (emattiza@gmail.com),
#  ORGANIZATION:
#       CREATED: 04/02/2019 11:46:20 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

[ -z "$AWS_ACCESS_KEY_ID" ] && echo "Set AWS_ACCESS_KEY_ID" && exit 1;
[ -z "$AWS_SECRET_ACCESS_KEY" ] && echo "Set AWS_SECRET_ACCESS_KEY" && exit 1;
[ -z "$AWS_DEFAULT_REGION" ] && echo "Set AWS_DEFAULT_REGION" && exit 1;
[ -z "$TF_VAR_username" ] && echo "Set TF_VAR_username" && exit 1;
[ -z "$TF_VAR_region" ] && echo "Set TF_VAR_region" && exit 1;
[ -z "$TF_VAR_priv_key_path" ] && echo "Set TF_VAR_priv_key_path" && exit 1;
[ -z "$TF_VAR_pub_key" ] && echo "Set TF_VAR_pub_key" && exit 1;
[ -z "$TF_VAR_key_pair_name" ] && echo "Set TF_VAR_key_pair_name" && exit 1;

# create a default vpc given current credentials
aws ec2 create-default-vpc
# apply terraform scaffolding
terraform apply --auto-approve
# curl output of terraform provisioning process to test web-host
curl $(terraform output | awk '/instance*/ {print $3}')

