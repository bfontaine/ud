#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require File.dirname(__FILE__) + '/fake_responses'

class UD_Query_test < Test::Unit::TestCase

  API_URL = 'http://api.urbandictionary.com/v0/define'
  ROOT_URL = 'http://www.urbandictionary.com/define.php'

  def setup
    @foo, @bar = [
      {
        :id => 1,
        :author => 'a1',
        :permalink => 'http://example.com/1',
        :word => 'foo',
        :definition => 'A',
        :example => 'AA',
        :upvotes => 42,
        :downvotes => 17

      },
      {
        :id => 2,
        :author => 'a2',
        :permalink => 'http://example.com/2',
        :word => 'bar',
        :definition => 'B',
        :example => 'BB',
        :upvotes => 17,
        :downvotes => 42
      }
    ]
  end

  # == UD#search_url == #

  def test_search_url_empty_term
    assert_equal("#{API_URL}?term=", UD.search_url(''))
  end

  def test_search_url_empty_term_nonapi
    assert_equal("#{ROOT_URL}?term=", UD.search_url('', :api => false))
  end

  def test_search_url_spaces_in_term
    assert_equal("#{API_URL}?term=a+b", UD.search_url('a b'))
  end

  def test_search_url_encode_special_chars
    assert_equal("#{API_URL}?term=%3D", UD.search_url('='))
  end

  def test_search_url
    assert_equal("#{API_URL}?term=foo", UD.search_url('foo'))
  end

  # == UD#random_url == #

  def test_random_url
    assert_equal("http://api.urbandictionary.com/v0/random", UD.random_url)
  end

  # == UD#query == #

  def test_query_no_results
    assert_equal([], UD.query('fooo'))
  end

  def test_query_two_results
    assert_equal([@foo, @bar], UD.query('two_results', :count => 2))
  end

  def test_query_count
    assert_equal([@foo], UD.query('two_results', :count => 1))
  end
end

