## Contributing

Venus is an object-orientation framework and extendible standard library for
Perl 5, built on top of the Mars architecture with classes which wrap most
native Perl data types.

## Philosophy

The goal of Venus is to be a viable non-core standard library, i.e. to provide a
robust set of methods for dealing with common computing tasks when operating on
primitive data types. Venus is concerned about developer ergonomics much more
than speed or conciseness.

## Aspirations

The following features and goals should anchor the direction and development
of this project:

- No dependencies
- Performance-minded
- Exception handling
- Pure-Perl autoboxing
- Pluggable standard library
- Consistent naming, intuitive behaviors
- Robust and accurate documentation
- Small, flexible, powerful, optional
- Simple package reflection
- Utility classes for common behaviors
- Value classes for primitives data types
- Composable standards via traits (roles)

## Installation

The following steps configures the local environment for developing on this
project.

**Setup**

```bash
mkdir venus && cd venus
```

**Fetch**

```bash
git clone git@github.com:awncorp/venus.git .
```

**Build**

```bash
cpanm -llocal -qn --installdeps .
```

**Validate**

```bash
prove -Ilib -Ilocal/lib/perl5 -r t
```

## Directory Structure

```
  lib
  ├── Venus.pm
  ├── ...
  │   └── ...
  t
  ├── ...
  └── Venus.t
```

Important! Before you checkout the code and start making contributions you need
to understand the project structure and reasoning. This will help ensure you
put code changes in the right place so they won't get overwritten.

The `lib` directory is where the packages (modules, classes, etc) are. Feel
free to create, delete and/or update as you see fit. All POD (documentation)
changes are made in their respective test files under the `t` directory.

POD isn't created and maintained manually, it is generated at-will (and
typically before release). Altering POD files will almost certainly result in
those changes being lost.

## Developing

This project uses `git` as its version control system and is managed on GitHub.
All code changes must be based on GitHub issues (tickets) and can only be
merged into the master branch using pull requests. In order to trigger the
necessary CI/CD workflows, pull requests must be based on branches with the
naming scheme of `issue-n` where `n` is the GitHub issues number (found in the
URL), e.g. `issue-1`.

Create or find an issue on GitHub:

```bash
open https://github.com/awncorp/venus/issues/1
```

Create a local branch based on the issue (ticket) number (found in the URL):

```bash
git checkout master
git pull origin master
git checkout -b issue-1
```

Make some code changes and push the branch to the remote:

```bash
git push origin issue-1
```

## Testing

Running the test suite using `prove`:

```bash
prove -Ilib -Ilocal/lib/perl5 -r t
```

## Experiment

Experiment with the code using `perl` (REPL):

```bash
perl -Ilib -Ilocal/lib/perl5 -MVenus -de0
```

Experiment with the code using the `reply` (REPL):

```bash
reply -Ilib -Ilocal/lib/perl5 -e 'use Venus'
```

## Support

**Questions, Suggestions, Issues/Bugs**

Please post any questions, suggestions, issues or bugs to the [issue
tracker](https://github.com/awncorp/venus/issues) on GitHub.