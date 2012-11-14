# -*- encoding: utf-8 -*-
require 'aws-sdk'
$:.unshift(File.dirname(__FILE__) + '/lib')

require 'chef/handler/s3'

task :build do
  system 'gem build chef-handler-s3.gemspec'
end

task :release do
  system "gem push chef-handler-s3-#{Chef::Handler::S3::VERSION}.gem"
end

task :default => :build
