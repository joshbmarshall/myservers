csf Cookbook
====================

This cookbook adds a /usr/bin/backup script to

Attributes
----------

#### csf::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['csf']['todo']</tt></td>
    <td></td>
    <td></td>
    <td><tt>blank</tt></td>
  </tr>
</table>

Usage
-----
#### csf::default

Just include `csf` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[csf]"
  ]
}
```

OR

Add the following line to your default.rb:

include_recipe 'csf'

And add the following line to your metadata.rb:

depends "csf"

License and Authors
-------------------
Authors: Josh Marshall
