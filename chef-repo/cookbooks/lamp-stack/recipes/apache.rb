# Ref: https://docs.chef.io/resources/package/
package 'apache2' do
  action :install
end

# Ref: https://docs.chef.io/resources/service/
service 'apache2' do
  action [:enable, :start]
end

# Virtual Hosts
# sitename faz for na 3 posição do array
# sitename = ["exemplo.com"]
# 
# data percorrer json 
# data = {}
node["lamp-stack"]["sites"].each do |sitename, data|
  document_root = "/var/www/html/#{sitename}"

  # Ref: https://docs.chef.io/resources/directory/
  directory document_root do
    mode '0755'
    recursive true
  end  

  execute "enable-sites" do
    command "a2ensite #{sitename}"
    action :nothing # Aguarda a execução
  end

  # Ref: https://docs.chef.io/resources/template/
  template "/etc/apache2/sites-available/#{sitename}.conf" do
    source 'virtualhosts.erb' # Nome do arquivo de template
    mode '0755'
    variables(
      :document_root => document_root,
      :port => data["port"],
      :serveradmin => data["serveradmin"],
      :servername => data["servername"]
    )
  notifies :restart, 'service[apache2]'
  end

  directory "/var/www/html/#{sitename}/public_html" do
    action :create
  end

  directory "/var/www/html/#{sitename}/logs" do
    action :create
  end
  
end
