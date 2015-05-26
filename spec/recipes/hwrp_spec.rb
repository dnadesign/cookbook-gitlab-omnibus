require_relative '../spec_helper'

describe 'gitlab-omnibus::default provider internals' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['gitlab_package']).converge('gitlab-omnibus::default')
  end

  it 'adds gitlab packagecloud repo' do
    expect(chef_run).to create_packagecloud_repo('gitlab/gitlab-ce').with(type: 'deb')
  end

  it 'upgrades gitlab package' do
    expect(chef_run).to upgrade_package('gitlab-ce')
  end

end

describe 'centos gitlab-omnibus::default provider internals' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS.merge(step_into: ['gitlab_package'])).converge('gitlab-omnibus')
  end

  it 'adds gitlab packagecloud repo' do
    expect(chef_run).to create_packagecloud_repo('gitlab/gitlab-ce').with(type: 'rpm')
  end

end
