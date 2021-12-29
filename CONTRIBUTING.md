## Contributing

Thanks for your interest in this project. We welcome all community
contributions! To install locally, follow the instructions in the
[README.md](./README.mkdn) file.

## Releasing

This project uses [Dist::Zilla](https://github.com/rjbs/Dist-Zilla) to manage
its build and release processes.

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

Thanks!

## Questions, Suggestions, Issues/Bugs

Please post any questions, suggestions, issues or bugs to the [issue
tracker](../../issues) on GitHub.