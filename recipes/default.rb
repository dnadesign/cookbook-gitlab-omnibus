#
# Cookbook Name:: gitlab-omnibus
# Recipe:: default
#
# Copyright (C) 2015 Jeremy Olliver
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

gitlab_package 'gitlab-ce' do
  package_repo "gitlab/gitlab-ce"
  version node['gitlab']['version']
end

template '/etc/gitlab/gitlab.rb' do
  owner 'root'
  group 'root'
  mode '0600'
  helpers(Gitlab::Helpers)
  variables({
    external_url:                node['gitlab']['config']['external_url'] || "http://#{node['fqdn']}/",
    gitlab_rails:                node['gitlab']['config']['gitlab_rails'],
    ldap_servers:                node['gitlab']['config']['ldap_servers'],
    user:                        node['gitlab']['config']['user'],
    unicorn:                     node['gitlab']['config']['unicorn'],
    sidekiq:                     node['gitlab']['config']['sidekiq'],
    gitlab_shell:                node['gitlab']['config']['gitlab_shell'],
    postgresql:                  node['gitlab']['config']['postgresql'],
    redis:                       node['gitlab']['config']['redis'],
    web_server:                  node['gitlab']['config']['web_server'],
    nginx:                       node['gitlab']['config']['nginx'],
    logging:                     node['gitlab']['config']['logging'],
    logrotate:                   node['gitlab']['config']['logrotate'],
    ci_external_url:             node['gitlab']['config']['ci_external_url'],
    gitlab_ci:                   node['gitlab']['config']['gitlab_ci'],
    ci_unicorn:                  node['gitlab']['config']['ci_unicorn'],
    ci_redis:                    node['gitlab']['config']['ci_redis'],
    ci_nginx:                    node['gitlab']['config']['ci_nginx'],
    mattermost_external_url:     node['gitlab']['config']['mattermost_external_url'],
    mattermost:                  node['gitlab']['config']['mattermost'],
    mattermost_nginx:            node['gitlab']['config']['mattermost_nginx']
  })
  notifies :reconfigure, 'gitlab_package[gitlab-ce]'
end
