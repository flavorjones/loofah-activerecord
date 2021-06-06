# loofah-activerecord

* http://github.com/flavorjones/loofah-activerecord
* http://rubydoc.info/github/flavorjones/loofah-activerecord/master/frames
* http://librelist.com/browser/loofah


## Status

[![ci](https://github.com/flavorjones/loofah-activerecord/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/flavorjones/loofah-activerecord/actions/workflows/ci.yml)


## Description

`loofah-activerecord` extends `loofah`'s HTML sanitization into Rails
ActiveRecord models.

See more about `loofah` at: http://github.com/flavorjones/loofah

## Features

There are two ActiveRecord extensions included with loofah-activerecord:

* Loofah::ActiveRecordExtension is an *opt-in* sanitizer. You must explicitly declare attributes to be sanitized.
* Loofah::XssFoliate, a drop-in replacement for [XssTerminate](http://github.com/look/xss_terminate/tree/master), is an *opt-out* sanitizer. By default all models and attributes are sanitized.


### ActiveRecord Extension #1: Opt-In

See Loofah::ActiveRecordExtension for full documentation. The class
methods mixed into ActiveRecord are:

* `html_document`
* `html_fragment`

which are used to declare how specific string and text attributes
should be scrubbed during `before_validation`.

``` ruby
# app/model/post.rb
class Post < ActiveRecord::Base
  html_fragment :body, :scrub => :prune  # scrubs `body` using the :prune scrubber
end
```


### ActiveRecord Extension #2: Opt-Out

See Loofah::XssFoliate::ClassMethods for more documentation. The class
methods mixed into ActiveRecord are:

* `xss_foliate`
* `xss_foliated?`

which are used to declare how specific string and text attributes
should be scrubbed during `before_validation`.

Attributes are scrubbed with the `:strip` scrubber by default, unless
another scrubber is specified or the attribute is present in an
`:except` clause.


## Requirements

* Loofah >= 1.0.0
* Rails 3.2+, 4.2+, 5.0+

Support for older versions of Rails is available in loofah-activerecord < 2.0.


## Installation

Unsurprisingly:

* gem install loofah-activerecord


## Support

The bug tracker is available here:

* http://github.com/flavorjones/loofah-activerecord/issues

And the mailing list is on librelist (the general Loofah mailing list):

* loofah@librelist.com / http://librelist.com

And the IRC channel is #loofah on freenode.


## Related Links

* Loofah: http://github.com/flavorjones/loofah
* XssTerminate: http://github.com/look/xss_terminate/tree/master


## Authors

* [Mike Dalessio](http://mike.daless.io) ([@flavorjones](https://twitter.com/flavorjones))

Featuring code contributed by:

* Josh Nichols
* Damon P. Cortesi


## Historical Note

This library was split out of the Loofah project for version 1.0.0.


## License

Distributed under the MIT License. See `MIT-LICENSE.txt` for details.
