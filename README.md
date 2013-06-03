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

It scrape only the first page of definitions. You can reduce the number of
definitions with some options:

- `-n`, `--count`: maximum number of definitions (default: 10)
- `-r`, `--ratio`: minimum upvotes/downvotes ratio (default: 0.0)
- `-u`, `--up`: shortcut for `--ratio 1`. With this option, only the definitions
  which have more upvotes than downvotes are shown

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
