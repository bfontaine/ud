#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'uri'
require 'json'
require 'open-uri'
require 'nokogiri'

require File.dirname(__FILE__) + '/ud/formatting'

# This module provide some methods to scrape definitions from the Urban
# Dictionary website.
module UD

  # The current version of the module
  def UD.version
    '0.1.2'
  end

  # Get the search URL to query for a given term.
  # [term] the term to search for. It must be a string, spaces are allowed
  def UD.search_url(term='')
    param = URI.encode_www_form('term' => term)
    "http://www.urbandictionary.com/define.php?#{param}"
  end

  # Get the thumbs (up/down) for a list of definitions' ids.
  # This is an helper for internal usage.
  def UD.thumbs(ids)

    param = URI.encode_www_form('ids' => ids.join(','))
    json = open "http://api.urbandictionary.com/v0/uncacheable?#{param}"

    response = JSON.parse(json.read)
    thumbs   = {}

    response['thumbs'].each do |t|

      thumbs[t['defid']] = {
        :up   => t['thumbs_up'],
        :down => t['thumbs_down']
      }

    end

    thumbs
  end

  # Get the text of an element. This is an helper for internal usage.
  def UD.text(el)
    el.text.strip.gsub(/\r/, "\n")
  rescue
    ''
  end

  # Query the website and return a list of definitions for the provided term.
  # This list may be empty if there's no result. It only scraps the first
  # page of results.
  # [term] the term to search for
  # [opts] options. This is used by the command-line tool. +:count+ is the
  # maximum number of results to return, +:ratio+ is the minimum
  # upvotes/downvotes ratio. Other options may be added in the future.
  def UD.query(term, *opts)

    opts = {:count => 1, :ratio => 0.0}.merge(opts[0] || {})

    return [] if opts[:count] <= 0

    url = search_url(term)
    doc = Nokogiri::HTML(open(url))

    return [] unless doc.css('#not_defined_yet').empty?

    words = doc.css('#entries .box')
    ids   = words.take(opts[:count]).map do |w|
      w.css('.thumb.up').first.attr('data-defid')
    end

    thumbs = thumbs(ids)

    if opts[:ratio] > 0
      ids.delete_if do |id|
        t = thumbs[id.to_i] || {:up => 1, :down => 1}
        (t[:up] / t[:down].to_f) < opts[:ratio]
      end
    end

    ids.map do |id|

      box = doc.css(".add_to_list[data-defid=\"#{id}\"]").first.parent

      word = text box.css(".word > a").first
      t    = thumbs[id.to_i] || {}

      {
        :id => id,
        :word => word,
        :definition => text(box.css('.definition')),
        :example => text(box.css('.example')),
        :upvotes => t[:up],
        :downvotes => t[:down]

      }

    end

  end

  # Format results for output
  # [results] this must be an array of results, as returned by +UD.query+.
  def UD.format_results(results, color=true)
    UD::Formatting.text(results, color)
  end

end
