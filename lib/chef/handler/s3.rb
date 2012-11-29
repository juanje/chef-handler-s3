#!/usr/bin/env ruby
# Chef Exception & Reporting Handler for storing reports at S3.
#
# Author:: Juanje Ojeda <juanje.ojeda@gmail.com>
# Copyright:: Copyright 2012 Wantudu.
# License:: Apache License 2.0
#

require 'rubygems'
require 'chef/handler'
require 'aws-sdk'

class Chef
  class Handler
    class S3 < ::Chef::Handler
      VERSION = '0.1.0'

      attr_reader :config

      def initialize(config={})
        @config = config
        @config[:path] ||= "/var/chef/reports"
        @config
      end

      def upload_file(file_path)
        bucket_name = config[:bucket_name]
        file_name = File.basename(file_path)

        AWS.config(
          :access_key_id => config[:access_key_id],
          :secret_access_key => config[:secret_access_key]
        )

        s3 = AWS::S3.new
        if s3.buckets[bucket_name].exists?
          bucket = s3.buckets[bucket_name]
        else
          bucket = s3.buckets.create(bucket_name)
        end

        if config.include? :folder
          key = "#{config[:folder]}/#{file_name}"
        else
          key = file_name
        end

        bucket.objects[key].write(:file => file_path)
        Chef::Log.info("Uploading file #{file_name} to bucket #{bucket_name}.")
      end

      def report
        run_data = Hash.new
        if run_status.failed?
          Chef::Log.error("Creating JSON exception report")
          run_data[:formatted_exception] = run_status.formatted_exception.split("\n")
          run_data[:exception] = run_status.exception.split("\n")
          run_data[:backtrace] = run_status.backtrace
        else
          Chef::Log.info("Creating JSON run report")
        end

        build_report_dir

        savetime = Time.now.strftime("%Y%m%d%H%M%S")
        run_data[:name] = node.name
        run_data[:fqdn] = node.fqdn
        run_data[:success] = run_status.success?
        run_data[:start_time] = run_status.start_time
        run_data[:end_time] = run_status.end_time
        run_data[:duration] = run_status.elapsed_time
        run_data[:updated_resources] = []
        run_status.updated_resources.each do |resource|
          run_data[:updated_resources] << {
            :name     => resource.name,
            :kind     => resource.resource_name,
            :provider => resource.provider,
            :action   => resource.action
          }
        end

        if node.include? :cloud
          run_data[:ipaddress] = node.cloud.public_ipv4
        else
          run_data[:ipaddress] = node.ipaddress
        end

        file_path = File.join(config[:path], "#{node.name}-#{savetime}.json")
        File.open(file_path, "w") do |file|
          file.puts Chef::JSONCompat.to_json_pretty(run_data)
        end

        upload_file(file_path)
      end

      def build_report_dir
        unless File.exists?(config[:path])
          FileUtils.mkdir_p(config[:path])
          File.chmod(00700, config[:path])
        end
      end

    end
  end
end
