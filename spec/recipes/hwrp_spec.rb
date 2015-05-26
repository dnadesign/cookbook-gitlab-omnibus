require_relative '../spec_helper'

describe 'gitlab-omnibus::default provider internals' do
  let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ['gitlab_package']).converge('gitlab-omnibus::default') }

  it 'adds gitlab packagecloud repo' do
    expect(chef_run).to create_packagecloud_repo('gitlab/gitlab-ce').with(type: 'deb')
  end

  it 'upgrades gitlab package' do
    expect(chef_run).to upgrade_package('gitlab-ce')
  end

end

describe 'centos gitlab-omnibus::default provider internals' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.4', step_into: ['gitlab_package']).converge('gitlab-omnibus') }

  it 'adds gitlab packagecloud repo' do
    expect(chef_run).to create_packagecloud_repo('gitlab/gitlab-ce').with(type: 'rpm')
  end

end
