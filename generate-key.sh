#!/bin/bash

set -e

ssh-keygen -t ed25519 -N '' -f ansible_key
pub_key=$(cat ./ansible_key.pub)

sed -i "s/%SSH_PLACEHOLDER%/${pub_key}/g" dietpi.txt
echo "Pub key inserted into dietpi.txt"