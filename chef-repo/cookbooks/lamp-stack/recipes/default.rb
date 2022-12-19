#
# Cookbook:: lamp-stack
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

execute 'update-upgrade' do
  command 'sudo apt-get update && sudo apt-get upgrade -y'
  action :run
end
