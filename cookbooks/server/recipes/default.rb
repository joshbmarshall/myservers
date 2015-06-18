#
# Cookbook Name:: vps
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default['tz'] = 'Australia/Brisbane'
node.default['is_backup_server'] = false
node.default['monit']['config']['mail_servers'] = [
  {
    "hostname" => "127.0.0.1",
    "port" => 25,
    "timeout" => "30 seconds",
  }
]
node.default['monit']['config']['log_file'] = 'syslog facility log_daemon'
node.default['monit']['config']['mail_from'] = 'alerts@sanchia.com.au'
node.default['monit']['config']['subscribers'] = [
    {
      'name'          => 'josh@sanchia.com.au',
      'subscriptions' => %w( connection content data exec fsflags gid icmp instance invalid nonexist permission pid ppid resource size timeout timestamp uid ),
    },
  ]
node.default["offsite_backup"] = {
  "/backup" => "backup"
}

node.packages.each do |pkg|
	package pkg
end

# Set the hostname
include_recipe 'hostnames::default'

# Add swap if needed
include_recipe 'swap_tuning'

# provision user account
include_recipe 'myusers'

# provision ssh
#include_recipe 'openssh'

# provision sysctl
include_recipe 'sysctl::apply'

# ConfigServer Firewall
include_recipe 'csf'

# Monit
include_recipe 'monit-ng'
include_recipe 'monit-ng::install'
include_recipe 'monit-ng::configure'

if node["install_postfix"] == true
  # Postfix
  include_recipe 'postfix'
  include_recipe 'postfix::aliases'
end

# Install cronie

yum_package "cronie" do
  action :install
end

# Install mailx

yum_package "mailx" do
  action :install
end

# Install zip
#
yum_package "zip" do
  action :install
end

yum_package "unzip" do
  action :install
end

# Clean up tmp

yum_package "tmpwatch" do
  action :install
end

# Add some cron jobs

template "/sbin/runchef" do
  source "sbin_runchef.erb"
  mode 0755
  owner "root"
  group "root"
end

template "/etc/cron.d/fixes" do
  source "etc_cron.d_fixes.erb"
  mode 0644
  owner "root"
  group "root"
end

if node["install_zbackup"] == true
  include_recipe 'zbackup'
end

# Timezone

bash 'Set Timezone' do
  user 'root'
  code "touch /etc/localtime; rm /etc/localtime; cp /usr/share/zoneinfo/#{node['tz']} /etc/localtime"
end

# Screen
package 'screen'

if node["install_vestacp"] == true
  include_recipe 'vesta'
end

