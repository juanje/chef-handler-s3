# -*- encoding: utf-8 -*-
require 'aws-sdk'
$:.unshift(File.dirname(__FILE__) + '/lib')

require 'chef/handler/s3'

Gem::Specification.new do |s|
  s.name = 'chef-handler-s3'
  s.version = Chef::Handler::S3::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = 'Juanje Ojeda'
  s.email = 'juanje.ojeda@gmail.com'
  s.homepage = 'https://github.com/juanje/chef-handler-s3'
  s.summary = 'Chef Exception & Reporting Handler for storing reports at S3'
  s.description = 'Allows storing reports of Chef Exceptions to S3.'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_dependency 'aws-sdk'
end
