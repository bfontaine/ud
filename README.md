# ud

[![Build Status](https://travis-ci.org/bfontaine/ud.png?branch=master)](https://travis-ci.org/bfontaine/ud)
[![Gem Version](https://badge.fury.io/rb/ud.png)](http://badge.fury.io/rb/ud)
[![Coverage Status](https://coveralls.io/repos/bfontaine/ud/badge.png)](https://coveralls.io/r/bfontaine/ud)

**ud** is a command-line tool for [Urban Dictionnary][urban-dic].

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

It supports a few options:

- `-n`, `--count`: maximum number of definitions (default: 1)
- `-r`, `--ratio`: minimum upvotes/downvotes ratio (default: 0.0)
- `--up`: shortcut for `--ratio 1`. With this option, only definitions which
  have more upvotes than downvotes are shown
- `--no-color`: disable colored output.

In a Ruby file:

```ruby
require 'ud'

defs = UD.query('wtf')
```

## Example

```
$ ud dafuq
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

It’ll generate a `coverage/index.html`, which you can open in a Web browser.
