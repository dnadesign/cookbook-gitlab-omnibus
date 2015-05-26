# gitlab-omnibus-cookbook

[![Circle CI](https://circleci.com/gh/dnadesign/cookbook-gitlab-omnibus.svg?style=svg)](https://circleci.com/gh/dnadesign/cookbook-gitlab-omnibus)

This chef cookbook downloads the official gitlab-omnibus package, and installs it.
This cookbook also manages the configuration for the installation at `/etc/gitlab/gitlab.rb` which can be configurated via attributes in this cookbook. For a full list of available options, see [the omnibus template](https://gitlab.com/gitlab-org/omnibus-gitlab/raw/master/files/gitlab-config-template/gitlab.rb.template) for the corresponding version that you are installing.

This cookbook does not manage SSL Certificates for you, it is up to you to manage with another cookbok, or manually - To configure TLS, set the appropriate attributes to point this cookbook at your certificate on disk.

## Supported Platforms

Out of the box, this cookbook supports ubuntu, debian, redhat, centos, amazon, scientific - as those are the platforms gitlab builds their omnibus package for. Check https://about.gitlab.com/downloads/ for a list of up to date supported platforms. You may also compile your own packages with https://gitlab.com/gitlab-org/omnibus-gitlab/

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gitlab']['version']</tt></td>
    <td>String</td>
    <td>The package version number</td>
    <td><tt>'7.11.2'</tt></td>
  </tr>
</table>

Further configuration of the installation is managed via:

* `['gitlab']['config']['external_url']` (String)
* `['gitlab']['config']['ci_external_url']` (String)
* `['gitlab']['config']['gitlab_rails']` (Hash)
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

See [the omnibus template](https://gitlab.com/gitlab-org/omnibus-gitlab/raw/7-11-stable/files/gitlab-config-template/gitlab.rb.template) for a list of available options.

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

The default admin password is user: `root` password: `5iveL!fe`

## Gitlab CI setup

Gitlab CI setup is a little trickier. While the gitlab package installed by this cookbook does include gitlab-ci (which can be enabled or disabled), it should be noted that the gitlab-ci service is actually a co-ordinator, and another 'job runner' service is required to actually run the jobs. Note: _A runner service is **not** included_ in this recipe, there are multiple projects that can fulfil this need, such as https://github.com/gitlabhq/gitlab-ci-runner#installation or https://github.com/ayufan/gitlab-ci-multi-runner

Below are the steps to setup authentication between gitlab and the gitlab-ci co-ordinator service

1. Run chef with this recipe
2. Browse to your gitlab URL in a browser, and login (default credentials are user: `root` password: `5iveL!fe`)
3. Navigate to the Admin > Applications section, and create a new application. Give it a name like 'Gitlab CI' and use `http://GITLABCI_DOMAIN/user_sessions/callback` for the URL.
4. This will provide you with an application id, and secret. Set these as attributes on your gitlabci node at `['gitlab']['config']['gitlab_ci']['app_id']` and `['gitlab']['config']['gitlab_ci']['app_secret']`
5. Re-run this chef recipe which fills those items into the config file, and reconfigures the service
6. Browse to your Gitlab CI url, and now login via gitlab. Click 'Authorize', and you'll be logged into gitlab ci.

Example node attributes:

```json
{
  "gitlab": {
    "config": {
      "external_url": "https://gitlab.example.com",
      "ci_external_url": "https://gitlab-ci.example.com",
      "nginx": {
        "ssl_certificate": "/etc/ssl/private/star.example.crt",
        "ssl_certificate_key": "/etc/ssl/private/star.example.key"
      },
      "gitlab_ci": {
        "gitlab_server": {
          "url": "https://gitlab.example.com",
          "app_id": "ed3a1e278da9872c5df75907157296bc28d8e14feb28c1b37087a6c94b127e85",
          "app_secret": "b2c08175e85d74fdd2996e3041c88d63a34a615119e851e8fb24a60d573d3dd9"
        }
      }
    }
  }
}
```

Configuring the runner requires additional setup from the gitlab-ci admin interface.

## License and Authors

Author:: Jeremy Olliver (<jeremy.olliver@gmail.com>)
