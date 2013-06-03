#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require File.dirname(__FILE__) + '/fake_responses'

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

  # == UD#query == #

  def test_query_no_results
    assert_equal([], UD.query('nothing'))
  end

  def test_query_two_results

    expected = [
      {
        :id => '1',
        :word => 'foo',
        :definition => 'A',
        :example => 'AA',
        :upvotes => 1,
        :downvotes => 1

      },
      {
        :id => '2',
        :word => 'bar',
        :definition => 'B',
        :example => 'BB',
        :upvotes => 2,
        :downvotes => 1
      }
    ]

    assert_equal(expected, UD.query('two'))
  end

  def test_query_count
    expected = [
      {
        :id => '1',
        :word => 'foo',
        :definition => 'A',
        :example => 'AA',
        :upvotes => 1,
        :downvotes => 1
      }
    ]

    assert_equal(expected, UD.query('two', :count => 1))
  end

  def test_query_ratio
    expected = [
      {
        :id => '2',
        :word => 'bar',
        :definition => 'B',
        :example => 'BB',
        :upvotes => 2,
        :downvotes => 1
      }
    ]

    assert_equal(expected, UD.query('two', :ratio => 1.5))
  end

end

