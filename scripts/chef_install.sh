#!/bin/bash

install_chef_server(){
    echo "Install Chef Infra Server..."
    curl https://packages.chef.io/files/stable/chef-server/15.3.2/ubuntu/22.04/chef-server-core_15.3.2-1_amd64.deb -o chef-server-core_15.3.2-1_amd64.deb 2> /dev/null
    sudo dpkg --install /home/vagrant/chef-server-core_15.3.2-1_amd64.deb
    sudo chef-server-ctl reconfigure --chef-license=accept
}

install_chef_manage(){
    echo "Install Chef Manage..."
    sudo chef-server-ctl install chef-manage
}

install_chef_workstation(){
    echo "Install Chef Workstation..."
    curl https://packages.chef.io/files/stable/chef-workstation/21.10.640/ubuntu/20.04/chef-workstation_21.10.640-1_amd64.deb -o chef-workstation_21.10.640-1_amd64.deb
    sudo dpkg --install /home/vagrant/chef-workstation_21.10.640-1_amd64.deb
    sudo chef-server-ctl reconfigure
    sudo chef-manage-ctl reconfigure --accept-license
}

chef_configuration(){
    echo "Creating user..."
    chef-server-ctl user-create leandro Leandro Alves leandro@gmail.com leandro --filename leandro.pem
    clear
    echo "User: leandro"
    echo "Passwod: leandro"
}

main() {
    install_chef_server
    install_chef_manage
    install_chef_workstation
    chef_configuration
}

main "$@"       