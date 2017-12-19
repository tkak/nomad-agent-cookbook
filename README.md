# Nomad agent cookbook

[![CircleCI](https://circleci.com/gh/tkak/nomad-agent-cookbook/tree/master.svg?style=svg)](https://circleci.com/gh/tkak/nomad-agent-cookbook/tree/master)
[![Chef cookbook](https://img.shields.io/cookbook/v/nomad-agent.svg)](https://supermarket.chef.io/cookbooks/nomad-agent)

This cookbook is to used to install and configure HashiCorp Nomad.

## Requirements

### Platforms

- RHEL 7+
- Ubuntu 16.04+

### Chef

- Chef 12.5+

## Attributes

The following attributes affect the behavior of the nomad agent or are used in the recipes for various settings that require flexibility.

Requires:

- `node['nomad']['config']['server']['enabled']` - Specifies if this agent should run in server mode. `true` or `false`.
- `node['nomad']['config']['server']['bootstrap_expect']` - Specifies the number of server nodes to wait for before bootstrapping.

Optional:

- `node['nomad']['version']` - The version of Nomad. Default "0.7.0".
- `node['nomad']['service_name']` - The name of Nomad service. Default "nomad".
- `node['nomad']['service_user']` - The name of user for the owner of Nomad service files and directories. Default "nomad".
- `node['nomad']['service_group']` - The name of group of Nomad service files and directories. Default "nomad".
- `node['nomad']['create_service_user']` - Whether the service user and group will be created. Default "true".
- `node['nomad']['config']['path']` - The path of a default configuration file of Nomad agent. Default "/etc/nomad/default.json".
- `node['nomad']['config']['data_dir']` - Specifies a local directory used to store agent state. Default "/var/lib/nomad".
- `node['nomad']['config']['bind_addr']` - Specifies which address the Nomad agent should bind to for network services. Default "0.0.0.0".
- `node['nomad']['config']['name']` - Specifies the name of the local node. Default `node['fqdn']`.
- `node['nomad']['config']['datacenter']` - Specifies the data center of the local agent. Default "dc1".
- `node['nomad']['config']['advertise']['http']` - The address to advertise for the HTTP interface. Default `node['ipaddress']`.
- `node['nomad']['config']['advertise']['rpc']` - The address to advertise for the RPC interface. Default `node['ipaddress']`.
- `node['nomad']['config']['advertise']['serf']` - The address advertised for the gossip layer. Default `node['ipaddress']`.
- `node['nomad']['config']['consul']['address']` - Specifies configuration for connecting to Consul. Default `#{node['ipaddress']}:8500`
- `node['nomad']['service']['config_dir']` - Specifies the directory of additional configuration files. Default "/etc/nomad/conf.d".

## Recipes

### default

Installs and configures HashiCorp Nomad.

