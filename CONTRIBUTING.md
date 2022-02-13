## Contributing

Venus is an object-orientation framework and extendible standard library for
Perl 5, built on top of Moo with classes which wrap most native Perl data
types.

## Philosophy

The main goal of Venus is to act as a standard library, i.e. to provide a
robust set of methods for dealing with common computing tasks when operating on
primitive data types. Venus is concerned about developer ergonomics much more
than speed or conciseness.

## Aspirations

The following feeatures and goals should anchor the direction and development
of this project:

- Exception handling
- Optional autoboxing
- Pluggable standard library
- Robust and accurate documentation
- Simple package reflection
- Single non-core dependency (Moo)
- Small, flexible, powerful
- Standard library, intuitive behaviors
- Utility classes for common computing tasks
- Value classes for primitives
- Composable standards via traits (roles)

## Prerequisites

The following tools are prerquisites for developing in this project.

**[plx](https://metacpan.org/pod/App::plx)**

```bash
$ curl -L https://cpanmin.us | perl - -qn App::plx
```

**[cpm](https://metacpan.org/pod/App::cpm)**

```bash
$ curl -L https://cpanmin.us | perl - -qn App::cpm
```

**[reply](https://metacpan.org/pod/Reply)**

```bash
$ plx cpanfile reply
```

## Installation

The following steps configures the local environment for developing on this
project.

**Space**

```bash
mkdir venus && cd venus
```

**Fetch**

```bash
git clone git@github.com:cpanery/venus.git .
```

**Build**

```bash
plx cpanfile
```

**Validate**

```bash
plx prove -r t
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
$ open https://github.com/cpanery/venus/issues/1
```

Create a local branch based on the issue (ticket) number (found in the URL):

```bash
$ git checkout master
$ git pull origin master
$ git checkout -b issue-1
```

Make some code changes and push the branch to the remote:

```bash
$ git push origin issue-1
```

## Testing

Running the test suite using `prove`:

```bash
$ plx prove -r t
```

Testing the code using the `reply` (REPL):

```bash
$ plx reply -e 'use Venus'
```

## Releasing

This project uses [Dist::Zilla](https://github.com/rjbs/Dist-Zilla) to manage
its build and release processes. The following tools are prerquisites for
releasing this project.

**[dzil](https://metacpan.org/pod/Dist::Zilla)**

Installing the `dzil` dependencies for distribution building:

```bash
plx cpanfile dzil
```

Building the code using `dzil`:

```bash
$ plx build $version # e.g. 0.01
```

Releasing the code using `dzil`:

```bash
$ plx release $version # e.g. 0.01
```

## Support

**Questions, Suggestions, Issues/Bugs**

Please post any questions, suggestions, issues or bugs to the [issue
tracker](https://github.com/cpanery/venus/issues) on GitHub.