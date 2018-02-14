#
# Cookbook:: nomad
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

poise_service_user node['nomad']['service_user'] do
  group node['nomad']['service_group']
  shell node['nomad']['service_shell'] unless node['nomad']['service_shell'].nil?
  not_if { node['nomad']['service_user'] == 'root' }
  not_if { node['nomad']['create_service_user'] == false }
end

service_name = node['nomad']['service_name']
nomad_config service_name do |r|
  node['nomad']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :reload, "nomad_service[#{service_name}]", :delayed
end

nomad_installation node['nomad']['version'] do
  archive_name node['nomad']['archive_name']
  archive_url node['nomad']['archive_url']
end

nomad_service service_name do |r|
  user node['nomad']['service_user']
  group node['nomad']['service_group']
  if node['nomad']['service']
    node['nomad']['service'].each_pair { |k, v| r.send(k, v) }
  end
end
