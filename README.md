# consul

Provides install/config recipes for [consul.io](http://consul.io) consul agent.
Also provides LWRP for service and check definitions.

## Supported Platforms

Known to work on Ubuntu. May work on others.

_Tests to come soon_

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['consul']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### consul::default

Include `consul` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Brandon Dennis (<dennis@kyck.com>)
