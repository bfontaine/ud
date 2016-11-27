# UD Changelog

## 0.3.0 (2016/11/27)

* Add `UD.random` and  `UD.open_random`, as well as the `--random` option
* Bump dependencies

### Breaking Changes

* Remove `--ratio` and `--up`
* Remove Python-style optional arguments in favor of hashes everywhere. This
  means `UD.search_url("foo", api=false)` becomes
  `UD.search_url("foo", api: false)`

## 0.2.5 (2015/05/17)

* Document `--browser` in the README
* Fix (again) the URL used by `--browser`

## 0.2.4 (2015/05/17)

* Full code documentation
* Fix the URL used by `--browser`

## 0.2.3 (2015/05/17)

* Add `--browser` option

## 0.2.1, 0.2.2 (2014/05/19)

* Add a lot more code documentation
* Clean abort on ^C
* Bump dependencies

## 0.2.0 (2014/01/22)

* Use the API instead of parsing HTML
* Add `-r` as an alias to `--ratio`

## 0.1.3 (2014/01/12)

* Fix the HTML parsing

## 0.1.2 (2013/10/11)

First public release.
