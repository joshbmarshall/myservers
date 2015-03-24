Description
-----------
Cookbook to install [Vesta Control Panel](http://vestacp.com/).  Pass in an
admin password to have it set the admin password to something you know.

Requirements
------------
Chef 11+

Platform
--------
* CentOS

Recipes
-------
* `default`: Installs the Vesta control panel

Attributes
----------
* `node['vesta']['email']`: Email address of the Vesta administrator
* `node['vesta']['admin_password']`: Plain text password to use for the `admin` user

Usage
-----
On nodes, use the default recipe:
```javascript
{ "run_list": ["recipe[vesta]"] }
```

