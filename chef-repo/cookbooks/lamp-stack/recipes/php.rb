apt_repository 'php-ppa' do
  uri 'ppa:ondrej/php'
  distribution 'jammy'
  action :add
end

apt_package 'php5.6' do
  action :install
end

apt_package 'php-pear' do
  action :install
end

apt_package 'php-mysql' do
  action :install
end