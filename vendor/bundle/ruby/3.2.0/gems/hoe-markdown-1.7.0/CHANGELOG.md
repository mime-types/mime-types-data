# Hoe::Markdown CHANGELOG

## v1.7.0 / 2025-01-02

Fix:

- Do not linkify link refs and link ref definitions. #5 @halostatue


## v1.6.0 / 2023-11-19

Fix:

- Do not linkify things like that look like issues when they are part of a word, like "LH#123".


## v1.5.1 / 2023-10-10

Remove experimental code that was accidentally included in v1.5.0.


## v1.5.0 / 2023-10-10

Feature:

- use `Bundler.load_gemspec` instead of `eval`, to support Ruby 3.3


## v1.4.0 / 2021-01-18

Feature:

- Hoe::Markdown::Standalone allows additional non-gemspec files to be specified


## v1.3.0 / 2020-08-28

Feature:

- Hoe::Markdown::Standalone allows use of these rake tasks outside of Hoe


## v1.2.0 / 2020-06-16

Fix:
* ensure idempotency on github usernames with dashes


## v1.1.0 / 2020-06-07

Fix:
* do not match github usernames if present inside an email address


## v1.0.0 / 2020-06-07

Released!
