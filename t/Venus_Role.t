package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role

=cut

$test->for('name');

=tagline

Role Builder

=cut

$test->for('tagline');

=abstract

Role Builder for Perl 5

=cut

$test->for('abstract');

=includes

function: attr
function: base
function: catch
function: error
function: false
function: from
function: mixin
function: raise
function: role
function: test
function: true
function: with

=cut

$test->for('includes');

=synopsis

  package Person;

  use Venus::Class 'attr';

  attr 'fname';
  attr 'lname';

  package Identity;

  use Venus::Role 'attr';

  attr 'id';
  attr 'login';
  attr 'password';

  sub EXPORT {
    # explicitly declare routines to be consumed
    ['id', 'login', 'password']
  }

  package Authenticable;

  use Venus::Role;

  sub authenticate {
    return true;
  }

  sub AUDIT {
    my ($self, $from) = @_;
    # ensure the caller has a login and password when consumed
    die "${from} missing the login attribute" if !$from->can('login');
    die "${from} missing the password attribute" if !$from->can('password');
  }

  sub BUILD {
    my ($self, $data) = @_;
    $self->{auth} = undef;
    return $self;
  }

  sub EXPORT {
    # explicitly declare routines to be consumed
    ['authenticate']
  }

  package User;

  use Venus::Class;

  base 'Person';

  with 'Identity';

  attr 'email';

  test 'Authenticable';

  sub valid {
    my ($self) = @_;
    return $self->login && $self->password ? true : false;
  }

  package main;

  my $user = User->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'User')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->isa('Person');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->can('login');
  ok $result->can('password');
  ok $result->can('valid');
  ok !$result->valid;
  ok UNIVERSAL::isa($result, 'HASH');
  ok $result->fname eq 'Elliot';
  ok $result->lname eq 'Alderson';
  ok $result->does('Identity');
  ok $result->does('Authenticable');
  ok exists $result->{auth};
  ok !defined $result->{auth};

  $result
});

=description

This package provides a role builder which when used causes the consumer to
inherit from L<Venus::Core::Role> which provides role construction and
lifecycle L<hooks|Venus::Core>. A role differs from a L<"class"|Venus::Class>
in that it can't be instantiated using the C<new> method. A role can act as an
interface by defining an L<"audit"|Venus::Core/AUDIT> hook which is invoked
automatically by the L<"test"|Venus::Class/test> function.

=cut

$test->for('description');

=function attr

The attr function creates attribute accessors for the calling package. This
function is always exported unless a routine of the same name already exists.

=signature attr

  attr(Str $name) (Str)

=metadata attr

{
  since => '1.00',
}

=example-1 attr

  package Example;

  use Venus::Class;

  attr 'name';

  # "Example"

=cut

$test->for('example', 1, 'attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->can('name');
  my $object = $result->new;
  ok !$object->name;
  $object = $result->new(name => 'example');
  ok $object->name eq 'example';
  $object = $result->new({name => 'example'});
  ok $object->name eq 'example';

  $result
});

=function base

The base function registers one or more base classes for the calling package.
This function is always exported unless a routine of the same name already
exists.

=signature base

  base(Str $name) (Str)

=metadata base

{
  since => '1.00',
}

=example-1 base

  package Entity;

  use Venus::Class;

  sub output {
    return;
  }

  package Example;

  use Venus::Class;

  base 'Entity';

  # "Example"

=cut

$test->for('example', 1, 'base', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Entity');
  ok $result->isa('Venus::Core::Class');
  ok $result->isa('Venus::Core');
  ok $result->can('output');

  $result
});

=function catch

The catch function executes the code block trapping errors and returning the
caught exception in scalar context, and also returning the result as a second
argument in list context. This function isn't export unless requested.

=signature catch

  catch(CodeRef $block) (Error, Any)

=metadata catch

{
  since => '1.01',
}

=example-1 catch

  package Ability;

  use Venus::Role 'catch';

  sub attempt_catch {
    catch {die};
  }

  sub EXPORT {
    ['attempt_catch']
  }

  package Example;

  use Venus::Class 'with';

  with 'Ability';

  package main;

  my $example = Example->new;

  my $error = $example->attempt_catch;

  $error;

  # "Died at ..."

=cut

$test->for('example', 1, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !ref($result);

  $result
});

=function error

The error function throws a L<Venus::Error> exception object using the
exception object arguments provided. This function isn't export unless requested.

=signature error

  error(Maybe[HashRef] $args) (Error)

=metadata error

{
  since => '1.01',
}

=example-1 error

  package Ability;

  use Venus::Role 'error';

  sub attempt_error {
    error;
  }

  sub EXPORT {
    ['attempt_error']
  }

  package Example;

  use Venus::Class 'with';

  with 'Ability';

  package main;

  my $example = Example->new;

  my $error = $example->attempt_error;

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

=function false

The false function returns a falsy boolean value which is designed to be
practically indistinguishable from the conventional numerical C<0> value. This
function is always exported unless a routine of the same name already exists.

=signature false

  false() (Bool)

=metadata false

{
  since => '1.00',
}

=example-1 false

  package Example;

  use Venus::Class;

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

  package Example;

  use Venus::Class;

  my $true = !false;

  # 1

=cut

$test->for('example', 2, 'false', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=function from

The from function registers one or more base classes for the calling package
and performs an L<"audit"|Venus::Core/AUDIT>. This function is always exported
unless a routine of the same name already exists.

=signature from

  from(Str $name) (Str)

=metadata from

{
  since => '1.00',
}

=example-1 from

  package Entity;

  use Venus::Role;

  attr 'startup';
  attr 'shutdown';

  sub EXPORT {
    ['startup', 'shutdown']
  }

  package Record;

  use Venus::Class;

  sub AUDIT {
    my ($self, $from) = @_;
    die "Missing startup" if !$from->can('startup');
    die "Missing shutdown" if !$from->can('shutdown');
  }

  package Example;

  use Venus::Class;

  with 'Entity';

  from 'Record';

  # "Example"

=cut

$test->for('example', 1, 'from', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Record');
  ok $result->does('Entity');
  ok $result->can('startup');
  ok $result->can('shutdown');

  $result
});

=function mixin

The mixin function registers and consumes mixins for the calling package. This
function is always exported unless a routine of the same name already exists.

=signature mixin

  mixin(Str $name) (Str)

=metadata mixin

{
  since => '1.02',
}

=example-1 mixin

  package YesNo;

  use Venus::Mixin;

  sub no {
    return 0;
  }

  sub yes {
    return 1;
  }

  sub EXPORT {
    ['no', 'yes']
  }

  package Answer;

  use Venus::Role;

  mixin 'YesNo';

  # "Answer"

=cut

$test->for('example', 1, 'mixin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Answer');
  ok $result->can('yes');
  ok $result->can('no');
  ok $result->yes == 1;
  ok $result->no == 0;

  $result
});

=example-2 mixin

  package YesNo;

  use Venus::Mixin;

  sub no {
    return 0;
  }

  sub yes {
    return 1;
  }

  sub EXPORT {
    ['no', 'yes']
  }

  package Answer;

  use Venus::Role;

  mixin 'YesNo';

  sub no {
    return [0];
  }

  sub yes {
    return [1];
  }

  my $package = "Answer";

  # "Answer"

=cut

$test->for('example', 2, 'mixin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->can('yes');
  ok $result->can('no');
  ok $result->yes == 1;
  ok $result->no == 0;

  $result
});

=function raise

The raise function generates and throws a named exception object derived from
L<Venus::Error>, or provided base class, using the exception object arguments
provided. This function isn't export unless requested.

=signature raise

  raise(Str $class | Tuple[Str, Str] $class, Maybe[HashRef] $args) (Error)

=metadata raise

{
  since => '1.01',
}

=example-1 raise

  package Ability;

  use Venus::Role 'raise';

  sub attempt_raise {
    raise 'Example::Error';
  }

  sub EXPORT {
    ['attempt_raise']
  }

  package Example;

  use Venus::Class 'with';

  with 'Ability';

  package main;

  my $example = Example->new;

  my $error = $example->attempt_raise;

  # bless({...}, 'Example::Error')

=cut

$test->for('example', 1, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Example::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=function role

The role function registers and consumes roles for the calling package. This
function is always exported unless a routine of the same name already exists.

=signature role

  role(Str $name) (Str)

=metadata role

{
  since => '1.00',
}

=example-1 role

  package Ability;

  use Venus::Role;

  sub action {
    return;
  }

  package Example;

  use Venus::Class;

  role 'Ability';

  # "Example"

=cut

$test->for('example', 1, 'role', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->does('Ability');
  ok !$result->can('action');

  $result
});

=example-2 role

  package Ability;

  use Venus::Role;

  sub action {
    return;
  }

  sub EXPORT {
    return ['action'];
  }

  package Example;

  use Venus::Class;

  role 'Ability';

  # "Example"

=cut

$test->for('example', 2, 'role', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->does('Ability');
  ok $result->can('action');

  $result
});

=function test

The test function registers and consumes roles for the calling package and
performs an L<"audit"|Venus::Core/AUDIT>, effectively allowing a role to act as
an interface. This function is always exported unless a routine of the same
name already exists.

=signature test

  test(Str $name) (Str)

=metadata test

{
  since => '1.00',
}

=example-1 test

  package Actual;

  use Venus::Role;

  package Example;

  use Venus::Class;

  test 'Actual';

  # "Example"

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->does('Actual');

  $result
});

=example-2 test

  package Actual;

  use Venus::Role;

  sub AUDIT {
    die "Example is not an 'actual' thing" if $_[1]->isa('Example');
  }

  package Example;

  use Venus::Class;

  test 'Actual';

  # "Example"

=cut

$test->for('example', 2, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error =~ qr/Example is not an 'actual' thing/;

  $result
});

=function true

The true function returns a truthy boolean value which is designed to be
practically indistinguishable from the conventional numerical C<1> value. This
function is always exported unless a routine of the same name already exists.

=signature true

  true() (Bool)

=metadata true

{
  since => '1.00',
}

=example-1 true

  package Example;

  use Venus::Class;

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

  package Example;

  use Venus::Class;

  my $false = !true;

  # 0

=cut

$test->for('example', 2, 'true', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=function with

The with function registers and consumes roles for the calling package. This
function is an alias of the L</test> function and will perform an
L<"audit"|Venus::Core/AUDIT> if present. This function is always exported
unless a routine of the same name already exists.

=signature with

  with(Str $name) (Str)

=metadata with

{
  since => '1.00',
}

=example-1 with

  package Understanding;

  use Venus::Role;

  sub knowledge {
    return;
  }

  package Example;

  use Venus::Class;

  with 'Understanding';

  # "Example"

=cut

$test->for('example', 1, 'with', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->does('Understanding');
  ok !$result->can('knowledge');

  $result
});

=example-2 with

  package Understanding;

  use Venus::Role;

  sub knowledge {
    return;
  }

  sub EXPORT {
    return ['knowledge'];
  }

  package Example;

  use Venus::Class;

  with 'Understanding';

  # "Example"

=cut

$test->for('example', 2, 'with', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->does('Understanding');
  ok $result->can('knowledge');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role.pod') if $ENV{RENDER};

ok 1 and done_testing;
