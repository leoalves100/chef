#!/bin/bash

export DEBIAN_FRONTEND=noninteractiv

# Adiciona IPs do chef-server e node no hosts
echo 192.168.56.2 chef-infra-server >> /etc/hosts
echo 192.168.56.3 node >> /etc/hosts

# Atualiza o SO
sudo apt-get update && sudo apt-get upgrade -y