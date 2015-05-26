if defined?(ChefSpec)
  def install_gitlab_package(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gitlab_package, :install, resource_name)
  end

  def reconfigure_gitlab(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gitlab_package, :reconfigure, resource_name)
  end
end
