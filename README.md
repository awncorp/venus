## Venus - Object-Oriented Standard Library for Perl 5

Venus is an object-orientation framework and extendible standard library for
Perl 5, built on top of [Moo](https://metacpan.org/pod/Moo) with classes which
wrap most native [Perl](https://www.perl.org/) data types. Venus has a simple
modular architecture, robust library of classes and methods, supports pure-Perl
autoboxing, advanced exception handling, "true" and "false" keywords, package
introspection, command-line options parsing, and more.

**Demo:** [Better Boolean Values](https://asciinema.org/a/aHmHDhmcd3zkyFW7qtVLAnDg8)

_i.e. Venus knows the difference between boolean `0`, numerical `0`, and the
string `'0'`._

![Venus Demo](https://github.com/cpanery/venus/raw/master/.github/assets/459060.gif)

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
$ curl -L https://cpanmin.us | perl - -qn Venus
```

Install Venus using Perl (from GitHub):

```bash
$ curl -ssL https://cpanmin.us | perl - -qn git://github.com/cpanery/venus.git
```

## Features

- [One Dependency](https://p3rl.org/Moo)
- [Standard Library](#feature-standard-library)
- [Value Classes](#feature-value-classes)
- [Builtin Autoboxing](#feature-builtin-autoboxing)
- [Utility Classes](#feature-utility-classes)
- [Package Reflection](#feature-package-reflection)
- [Exception Handling](#feature-exception-handling)
- [Composable Standards](#feature-composable-standards)
- [Pluggable Library](#feature-pluggable-library)
- [Robust Documentation](#documentation)

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

## Documentation

[CPAN](https://metacpan.org/dist/Venus)

For documentation and usage information on specific classes or roles (traits),
see below:

- [Venus](https://github.com/cpanery/venus/blob/master/lib/Venus.pod#name)
- [Venus::Args](https://github.com/cpanery/venus/blob/master/lib/Venus/Args.pod#name)
- [Venus::Array](https://github.com/cpanery/venus/blob/master/lib/Venus/Array.pod#name)
- [Venus::Boolean](https://github.com/cpanery/venus/blob/master/lib/Venus/Boolean.pod#name)
- [Venus::Box](https://github.com/cpanery/venus/blob/master/lib/Venus/Box.pod#name)
- [Venus::Class](https://github.com/cpanery/venus/blob/master/lib/Venus/Class.pod#name)
- [Venus::Code](https://github.com/cpanery/venus/blob/master/lib/Venus/Code.pod#name)
- [Venus::Data](https://github.com/cpanery/venus/blob/master/lib/Venus/Data.pod#name)
- [Venus::Date](https://github.com/cpanery/venus/blob/master/lib/Venus/Date.pod#name)
- [Venus::Error](https://github.com/cpanery/venus/blob/master/lib/Venus/Error.pod#name)
- [Venus::Float](https://github.com/cpanery/venus/blob/master/lib/Venus/Float.pod#name)
- [Venus::Hash](https://github.com/cpanery/venus/blob/master/lib/Venus/Hash.pod#name)
- [Venus::Json](https://github.com/cpanery/venus/blob/master/lib/Venus/Json.pod#name)
- [Venus::Kind](https://github.com/cpanery/venus/blob/master/lib/Venus/Kind.pod#name)
- [Venus::Kind::Utility](https://github.com/cpanery/venus/blob/master/lib/Venus/Kind/Utility.pod#name)
- [Venus::Kind::Value](https://github.com/cpanery/venus/blob/master/lib/Venus/Kind/Value.pod#name)
- [Venus::Match](https://github.com/cpanery/venus/blob/master/lib/Venus/Match.pod#name)
- [Venus::Name](https://github.com/cpanery/venus/blob/master/lib/Venus/Name.pod#name)
- [Venus::Number](https://github.com/cpanery/venus/blob/master/lib/Venus/Number.pod#name)
- [Venus::Opts](https://github.com/cpanery/venus/blob/master/lib/Venus/Opts.pod#name)
- [Venus::Path](https://github.com/cpanery/venus/blob/master/lib/Venus/Path.pod#name)
- [Venus::Process](https://github.com/cpanery/venus/blob/master/lib/Venus/Process.pod#name)
- [Venus::Regexp](https://github.com/cpanery/venus/blob/master/lib/Venus/Regexp.pod#name)
- [Venus::Replace](https://github.com/cpanery/venus/blob/master/lib/Venus/Replace.pod#name)
- [Venus::Role](https://github.com/cpanery/venus/blob/master/lib/Venus/Role.pod#name)
- [Venus::Role::Accessible](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Accessible.pod#name)
- [Venus::Role::Boxable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Boxable.pod#name)
- [Venus::Role::Buildable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Buildable.pod#name)
- [Venus::Role::Catchable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Catchable.pod#name)
- [Venus::Role::Coercible](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Coercible.pod#name)
- [Venus::Role::Digestable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Digestable.pod#name)
- [Venus::Role::Doable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Doable.pod#name)
- [Venus::Role::Dumpable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Dumpable.pod#name)
- [Venus::Role::Explainable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Explainable.pod#name)
- [Venus::Role::Mappable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Mappable.pod#name)
- [Venus::Role::Matchable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Matchable.pod#name)
- [Venus::Role::Pluggable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Pluggable.pod#name)
- [Venus::Role::Printable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Printable.pod#name)
- [Venus::Role::Proxyable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Proxyable.pod#name)
- [Venus::Role::Stashable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Stashable.pod#name)
- [Venus::Role::Throwable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Throwable.pod#name)
- [Venus::Role::Tryable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Tryable.pod#name)
- [Venus::Role::Valuable](https://github.com/cpanery/venus/blob/master/lib/Venus/Role/Valuable.pod#name)
- [Venus::Scalar](https://github.com/cpanery/venus/blob/master/lib/Venus/Scalar.pod#name)
- [Venus::Search](https://github.com/cpanery/venus/blob/master/lib/Venus/Search.pod#name)
- [Venus::Space](https://github.com/cpanery/venus/blob/master/lib/Venus/Space.pod#name)
- [Venus::String](https://github.com/cpanery/venus/blob/master/lib/Venus/String.pod#name)
- [Venus::Template](https://github.com/cpanery/venus/blob/master/lib/Venus/Template.pod#name)
- [Venus::Throw](https://github.com/cpanery/venus/blob/master/lib/Venus/Throw.pod#name)
- [Venus::Try](https://github.com/cpanery/venus/blob/master/lib/Venus/Try.pod#name)
- [Venus::Type](https://github.com/cpanery/venus/blob/master/lib/Venus/Type.pod#name)
- [Venus::Undef](https://github.com/cpanery/venus/blob/master/lib/Venus/Undef.pod#name)
- [Venus::Vars](https://github.com/cpanery/venus/blob/master/lib/Venus/Vars.pod#name)
- [Venus::Yaml](https://github.com/cpanery/venus/blob/master/lib/Venus/Yaml.pod#name)

## Founder

- [@iamalnewkirk](https://github.com/iamalnewkirk)

## Contributing

We rely on your contributions and feedback to improve Venus, and we love
hearing about your experiences and what we can improve upon.

All contributions are always welcome! See the [contributing
guide](https://github.com/cpanery/venus/blob/master/CONTRIBUTING.md) for ways
to get started, and please adhere to this project's [code of
conduct](https://github.com/cpanery/venus/blob/master/CODE_OF_CONDUCT.md).

## Support

For support, feel free to report an [issue](https://github.com/cpanery/venus/issues).

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)
