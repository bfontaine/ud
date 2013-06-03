#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

class FakeHTMLElement

  attr_reader :text

  def initialize(txt='')
    @text = txt
  end
end

class UD_Formatting_test < Test::Unit::TestCase

  # == UD#text == #

  def test_text_empty
    el = FakeHTMLElement.new
    assert_equal('', UD.text(el))
  end

  def test_text_trailing_spaces
    el = FakeHTMLElement.new('foo    ')
    assert_equal('foo', UD.text(el))

    el = FakeHTMLElement.new(" bar \n")
    assert_equal('bar', UD.text(el))
  end

  def test_text_newline
    el = FakeHTMLElement.new("a\rb")
    assert_equal("a\nb", UD.text(el))

    el = FakeHTMLElement.new("a\nb")
    assert_equal("a\nb", UD.text(el))
  end

  def test_text_invalid_element
    assert_equal('', UD.text(nil))
    assert_equal('', UD.text(true))
    assert_equal('', UD.text('foo'))
  end

  # == UD#format_results == #

  def test_format_results_empty_list
    assert_equal('', UD.format_results([]))
  end

  def test_format_results_one_element
    res = {
      :word => 'XYZ',
      :upvotes => 42,
      :downvotes => 78,
      :definition => 'xyz',
      :example => 'zyx'
    }

    output = UD.format_results([res]).strip
    expected = <<EOS
* XYZ (42/78):

 \txyz

 Example:
 \tzyx
EOS

    assert_equal(expected.strip, output)

  end

end
