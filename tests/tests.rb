#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

ci = ENV["CI"] || ENV["CONTINUOUS_INTEGRATION"]

if ci
  require 'coveralls'
  Coveralls.wear!
end

require 'test/unit'
require 'simplecov'

test_dir = File.expand_path( File.dirname(__FILE__) )

SimpleCov.formatter = Coveralls::SimpleCov::Formatter if ci
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

  # == UD#open_cmd (private) == #

  def test_ud_open_cmd
    os = RbConfig::CONFIG["host_os"]

    RbConfig::CONFIG["host_os"] = "darwin"
    assert_equal "open", UD.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = "linux"
    assert_equal "xdg-open", UD.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = "bsd"
    assert_equal "xdg-open", UD.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = "cygwin"
    assert_equal "start", UD.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = os
  end

end


exit Test::Unit::AutoRunner.run
