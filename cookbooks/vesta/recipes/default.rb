# coding: utf-8
#
# Cookbook Name:: vesta
# Recipe:: default
#
# Copyright 2014
#
#

node.default['vesta']['email'] = 'josh@sanchia.com.au'
node.default['vesta']['admin_password'] = 'default_password'
node.default['install_vestacp_php55'] = true

yum_package "epel-release" do
  action :install
end

remote_file '/root/.vst-install.sh' do
  source 'http://vestacp.com/pub/vst-install.sh'
  mode '0700'
  owner 'root'
  group 'root'
end

execute "Install VestaCP" do
  cwd "/tmp/"
  command <<-EOH
  bash /root/.vst-install.sh -e #{node['vesta']['email']} -f -p #{node['vesta']['admin_password']}
  EOH
  creates "/usr/local/vesta"
end

# set admin password
execute "Set VestaCP admin password" do
  cwd "/tmp"
  command "VESTA='/usr/local/vesta' /usr/local/vesta/bin/v-change-user-password admin #{node['vesta']['admin_password']}"
end

template "/etc/sudoers.d/vesta" do
  source "sudo.erb"
  mode 0440
  owner "root"
  group "root"
end

template "/usr/local/vesta/bin/v-backup-user" do
  source "v-backup-user.erb"
  mode 0755
  owner "root"
  group "root"
end

template "/usr/local/vesta/bin/v-backup-users" do
  source "v-backup-users.erb"
  mode 0755
  owner "root"
  group "root"
end

template "/usr/local/vesta/bin/v-restore-user" do
  source "v-restore-user.erb"
  mode 0755
  owner "root"
  group "root"
end

if node["install_vestacp_php55"] == true
  yum_repository 'remi' do
    description 'Les RPM de Remi - Repository'
    mirrorlist 'http://rpms.famillecollet.com/enterprise/6/remi/mirror'
    gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
    fastestmirror_enabled true
    enabled true
    action :create
  end

  yum_repository 'remi-php55' do
    description 'Les RPM de Remi PHP55 - Repository'
    mirrorlist 'http://rpms.famillecollet.com/enterprise/6/php55/mirror'
    gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
    fastestmirror_enabled true
    enabled true
    action :create
  end

  yum_package "php-opcache" do
    action :install
  end
end

template "/etc/php.ini" do
  source "etc_php.ini.erb"
  mode 0644
  owner "root"
  group "root"
end

execute "reloadproxy" do
  command '/usr/local/vesta/bin/v-restart-proxy'
  action :nothing
end

template "/etc/nginx/nginx.conf" do
  source "etc_nginx_nginx.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, "execute[reloadproxy]"
end

service "mysqld" do
  supports :restart => true, :reload => true, :start => true, :stop => true
end

template "/etc/my.cnf" do
  source "etc_my.cnf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[mysqld]"
end


