Vagrant.configure('2') do |config|
    config.vm.box = 'ubuntu/jammy64'
    config.ssh.insert_key = false

    # Executa em todas as instâncias
    config.vm.provision 'shell', path: 'scripts/instance.sh'

    config.vm.provision 'file',
      source: '~/.vagrant.d/insecure_private_key',
      destination: '~/.ssh/'

    config.vm.define 'chef-infra-server' do |chef|
      chef.vm.hostname = 'chef-infra-server'
      chef.vm.network 'private_network', ip: '192.168.56.2'
      chef.vm.provision 'shell', path: 'scripts/chef_install.sh'

      chef.vm.provider :virtualbox do |chef|
        chef.customize [
          'setextradata', :id,
          'VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root', '1'
        ]

        chef.customize [
          'modifyvm', :id,
          '--natdnshostresolver1', 'on',
          '--memory', '4096',
          '--cpus', '2'
        ]
      end
    end

    config.vm.define 'node' do |node|
      node.vm.hostname = 'node'
      node.vm.network 'private_network', ip: '192.168.56.3'

      node.vm.provision 'shell', inline: <<-SHELL
        sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd
        echo "vagrant:vagrant" | chpasswd
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
        'setextradata', :id,
        'VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root', '1'
      ]

      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize [
        'modifyvm', :id,
        '--natdnshostresolver1', 'on',
        '--memory', '1024',
        '--cpus', '2'
      ]
    end
  end