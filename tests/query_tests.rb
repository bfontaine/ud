#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

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

end

