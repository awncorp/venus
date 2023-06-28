package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Core

=cut

$test->for('name');

=tagline

Core Base Class

=cut

$test->for('tagline');

=abstract

Core Base Class for Perl 5

=cut

$test->for('abstract');

=includes

method: args
method: attr
method: audit
method: base
method: bless
method: build
method: buildargs
method: data
method: destroy
method: does
method: export
method: from
method: get
method: import
method: item
method: meta
method: name
method: role
method: set
method: subs
method: test
method: unimport

=cut

$test->for('includes');

=synopsis

  package User;

  use base 'Venus::Core';

  package main;

  my $user = User->BLESS(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'User')

  # i.e. BLESS is somewhat equivalent to writing

  # User->BUILD(bless(User->ARGS(User->BUILDARGS(@args) || User->DATA), 'User'))

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok UNIVERSAL::isa($result, 'Venus::Core');
  ok UNIVERSAL::isa($result, 'HASH');
  ok $result->{fname} eq 'Elliot';
  ok $result->{lname} eq 'Alderson';

  $result
});

=description

This package provides a base class for L<"class"|Venus::Core::Class> and
L<"role"|Venus::Core::Role> (kind) derived packages and provides class building,
object construction, and object deconstruction lifecycle hooks. The
L<Venus::Class> and L<Venus::Role> packages provide a simple DSL for automating
L<Venus::Core> derived base classes.

=cut

$test->for('description');

=method args

The ARGS method is a object construction lifecycle hook which accepts a list of
arguments and returns a blessable data structure.

=signature args

  ARGS(Any @args) (HashRef)

=metadata args

{
  since => '1.00',
}

=example-1 args

  # given: synopsis

  package main;

  my $args = User->ARGS;

  # {}

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref $result eq 'HASH';

  $result
});

=example-2 args

  # given: synopsis

  package main;

  my $args = User->ARGS(name => 'Elliot');

  # {name => 'Elliot'}

=cut

$test->for('example', 2, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref $result eq 'HASH';
  ok int(keys(%{$result})) == 1;
  ok $result->{name} eq 'Elliot';

  $result
});

=example-3 args

  # given: synopsis

  package main;

  my $args = User->ARGS({name => 'Elliot'});

  # {name => 'Elliot'}

=cut

$test->for('example', 3, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref $result eq 'HASH';
  ok int(keys(%{$result})) == 1;
  ok $result->{name} eq 'Elliot';

  $result
});

=method attr

The ATTR method is a class building lifecycle hook which installs an attribute
accessors in the calling package.

=signature attr

  ATTR(Str $name, Any @args) (Str | Object)

=metadata attr

{
  since => '1.00',
}

=example-1 attr

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

  # $user->name;

  # ""

  # $user->name('Elliot');

  # "Elliot"

=cut

$test->for('example', 1, 'attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->can('name');
  ok !exists $result->{name};
  ok !$result->name;
  ok $result->name('Elliot') eq 'Elliot';
  ok $result->name;

  $result
});

=example-2 attr

  package User;

  use base 'Venus::Core';

  User->ATTR('role');

  package main;

  my $user = User->BLESS(role => 'Engineer');

  # bless({role => 'Engineer'}, 'User')

  # $user->role;

  # "Engineer"

  # $user->role('Hacker');

  # "Hacker"

=cut

$test->for('example', 2, 'attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->can('role');
  ok $result->{role} eq 'Engineer';
  ok $result->role eq 'Engineer';
  ok $result->role('Hacker') eq 'Hacker';
  ok $result->{role} eq 'Hacker';
  ok $result->role eq 'Hacker';

  $result
});

=method audit

The AUDIT method is a class building lifecycle hook which exist in roles and is
executed as a callback when the consuming class invokes the L</TEST> hook.

=signature audit

  AUDIT(Str $role) (Str | Object)

=metadata audit

{
  since => '1.00',
}

=example-1 audit

  package HasType;

  use base 'Venus::Core';

  sub AUDIT {
    die 'Consumer missing "type" attribute' if !$_[1]->can('type');
  }

  package User;

  use base 'Venus::Core';

  User->TEST('HasType');

  package main;

  my $user = User->BLESS;

  # Exception! Consumer missing "type" attribute

=cut

$test->for('example', 1, 'audit', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error =~ qr/Consumer missing "type" attribute/;

  $result
});

=example-2 audit

  package HasType;

  sub AUDIT {
    die 'Consumer missing "type" attribute' if !$_[1]->can('type');
  }

  package User;

  use base 'Venus::Core';

  User->ATTR('type');

  User->TEST('HasType');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 2, 'audit', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->can('type');

  $result
});

=method base

The BASE method is a class building lifecycle hook which registers a base class
for the calling package. B<Note:> Unlike the L</FROM> hook, this hook doesn't
invoke the L</AUDIT> hook.

=signature base

  BASE(Str $name) (Str | Object)

=metadata base

{
  since => '1.00',
}

=example-1 base

  package Entity;

  sub work {
    return;
  }

  package User;

  use base 'Venus::Core';

  User->BASE('Entity');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 1, 'base', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->isa('Entity');
  ok $result->can('work');
  {
    no strict 'refs';
    is_deeply [@User::ISA], ['Entity', 'Venus::Core'];
  }

  $result
});

=example-2 base

  package Engineer;

  sub debug {
    return;
  }

  package Entity;

  sub work {
    return;
  }

  package User;

  use base 'Venus::Core';

  User->BASE('Entity');

  User->BASE('Engineer');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 2, 'base', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->isa('Entity');
  ok $result->isa('Engineer');
  ok $result->isa('Venus::Core');
  ok $result->can('work');
  ok $result->can('debug');
  {
    no strict 'refs';
    is_deeply [@User::ISA], ['Engineer', 'Entity', 'Venus::Core'];
  }

  $result
});

=example-3 base

  package User;

  use base 'Venus::Core';

  User->BASE('Manager');

  # Exception! "Can't locate Manager.pm in @INC"

=cut

$test->for('example', 3, 'base', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error =~ qr/Can't locate Manager\.pm in \@INC/;

  $result
});

=method bless

The BLESS method is an object construction lifecycle hook which returns an
instance of the calling package.

=signature bless

  BLESS(Any @args) (Object)

=metadata bless

{
  since => '1.00',
}

=example-1 bless

  package User;

  use base 'Venus::Core';

  package main;

  my $example = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 1, 'bless', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok !%$result;

  $result
});

=example-2 bless

  package User;

  use base 'Venus::Core';

  package main;

  my $example = User->BLESS(name => 'Elliot');

  # bless({name => 'Elliot'}, 'User')

=cut

$test->for('example', 2, 'bless', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok int(keys(%$result)) == 1;
  ok exists $result->{name};
  ok $result->{name} eq 'Elliot';
  ok $result->name eq 'Elliot';

  $result
});

=example-3 bless

  package User;

  use base 'Venus::Core';

  package main;

  my $example = User->BLESS({name => 'Elliot'});

  # bless({name => 'Elliot'}, 'User')

=cut

$test->for('example', 3, 'bless', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok int(keys(%$result)) == 1;
  ok exists $result->{name};
  ok $result->{name} eq 'Elliot';
  ok $result->name eq 'Elliot';

  $result
});

=example-4 bless

  package List;

  use base 'Venus::Core';

  sub ARGS {
    my ($self, @args) = @_;

    return @args
      ? ((@args == 1 && ref $args[0] eq 'ARRAY') ? @args : [@args])
      : $self->DATA;
  }

  sub DATA {
    my ($self, $data) = @_;

    return $data ? [@$data] : [];
  }

  package main;

  my $list = List->BLESS(1..4);

  # bless([1..4], 'List')

=cut

$test->for('example', 4, 'bless', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('List');
  is_deeply $result, [1..4];

  $result
});

=example-5 bless

  package List;

  use base 'Venus::Core';

  sub ARGS {
    my ($self, @args) = @_;

    return @args
      ? ((@args == 1 && ref $args[0] eq 'ARRAY') ? @args : [@args])
      : $self->DATA;
  }

  sub DATA {
    my ($self, $data) = @_;

    return $data ? [@$data] : [];
  }

  package main;

  my $list = List->BLESS([1..4]);

  # bless([1..4], 'List')

=cut

$test->for('example', 5, 'bless', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('List');
  is_deeply $result, [1..4];

  $result
});

=method build

The BUILD method is an object construction lifecycle hook which receives an
object and the data structure that was blessed, and should return an object
although its return value is ignored by the L</BLESS> hook.

=signature build

  BUILD(HashRef $data) (Object)

=metadata build

{
  since => '1.00',
}

=example-1 build

  package User;

  use base 'Venus::Core';

  sub BUILD {
    my ($self) = @_;

    $self->{name} = 'Mr. Robot';

    return $self;
  }

  package main;

  my $example = User->BLESS(name => 'Elliot');

  # bless({name => 'Mr. Robot'}, 'User')

=cut

$test->for('example', 1, 'build', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok int(keys(%$result)) == 1;
  ok exists $result->{name};
  ok $result->{name} eq 'Mr. Robot';
  ok $result->name eq 'Mr. Robot';

  $result
});

=example-2 build

  package User;

  use base 'Venus::Core';

  sub BUILD {
    my ($self) = @_;

    $self->{name} = 'Mr. Robot';

    return $self;
  }

  package Elliot;

  use base 'User';

  sub BUILD {
    my ($self, $data) = @_;

    $self->SUPER::BUILD($data);

    $self->{name} = 'Elliot';

    return $self;
  }

  package main;

  my $elliot = Elliot->BLESS;

  # bless({name => 'Elliot'}, 'Elliot')

=cut

$test->for('example', 2, 'build', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Elliot');
  ok $result->isa('User');
  ok int(keys(%$result)) == 1;
  ok exists $result->{name};
  ok $result->{name} eq 'Elliot';
  ok $result->name eq 'Elliot';

  $result
});

=method buildargs

The BUILDARGS method is an object construction lifecycle hook which receives
the arguments provided to the constructor (unaltered) and should return a list
of arguments, a hashref, or key/value pairs.

=signature buildargs

  BUILDARGS(Any @args) (Any @args | HashRef $data)

=metadata buildargs

{
  since => '1.00',
}

=example-1 buildargs

  package User;

  use base 'Venus::Core';

  sub BUILD {
    my ($self) = @_;

    return $self;
  }

  sub BUILDARGS {
    my ($self, @args) = @_;

    my $data = @args == 1 && !ref $args[0] ? {name => $args[0]} : {};

    return $data;
  }

  package main;

  my $user = User->BLESS('Elliot');

  # bless({name => 'Elliot'}, 'User')

=cut

$test->for('example', 1, 'buildargs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok int(keys(%$result)) == 1;
  ok exists $result->{name};
  ok $result->{name} eq 'Elliot';
  ok $result->name eq 'Elliot';

  $result
});

=method data

The DATA method is an object construction lifecycle hook which returns the
default data structure reference to be blessed when no arguments are provided
to the constructor. The default data structure is an empty hashref.

=signature data

  DATA() (Ref)

=metadata data

{
  since => '1.00',
}

=example-1 data

  package Example;

  use base 'Venus::Core';

  sub DATA {
    return [];
  }

  package main;

  my $example = Example->BLESS;

  # bless([], 'Example')

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok @$result == 0;

  $result
});

=example-2 data

  package Example;

  use base 'Venus::Core';

  sub DATA {
    return {};
  }

  package main;

  my $example = Example->BLESS;

  # bless({}, 'Example')

=cut

$test->for('example', 2, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok int(keys(%$result)) == 0;
  ok !exists $result->{name};

  $result
});

=method destroy

The DESTROY method is an object destruction lifecycle hook which is called when
the last reference to the object goes away.

=signature destroy

  DESTROY() (Any)

=metadata destroy

{
  since => '1.00',
}

=example-1 destroy

  package User;

  use base 'Venus::Core';

  our $USERS = 0;

  sub BUILD {
    return $USERS++;
  }

  sub DESTROY {
    return $USERS--;
  }

  package main;

  my $user = User->BLESS(name => 'Elliot');

  undef $user;

  # undef

=cut

$test->for('example', 1, 'destroy', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  no warnings 'once';
  ok $User::USERS == 0;

  !$result
});

=method does

The DOES method returns true or false if the invocant consumed the role or
interface provided.

=signature does

  DOES(Str $name) (Bool)

=metadata does

{
  since => '1.00',
}

=example-1 does

  package Admin;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  sub BUILD {
    my ($self) = @_;

    return $self;
  }

  sub BUILDARGS {
    my ($self, @args) = @_;

    return (@args);
  }

  package main;

  my $admin = User->DOES('Admin');

  # 1

=cut

$test->for('example', 1, 'does', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 does

  package Admin;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  sub BUILD {
    my ($self) = @_;

    return $self;
  }

  sub BUILDARGS {
    my ($self, @args) = @_;

    return (@args);
  }

  package main;

  my $is_owner = User->DOES('Owner');

  # 0

=cut

$test->for('example', 2, 'does', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method export

The EXPORT method is a class building lifecycle hook which returns an arrayref
of routine names to be automatically imported by the calling package whenever
the L</ROLE> or L</TEST> hooks are used.

=signature export

  EXPORT(Any @args) (ArrayRef)

=metadata export

{
  since => '1.00',
}

=example-1 export

  package Admin;

  use base 'Venus::Core';

  sub shutdown {
    return;
  }

  sub EXPORT {
    ['shutdown']
  }

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 1, 'export', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->DOES('Admin');

  $result
});

=method from

The FROM method is a class building lifecycle hook which registers a base class
for the calling package, automatically invoking the L</AUDIT> and L</IMPORT>
hooks on the base class.

=signature from

  FROM(Str $name) (Str | Object)

=metadata from

{
  since => '1.00',
}

=example-1 from

  package Entity;

  use base 'Venus::Core';

  sub AUDIT {
    my ($self, $from) = @_;
    die "Missing startup" if !$from->can('startup');
    die "Missing shutdown" if !$from->can('shutdown');
  }

  package User;

  use base 'Venus::Core';

  User->ATTR('startup');
  User->ATTR('shutdown');

  User->FROM('Entity');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 1, 'from', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->isa('Entity');
  ok $result->can('startup');
  ok $result->can('shutdown');

  $result
});

=example-2 from

  package Entity;

  use base 'Venus::Core';

  sub AUDIT {
    my ($self, $from) = @_;
    die "Missing startup" if !$from->can('startup');
    die "Missing shutdown" if !$from->can('shutdown');
  }

  package User;

  use base 'Venus::Core';

  User->FROM('Entity');

  sub startup {
    return;
  }

  sub shutdown {
    return;
  }

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 2, 'from', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->isa('Entity');
  ok $result->can('startup');
  ok $result->can('shutdown');

  $result
});

=method get

The GET method is a class instance lifecycle hook which is responsible for
I<"getting"> instance items (or attribute values). By default, all class
attributes I<"getters"> are dispatched to this method.

=signature get

  GET(Str $name) (Any)

=metadata get

{
  since => '2.91',
}

=cut

=example-1 get

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS(title => 'Engineer');

  # bless({title => 'Engineer'}, 'User')

  my $get = $user->GET('title');

  # "Engineer"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Engineer";

  $result
});

=method import

The IMPORT method is a class building lifecycle hook which dispatches the
L</EXPORT> lifecycle hook whenever the L</ROLE> or L</TEST> hooks are used.

=signature import

  IMPORT(Str $into, Any @args) (Str | Object)

=metadata import

{
  since => '1.00',
}

=example-1 import

  package Admin;

  use base 'Venus::Core';

  our $USES = 0;

  sub shutdown {
    return;
  }

  sub EXPORT {
    ['shutdown']
  }

  sub IMPORT {
    my ($self, $into) = @_;

    $self->SUPER::IMPORT($into);

    $USES++;

    return $self;
  }

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 1, 'import', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->DOES('Admin');
  no warnings 'once';
  ok $Admin::USES == 1;

  $result
});

=method item

The ITEM method is a class instance lifecycle hook which is responsible for
I<"getting"> and I<"setting"> instance items (or attributes). By default, all
class attributes are dispatched to this method.

=signature item

  ITEM(Str $name, Any @args) (Str | Object)

=metadata item

{
  since => '1.11',
}

=example-1 item

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

  my $item = $user->ITEM('name', 'unknown');

  # "unknown"

=cut

$test->for('example', 1, 'item', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'unknown';

  $result
});

=example-2 item

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

  $user->ITEM('name', 'known');

  my $item = $user->ITEM('name');

  # "known"

=cut

$test->for('example', 2, 'item', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'known';

  $result
});

=method meta

The META method return a L<Venus::Meta> object which describes the invocant's
configuration.

=signature meta

  META() (Meta)

=metadata meta

{
  since => '1.00',
}

=example-1 meta

  package User;

  use base 'Venus::Core';

  package main;

  my $meta = User->META;

  # bless({name => 'User'}, 'Venus::Meta')

=cut

$test->for('example', 1, 'meta', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Meta');
  ok $result->{name} eq 'User';
  is_deeply scalar $result->bases, ['Entity', 'Engineer', 'Venus::Core'];
  is_deeply [sort $result->roles], ['Admin', 'HasType'];

  $result
});

=method mixin

The MIXIN method is a class building lifecycle hook which consumes the mixin
provided, automatically invoking the mixin's L</IMPORT> hook. The role
composition semantics are as follows: Routines to be consumed must be
explicitly declared via the L</EXPORT> hook. Routines will be copied to the
consumer even if they already exist. If multiple roles are consumed having
routines with the same name (i.e. naming collisions) the last routine copied
wins.

=signature mixin

  MIXIN(Str $name) (Str | Object)

=metadata mixin

{
  since => '1.02',
}

=example-1 mixin

  package Action;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->MIXIN('Action');

  package main;

  my $admin = User->DOES('Action');

  # 0

=cut

$test->for('example', 1, 'mixin', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method name

The NAME method is a class building lifecycle hook which returns the name of
the package.

=signature name

  NAME() (Str)

=metadata name

{
  since => '1.00',
}

=example-1 name

  package User;

  use base 'Venus::Core';

  package main;

  my $name = User->NAME;

  # "User"

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'User';

  $result
});

=example-2 name

  package User;

  use base 'Venus::Core';

  package main;

  my $name = User->BLESS->NAME;

  # "User"

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'User';

  $result
});

=method role

The ROLE method is a class building lifecycle hook which consumes the role
provided, automatically invoking the role's L</IMPORT> hook. B<Note:> Unlike
the L</TEST> and L</WITH> hooks, this hook doesn't invoke the L</AUDIT> hook.
The role composition semantics are as follows: Routines to be consumed must be
explicitly declared via the L</EXPORT> hook. Routines will be copied to the
consumer unless they already exist (excluding routines from base classes, which
will be overridden). If multiple roles are consumed having routines with the
same name (i.e. naming collisions) the first routine copied wins.

=signature role

  ROLE(Str $name) (Str | Object)

=metadata role

{
  since => '1.00',
}

=example-1 role

  package Admin;

  use base 'Venus::Core';

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  package main;

  my $admin = User->DOES('Admin');

  # 1

=cut

$test->for('example', 1, 'role', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 role

  package Create;

  use base 'Venus::Core';

  package Delete;

  use base 'Venus::Core';

  package Manage;

  use base 'Venus::Core';

  Manage->ROLE('Create');
  Manage->ROLE('Delete');

  package User;

  use base 'Venus::Core';

  User->ROLE('Manage');

  package main;

  my $create = User->DOES('Create');

  # 1

=cut

$test->for('example', 2, 'role', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;
  ok +User->DOES('Create');
  ok +User->DOES('Delete');
  ok +User->DOES('Manage');

  $result
});

=method set

The SET method is a class instance lifecycle hook which is responsible for
I<"setting"> instance items (or attribute values). By default, all class
attributes I<"setters"> are dispatched to this method.

=signature set

  SET(Str $name, Any @args) (Any)

=metadata get

{
  since => '2.91',
}

=cut

=example-1 set

  package User;

  use base 'Venus::Core';

  User->ATTR('name');

  package main;

  my $user = User->BLESS(title => 'Engineer');

  # bless({title => 'Engineer'}, 'User')

  my $set = $user->SET('title', 'Manager');

  # "Manager"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Manager";

  $result
});

=method subs

The SUBS method returns the routines defined on the package and consumed from
roles, but not inherited by superclasses.

=signature subs

  SUBS() (ArrayRef)

=metadata subs

{
  since => '1.00',
}

=example-1 subs

  package Example;

  use base 'Venus::Core';

  package main;

  my $subs = Example->SUBS;

  # [...]

=cut

$test->for('example', 1, 'subs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['DATA'];

  $result
});

=method test

The TEST method is a class building lifecycle hook which consumes the role
provided, automatically invoking the role's L</IMPORT> hook as well as the
L</AUDIT> hook if defined.

=signature test

  TEST(Str $name) (Str | Object)

=metadata test

{
  since => '1.00',
}

=example-1 test

  package Admin;

  use base 'Venus::Core';

  package IsAdmin;

  use base 'Venus::Core';

  sub shutdown {
    return;
  }

  sub AUDIT {
    my ($self, $from) = @_;
    die "${from} is not a super-user" if !$from->DOES('Admin');
  }

  sub EXPORT {
    ['shutdown']
  }

  package User;

  use base 'Venus::Core';

  User->ROLE('Admin');

  User->TEST('IsAdmin');

  package main;

  my $user = User->BLESS;

  # bless({}, 'User')

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok $result->DOES('Admin');
  ok $result->DOES('IsAdmin');

  $result
});

=method unimport

The UNIMPORT method is a class building lifecycle hook which is invoked
whenever the L<perlfunc/no> declaration is used.

=signature unimport

  UNIMPORT(Str $into, Any @args) (Any)

=metadata unimport

{
  since => '2.91',
}

=example-1 unimport

  package User;

  use base 'Venus::Core';

  package main;

  User->UNIMPORT;

  # 'User'

=cut

$test->for('example', 1, 'unimport', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'User';

  $result
});

=method use

The USE method is a class building lifecycle hook which is invoked
whenever the L<perlfunc/use> declaration is used.

=signature use

  USE(Str $into, Any @args) (Any)

=metadata use

{
  since => '2.91',
}

=example-1 use

  package User;

  use base 'Venus::Core';

  package main;

  User->USE;

  # 'User'

=cut

$test->for('example', 1, 'use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'User';

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Core.pod') if $ENV{RENDER};

ok 1 and done_testing;
