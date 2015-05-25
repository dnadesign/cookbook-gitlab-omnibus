name             'gitlab-omnibus'
maintainer       'Jeremy Olliver'
maintainer_email 'jeremy.olliver@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures gitlab-omnibus'
long_description 'Installs/Configures gitlab-omnibus'
version          '7.11.2'

['ubuntu', 'debian', 'redhat', 'centos', 'amazon', 'scientific'].each do |os|
  supports os
end

depends 'packagecloud', '~> 0.0.18'
