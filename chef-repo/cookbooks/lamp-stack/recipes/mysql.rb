# Acessando databag
mysqlpass = data_bag_item('mysql', 'rtpass.json')

mysql_service 'default' do
  version '8.0'
  initial_root_password mysqlpass['password']
  action [:create, :start]
end
