#!/usr/bin/env ruby
# Chef Exception & Reporting Handler for Campfire.
#
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Author:: Brian Scott <mailto:brainscott@gmail.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


require 'rubygems'
require 'chef/handler'
require 'tinder'



class Chef
  class Handler
    class Campfire < Chef::Handler
      VERSION = '2.0.2'

      def initialize(subdomain, token, room)
        @subdomain = subdomain
        @token = token
        @room = room
      end

      def report
        if run_status.failed?
          Chef::Log.error('Creating Campfire exception report.')
          campfire = Tinder::Campfire.new(@subdomain, :token => @token)

          room = if @room.nil?
                   campfire.rooms.first
                 else
                   campfire.find_room_by_id(@room.to_i)
                 end

          room.speak([node.hostname, run_status.formatted_exception].join(' '))
          room.paste(Array(backtrace).join('\n'))
        end
      end
    end
  end
end
