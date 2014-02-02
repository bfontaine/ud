#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'fakeweb'

RESPONSES_DIR = "#{File.expand_path(File.dirname(__FILE__))}/responses"
BASE_URL = 'http://api.urbandictionary.com/v0/define'

FakeWeb.allow_net_connect = %r[^https?://coveralls\.io]

Dir["#{RESPONSES_DIR}/*.json"].each do |f|
  next if f !~ /\/(\w+)\.json$/
  term = $1
  puts "registering fake response for #{term}."
  FakeWeb.register_uri(
    :get,
    "#{BASE_URL}?term=#{term}",
    :body => File.read(f)
  )
end
