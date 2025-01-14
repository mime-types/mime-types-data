# hoe-git2 Changelog

## 1.8.0 / 2023-02-16

- 1 minor enhancement

  - Added an explicit dependency on `hoe` permitting both Hoe 3.x and 4.x.

## 1.7.0 / 2022-07-18

- 2 minor enhancements:

  - Incorporated the porcelain change for jbarnette/hoe-git#14, resolving
    jbarnette/hoe-git#13. Thanks to @ghost for the original contribution.

  - Improved in-git and git-svn detection to use git porcelain instead of
    strict directory detection.

- This is sort of a re-birthday! Since jbarnette/hoe-git has been archived,
  I've forked the repository and released this plug-in as `hoe-git2`. I've
  also chosen to reformat this to my preferred style. I have released this
  using the same versioning as `hoe-git` because this is very much
  a continuation of the original code.

## 1.6.0 / 2014-02-05

- 1 minor enhancement:

  - Added signed tag support to hoe-git

## 1.5.0 / 2012-03-22

- 1 minor enhancement:

  - Added prerelease support. Use `rake release VERSION=1.0 PRE=rc.1` to
    create a prerelease gem.

- 1 bug fix:

  - The `git:tag` task is now a dependency of release_to instead of release to
    ensure it runs before post_release tasks

## 1.4.1 / 2011-10-04

- 1 minor enhancement:

  - Added `git:tags`.

- 2 bug fixes:

  - Fixed `name-rev` to use `--tags`. Version diff?

  - Newer versions of git are tacking on a `^0` to tag names for some stupid
    reason.

## 1.4.0 / 2011-05-16

- 2 minor enhancements:

  - Exported all the other git functions so that other rake tasks can benefit.

  - Updated `git:changelog` to support annotated commit messages.

- 1 bug fix:

  - Fix shell escaping on Windows. (Gordon Thiesfeld)

## 1.3.0 / 2009-07-27

- Add a `git:manifest` task. (Phil Hagelb0rg)
- Clean up `git:changelog` a bit.
- Add the doofus Hoe plugin.
- Update README w/better docs.

## 1.2.0 / 2009-07-01

- Add git-svn support for `git:tag` and `git:changelog`.

## 1.1.3 / 2009-06-27

- Changelog should use author, not committer.

## 1.1.2 / 2009-06-26

- Doc cleanups.
- Veto releases when the index is dirty.

## 1.1.1 / 2009-06-23

- Use git_release_tag_prefix more consistently, handle unreleased case.
- Make the README a bit better.

## 1.1.0 / 2009-06-23

- Allow configurable release tag prefixes.
- Add git:changelog to make release notes easier.
- Make the git:tag task respect a TAG env var.
- Minor cleanups.

## 1.0.0 / 2009-06-23

- Birthday!
