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
FakeWeb.register_uri(
  :get,
  "#{thumbs_url}?ids=1",
  :body => '{"thumbs":[{"defid":1,"thumbs_up":1,"thumbs_down":1}]}'
)
FakeWeb.register_uri(
  :get,
  "#{thumbs_url}?ids=2",
  :body => '{"thumbs":[{"defid":2,"thumbs_up":2,"thumbs_down":1}]}'
)

# Multiple ids
FakeWeb.register_uri(
  :get,
  "#{thumbs_url}?ids=1%2C2",
  :body => '{"thumbs":[{"defid":1,"thumbs_up":1,"thumbs_down":1},' +
           '{"defid":2,"thumbs_up":2,"thumbs_down":1}]}'
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
<div id="entries">
<div class="box">
<div class="ribbon"></div>
<a class="add_to_list" data-defid="1" href="#">
<i class="icon-star-empty"></i></a>
<div class="inner">
<div class="word">
<a href="/define.php?term=cenosillicaphobia&amp;defid=1">foo</a>
</div>
<div class="definition">A</div>
<div class="example"> AA</div>
<div class="contributor"> </div>
<div class="share"> </div>
</div>
<div class="footer">
<a class="thumb up" data-defid="1" data-direction="up" href="#">
<i class="icon-thumbs-up"></i>
</a>
<a class="thumb down" data-defid="1" data-direction="down" href="#">
<i class="icon-thumbs-down"></i>
</a>
</div>
</div>
<div class="box">
<div class="ribbon"></div>
<a class="add_to_list" data-defid="2" href="#">
<i class="icon-star-empty"></i></a>
<div class="inner">
<div class="word">
<a href="/define.php?term=cenosillicaphobia&amp;defid=2">bar</a>
</div>
<div class="definition">B</div>
<div class="example"> BB</div>
<div class="contributor"> </div>
<div class="share"> </div>
</div>
<div class="footer">
<a class="thumb up" data-defid="2" data-direction="up" href="#">
<i class="icon-thumbs-up"></i>
</a>
<a class="thumb down" data-defid="2" data-direction="down" href="#">
<i class="icon-thumbs-down"></i>
</a>
</div>
</div>
</body>
EOS
)
