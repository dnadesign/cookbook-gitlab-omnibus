class Chef
  class Provider
    class GitlabPackage < Chef::Provider::LWRPBase

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def load_current_resource
        self.current_resource = Chef::Resource::GitlabPackage.new(new_resource.name)
        current_resource.package_name(new_resource.package_name)
        current_resource
      end

      action :install do

        packagecloud_repo "gitlab/gitlab-ce" do
          base_url new_resource.repo_base_url
          type node['gitlab']['package_format']
        end

        package new_resource.package_name do
          version new_resource.version
          action :upgrade
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
