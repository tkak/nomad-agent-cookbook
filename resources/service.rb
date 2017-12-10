resource_name :nomad_service

property :config_file, String, default: lazy { node['nomad']['config']['path'] }
property :config_dir, String, default: lazy { node['nomad']['service']['config_dir'] }
property :data_dir, String, default: lazy { node['nomad']['config']['data_dir'] }
property :user, String, default: lazy { node['nomad']['service_user'] }
property :group, String, default: lazy { node['nomad']['service_group'] }
property :program, String, default: '/usr/local/bin/nomad'

action :start do
  create_init

  service 'nomad' do
    supports restart: true, reload: true, status: true
    provider Chef::Provider::Service::Init::Systemd
    action [:enable, :start]
  end
end

action :stop do
  service 'nomad' do
    supports restart: true, reload: true, status: true
    provider Chef::Provider::Service::Init::Systemd
    action :stop
  end
end

action :restart do
  service 'nomad' do
    supports restart: true, reload: true, status: true
    provider Chef::Provider::Service::Init::Systemd
    action :restart
  end
end

action :reload do
  service 'nomad' do
    supports restart: true, reload: true, status: true
    provider Chef::Provider::Service::Init::Systemd
    action :reload
  end
end

action :enable do
  create_init

  service 'nomad' do
    supports restart: true, reload: true, status: true
    provider Chef::Provider::Service::Init::Systemd
    action :enable
  end
end

action :disable do
  service 'nomad' do
    supports restart: true, reload: true, status: true
    provider Chef::Provider::Service::Init::Systemd
    action :disable
  end
end

action_class do
  def create_init
    directory '/etc/systemd/system' do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
      action :create
    end

    directory new_resource.data_dir do
      owner new_resource.user
      group new_resource.group
      mode '0755'
      recursive true
      action :create
    end

    systemd_unit 'nomad.service' do
      content service_unit_content
      action :create
      notifies :restart, 'service[nomad]', :delayed
    end

    service 'nomad' do
      supports restart: true, reload: true, status: true
      provider Chef::Provider::Service::Init::Systemd
      action :nothing
    end
  end

  def service_unit_content
    {
      'Unit' => {
        'Description' => 'Nomad agent daemon',
        'Wants' => 'network.target',
        'After' => 'network.target',
      },
      'Service' => {
        'ExecStart' => "#{new_resource.program} agent -config=#{new_resource.config_file} -config=#{new_resource.config_dir}",
        'ExecReload' => '/bin/kill -HUP $MAINPID',
        'WorkingDirectory' => new_resource.data_dir,
        'LimitNOFILE' => 65536,
      },
      'Install' => {
        'WantedBy' => 'multi-user.target',
      },
    }
  end
end
