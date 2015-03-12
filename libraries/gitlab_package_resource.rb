class Chef
  class Resource
    class GitlabPackage < Chef::Resource::LWRPBase
      self.resource_name = 'gitlab_package'

      actions :install, :uninstall, :remove, :reconfigure
      default_action :install
      state_attrs :installed

      attribute :package_name, :kind_of => String, :name_attribute => true
      # Attributes for reconfigure step
      attribute :ctl_command, :kind_of => String, :default => 'gitlab-ctl'
      # Attributes for package
      attribute :options, :kind_of => String
      # Attributes for package download
      attribute :package_url, :kind_of => String
      attribute :checksum, :kind_of => String
      attribute :version, :kind_of => String, :default => nil
      attribute :installed, :kind_of => [TrueClass, FalseClass, NilClass], :default => false
      attribute :reconfigure, :kind_of => [TrueClass, FalseClass], default: false
    end
  end
end
