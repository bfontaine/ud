#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'uri'
require 'json'
require 'open-uri'

require File.dirname(__FILE__) + '/ud/formatting'

# This module provide some methods to scrape definitions from the Urban
# Dictionary website.
module UD
  class << self

    def version
      '0.1.3'
    end

    # Get the search URL to query for a given term.
    # [term] the term to search for. It must be a string, spaces are allowed
    def search_url(term='')
      param = URI.encode_www_form('term' => term)
      "http://api.urbandictionary.com/v0/define?#{param}"
    end

    # Get the text of an element. This is an helper for internal usage.
    def text(el)
      el.text.strip.gsub(/\r/, "\n")
    rescue
      ''
    end

    # Query the website and return a list of definitions for the provided term.
    # This list may be empty if there's no result.
    # [term] the term to search for
    # [opts] options. This is used by the command-line tool. +:count+ is the
    # maximum number of results to return, +:ratio+ is the minimum
    # upvotes/downvotes ratio. Other options may be added in the future.
    def query(term, *opts)

      opts = {:count => 1, :ratio => 0.0}.merge(opts[0] || {})

      return [] if opts[:count] <= 0

      resp = JSON.parse(open(search_url term).read, :symbolize_names => true)

      resp[:list].map do |res|
        {
          :id         => res[:defid],
          :word       => res[:word],
          :author     => res[:author],
          :permalink  => res[:permalink],
          :definition => res[:definition].strip,
          :example    => res[:example].strip,
          :upvotes    => res[:thumbs_up],
          :downvotes  => res[:thumbs_down]
        }
      end.keep_if do |d|
        d[:upvotes]/[d[:downvotes], 0.1].max.to_f >= opts[:ratio]
      end.take opts[:count]
    end

    # Format results for output
    # [results] this must be an array of results, as returned by +UD.query+.
    def format_results(results, color=true)
      UD::Formatting.text(results, color)
    end

  end
end
