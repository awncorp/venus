package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus

=cut

$test->for('name');

=tagline

OO Library

=cut

$test->for('tagline');

=abstract

OO Standard Library for Perl 5

=cut

$test->for('abstract');

=includes

function: cast
function: catch
function: error
function: false
function: raise
function: true

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus qw(
    catch
    error
    raise
  );

  # error handling
  my ($error, $result) = catch {
    error;
  };

  # boolean keywords
  if ($result and $result eq false) {
    true;
  }

  # raise exceptions
  if (false) {
    raise 'MyApp::Error';
  }

  # and much more!
  true ne false;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This library provides an object-orientation framework and extendible standard
library for Perl 5, built on top of the L<Mars> architecture with classes which
wrap most native Perl data types. Venus has a simple modular architecture,
robust library of classes, methods, and roles, supports pure-Perl autoboxing,
advanced exception handling, "true" and "false" functions, package
introspection, command-line options parsing, and more. This package will always
automatically exports C<true> and C<false> keyword functions (unless existing
routines of the same name already exist in the calling package or its parents),
otherwise exports keyword functions as requested at import. This library
requires Perl C<5.18+>.

=cut

$test->for('description');

=function cast

The cast function returns the argument provided as an object, promoting native
Perl data types to data type objects. The optional second argument can be the
name of the type for the object to cast to explicitly.

=signature cast

  cast(Any $data, Str $type) (Object)

=metadata cast

{
  since => '1.40',
}

=example-1 cast

  package main;

  use Venus 'cast';

  my $undef = cast;

  # bless({value => undef}, "Venus::Undef")

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Undef');

  !$result
});

=example-2 cast

  package main;

  use Venus 'cast';

  my @booleans = map cast, true, false;

  # (bless({value => 1}, "Venus::Boolean"), bless({value => 0}, "Venus::Boolean"))

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  ok $result[0]->isa('Venus::Boolean');
  is $result[0]->get, 1;
  ok $result[1]->isa('Venus::Boolean');
  is $result[1]->get, 0;

  @result
});

=example-3 cast

  package main;

  use Venus 'cast';

  my $example = cast bless({}, "Example");

  # bless({value => 1}, "Example")

=cut

$test->for('example', 3, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=example-4 cast

  package main;

  use Venus 'cast';

  my $float = cast 1.23;

  # bless({value => "1.23"}, "Venus::Float")

=cut

$test->for('example', 4, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Float');
  is $result->get, 1.23;

  $result
});

=function catch

The catch function executes the code block trapping errors and returning the
caught exception in scalar context, and also returning the result as a second
argument in list context.

=signature catch

  catch(CodeRef $block) (Error, Any)

=metadata catch

{
  since => '0.01',
}

=example-1 catch

  package main;

  use Venus 'catch';

  my $error = catch {die};

  $error;

  # "Died at ..."

=cut

$test->for('example', 1, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !ref($result);

  $result
});

=example-2 catch

  package main;

  use Venus 'catch';

  my ($error, $result) = catch {error};

  $error;

  # bless({...}, 'Venus::Error')

=cut

$test->for('example', 2, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');

  $result
});

=example-3 catch

  package main;

  use Venus 'catch';

  my ($error, $result) = catch {true};

  $result;

  # 1

=cut

$test->for('example', 3, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=function error

The error function throws a L<Venus::Error> exception object using the
exception object arguments provided.

=signature error

  error(Maybe[HashRef] $args) (Error)

=metadata error

{
  since => '0.01',
}

=example-1 error

  package main;

  use Venus 'error';

  my $error = error;

  # bless({...}, 'Venus::Error')

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=example-2 error

  package main;

  use Venus 'error';

  my $error = error {
    message => 'Something failed!',
  };

  # bless({message => 'Something failed!', ...}, 'Venus::Error')

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Something failed!';

  $result
});

=function false

The false function returns a falsy boolean value which is designed to be
practically indistinguishable from the conventional numerical C<0> value.

=signature false

  false() (Bool)

=metadata false

{
  since => '0.01',
}

=example-1 false

  package main;

  use Venus;

  my $false = false;

  # 0

=cut

$test->for('example', 1, 'false', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-2 false

  package main;

  use Venus;

  my $true = !false;

  # 1

=cut

$test->for('example', 2, 'false', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=function raise

The raise function generates and throws a named exception object derived from
L<Venus::Error>, or provided base class, using the exception object arguments
provided.

=signature raise

  raise(Str $class | Tuple[Str, Str] $class, Maybe[HashRef] $args) (Error)

=metadata raise

{
  since => '0.01',
}

=example-1 raise

  package main;

  use Venus 'raise';

  my $error = raise 'MyApp::Error';

  # bless({...}, 'MyApp::Error')

=cut

$test->for('example', 1, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('MyApp::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=example-2 raise

  package main;

  use Venus 'raise';

  my $error = raise ['MyApp::Error', 'Venus::Error'];

  # bless({...}, 'MyApp::Error')

=cut

$test->for('example', 2, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('MyApp::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=example-3 raise

  package main;

  use Venus 'raise';

  my $error = raise ['MyApp::Error', 'Venus::Error'], {
    message => 'Something failed!',
  };

  # bless({message => 'Something failed!', ...}, 'MyApp::Error')

=cut

$test->for('example', 3, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('MyApp::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Something failed!';

  $result
});

=function true

The true function returns a truthy boolean value which is designed to be
practically indistinguishable from the conventional numerical C<1> value.

=signature true

  true() (Bool)

=metadata true

{
  since => '0.01',
}

=example-1 true

  package main;

  use Venus;

  my $true = true;

  # 1

=cut

$test->for('example', 1, 'true', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 true

  package main;

  use Venus;

  my $false = !true;

  # 0

=cut

$test->for('example', 2, 'true', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=feature standard-library

This library provides a Perl object-oriented standard library with value
classes and consistently named methods.

=cut

$test->for('feature', 'standard-library');

=example-1 standard-library

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

  # 1

=cut

$test->for('example', 1, 'standard-library', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=feature value-classes

This library provides value classes which wrap native Perl data types and
provides methods for operating their values.

=cut

$test->for('feature', 'value-classes');

=example-1 value-classes

  package main;

  use Venus::Array;

  my $array = Venus::Array->new;

  # bless({...}, 'Venus::Array')

=cut

$test->for('example', 1, 'value-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-2 value-classes

  package main;

  use Venus::Boolean;

  my $boolean = Venus::Boolean->new;

  # bless({...}, 'Venus::Boolean')

=cut

$test->for('example', 2, 'value-classes', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-3 value-classes

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  # bless({...}, 'Venus::Code')

=cut

$test->for('example', 3, 'value-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-4 value-classes

  package main;

  use Venus::Float;

  my $float = Venus::Float->new;

  # bless({...}, 'Venus::Float')

=cut

$test->for('example', 4, 'value-classes', sub {
  my ($tryable) = @_;
  ok !!(my $result = $tryable->result);

  !!$result
});

=example-5 value-classes

  package main;

  use Venus::Hash;

  my $hash = Venus::Hash->new;

  # bless({...}, 'Venus::Hash')

=cut

$test->for('example', 5, 'value-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-6 value-classes

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  # bless({...}, 'Venus::Number')

=cut

$test->for('example', 6, 'value-classes', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-7 value-classes

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new;

  # bless({...}, 'Venus::Regexp')

=cut

$test->for('example', 7, 'value-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-8 value-classes

  package main;

  use Venus::Scalar;

  my $scalar = Venus::Scalar->new;

  # bless({...}, 'Venus::Scalar')

=cut

$test->for('example', 8, 'value-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-9 value-classes

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  # bless({...}, 'Venus::String')

=cut

$test->for('example', 9, 'value-classes', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-10 value-classes

  package main;

  use Venus::Undef;

  my $undef = Venus::Undef->new;

  # bless({...}, 'Venus::Undef')

=cut

$test->for('example', 10, 'value-classes', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=feature builtin-autoboxing

This library provides opt-in pure Perl autoboxing allowing you to chain methods
calls across objects and values.

=cut

$test->for('feature', 'builtin-autoboxing');

=example-1 builtin-autoboxing

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello, world');

  $string->box->split(', ')->join(' ')->titlecase->unbox->get;

  # Hello World

=cut

$test->for('example', 1, 'builtin-autoboxing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=feature utility-classes

This library provides serveral essential utility classes for performing common
programming tasks.

=cut

$test->for('feature', 'utility-classes');

=example-1 utility-classes

  package main;

  use Venus::Args;

  my $args = Venus::Args->new;

  # bless({...}, 'Venus::Args')

=cut

$test->for('example', 1, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-2 utility-classes

  package main;

  use Venus::Box;

  my $box = Venus::Box->new;

  # bless({...}, 'Venus::Box')

=cut

$test->for('example', 2, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-3 utility-classes

  package main;

  use Venus::Data;

  my $docs = Venus::Data->new->docs;

  # bless({...}, 'Venus::Data')

=cut

$test->for('example', 3, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-4 utility-classes

  package main;

  use Venus::Date;

  my $date = Venus::Date->new;

  # bless({...}, 'Venus::Date')

=cut

$test->for('example', 4, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-5 utility-classes

  package main;

  use Venus::Error;

  my $error = Venus::Error->new;

  # bless({...}, 'Venus::Error')

=cut

$test->for('example', 5, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-6 utility-classes

  package main;

  use Venus::Json;

  my $json = Venus::Json->new;

  # bless({...}, 'Venus::Json')

=cut

$test->for('example', 6, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-7 utility-classes

  package main;

  use Venus::Name;

  my $name = Venus::Name->new;

  # bless({...}, 'Venus::Name')

=cut

$test->for('example', 7, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-8 utility-classes

  package main;

  use Venus::Opts;

  my $opts = Venus::Opts->new;

  # bless({...}, 'Venus::Opts')

=cut

$test->for('example', 8, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-9 utility-classes

  package main;

  use Venus::Path;

  my $path = Venus::Path->new;

  # bless({...}, 'Venus::Path')

=cut

$test->for('example', 9, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-10 utility-classes

  package main;

  use Venus::Data;

  my $text = Venus::Data->new->text;

  # bless({...}, 'Venus::Data')

=cut

$test->for('example', 10, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-11 utility-classes

  package main;

  use Venus::Space;

  my $space = Venus::Space->new;

  # bless({...}, 'Venus::Space')

=cut

$test->for('example', 11, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-12 utility-classes

  package main;

  use Venus::Throw;

  my $throw = Venus::Throw->new;

  # bless({...}, 'Venus::Throw')

=cut

$test->for('example', 12, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-13 utility-classes

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  # bless({...}, 'Venus::Try')

=cut

$test->for('example', 13, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-14 utility-classes

  package main;

  use Venus::Type;

  my $type = Venus::Type->new;

  # bless({...}, 'Venus::Type')

=cut

$test->for('example', 14, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-15 utility-classes

  package main;

  use Venus::Vars;

  my $vars = Venus::Vars->new;

  # bless({...}, 'Venus::Vars')

=cut

$test->for('example', 15, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-16 utility-classes

  package main;

  use Venus::Match;

  my $match = Venus::Match->new;

  # bless({...}, 'Venus::Match')

=cut

$test->for('example', 16, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-17 utility-classes

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 17, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-18 utility-classes

  package main;

  use Venus::Template;

  my $template = Venus::Template->new;

  # bless({...}, 'Venus::Template')

=cut

$test->for('example', 18, 'utility-classes', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Template');

  !$result
});

=example-19 utility-classes

  package main;

  use Venus::Yaml;

  my $yaml = Venus::Yaml->new;

  # bless({...}, 'Venus::Yaml')

=cut

$test->for('example', 19, 'utility-classes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
})
if require Venus::Yaml && Venus::Yaml->package;

=feature package-reflection

This library provides a package reflection class, L<Venus::Space>, which can be
used to perform meta-programming on package spaces.

=cut

$test->for('feature', 'package-reflection');

=example-1 package-reflection

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus');

  $space->do('tryload')->routines;

  # [...]

=cut

$test->for('example', 1, 'package-reflection', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=feature exception-handling

This library provides a framework for raising, i.e. generating and throwing,
exception objects and catching them.

=cut

$test->for('feature', 'exception-handling');

=example-1 exception-handling

  package MyApp;

  use Venus::Class;

  with 'Venus::Role::Tryable';
  with 'Venus::Role::Throwable';
  with 'Venus::Role::Catchable';

  sub execute {
    my ($self) = @_;

    $self->throw->error;
  }

  package main;

  my $myapp = MyApp->new;

  my $error = $myapp->catch('execute');

  # bless({...}, 'MyApp::Error');

=cut

$test->for('example', 1, 'exception-handling', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=feature composable-standards

This library provides a library of composable roles which can be used to extend
core behaviors to custom objects.

=cut

$test->for('feature', 'composable-standards');

=example-1 composable-standards

  package MyApp;

  use Venus::Class;

  with 'Venus::Role::Dumpable';
  with 'Venus::Role::Stashable';

  package main;

  my $myapp = MyApp->new;

  $myapp->stash(greeting => 'hello world');

  $myapp->dump('stash');

  # '{"greeting" => "hello world"}'

=cut

$test->for('example', 1, 'composable-standards', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=feature pluggable-library

This library provides a mechanism for extending the standard library, i.e.
value classes, using plugins which can be automatically discovered and invoked.
(no monkey-patching necessary)

=cut

$test->for('feature', 'pluggable-library');

=example-1 pluggable-library

  package Venus::String::Plugin::Base64;

  sub new {
    return bless {};
  }

  sub execute {
    my ($self, $string, @args) = @_;

    require MIME::Base64;

    return MIME::Base64::encode_base64($string->value);
  }

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello, world');

  $string->base64;

  # "aGVsbG8sIHdvcmxk\n"

=cut

$test->for('example', 1, 'pluggable-library', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=feature template-system

This library provides a minimalistic templating system.

=cut

$test->for('feature', 'template-system');

=example-1 template-system

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

  # "Welcome, friend!"

=cut

$test->for('example', 1, 'template-system', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=authors

Awncorp, C<awncorp@cpan.org>

+=head1 LICENSE

Copyright (C) 2000, Al Newkirk.

This program is free software, you can redistribute it and/or modify it under
the terms of the Apache license version 2.0.

=cut

# END

$test->render('lib/Venus.pod') if $ENV{RENDER};

ok 1 and done_testing;
