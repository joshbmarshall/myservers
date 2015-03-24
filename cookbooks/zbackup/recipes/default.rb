#
# Cookbook Name:: zbackup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "zbackup" do
  path "/usr/bin/zbackup"
  mode 0755
  action :create
end

# Install libraries

yum_package "protobuf" do
  action :install
end

yum_package "xz" do
  action :install
end

yum_package "lzo" do
  action :install
end

