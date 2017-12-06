resource_name :nomad_service

property :config_file, String, default: lazy { node['nomad']['config']['path'] }
property :config_dir, String, default: lazy { node['nomad']['service']['config_dir'] }
property :user, String, default: lazy { node['nomad']['service_user'] }
property :group, String, default: lazy { node['nomad']['service_group'] }
property :program, String, default: '/usr/local/bin/nomad'

%i(start reload stop enable disable).each do |act|
  __send__(:action, act, &proc do
    rs = @new_resource
    poise_service 'nomad' do
      template 'systemd.service'
      command "#{rs.program} agent -config-file=#{rs.config_file} -config-dir=#{rs.config_dir}"
      action act
    end
  end)
end

