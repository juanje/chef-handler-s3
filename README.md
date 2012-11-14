Description
===========

A Chef Exception & Reporting Handler for storing reports at [S3](http://aws.amazon.com/s3).

The gem install a exception/report handler for Chef that create a local simplified JSON report and then upload it to a S3 bucket.

This Chef Exception & Reporting Handler gem is heavily based on the [Campfire's one](https://github.com/ampledata/chef-handler-campfire) and the Chef's JsonFile handler.

Usage
=====

1. Create a [Amazon S3](http://aws.amazon.com/s3) account.
2. Retrieve your **ACCESS_KEY_ID** and your **SECRET_ACCESS_KEY**.
3. Create a bucket.
4. Download the [chef_handler](http://community.opscode.com/cookbooks/chef_handler)
Cookbook.
5. Given you've retrieved your S3 **ACCESS_KEY_ID** as `:access_key_id`, your **SECRET_ACCESS_KEY** as `:secret_access_key` and the bucket name as `:bucket_name`, add a Recipe similar to the example below:

```ruby
include_recipe "chef_handler::default"

%w{libxml2-dev libxslt1-dev}.each do |pkg|
  package pkg do
    action :nothing
  end.run_action(:install)
end

chef_gem 'aws-sdk'
chef_gem "chef-handler-s3"
gem "chef-handler-s3"

chef_handler 'Chef::Handler::S3' do
  source 'chef/handler/s3'
  arguments :access_key_id     => 'XXXXXXXXXXXXX',
            :secret_access_key => 'XXXXXXXXXXXXX',
            :bucket_name       => 'some_bucket_name',
            :folder            => 'some_bucket_folder_name'
  action :enable
end
```

The argument `:folder` is optional. This will store the file inside of a folder with that name at the pointed bucket.

See also: [Enable Chef Handler with LWRP](http://wiki.opscode.com/display/chef/Distributing+Chef+Handlers#DistributingChefHandlers-EnabletheChefHandlerwiththe%7B%7Bchefhandler%7D%7DLWRP)


Authors
============
1. [Juanje Ojeda](https://github.com/juanje)


Copyright
=========
Copyright 2012 Wantudu


License
=======
Apache License 2.0
