#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

module UD
  module Formatting

    # Fit a text in a given width (number of chars). It returns
    # a list of lines of text.
    def self.fit(txt, width=79)
      # from http://stackoverflow.com/a/7567210/735926
      txt.split("\n").map{|l| l.scan(/(.{1,#{width}})(?:\s|$)/m) }.flatten
    end

  end
end
