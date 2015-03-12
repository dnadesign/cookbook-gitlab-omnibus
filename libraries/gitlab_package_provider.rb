# require 'uri'
# require 'pathname'

class Chef
  class Provider
    class GitlabPackage < Chef::Provider::LWRPBase

      use_inline_resources

      def whyrun_supported?
        true
      end

      def load_current_resource
        self.current_resource = Chef::Resource::GitlabPackage.new(new_resource.name)
        current_resource.package_name(new_resource.package_name)
        current_resource
      end

      action :install do

        package_filename = new_resource.package_url.split('/').last

        remote_file "#{Chef::Config[:file_cache_path]}/#{package_filename}" do
          source new_resource.package_url
          checksum new_resource.checksum
          action :create_if_missing
        end

        case node['platform_family']
        when 'debian'
          package_provider = Chef::Provider::Package::Dpkg
        when 'rhel', 'fedora'
          package_provider = Chef::Provider::Package::Rpm
        end

        package new_resource.package_name do
          source "#{Chef::Config[:file_cache_path]}/#{package_filename}"
          version new_resource.version
          options new_resource.options
          provider package_provider
        end

        if new_resource.reconfigure
          ctl_cmd = ctl_command
          execute "#{new_resource.package_name}-reconfigure" do
            command "#{ctl_cmd} reconfigure"
          end
        end
      end

      action :uninstall do
        package new_resource.package_name do
          action :remove
        end
      end

      action :remove do
        action_uninstall
      end

      action :reconfigure do
        ctl_cmd = ctl_command
        execute "#{new_resource.package_name}-reconfigure" do
          command "#{ctl_cmd} reconfigure"
        end
      end

      private

      def ctl_command
        new_resource.ctl_command
      end

      def reconfigure
        ctl_cmd = ctl_command
        execute "#{new_resource.package_name}-reconfigure" do
          command "#{ctl_cmd} reconfigure"
        end
      end

    end
  end
end
