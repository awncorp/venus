## Venus - Object-Oriented Standard Library for Perl 5

Venus is an object-orientation framework and extendible standard library for
Perl 5, built on top of Mars architecture with classes which wrap most native
[Perl](https://www.perl.org/) data types. Venus has a simple modular
architecture, robust library of classes and methods, supports pure-Perl
autoboxing, advanced exception handling, "true" and "false" keywords, package
introspection, command-line options parsing, and more.

## Installation

Install Venus using [cpm](https://metacpan.org/pod/App::cpm):

```bash
cpm install Venus
```

Install Venus using [cpanm](https://metacpan.org/pod/App::cpanminus):

```bash
cpanm -qn Venus
```

Install Venus using Perl:

```bash
curl -sSL https://cpanmin.us | perl - -qn Venus
```

Install Venus using Perl (from GitHub):

```bash
curl -ssL https://cpanmin.us | perl - -qn git://github.com/awncorp/venus.git
```

## Features

- Zero Dependencies
- Supports Perl 5.18.0+
- Fast Object-Orientation
- [Boolean Values](#feature-boolean-values)
- [Standard Library](#feature-standard-library)
- [Value Classes](#feature-value-classes)
- [Builtin Autoboxing](#feature-builtin-autoboxing)
- [Utility Classes](#feature-utility-classes)
- [Package Reflection](#feature-package-reflection)
- [Exception Handling](#feature-exception-handling)
- [Composable Standards](#feature-composable-standards)
- [Pluggable Library](#feature-pluggable-library)
- Robust Documentation
- Dispatcher Methods

### Feature: Boolean Values

_i.e. Venus knows the difference between boolean `0`, numerical `0`, and the
string `'0'`._

![Venus Demo](https://github.com/awncorp/venus/raw/master/.github/assets/459060.gif)

### Feature: Standard Library

```perl
package main;

use Venus::Array;

my $array = Venus::Array->new([1..4]);

# $array->all(sub{ $_ > 0 });
# $array->any(sub{ $_ > 0 });
# $array->each(sub{ $_ > 0 });
# $array->grep(sub{ $_ > 0 });
# $array->map(sub{ $_ > 0 });
# $array->none(sub{ $_ < 0 });
# $array->one(sub{ $_ == 0 });
# $array->random;

use Venus::Hash;

my $hash = Venus::Hash->new({1..8});

# $hash->all(sub{ $_ > 0 });
# $hash->any(sub{ $_ > 0 });
# $hash->each(sub{ $_ > 0 });
# $hash->grep(sub{ $_ > 0 });
# $hash->map(sub{ $_ > 0 });
# $hash->none(sub{ $_ < 0 });
# $hash->one(sub{ $_ == 0 });
# $hash->random;

$array->count == $hash->count;
```

### Feature: Value Classes

**Array**

```perl
package main;

use Venus::Array;

my $array = Venus::Array->new;

$array->random;
```

**Boolean**

```perl
package main;

use Venus::Boolean;

my $boolean = Venus::Boolean->new;

$boolean->negate;
```

**Code**

```perl
package main;

use Venus::Code;

my $code = Venus::Code->new;

$code->call;
```

**Hash**

```perl
package main;

use Venus::Hash;

my $hash = Venus::Hash->new;

$hash->random;
```

### Feature: Builtin Autoboxing

```perl
package main;

use Venus::String;

my $string = Venus::String->new('hello, world');

$string->box->split(', ')->join(' ')->titlecase->unbox->get;

# Hello World
```

### Feature: Utility Classes

**Args**

```perl
package main;

use Venus::Args;

my $args = Venus::Args->new;

$args->get(0);
```

**Data**

```perl
package main;

use Venus::Data;

my $docs = Venus::Data->new->docs;

$docs->find('head1', 'NAME');
```

**Date**

```perl
package main;

use Venus::Date;

my $date = Venus::Date->new;

$date->iso8601;
```

**Error**

```perl
package main;

use Venus::Error;

my $error = Venus::Error->new;

$error->throw;
```

**Path**

```perl
package main;

use Venus::Path;

my $path = Venus::Path->new('/tmp/random');

$path->mkdirs;
```

### Feature: Package Reflection

```perl
package main;

use Venus::Space;

my $space = Venus::Space->new('Venus');

$space->do('tryload')->routines;
```

### Feature: Exception Handling

```perl
package MyApp;

use Venus::Class;

with 'Venus::Role::Throwable';
with 'Venus::Role::Catchable';

sub execute {
  shift->throw->error;
}

package main;

my $myapp = MyApp->new;

my $error = $myapp->catch('execute');

# $error->isa('MyApp::Error');
```

### Feature: Composable Standards

```perl
package MyApp;

use Venus::Class;

with 'Venus::Role::Dumpable';
with 'Venus::Role::Stashable';

package main;

my $myapp = MyApp->new;

$myapp->stash(greeting => 'hello world');

$myapp->dump('stash');

# '{"greeting" => "hello world"}'
```

### Feature: Pluggable Library

```perl
package Venus::String::Plugin::Base64;

use Venus::Class;

sub execute {
  my ($self, $string) = @_;

  require MIME::Base64;

  return MIME::Base64::encode_base64($string->value);
}

package main;

use Venus::String;

my $string = Venus::String->new('hello, world');

$string->base64;
```

### Feature: Template System

```perl
package main;

use Venus::Template;

my $template = Venus::Template->new(q(
  {{ if user.name }}
  Welcome, {{ user.name }}!
  {{ else user.name }}
  Welcome, friend!
  {{ end user.name }}
));

$template->render;
```

## Founder

- [@awncorp](https://github.com/awncorp)

## Contributing

We rely on your contributions and feedback to improve Venus, and we love
hearing about your experiences and what we can improve upon.

All contributions are always welcome! See the [contributing
guide](https://github.com/awncorp/venus/blob/master/CONTRIBUTING.md) for ways
to get started, and please adhere to this project's [code of
conduct](https://github.com/awncorp/venus/blob/master/CODE_OF_CONDUCT.md).

## Support

For support, feel free to report an [issue](https://github.com/awncorp/venus/issues).

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)
