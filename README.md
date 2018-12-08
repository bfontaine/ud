# ud

[![Build Status](https://img.shields.io/travis/bfontaine/ud.svg)](https://travis-ci.org/bfontaine/ud)
[![Gem Version](https://img.shields.io/gem/v/ud.png)](http://badge.fury.io/rb/ud)
[![Coverage Status](https://img.shields.io/coveralls/bfontaine/ud.svg)](https://coveralls.io/r/bfontaine/ud)
[![Inline docs](http://inch-ci.org/github/bfontaine/ud.svg)](http://inch-ci.org/github/bfontaine/ud)

**ud** is a command-line tool for the [Urban Dictionnary][urban-dic].

[urban-dic]: http://www.urbandictionary.com

## Example

    $ ud dafuq
    * dafuq (11644/4888):

        [what the fuck] , but in a more confused manner

     Example:
        Hagrid: You're a wizard Harry
        Harry: Dafuq?

## Install

    gem install ud

Windows users: You will need the Win32 Console ANSI gem for the colored output.
Install it with `gem install win32console`.

## Usage

From the command-line:

    $ ud <word>

It supports a few options:

- `-n`, `--count`: maximum number of definitions (default: 1)
- `-m`, `--random`: print a random definition instead
- `--no-color`: disable colored output.
- `-b`, `--browser`: open the results in your browser instead of displaying
  them in the console

In a Ruby script:

```ruby
require "ud"

defs = UD.query("wtf")
```

## Tests

```
$ git clone https://github.com/bfontaine/ud.git
$ cd ud
$ bundle install
$ bundle exec rake test
```

It’ll generate a `coverage/index.html`, which you can open in a Web browser.
