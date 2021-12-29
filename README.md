## Venus - OO Library

Venus is an object-orientation framework and extendible standard library for
Perl 5, built on top of [Moo](https://metacpan.org/pod/Moo) with classes which
wrap most native [Perl](https://www.perl.org/) data types. Venus has a simple
modular architecture, robust library of classes and methods, supports pure-Perl
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
$ curl -L https://cpanmin.us | perl - -qn Venus
```

## Features

- One Dependency
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

$string->box->split(', ')->join(' ')->titlecase->unbox->get; # Hello World
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

$myapp->catch('execute'); # catch MyApp::Error
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

$myapp->dump('stash'); # '{"greeting" => "hello world"}'
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

## Documentation

[CPAN](https://metacpan.org/dist/Venus)

For documentation and usage information on specific classes or roles (traits),
see below:

- [Venus](https://github.com/cpanery/blob/main/lib/Venus.pod)
- [Venus::Args](https://github.com/cpanery/blob/main/lib/Venus/Args.pod)
- [Venus::Array](https://github.com/cpanery/blob/main/lib/Venus/Array.pod)
- [Venus::Boolean](https://github.com/cpanery/blob/main/lib/Venus/Boolean.pod)
- [Venus::Box](https://github.com/cpanery/blob/main/lib/Venus/Box.pod)
- [Venus::Class](https://github.com/cpanery/blob/main/lib/Venus/Class.pod)
- [Venus::Code](https://github.com/cpanery/blob/main/lib/Venus/Code.pod)
- [Venus::Data](https://github.com/cpanery/blob/main/lib/Venus/Data.pod)
- [Venus::Date](https://github.com/cpanery/blob/main/lib/Venus/Date.pod)
- [Venus::Error](https://github.com/cpanery/blob/main/lib/Venus/Error.pod)
- [Venus::Float](https://github.com/cpanery/blob/main/lib/Venus/Float.pod)
- [Venus::Hash](https://github.com/cpanery/blob/main/lib/Venus/Hash.pod)
- [Venus::Json](https://github.com/cpanery/blob/main/lib/Venus/Json.pod)
- [Venus::Kind](https://github.com/cpanery/blob/main/lib/Venus/Kind.pod)
- [Venus::Kind::Utility](https://github.com/cpanery/blob/main/lib/Venus/Kind/Utility.pod)
- [Venus::Kind::Value](https://github.com/cpanery/blob/main/lib/Venus/Kind/Value.pod)
- [Venus::Name](https://github.com/cpanery/blob/main/lib/Venus/Name.pod)
- [Venus::Number](https://github.com/cpanery/blob/main/lib/Venus/Number.pod)
- [Venus::Opts](https://github.com/cpanery/blob/main/lib/Venus/Opts.pod)
- [Venus::Path](https://github.com/cpanery/blob/main/lib/Venus/Path.pod)
- [Venus::Regexp](https://github.com/cpanery/blob/main/lib/Venus/Regexp.pod)
- [Venus::Replace](https://github.com/cpanery/blob/main/lib/Venus/Replace.pod)
- [Venus::Role](https://github.com/cpanery/blob/main/lib/Venus/Role.pod)
- [Venus::Role::Accessible](https://github.com/cpanery/blob/main/lib/Venus/Role/Accessible.pod)
- [Venus::Role::Boxable](https://github.com/cpanery/blob/main/lib/Venus/Role/Boxable.pod)
- [Venus::Role::Buildable](https://github.com/cpanery/blob/main/lib/Venus/Role/Buildable.pod)
- [Venus::Role::Catchable](https://github.com/cpanery/blob/main/lib/Venus/Role/Catchable.pod)
- [Venus::Role::Doable](https://github.com/cpanery/blob/main/lib/Venus/Role/Doable.pod)
- [Venus::Role::Dumpable](https://github.com/cpanery/blob/main/lib/Venus/Role/Dumpable.pod)
- [Venus::Role::Explainable](https://github.com/cpanery/blob/main/lib/Venus/Role/Explainable.pod)
- [Venus::Role::Mappable](https://github.com/cpanery/blob/main/lib/Venus/Role/Mappable.pod)
- [Venus::Role::Pluggable](https://github.com/cpanery/blob/main/lib/Venus/Role/Pluggable.pod)
- [Venus::Role::Printable](https://github.com/cpanery/blob/main/lib/Venus/Role/Printable.pod)
- [Venus::Role::Proxyable](https://github.com/cpanery/blob/main/lib/Venus/Role/Proxyable.pod)
- [Venus::Role::Stashable](https://github.com/cpanery/blob/main/lib/Venus/Role/Stashable.pod)
- [Venus::Role::Throwable](https://github.com/cpanery/blob/main/lib/Venus/Role/Throwable.pod)
- [Venus::Role::Tryable](https://github.com/cpanery/blob/main/lib/Venus/Role/Tryable.pod)
- [Venus::Role::Valuable](https://github.com/cpanery/blob/main/lib/Venus/Role/Valuable.pod)
- [Venus::Scalar](https://github.com/cpanery/blob/main/lib/Venus/Scalar.pod)
- [Venus::Search](https://github.com/cpanery/blob/main/lib/Venus/Search.pod)
- [Venus::Space](https://github.com/cpanery/blob/main/lib/Venus/Space.pod)
- [Venus::String](https://github.com/cpanery/blob/main/lib/Venus/String.pod)
- [Venus::Throw](https://github.com/cpanery/blob/main/lib/Venus/Throw.pod)
- [Venus::Try](https://github.com/cpanery/blob/main/lib/Venus/Try.pod)
- [Venus::Type](https://github.com/cpanery/blob/main/lib/Venus/Type.pod)
- [Venus::Undef](https://github.com/cpanery/blob/main/lib/Venus/Undef.pod)
- [Venus::Vars](https://github.com/cpanery/blob/main/lib/Venus/Vars.pod)

## Founder

- [@iamalnewkirk](https://github.com/iamalnewkirk)

## Contributing

We rely on your contributions and feedback to improve Venus, and we love
hearing about your experiences and about what may be unclear and we can improve
upon.

Contributions are always welcome! See the [contributing
guide](https://github.com/cpanery/venus/blob/main/CONTRIBUTING.md) for ways to
get started, and please adhere to this project's [code of
conduct](https://github.com/cpanery/venus/blob/main/CODE_OF_CONDUCT.md).

## Support

For support, feel free to report an [issue](issues).

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)
