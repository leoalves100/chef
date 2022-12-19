Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"
    config.ssh.insert_key = false

    # Execute all instances
    config.vm.provision "shell", inline: <<-SHELL
      # Adiciona ip do chef-server e node no hosts
      echo 192.168.56.2 chef-infra-server >> /etc/hosts
      echo 192.168.56.3 node >> /etc/hosts

      # Atualiza o SO
      sudo apt update && sudo apt upgrade -y
    SHELL

    config.vm.provision "file", 
      source: "~/.vagrant.d/insecure_private_key", 
      destination: "~/.ssh/"
    
    config.vm.define "chef-infra-server" do |chef|
      chef.vm.hostname = "chef-infra-server"      
      chef.vm.network "forwarded_port", guest: 80, host: 8080
      chef.vm.network "private_network", ip: "192.168.56.2"
      
      chef.vm.provision "shell", inline: <<-SHELL
        curl https://packages.chef.io/files/stable/chef-server/15.3.2/ubuntu/22.04/chef-server-core_15.3.2-1_amd64.deb -o chef-server-core_15.3.2-1_amd64.deb
        sudo dpkg --install chef-server-core_15.3.2-1_amd64.deb
        # Reconfigure chef-server
        sudo chef-server-ctl reconfigure --chef-license=accept
        # Install chef-server GUI
        sudo chef-server-ctl install chef-manage
        # Install Chef Workstation
        curl https://packages.chef.io/files/stable/chef-workstation/21.10.640/ubuntu/20.04/chef-workstation_21.10.640-1_amd64.deb -o chef-workstation_21.10.640-1_amd64.deb
        sudo dpkg --install chef-workstation_21.10.640-1_amd64.deb
        # Reconfigure renew
        sudo chef-server-ctl reconfigure
        sudo chef-manage-ctl reconfigure --accept-license
        chef-server-ctl user-create leandro Leandro Alves leandro@gmail.com leandro --filename leandro.pem

      SHELL

      chef.vm.provider :virtualbox do |chef|
        chef.customize [
          "setextradata", :id,
          "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"
        ]
    
        chef.customize [
          'modifyvm', :id,
          '--natdnshostresolver1', 'on',
          '--memory', '4096',
          '--cpus', '2'
        ]
        end
      end

    config.vm.define "node" do |node|
      node.vm.hostname = "node"
      node.vm.network "private_network", ip: "192.168.56.3"

      node.vm.provision "shell", inline: <<-SHELL
      SHELL

    end

    config.vm.provider :virtualbox do |vb|
  
      # Enable creating symlinks between guest and host
      vb.customize [
        # see https://github.com/mitchellh/vagrant/issues/713#issuecomment-17296765
        # 1) Added these lines to my config :
        #
        # 2) run this command in an admin command prompt on windows :
        #    >> fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1
        #    see http://technet.microsoft.com/ja-jp/library/cc785435%28v=ws.10%29.aspx
        # 3) REBOOT HOST MACHINE
        # 4) 'vagrant up' from an admin command prompt
        "setextradata", :id,
        "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"
      ]
  
      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize [
        'modifyvm', :id,
        '--natdnshostresolver1', 'on',
        '--memory', '512',
        '--cpus', '2'
      ]
    end
  end