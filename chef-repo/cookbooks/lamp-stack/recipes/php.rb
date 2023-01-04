package 'php-ppa' do
  uri 'ppa:ondrej/php'
  distribution 'jammy'
  action :install
end

package 'php5' do
  action :install
end

package 'php-pear' do
  action :install
end

package 'php-mysql' do
  action :install
end