# ud

[![Build Status](https://travis-ci.org/bfontaine/ud.png?branch=master)](https://travis-ci.org/bfontaine/ud)

**ud** is a web scrapping tool for [Urban Dictionnary][urban-dic]. The website
doesn’t have a public API, so this little tool allows you to find the definition(s) of
a word by scrapping its pages.

[urban-dic]: http://www.urbandictionary.com

## Install

```
gem install ud
```

Windows users: You will need the Win32 Console ANSI gem for the colored output.
Install it with `gem install win32console`.

## Usage

From the command-line:

```
$ ud <word>
```

It scrapes only the first page of definitions. It supports a few options:

- `-n`, `--count`: maximum number of definitions (default: 10)
- `-r`, `--ratio`: minimum upvotes/downvotes ratio (default: 0.0)
- `-u`, `--up`: shortcut for `--ratio 1`. With this option, only the definitions
  which have more upvotes than downvotes are shown
- `--no-color`: disable colored output.

In a Ruby file:

```ruby
require 'ud'

defs = UD.query('wtf')
```

## Example

```
$ ud -n 1 dafuq
* dafuq (9427/4425):

   what the fuck , but in a more confused manner

 Example:
   Hagrid: You're a wizard Harry
   Harry: Dafuq?
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
