Description
===========

A Chef Exception & Reporting Handler for 37signal's 
[Campfire](http://www.campfirenow.com).

Usage
=====

1. Create a 37signals [Campfire](http://www.campfirenow.com) account.
2. Retrieve your Campfire Token. URL TK
3. Create a Campfire Room. URL TK
4. Download the [chef_handler](http://community.opscode.com/cookbooks/chef_handler)
Cookbook.
5. Given you've retrieved your Campfire Token as **TOKEN**, your Room ID as 
**ROOM** and Subdomain as **SUBDOMAIN**, add a Recipe similar to the example 
below:

```ruby
include_recipe 'chef_handler'

gem_package('chef-handler-campfire'){action :nothing}.run_action(:install)

chef_handler 'Chef::Handler::Campfire' do
  action :enable
  token 'TOKEN'
  room 'ROOM'
  subdomain 'SUBDOMAIN'
  source File.join(Gem.all_load_paths.grep(/chef-handler-campfire/).first,
                   'chef', 'handler', 'campfire.rb')
end
```

See also: [Enable Chef Handler with LWRP](http://wiki.opscode.com/display/chef/Distributing+Chef+Handlers#DistributingChefHandlers-EnabletheChefHandlerwiththe%7B%7Bchefhandler%7D%7DLWRP)


Authors
============
1. [Umang Chouhan](https://github.com/uchouhan) for the campfire gem.
2. [Brain Scott](https://github.com/bscott) for the original campfire_handler gem.
3. [Greg Albrecht](https://github.com/ampledata) for chef-handler-campfire gem.


Copyright
=========
Copyright 2012 Splunk, Inc.


License
=======
Apache License 2.0
