name 'nomad-agent'
maintainer 'Takaaki Furukawa'
maintainer_email 'takaaki.frkw@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures nomad'
long_description 'Installs/Configures nomad'
version '0.1.9'
chef_version '>= 12.5'

depends 'poise-archive'
depends 'poise-service'

supports 'ubuntu', '>= 16.04'
supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

issues_url 'https://github.com/tkak/nomad-agent-cookbook/issues'
source_url 'https://github.com/tkak/nomad-agent-cookbook'
