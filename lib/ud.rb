# -*- coding: UTF-8 -*-

require "uri"
require "json"

require "defcli"

# This module provide some methods to scrape definitions from the Urban
# Dictionary website.
module UD
  class << self
    # @return [String] the current gem's version
    def version
      "0.4.0"
    end

    API_ROOT = "https://api.urbandictionary.com/v0"
    WWW_ROOT = "https://www.urbandictionary.com"

    # Get the search URL to query for a given term.
    # @param term [String] the term to search for. It must be a string, spaces
    #                      are allowed.
    # @param opts [Hash] options.
    # @return [String]
    def search_url(term, opts = {})
      param = URI.encode_www_form("term" => term)

      if opts[:api] != false
        "#{API_ROOT}/define?#{param}"
      else
        "#{WWW_ROOT}/define.php?#{param}"
      end
    end

    # Return a URL for a random definition.
    # @param opts [Hash] options.
    def random_url(opts = {})
      if opts[:api] != false
        "#{API_ROOT}/random"
      else
        "#{WWW_ROOT}/random.php"
      end
    end

    # Open the search URL in the user's browser
    # @param term [String] the term to search for. It must be a string, spaces
    #                      are allowed.
    # @return [Nil]
    def open_url(term)
      Defcli.open_in_browser search_url(term, :api => false)
    end

    # Open a random definition URL in the user's browser
    # @return [Nil]
    def open_random
      Defcli.open_in_browser random_url(:api => false)
    end

    # Query the website and return a list of definitions for the provided term.
    # This list may be empty if there's no result.
    # @param term [String] the term to search for
    # @param opts [Hash] options. This is used by the command-line tool.
    #                    +:count+ is the maximum number of results to return
    # @return [Array<Hash>]
    def query(term, opts = {})
      parse_response(Defcli.read_url(search_url(term)), opts)
    end

    # Return a random definition
    # @param opts [Hash] options.
    def random(opts = {})
      parse_response(Defcli.read_url(random_url), opts)
    end

    # Parse a response from the Urban Dictionary website.
    # @param opts [Hash] options. This is used by the command-line tool.
    #                    +:count+ is the maximum number of results to return
    # @return [Array<Hash>]
    def parse_response(text, opts = {})
      opts = { :count => 1 }.merge(opts || {})

      return [] if opts[:count] <= 0

      resp = JSON.parse(text, :symbolize_names => true)

      results = resp[:list].map do |res|
        {
          :id         => res[:defid],
          :word       => res[:word],
          :author     => res[:author],
          :permalink  => res[:permalink],
          :definition => res[:definition].strip,
          :example    => res[:example].strip,
          :upvotes    => res[:thumbs_up],
          :downvotes  => res[:thumbs_down],
        }
      end

      results.take opts[:count]
    end

    # Format results for output
    # @param results [Array] this must be an array of results, as returned by
    #                        +UD.query+.
    # @param color [Boolean] colored output
    # @return [String]
    def format_results(results, color = true)
      Defcli.format_results(results, color)
    end
  end
end
