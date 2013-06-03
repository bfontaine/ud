# ud

**ud** is a web scrapping tool for [Urban Dictionnary][urban-dic]. The website
doesn’t have an API, so this little tool allows you to find the definition(s) of
a word by scrapping its pages.

[urban-dic]: http://www.urbandictionary.com/define.php?term=totolala

## Install

```
gem install ud
```

## Usage

From the command-line:

```sh
ud <word>
```

In a Ruby file:

```ruby
require 'ud'

defs = UD.query('wtf')
```
