# -*- coding: UTF-8 -*-

require 'uri'
require 'json'
require 'open-uri'

require File.dirname(__FILE__) + '/ud/formatting'

# This module provide some methods to scrape definitions from the Urban
# Dictionary website.
module UD
  class << self

    # @return [String] the current gem's version
    def version
      '0.2.5'
    end

    # Get the search URL to query for a given term.
    # @param term [String] the term to search for. It must be a string, spaces
    #                      are allowed.
    # @param api [Boolean] truthy if the API URL should be used.
    # @return [String]
    def search_url(term='', api=true)
      param = URI.encode_www_form('term' => term)

      if api
        "http://api.urbandictionary.com/v0/define?#{param}"
      else
        "http://www.urbandictionary.com/define.php?#{param}"
      end
    end

    # Open the search URL in the user's browser
    # @param term [String] the term to search for. It must be a string, spaces
    #                      are allowed.
    # @return [Nil]
    def open_url(term='')
      system open_cmd, search_url(term, false)
    end

    # Query the website and return a list of definitions for the provided term.
    # This list may be empty if there's no result.
    # @param term [String] the term to search for
    # @param opts [Hash] options. This is used by the command-line tool.
    #                    +:count+ is the maximum number of results to return,
    #                    +:ratio+ is the minimum upvotes/downvotes ratio. Other
    #                    options may be added in the future.
    # @return [Array<Hash>]
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
    # @param results [Array] this must be an array of results, as returned by
    #                        +UD.query+.
    # @param color [Boolean] colored output
    # @return [String]
    def format_results(results, color=true)
      UD::Formatting.text(results, color)
    end

    private

    def open_cmd
      case RbConfig::CONFIG["host_os"]
      when /darwin/
        "open"
      when /bsd|linux/
        "xdg-open"
      when /cygwin|mingw|mswin/
        "start"
      end
    end
  end
end
