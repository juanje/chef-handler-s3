# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib/chef/handler', __FILE__)

require 'campfire'


task :build do
  system 'gem build chef-handler-campfire.gemspec'
end

task :release do
  system "gem push chef-handler-campfire-#{Chef::Handler::Campfire}.gem"
end

task :default => :build
