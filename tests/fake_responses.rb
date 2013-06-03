#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'fakeweb'

# == Thumbs up/down == #

thumbs_url = 'http://api.urbandictionary.com/v0/uncacheable'

# No ids
FakeWeb.register_uri(
  :get,
  "#{thumbs_url}?ids=",
  :body => '{"thumbs":[]}'
)

# One id
FakeWeb.register_uri(
  :get,
  "#{thumbs_url}?ids=42",
  :body => '{"thumbs":[{"defid":42,"thumbs_up":2,"thumbs_down":1}]}'
)

# Multiple ids
FakeWeb.register_uri(
  :get,
  "#{thumbs_url}?ids=1%2C2",
  :body => '{"thumbs":[{"defid":1,"thumbs_up":1,"thumbs_down":1},' +
           '{"defid":2,"thumbs_up":2,"thumbs_down":2}]}'
)

# == Definitions queries == #

def_url = 'http://www.urbandictionary.com/define.php'

# No results
FakeWeb.register_uri(
  :get,
  "#{def_url}?term=nothing",
  :body => '<body><span id="not_defined_yet"></span></body>'
)

FakeWeb.register_uri(
  :get,
  "#{def_url}?term=two",
  :body => <<EOS
<body>
  <div class="word" data-defid="1">
    <span>foo</span>
  </div>
  <div id="entry_1">
    <span class="definition">A</span>
    <span class="example">AA</span>
  </div>
  <div class="word" data-defid="2">
    <span>bar</span>
  </div>
  <div id="entry_2">
    <span class="definition">B</span>
    <span class="example">BB</span>
  </div>
</body>
EOS
)
