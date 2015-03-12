name             'gitlab-omnibus'
maintainer       'Jeremy Olliver'
maintainer_email 'jeremy.olliver@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures gitlab-omnibus'
long_description 'Installs/Configures gitlab-omnibus'
version          '7.8.0'

['ubuntu', 'debian', 'redhat', 'centos', 'amazon', 'scientific'].each do |os|
  supports os
end
