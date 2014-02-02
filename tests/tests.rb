#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'coveralls'
Coveralls.wear!

require 'test/unit'
require 'simplecov'

test_dir = File.expand_path( File.dirname(__FILE__) )

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start { add_filter '/tests/' }

require 'ud'

for t in Dir.glob( File.join( test_dir,  '*_tests.rb' ) )
  require t
end

class UDTests < Test::Unit::TestCase

  # == UD#version == #

  def test_ud_version
    assert(UD.version =~ /^\d+\.\d+\.\d+/)
  end

end


exit Test::Unit::AutoRunner.run
