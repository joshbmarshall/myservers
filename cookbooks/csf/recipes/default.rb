#
# Cookbook Name:: csf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install CSF

chkconfig = "update-rc.d"
chkconfig_suffix = "defaults"

case node['platform']
when  "redhat", "centos", "scientific", "amazon", "fedora"
  chkconfig = "chkconfig"
  chkconfig_suffix = "on"
end

package "fail2ban" do
  action [:remove]
end

execute "Download CSF" do
  cwd "/tmp/"
  command <<-EOH
  wget http://configserver.com/free/csf.tgz
  tar -vzxf csf.tgz
  EOH
  creates "/tmp/csf.tgz"
end

execute "Install CSF" do
  cwd "/tmp/csf/"
  command "sh install.sh"
  returns [0,127]
  creates "/etc/csf/csf.conf"
end

service "csf" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :start
end

service "lfd" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :start
end

execute "Update CSF" do
  cwd "/tmp/csf/"
  command "/usr/sbin/csf -u"
end

# Create csf config files

template "/etc/csf/csf.conf" do
  source "csf.conf.erb"
  mode 0600
  owner "root"
  group "root"
  notifies :restart, resources(:service => "csf"), :immediate
  notifies :restart, resources(:service => "lfd"), :immediate
end

template "/etc/csf/csf.allow" do
  source "csf.allow.erb"
  mode 0600
  owner "root"
  group "root"
  notifies :restart, resources(:service => "csf"), :immediate
end

template "/etc/csf/csf.blocklists" do
  source "csf.blocklists.erb"
  mode 0600
  owner "root"
  group "root"
  notifies :restart, resources(:service => "csf"), :immediate
  notifies :restart, resources(:service => "lfd"), :immediate
end

