# ud

**ud** is a web scrapping tool for [Urban Dictionnary][urban-dic]. The website
doesn’t have a public API, so this little tool allows you to find the definition(s) of
a word by scrapping its pages.

[urban-dic]: http://www.urbandictionary.com/define.php?term=totolala

## Install

```
gem install ud
```

## Usage

From the command-line:

```sh
$ ud <word>
```

In a Ruby file:

```ruby
require 'ud'

defs = UD.query('wtf')
```

## Tests

```
$ git clone https://github.com/bfontaine/ud.git
$ cd ud
$ bundle install
$ rake test
```

Set the `COVERAGE` environment variable to activate the code
coverage report, e.g.:

```
$ export COVERAGE=1; rake test
```


It’ll generate a `coverage/index.html`, which you can open in a
Web browser.
