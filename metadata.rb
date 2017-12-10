name 'nomad-agent'
maintainer 'Takaaki Furukawa'
maintainer_email 'takaaki.frkw@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures nomad'
long_description 'Installs/Configures nomad'
version '0.1.4'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'poise-archive'
depends 'poise-service'

issues_url 'https://github.com/tkak/nomad-agent-cookbook/issues'
source_url 'https://github.com/tkak/nomad-agent-cookbook'
