#!/bin/bash

export DEBIAN_FRONTEND=noninteractiv

readonly PATH_USER=/home/vagrant

# USER
readonly USER_NAME="leandro"
readonly USER_FULL_NAME="Leandro Alves"
readonly USER_EMAIL="leandro@gmail.com"
readonly USER_PASSWORD="leandro"

# ORGANIZATION
readonly ORG="vagrant"
readonly ORG_FULL="HashiCorp Inc."

install_chef_server(){
    echo "Install Chef Infra Server..."
    curl https://packages.chef.io/files/stable/chef-server/15.3.2/ubuntu/22.04/chef-server-core_15.3.2-1_amd64.deb -o chef-server-core_15.3.2-1_amd64.deb 2> /dev/null
    dpkg --install ${PATH_USER}/chef-server-core_15.3.2-1_amd64.deb
    chef-server-ctl reconfigure --chef-license=accept
}

install_chef_manage(){
    echo "Install Chef Manage..."
    chef-server-ctl install chef-manage
}

install_chef_workstation(){
    echo "Install Chef Workstation..."
    curl https://packages.chef.io/files/stable/chef-workstation/21.10.640/ubuntu/20.04/chef-workstation_21.10.640-1_amd64.deb -o chef-workstation_21.10.640-1_amd64.deb 2> /dev/null
    dpkg --install ${PATH_USER}/chef-workstation_21.10.640-1_amd64.deb
    chef-server-ctl reconfigure
    chef-manage-ctl reconfigure --accept-license
}

chef_configuration(){
    
    echo "Creating user..."
    # shellcheck disable=SC2086
    chef-server-ctl user-create ${USER_NAME} ${USER_FULL_NAME} ${USER_EMAIL} ${USER_PASSWORD} --filename ${PATH_USER}/.chef/${USER_NAME}.pem

    echo "Add user to admin..."
    chef-server-ctl grant-server-admin-permissions leandro
    
    echo "Creating organization..."    
    chef-server-ctl org-create "${ORG}" "${ORG_FULL}" --association_user ${USER_NAME} --filename  ${PATH_USER}/.chef/${ORG}-validator.pem
}

node_registration(){
    echo "Registering node..."
    knife bootstrap 192.168.56.3 -U vagrant -P 'vagrant' --node-name chef-node-01 --sudo --node-ssl-verify-mode none --yes
}

clean_installation_files(){
    rm -f ${PATH_USER}/chef*.deb
}

main() {
    install_chef_server
    install_chef_manage
    install_chef_workstation
    chef_configuration
    node_registration
    clean_installation_files
}

main "$@"       