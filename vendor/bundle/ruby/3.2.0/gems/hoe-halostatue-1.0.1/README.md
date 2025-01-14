# Hoe - Halostatue Meta-Plugin

## Description

Hoe::Halostatue is a [Hoe][hoe] meta-plugin that ensures that the following
plugins are installed and enabled for your project:

- [`hoe-doofus`][hoe-doofus]
- [`hoe-gemspec2`][hoe-gemspec2]
- [`hoe-git2`][hoe-git2]
- [`hoe-markdown`][hoe-markdown]
- [`hoe-rubygems`][hoe-rubygems]

It also provides an improved implementation for `Hoe#parse_urls` that works
better with a Markdown README. It allows either `*` or `-` as list leaders for
the README. It also allows the URLs to be blank. Double colons are still
required for pattern matching.

In addition to the four letter aliases in `Hoe::URLS_TO_META_MAP` (`bugs`,
`clog`, `doco`, `docs`, `home`, `code`, `wiki`, and `mail`), this adds:

- `changelog`, `changes`, and `history` as aliases for `changelog_uri`
- `documentation` for `documentation_uri`
- `issues` and `tickets` for `bug_tracker_uri`

## Examples

```ruby
# in your Rakefile
Hoe.plugin :halostatue
```

## Dependencies

Hoe and Git, obviously. I wouldn't be surprised if things don't quite work for
git < 2.37.

## Installation

```console
$ gem install hoe-halostatue
```

## License

Copyright 2024 Austin Ziegler (halostatue@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[hoe-doofus]: https://github.com/jbarnette/hoe-doofus
[hoe-gemspec2]: https://github.com/raggi/hoe-gemspec2
[hoe-git2]: https://github.com/halostatue/hoe-git2
[hoe-markdown]: https://github.com/flavorjones/hoe-markdown
[hoe-rubygems]: https://github.com/jbarnette/hoe-rubygems
[hoe]: https://github.com/seattlerb/hoe
