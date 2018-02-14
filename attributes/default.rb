default['nomad']['version'] = '0.7.1'
default['nomad']['service_name'] = 'nomad'
default['nomad']['service_user'] = 'nomad'
default['nomad']['service_group'] = 'nomad'
default['nomad']['create_service_user'] = true
default['nomad']['archive_name'] = 'nomad'
default['nomad']['archive_url'] = 'https://releases.hashicorp.com/nomad/'

default['nomad']['config']['path'] = '/etc/nomad/default.json'
default['nomad']['config']['data_dir'] = '/var/lib/nomad'
default['nomad']['config']['bind_addr'] = '0.0.0.0'
default['nomad']['config']['name'] = node['fqdn']
default['nomad']['config']['datacenter'] = 'dc1'
default['nomad']['config']['advertise']['http'] = node['ipaddress']
default['nomad']['config']['advertise']['rpc'] = node['ipaddress']
default['nomad']['config']['advertise']['serf'] = node['ipaddress']
default['nomad']['config']['consul']['address'] = "#{node['ipaddress']}:8500"

default['nomad']['service']['config_dir'] = '/etc/nomad/conf.d'
