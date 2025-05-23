# Ref: https://docs.chef.io/workstation/config_rb/

node_name 'leandro'
chef_server_url 'https://192.168.56.2/organizations/vagrant'
client_key '~/.chef/leandro.pem'

ssl_verify_mode :verify_none

log_level     :info
log_location  STDOUT

knife[:editor] = '/usr/bin/vim' 