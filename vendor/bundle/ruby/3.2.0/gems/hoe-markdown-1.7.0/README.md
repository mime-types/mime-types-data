# Hoe::Markdown

Hoe::Markdown is a [Hoe](https://www.zenspider.com/projects/hoe.html) plugin to help manage your project's markdown files. It's intended for gem maintainers, but the underlying library of markdown manipulation methods might be generally useful.

Hoe::Markdown::Standalone can be used without Hoe.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hoe-markdown'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hoe-markdown


## Usage with Hoe

In your Rakefile:

``` ruby
Hoe::plugin :markdown
```

Rake tasks are exposed under the `markdown` namespace.

### Choosing your markdown files correctly

Hoe makes some outdated assumptions about the location of your README and your changelog files, which you (as a maintainer) need to opt out of. Specifically, you probably have something like this in your Rakefile

```
Hoe.spec "projectname" do
  ...
  self.history_file = "CHANGELOG.md"
  self.readme_file = "README.md"
  ...
end
```

If you've got files named "CHANGELOG.md" and/or "README.md" then this plugin will do the right thing, and you won't need to specify this in your Rakefile.


### Controlling what files are modified

By default, any `.md` file that Hoe knows about (through `Manifest.txt` or other attributes) will be included.

This can be overridden by setting the attribute named `markdown_linkify_files` which should be an array of file paths.


### Rake Tasks

An idempotent rake task `markdown:linkify` is created which will iterate through each of the markdown files in your project, and create hyperlinks for:

* any github username [formatted like `@username`]
* github issue mention [formatted like `#1234`]
* github issue URI [which must match either the Hoe metadata URI for the bug tracker, or that same URI's equivalent pull request URI]

So, for example, this text:

```markdown
# Changelog

## v1.0.0

Bugfix: Frobnicate the transmogrifier. #123
Thanks, @hobbes!

Feature: Finagle the sprocket. See https://github.com/cogswellcogs/sprocketkiller/issues/456
```

would be turned into:

```markdown
# Changelog

## v1.0.0

Bugfix: Frobnicate the transmogrifier. [#123](https://github.com/cogswellcogs/sprocketkiller/issues/123)
Thanks, [@hobbes](https://github.com/hobbes)!

Feature: Finagle the sprocket. See [#456](https://github.com/cogswellcogs/sprocketkiller/issues/456)
```

## Usage without Hoe

In your Rakefile:

``` ruby
require "hoe/markdown"
Hoe::Markdown::Standalone.new("gemname").define_markdown_tasks
```

This will attempt to read your gemspec from `#{gemname}.gemspec`, and then the same rake tasks described above are created and behave the same way. If you have additional files (beyond the files declared in the gemspec), you may pass them into this method:

``` ruby
require "hoe/markdown"
Hoe::Markdown::Standalone.new("gemname").define_markdown_tasks("CHANGELOG.md", "CONTRIBUTORS.md")
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flavorjones/hoe-markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/flavorjones/hoe-markdown/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). See [LICENSE.txt](https://github.com/flavorjones/hoe-markdown/blob/master/LICENSE.txt).


## Code of Conduct

Everyone interacting in the Hoe::Markdown project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flavorjones/hoe-markdown/blob/master/CODE_OF_CONDUCT.md).
