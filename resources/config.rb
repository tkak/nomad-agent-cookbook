resource_name :nomad_config

property :path, String, name_attribute: true
property :owner, String, default: lazy { node['nomad']['service_user'] }
property :group, String, default: lazy { node['nomad']['service_group'] }
property :config_dir, String, default: lazy { node['nomad']['service']['config_dir'] }
property :config_dir_mode, String, default: '0755'

# @see: https://www.nomadproject.io/docs/agent/configuration/index.html
property :acl, [Hash, Mash]
property :addresses, [Hash, Mash]
property :advertise, [Hash, Mash]
property :bind_addr, String
property :client, [Hash, Mash]
property :consul, [Hash, Mash]
property :datacenter, String
property :data_dir, String
property :disable_anonymous_signature, [true, false]
property :disable_update_check, [true, false]
property :enable_debug, [true, false]
property :enable_syslog, [true, false]
property :http_api_response_headers, [Hash, Mash]
property :leave_on_interrupt, [true, false]
property :leave_on_terminate, [true, false]
property :log_level, String
property :ports, [Hash, Mash]
property :region, String
property :sentinel, [Hash, Mash]
property :server, [Hash, Mash]
property :syslog_facility, String
property :tls, [Hash, Mash]
property :vault, [Hash, Mash]

action :create do
  [::File.dirname(new_resource.path), new_resource.config_dir].each do |dir|
    directory dir do
      recursive true
      owner new_resource.owner
      group new_resource.group
      mode new_resource.config_dir_mode
      not_if { dir == '/etc' }
    end

    file new_resource.path do
      owner new_resource.owner
      group new_resource.group
      mode '0640'
      content params_to_json(new_resource)
    end
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end

action_class do
  def params_to_json(options)
    for_keeps = %i(
      acl
      addresses
      advertise
      bind_addr
      client
      consul
      datacenter
      data_dir
      disable_anonymous_signature
      disable_update_check
      enable_debug
      enable_syslog
      http_api_response_headers
      leave_on_interrupt
      leave_on_terminate
      log_level
      ports
      region
      sentinel
      server
      syslog_facility
      tls
      vault
    )
    for_keeps = for_keeps.flatten

    config = options.to_hash.select do |k, v|
      !v.nil? && for_keeps.include?(k.to_sym)
    end
    JSON.pretty_generate(Hash[config.sort_by { |k, _| k.to_s }], quirks_mode: true)
  end
end
