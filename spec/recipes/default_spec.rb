require_relative '../spec_helper'

describe 'gitlab-omnibus::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs gitlab package' do
    expect(chef_run).to install_gitlab_package('gitlab-ce')
  end

  it 'generates gitlab config' do
    expect(chef_run).to render_file('/etc/gitlab/gitlab.rb')
  end

  it 'reconfigures gitlab service' do
    resource = chef_run.template('/etc/gitlab/gitlab.rb')
    expect(resource).to notify('gitlab_package[gitlab-ce]').to(:reconfigure)
  end
end

describe 'setting custom version of gitlab' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['gitlab']['version'] = '7.10.4'
    end.converge('gitlab-omnibus::default')
  end

  it 'installs the correct version of gitlab' do
    expect(chef_run).to install_gitlab_package('gitlab-ce').with_version("7.10.4")
  end
end
