# gitlab-omnibus-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gitlab-omnibus']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### gitlab-omnibus::default

Include `gitlab-omnibus` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[gitlab-omnibus::default]"
  ]
}
```

## License and Authors

Author:: Jeremy Olliver (<jeremy.olliver@gmail.com>)
