#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'fakeweb'

# No ids
FakeWeb.register_uri(
  :get,
  'http://api.urbandictionary.com/v0/uncacheable?ids=',
  :body => '{"thumbs":[]}'
)

# One id
FakeWeb.register_uri(
  :get,
  'http://api.urbandictionary.com/v0/uncacheable?ids=42',
  :body => '{"thumbs":[{"defid":42,"thumbs_up":2,"thumbs_down":1}]}'
)

class UD_Formatting_test < Test::Unit::TestCase

  ROOT_URL = 'http://www.urbandictionary.com'

  # == UD#search_url == #

  def test_search_url_empty_term
    assert_equal(
      "#{ROOT_URL}/define.php?term=",
      UD.search_url())
      assert_equal(
        "#{ROOT_URL}/define.php?term=",
        UD.search_url(''))
  end

  def test_search_url_spaces_in_term
    assert_equal(
      "#{ROOT_URL}/define.php?term=a+b",
      UD.search_url('a b'))
  end

  def test_search_url_encode_special_chars
    assert_equal(
      "#{ROOT_URL}/define.php?term=%3D",
      UD.search_url('='))
  end

  def test_search_url
    assert_equal(
      "#{ROOT_URL}/define.php?term=foo",
      UD.search_url('foo'))
  end

  # == UD#thumbs == #

  def test_thumbs_no_ids
    assert_equal({}, UD.thumbs([]))
  end

  def test_thumbs_one_id
    assert_equal({42 =>{:up => 2, :down => 1}}, UD.thumbs([42]))
  end

end

