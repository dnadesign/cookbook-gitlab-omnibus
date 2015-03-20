# gitlab-omnibus-cookbook

This chef cookbook downloads the official gitlab-omnibus package, and installs it.
This cookbook also manages the configuration for the installation at `/etc/gitlab/gitlab.rb` which can be configurated via attributes in this cookbook. For a full list of available options, see https://gitlab.com/gitlab-org/omnibus-gitlab/raw/master/files/gitlab-config-template/gitlab.rb.template for the corresponding version that you are installing.

This cookbook does not manage SSL Certificates for you, it is up to you to manage with another cookbok, or manually - To configure TLS, set the appropriate attributes to point this cookbook at your certificate on disk.

## Supported Platforms

This cookbook should support all platforms that the omnibus packages support.
See https://about.gitlab.com/downloads/archives/ && https://about.gitlab.com/downloads/ for more details about the packages available - or compile your own with https://gitlab.com/gitlab-org/omnibus-gitlab/

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gitlab']['omnibus']['package_version']</tt></td>
    <td>String</td>
    <td>The package version number</td>
    <td><tt>'7.8.2-omnibus.1-1'</tt></td>
  </tr>
  <tr>
    <td><tt>['gitlab']['omnibus']['url']</tt></td>
    <td>String</td>
    <td>The URL to download the package from</td>
    <td>Determined based on platform</td>
  </tr>
  <tr>
    <td><tt>['gitlab']['omnibus']['checksum']</tt></td>
    <td>String</td>
    <td>The sha256 checksum of the package you are downloading</td>
    <td></td>
  </tr>
</table>

Further configuration of the installation is managed via:

* `['gitlab']['config']['external_url']` (String)
* `['gitlab']['config']['ci_external_url']` (String)
* `['gitlab']['config']['gitlab_rails']` (Hash)
* `['gitlab']['config']['ldap_servers']` (Hash)
* `['gitlab']['config']['user']` (Hash)
* `['gitlab']['config']['unicorn']` (Hash)
* `['gitlab']['config']['sidekiq']` (Hash)
* `['gitlab']['config']['gitlab_shell']` (Hash)
* `['gitlab']['config']['postgresql']` (Hash)
* `['gitlab']['config']['redis']` (Hash)
* `['gitlab']['config']['web_server']` (Hash)
* `['gitlab']['config']['nginx']` (Hash)
* `['gitlab']['config']['logging']` (Hash)
* `['gitlab']['config']['logrotate']` (Hash)
* `['gitlab']['config']['gitlab_ci']` (Hash)
* `['gitlab']['config']['ci_unicorn']` (Hash)
* `['gitlab']['config']['ci_redis']` (Hash)
* `['gitlab']['config']['ci_nginx']` (Hash)

See https://gitlab.com/gitlab-org/omnibus-gitlab/raw/master/files/gitlab-config-template/gitlab.rb.template for a list of available options.

## Usage

### gitlab-omnibus::default

Include `gitlab-omnibus` in your node's `run_list`:

```json
{
  "gitlab": {
    "config": {
      "external_url": "https://gitlab.example.com/",
      "ci_external_url": "https://gitlab-ci.example.com/",
      "nginx": {
        "ssl_certificate": "/etc/gitlab/ssl/star-example-com.crt",
        "ssl_certificate_key": "/etc/gitlab/ssl/star-example-com.key"
      }
    }
  },
  "run_list": [
    "recipe[gitlab-omnibus::default]"
  ]
}
```

## License and Authors

Author:: Jeremy Olliver (<jeremy.olliver@gmail.com>)
