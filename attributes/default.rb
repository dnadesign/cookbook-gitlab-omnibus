default['gitlab']['omnibus']['package_version'] = '7.8.2-omnibus.1-1'

# New package download locations are updated at https://about.gitlab.com/downloads/archives/ && https://about.gitlab.com/downloads/
case node['platform_family']
when 'rhel', 'fedora'
  if node['platform_version'].to_i == 7
    # rhel 7 build
    default['gitlab']['omnibus']['url']      = "https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-#{node['gitlab']['omnibus']['package_version']}.el7.x86_64.rpm"
    default['gitlab']['omnibus']['checksum'] = '3fe237777fd1ea619b382ecbefc51244088b3b9606361e5735d25506800c4111'
  else
    # rhel 6 build
    default['gitlab']['omnibus']['url']      = "https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-#{node['gitlab']['omnibus']['package_version']}.el6.x86_64.rpm"
    default['gitlab']['omnibus']['checksum'] = 'dbf343fa18d4c64894996e0d906289ecb242f92cfe4c448ab8bdc87f84d4e4d3'
  end
when 'debian'
  if node['platform'] == 'ubuntu'
    if node['platform_version'] == '14.04'
      # ubuntu 14.04 build
      default['gitlab']['omnibus']['url']      = "https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_#{node['gitlab']['omnibus']['package_version']}_amd64.deb"
      default['gitlab']['omnibus']['checksum'] = '9e052536e2a76e61bbd16b4bff771cff560ab2ffe966c90bd85510d1849f9996'
    else
      # ubuntu 12.04 build
      default['gitlab']['omnibus']['url']      = "https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_#{node['gitlab']['omnibus']['package_version']}_amd64.deb"
      default['gitlab']['omnibus']['checksum'] = '9a91f9344b9cce376f6e620773d7607f9c42f93ac9b4ee4cbebfb3f2ce736cfc'
    end
  else
    # debian 7 build
    default['gitlab']['omnibus']['url']      = "https://downloads-packages.s3.amazonaws.com/debian-7.8/gitlab_#{node['gitlab']['omnibus']['package_version']}_amd64.deb"
    default['gitlab']['omnibus']['checksum'] = '4eb7c4b1b4e22580488698b48748524f2f0dbba1873f52e3e606a838f48f6132'
  end
else
  # You must select your own package
  default['gitlab']['omnibus']['package_version'] = nil
  default['gitlab']['omnibus']['url']             = nil
  default['gitlab']['omnibus']['checksum']        = nil
end

## Config

default['gitlab']['config']['external_url'] = "http://#{node['fqdn']}/"
default['gitlab']['config']['gitlab_rails'] = {}
default['gitlab']['config']['ldap_servers'] = {}
default['gitlab']['config']['user']         = {}
default['gitlab']['config']['unicorn']      = {}
default['gitlab']['config']['sidekiq']      = {}
default['gitlab']['config']['gitlab_shell'] = {}
default['gitlab']['config']['postgresql']   = {}
default['gitlab']['config']['redis']        = {}
default['gitlab']['config']['web_server']   = {}
default['gitlab']['config']['nginx']        = {}
default['gitlab']['config']['logging']      = {}
default['gitlab']['config']['logrotate']    = {}
default['gitlab']['config']['gitlab_ci']    = {}
default['gitlab']['config']['ci_unicorn']   = {}
default['gitlab']['config']['ci_redis']     = {}
default['gitlab']['config']['ci_nginx']     = {}
