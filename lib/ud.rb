#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'uri'
require 'json'
require 'open-uri'
require 'nokogiri'

module UD

  def UD.version
    '0.1.1'
  end

  # Get the search URL to query for a given term
  def UD.search_url(term='')
    param = URI.encode_www_form('term' => term)
    "http://www.urbandictionary.com/define.php?#{param}"
  end

  # Get the thumbs (up/down) for a list of definitions (ids)
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

  # Get the text of an element
  def UD.text(el)
    el.text.strip.gsub(/\r/, "\n")
  rescue
    ''
  end

  # Query the website and return a list of definitions for the provided term.
  # This list may be empty if there's no results. It only scraps the first
  # page of results, since it's generally sufficient.
  def UD.query(term, *opts)

    opts = opts[0] || { :count => 10, :ratio => 0.0 }

    return [] if opts[:count] <= 0

    url = search_url(term)
    doc = Nokogiri::HTML(open(url))

    return [] unless doc.css('#not_defined_yet').empty?

    words = doc.css('.word[data-defid]')
    ids   = words.map { |w| w.attr('data-defid') }.take opts[:count]

    thumbs = thumbs(ids)

    if opts[:ratio] > 0
      ids.delete_if do |id|
        t = thumbs[id.to_i] || {:up => 1, :down => 1}
        (t[:up] / t[:down].to_f) < opts[:ratio]
      end
    end

    ids.map do |id|

      word = text doc.css(".word[data-defid=\"#{id}\"] > span").first
      body = doc.css("#entry_#{id}")
      t    = thumbs[id.to_i] || {}

      {
        :id => id,
        :word => word,
        :definition => text(body.css('.definition')),
        :example => text(body.css('.example')),
        :upvotes => t[:up],
        :downvotes => t[:down]

      }

    end

  end

  # Format results for output, and print them
  def UD.format_results(results, color=true)

    results.map do |r|

      s = ''

      s << "* #{r[:word]} (#{r[:upvotes]}/#{r[:downvotes]}):\n"
      s << "\n"
      s << " \t#{r[:definition].gsub(/\n/, "\n\t")}\n\n"
      s << " Example:\n"
      s << " \t#{r[:example].gsub(/\n/, "\n\t")}\n"
      s << "\n\n"

    end.join("\n")

  end

end
