#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'uri'
require 'json'
require 'open-uri'
require 'nokogiri'

module UD

    # Get the search URL to query for a given term
    def UD.search_url(term)
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
    def UD.query(term)
        url = search_url(term)
        doc = Nokogiri::HTML(open(url))

        return [] unless doc.css('#not_defined_yet').empty?

        words = doc.css('.word[data-defid]')
        ids   = words.map { |w| w.attr('data-defid') }

        thumbs = thumbs(ids)

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
    def UD.format_results(results)

        results.each do |r|

            puts "* #{r[:word]} (#{r[:upvotes]}/#{r[:downvotes]}):"
            puts ''
            puts " \t#{r[:definition].gsub(/\n/, "\n\t")}\n"
            puts ' Example:'
            puts " \t#{r[:example].gsub(/\n/, "\n\t")}"
            puts "\n\n"

        end

    end

end
