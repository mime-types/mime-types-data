# Contributing

Contributions to mime-types-data is encouraged in any form: a bug report, new
MIME type definitions, or additional code to help manage the MIME types. As with
many of my projects, I have a few suggestions for improving the chance of
acceptance of your code contributions:

- The support files are written in Ruby and should remain in the coding style
  that already exists, and I use hoe for releasing the mime-types-data RubyGem.
- Use a thoughtfully-named topic branch that contains your change. Rebase your
  commits into logical chunks as necessary.
- Use [quality commit messages][qcm].
- Do not change the version number; when your patch is accepted and a release is
  made, the version will be updated at that point.
- Submit a GitHub pull request with your changes.
- New or changed behaviours require new or updated documentation.

Although mime-types-data was extracted from the [Ruby mime-types][rmt] gem and
the support files are written in Ruby, the _target_ of mime-types-data is any
implementation that wishes to use the data as a MIME types registry, so I am
particularly interested in tools that will create a mime-types-data package for
other languages.

## Adding or Modifying MIME Types

The Ruby mime-types gem loads its data from files encoded in the `data`
directory in this gem by loading `mime-types-data` and reading
MIME::Types::Data::PATH. These files are compiled files from the collection of
data in the `types` directory. Pull requests that include changes to these files
will require amendment to revert these files.

New or modified MIME types should be edited in the appropriate YAML file under
`types`. The format is as shown below for the `application/xml` MIME type in
`types/application.yml`.

```yaml
- !ruby/object:MIME::Type
  content-type: application/xml
  encoding: 8bit
  extensions:
    - xml
    - xsl
  references:
    - IANA
    - RFC3023
  xrefs:
    rfc:
      - rfc3023
  registered: true
```

There are other fields that can be added, matching the fields discussed in the
documentation for MIME::Type. Pull requests for MIME types should just contain
the changes to the YAML files for the new or modified MIME types; I will convert
the YAML files to JSON prior to a new release. I would rather not have to verify
that the JSON matches the YAML changes, which is why it is not necessary to
convert for the pull request.

If you are making a change for a private fork, use `rake convert:yaml:json` to
convert the YAML to JSON, or `rake convert:yaml:columnar` to convert it to the
new columnar format.

### Updating Types from the IANA or Apache Lists

If you are maintaining a private fork and wish to update your copy of the MIME
types registry used by this gem, you can do this with the rake tasks:

```sh
$ rake mime:iana
$ rake mime:apache
```

#### A Note on Provisional Types

Provisionally registered types from IANA are contained in the `types/*.yaml`
files. Per IANA,

> This registry, unlike some other provisional IANA registries, is only for
> temporary use. Entries in this registry are either finalized and moved to the
> main media types registry or are abandoned and deleted. Entries in this
> registry are suitable for use for development and test purposes only.

Provisional types are rewritten when updated, so pull requests to manually
customize provisional types (such as with extensions) are considered lower
priority. It is recommended that any updates required to the data be performed
in your application if you require provisional types.

## Development Dependencies

## Test Dependencies

mime-types-data uses Ryan Davis’s [Hoe][hoe] to manage the release process, and
it adds a number of rake tasks. You will mostly be interested in `rake`, which
runs tests the same way that `rake test` does.

To assist with the installation of the development dependencies for mime-types,
I have provided the simplest possible Gemfile pointing to the (generated)
`mime-types-data.gemspec` file. This permits `bundle install` for dependencies.
If you already have `hoe` installed, you can accomplish the same thing with
`rake newb`. This task will install any missing dependencies, run the tests, and
generate the RDoc.

You can run tests with code coverage analysis by running `rake test:coverage`.

### Workflow

Here's the most direct way to get your work merged into the project:

- Fork the project.
- Clone down your fork
  (`git clone git://github.com/<username>/mime-types-data.git`).
- Create a topic branch to contain your change
  (`git checkout -b my\_awesome\_feature`).
- Hack away, add tests. Not necessarily in that order.
- Make sure everything still passes by running `rake`.
- If necessary, rebase your commits into logical chunks, without errors.
- Push the branch up (`git push origin my\_awesome\_feature`).
- Create a pull request against mime-types/mime-types-data and describe what
  your change does and the why you think it should be merged.

## The Release Process

The release process is much more automated than it used to be, as regular
updates are performed with GitHub actions on Tuesdays. Before release, however,
a final step of checking for IANA updates should be performed.

1. Review any outstanding issues or pull requests to see if anything needs to be
   addressed. This is necessary because there is no automated source for
   extensions for the thousands of MIME entries. (Suggestions and/or pull
   requests for same would be deeply appreciated.)
2. `bundle install`
3. `bundle exec rake mime:apache`
4. `bundle exec rake mime:iana`
5. Review the changes to make sure that the changes are sane. The IANA data
   source changes from time to time, resulting in big changes or even a broken
   step 4. (The most recent change was the addition of the `font/*` top-level
   category.)
6. `bundle exec rake convert`
7. `bundle exec rake update:version`
8. Write up the changes in `History.md`. If any PRs have been merged, these
   should be noted specifically and contributions should be added in
   `Contributing.md`.
9. Commit the changes and push to GitHub.
10. `bundle exec rake release VERSION=newversion`

This is based on an issue [#18][#18].

### Contributors

- Austin Ziegler created mime-types.

Thanks to everyone else who has contributed to mime-types:

- Aaron Patterson
- Aggelos Avgerinos
- Alessio Parma
- Alex Balhatchet
- Andre Pankratz
- Andrey Eremin
- Andy Brody
- Arnaud Meuret
- Bradley Meck
- Brandon Galbraith
- Chris Gat
- Chris Salzberg
- David Genord
- Eric Marden
- Garret Alfert
- Godfrey Chan
- Greg Brockman
- Hans de Graaff
- Henrik Hodne
- Jeremy Evans
- John Gardner
- Jon Sneyers
- Jonas Petersen
- Juanito Fatas
- Keerthi Siva
- Ken Ip
- Łukasz Śliwa
- Lucia
- Martin d'Allens
- Mauricio Linhares
- Mohammed Gad
- Myk Klemme
- nycvotes-dev
- Postmodern
- Richard Hirner
- Richard Hurt
- Richard Schneeman
- Robert Buchberger
- Samuel Williams
- Sergio Baptista
- Shane Eskritt
- Tao Guo
- Thomas Leese
- Tibor Szolár
- Todd Carrico
- Yoran Brondsema

[qcm]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[rmt]: https://github.com/mime-types/ruby-mime-types/
[hoe]: https://github.com/seattlerb/hoe
