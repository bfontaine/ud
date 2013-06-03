#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'test/unit'
require 'simplecov'

test_dir = File.expand_path( File.dirname(__FILE__) )

SimpleCov.start { add_filter '/tests/' } if ENV['COVERAGE']

require 'ud'

for t in Dir.glob( File.join( test_dir,  '*_tests.rb' ) )
  require t
end

exit Test::Unit::AutoRunner.run
