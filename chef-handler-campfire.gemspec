# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib/chef/handler', __FILE__)
require 'campfire'

Gem::Specification.new do |s|
  s.name = 'chef-handler-campfire'
  s.version = Chef::Handler::Campfire::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Brian Scott', 'Greg Albrecht']
  s.email = ['brainscott@gmail.com', 'gba@splunk.com']
  s.homepage = 'https://github.com/ampledata/chef-handler-campfire'
  s.summary = 'Chef Exception & Reporting Handler for Campfire'
  s.description = 'Allows reporting of Chef Exceptions to Campfire Chat Rooms.'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_runtime_dependency('tinder')
end
