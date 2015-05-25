class Chef
  class Resource
    class GitlabPackage < Chef::Resource::LWRPBase
      self.resource_name = 'gitlab_package'

      actions :install, :uninstall, :remove, :reconfigure
      default_action :install
      state_attrs :installed

      attribute :package_name, :kind_of => String, :name_attribute => true, :default => 'gitlab-ce'
      attribute :version, :kind_of => String, :default => nil
      attribute :package_repo, :kind_of => String, :default => 'gitlab/gitlab-ce'
      attribute :repo_base_url, :kind_of => String, :default => 'https://packages.gitlab.com'

      # Attributes for reconfigure step
      attribute :ctl_command, :kind_of => String, :default => 'gitlab-ctl'
      # Attributes for package download
      attribute :installed, :kind_of => [TrueClass, FalseClass, NilClass], :default => false
      attribute :reconfigure, :kind_of => [TrueClass, FalseClass], default: false
    end
  end
end
