resource_name :nomad_installation

default_action :create

property :version, String, name_attribute: true
property :archive_url, String, default: 'https://releases.hashicorp.com/nomad/'
property :extract_to, String, default: '/opt/nomad'

action :create do
  directory ::File.join(new_resource.extract_to, new_resource.version) do
    mode '0755'
    recursive true
  end

  url = ::File.join(new_resource.archive_url, new_resource.version, binary_basename(node, new_resource.version))
  poise_archive url do
    destination ::File.join(new_resource.extract_to, new_resource.version)
    strip_components 0
    not_if { ::File.exist?(nomad_program) }
  end

  link '/usr/local/bin/nomad' do
    to ::File.join(new_resource.extract_to, new_resource.version, 'nomad')
  end
end

action_class do
  def nomad_program
    @program ||= ::File.join(new_resource.extract_to, new_resource.version, 'nomad')
  end

  def binary_basename(node, version)
    case node['kernel']['machine']
    when 'x86_64', 'amd64' then ['nomad', version, node['os'], 'amd64'].join('_')
    when /i\d86/ then ['nomad', version, node['os'], '386'].join('_')
    when /^arm/ then ['nomad', version, node['os'], 'arm'].join('_')
    else ['nomad', version, node['os'], node['kernel']['machine']].join('_')
    end.concat('.zip')
  end
end
