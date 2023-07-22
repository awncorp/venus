package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Unpack

=cut

$test->for('name');

=tagline

Unpack Class

=cut

$test->for('tagline');

=abstract

Unpack Class for Perl 5

=cut

$test->for('abstract');

=includes

method: all
method: arg
method: args
method: array
method: cast
method: checks
method: copy
method: first
method: from
method: get
method: into
method: last
method: list
method: move
method: name
method: one
method: reset
method: set
method: signature
method: types
method: use
method: validate

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Unpack;

  my $unpack = Venus::Unpack->new(args => ["hello", 123, 1.23]);

  # my $args = $unpack->all->types('string', 'number', 'float')->args;

  # ["hello", 123, 1.23]

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  is_deeply scalar $result->all->types('string', 'number', 'float')->args, [
    "hello", 123, 1.23,
  ];

  $result
});

=description

This package provides methods for validating, coercing, and otherwise operating
on lists of arguments.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=method all

The all method selects all arguments for processing returns the invocant.

=signature all

  all() (Unpack)

=metadata all

{
  since => '2.01',
}

=example-1 all

  # given: synopsis

  package main;

  $unpack = $unpack->all;

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'all', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  is_deeply $result->{uses}, [0..2];

  $result
});

=method arg

The arg method returns the argument at the index specified.

=signature arg

  arg(Str $index) (Any)

=metadata arg

{
  since => '2.01',
}

=example-1 arg

  # given: synopsis

  package main;

  my $arg = $unpack->arg(0);

  # "hello"

=cut

$test->for('example', 1, 'arg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello';

  $result
});

=example-2 arg

  # given: synopsis

  package main;

  my $arg = $unpack->arg(1);

  # 123

=cut

$test->for('example', 2, 'arg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123;

  $result
});

=example-3 arg

  # given: synopsis

  package main;

  my $arg = $unpack->arg(2);

  # 1.23

=cut

$test->for('example', 3, 'arg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1.23;

  $result
});

=method args

The args method returns all arugments as an arrayref, or list in list context.
If arguments are provided they will overwrite the existing arugment list.

=signature args

  args(Any @args) (ArrayRef)

=metadata args

{
  since => '2.01',
}

=example-1 args

  # given: synopsis

  package main;

  my $args = $unpack->args;

  # ["hello", 123, 1.23]

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["hello", 123, 1.23];

  $result
});

=example-2 args

  # given: synopsis

  package main;

  my $args = $unpack->args(1.23, 123, "hello");

  # [1.23, 123, "hello"]

=cut

$test->for('example', 2, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1.23, 123, "hello"];

  $result
});

=method array

The array method returns the argument list as a L<Venus::Array> object.

=signature array

  array() (Venus::Array)

=metadata array

{
  since => '2.01',
}

=example-1 array

  # given: synopsis

  package main;

  my $array = $unpack->array;

  # bless(..., 'Venus::Array')

=cut

$test->for('example', 1, 'array', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Array');
  ok $result->count == 3;
  is_deeply $result->value, ["hello", 123, 1.23];

  $result
});

=method cast

The cast method processes the selected arguments, passing each value to the
class name specified, or the L<Venus::Type/cast> method, and returns results.

=signature cast

  cast(Str $name) (ArrayRef)

=metadata cast

{
  since => '2.01',
}

=example-1 cast

  # given: synopsis

  package main;

  my $cast = $unpack->all->cast;

  # [
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::Number'),
  #   bless(..., 'Venus::Float'),
  # ]

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::Number');
  ok $result->[1]->value == 123;
  ok $result->[2]->isa('Venus::Float');
  ok $result->[2]->value == 1.23;

  $result
});

=example-2 cast

  # given: synopsis

  package main;

  my $cast = $unpack->all->cast('scalar');

  # [
  #   bless(..., 'Venus::Scalar'),
  #   bless(..., 'Venus::Scalar'),
  #   bless(..., 'Venus::Scalar'),
  # ]

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Venus::Scalar');
  ok ${$result->[0]->value} eq 'hello';
  ok $result->[1]->isa('Venus::Scalar');
  ok ${$result->[1]->value} == 123;
  ok $result->[2]->isa('Venus::Scalar');
  ok ${$result->[2]->value} == 1.23;

  $result
});

=method checks

The checks method processes the selected arguments, passing each value to the
L<Venus::Assert/check> method with the type expression provided, and returns
results.

=signature checks

  checks(Str @types) (ArrayRef)

=metadata checks

{
  since => '2.01',
}

=example-1 checks

  # given: synopsis

  package main;

  my $checks = $unpack->all->checks('string');

  # [true, false, false]

=cut

$test->for('example', 1, 'checks', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1, 0, 0];

  $result
});

=example-2 checks

  # given: synopsis

  package main;

  my $checks = $unpack->all->checks('string | number');

  # [true, true, false]

=cut

$test->for('example', 2, 'checks', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1, 1, 0];

  $result
});

=example-3 checks

  # given: synopsis

  package main;

  my $checks = $unpack->all->checks('string | number', 'float');

  # [true, false, true]

=cut

$test->for('example', 3, 'checks', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1, 0, 1];

  $result
});

=example-4 checks

  # given: synopsis

  package main;

  my $checks = $unpack->all->checks('string', 'number', 'float');

  # [true, true, true]

=cut

$test->for('example', 4, 'checks', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1, 1, 1];

  $result
});

=example-5 checks

  # given: synopsis

  package main;

  my $checks = $unpack->all->checks('boolean', 'value');

  # [false, true, true]

=cut

$test->for('example', 5, 'checks', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [0, 1, 1];

  $result
});

=method copy

The copy method copies values from the arugment list as properties of the
underlying object and returns the invocant.

=signature copy

  copy(Str @pairs) (Unpack)

=metadata copy

{
  since => '2.01',
}

=example-1 copy

  # given: synopsis

  package main;

  $unpack = $unpack->copy(0 => 'arg1');

  # bless({..., arg1 => 'hello'}, 'Venus::Unpack')

=cut

$test->for('example', 1, 'copy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{arg1} eq 'hello';
  ok !$result->{arg2};
  ok !$result->{arg3};
  is_deeply $result->{args}, ['hello', 123, 1.23];

  $result
});

=example-2 copy

  # given: synopsis

  package main;

  $unpack = $unpack->copy(0 => 'arg1', 2 => 'arg3');

  # bless({..., arg1 => 'hello', arg3 => 1.23}, 'Venus::Unpack')

=cut

$test->for('example', 2, 'copy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{arg1} eq 'hello';
  ok !$result->{arg2};
  ok $result->{arg3} == 1.23;
  is_deeply $result->{args}, ['hello', 123, 1.23];

  $result
});

=example-3 copy

  # given: synopsis

  package main;

  $unpack = $unpack->copy(0 => 'arg1', 1 => 'arg2', 2 => 'arg3');

  # bless({..., arg1 => 'hello', arg2 => 123, arg3 => 1.23}, 'Venus::Unpack')

=cut

$test->for('example', 3, 'copy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{arg1} eq 'hello';
  ok $result->{arg2} == 123;
  ok $result->{arg3} == 1.23;
  is_deeply $result->{args}, ['hello', 123, 1.23];

  $result
});

=method first

The first method selects the first argument for processing returns the
invocant.

=signature first

  first() (Unpack)

=metadata first

{
  since => '2.01',
}

=example-1 first

  # given: synopsis

  package main;

  $unpack = $unpack->first;

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'first', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  is_deeply $result->{uses}, [0];

  $result
});

=method from

The from method names the source of the unpacking operation and is used in
exception messages whenever the L<Venus::Unpack/signature> operation fails.
This method returns the invocant.

=signature from

  from(Str $data) (Unpack)

=metadata from

{
  since => '2.23',
}

=example-1 from

  # given: synopsis

  package main;

  $unpack = $unpack->from;

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'from', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok !exists $result->{from};

  $result
});

=example-2 from

  # given: synopsis

  package main;

  $unpack = $unpack->from('Example');

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 2, 'from', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{from} eq 'Example';

  $result
});

=method get

The get method returns the argument at the index specified.

=signature get

  get(Str $index) (Any)

=metadata get

{
  since => '2.01',
}

=example-1 get

  # given: synopsis

  package main;

  my $get = $unpack->get;

  # undef

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=example-2 get

  # given: synopsis

  package main;

  my $get = $unpack->get(0);

  # "hello"

=cut

$test->for('example', 2, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello';

  $result
});

=example-3 get

  # given: synopsis

  package main;

  my $get = $unpack->get(1);

  # 123

=cut

$test->for('example', 3, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123;

  $result
});

=example-4 get

  # given: synopsis

  package main;

  my $get = $unpack->get(2);

  # 1.23

=cut

$test->for('example', 4, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1.23;

  $result
});

=example-5 get

  # given: synopsis

  package main;

  my $get = $unpack->get(3);

  # undef

=cut

$test->for('example', 5, 'get', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method into

The into method processes the selected arguments, passing each value to the
class name specified, and returns results.

=signature into

  into(Str @args) (Any)

=metadata into

{
  since => '2.01',
}

=example-1 into

  # given: synopsis

  package main;

  my $cast = $unpack->all->into('Venus::String');

  # [
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::String'),
  # ]

=cut

$test->for('example', 1, 'into', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::String');
  ok $result->[1]->value == 123;
  ok $result->[2]->isa('Venus::String');
  ok $result->[2]->value == 1.23;

  $result
});

=example-2 into

  # given: synopsis

  package main;

  my $cast = $unpack->all->into('Venus::String', 'Venus::Number');

  # [
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::Number'),
  #   bless(..., 'Venus::Number'),
  # ]

=cut

$test->for('example', 2, 'into', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::Number');
  ok $result->[1]->value == 123;
  ok $result->[2]->isa('Venus::Number');
  ok $result->[2]->value == 1.23;

  $result
});

=example-3 into

  # given: synopsis

  package main;

  my $cast = $unpack->all->into('Venus::String', 'Venus::Number', 'Venus::Float');

  # [
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::Number'),
  #   bless(..., 'Venus::Float'),
  # ]

=cut

$test->for('example', 3, 'into', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::Number');
  ok $result->[1]->value == 123;
  ok $result->[2]->isa('Venus::Float');
  ok $result->[2]->value == 1.23;

  $result
});

=method last

The last method selects the last argument for processing returns the
invocant.

=signature last

  last() (Unpack)

=metadata last

{
  since => '2.01',
}

=example-1 last

  # given: synopsis

  package main;

  $unpack = $unpack->last;

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'last', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  is_deeply $result->{uses}, [2];

  $result
});

=method list

The list method returns the result of the dispatched method call as an
arrayref, or list in list context.

=signature list

  list(Str | CodeRef $code, Any @args) (ArrayRef)

=metadata list

{
  since => '2.01',
}

=example-1 list

  # given: synopsis

  package main;

  my (@args) = $unpack->all->list('cast');

  # (
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::Number'),
  #   bless(..., 'Venus::Float'),
  # )

=cut

$test->for('example', 1, 'list', sub {
  my ($tryable) = @_;
  my $result = [$tryable->result];
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::Number');
  ok $result->[1]->value == 123;
  ok $result->[2]->isa('Venus::Float');
  ok $result->[2]->value == 1.23;

  $result
});

=example-2 list

  # given: synopsis

  package main;

  my ($string) = $unpack->all->list('cast');

  # (
  #   bless(..., 'Venus::String'),
  # )

=cut

$test->for('example', 2, 'list', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->value eq 'hello';

  $result
});

=example-3 list

  # given: synopsis

  package main;

  my (@args) = $unpack->all->list('cast', 'string');

  # (
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::String'),
  # )

=cut

$test->for('example', 3, 'list', sub {
  my ($tryable) = @_;
  my $result = [$tryable->result];
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::String');
  ok $result->[1]->value == 123;
  ok $result->[2]->isa('Venus::String');
  ok $result->[2]->value == 1.23;

  $result
});

=example-4 list

  # given: synopsis

  package main;

  my (@args) = $unpack->use(0,2)->list('cast', 'string', 'float');

  # (
  #   bless(..., 'Venus::String'),
  #   bless(..., 'Venus::Float'),
  # )

=cut

$test->for('example', 4, 'list', sub {
  my ($tryable) = @_;
  my $result = [$tryable->result];
  ok $result->[0]->isa('Venus::String');
  ok $result->[0]->value eq 'hello';
  ok $result->[1]->isa('Venus::Float');
  ok $result->[1]->value == 1.23;

  $result
});

=method move

The move method moves values from the arugment list, reducing the arugment
list, as properties of the underlying object and returns the invocant.

=signature move

  move(Str @pairs) (Unpack)

=metadata move

{
  since => '2.01',
}

=example-1 move

  # given: synopsis

  package main;

  $unpack = $unpack->move(0 => 'arg1');

  # bless({..., arg1 => 'hello'}, 'Venus::Unpack')

=cut

$test->for('example', 1, 'move', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{arg1} eq 'hello';
  ok !$result->{arg2};
  ok !$result->{arg3};
  is_deeply $result->{args}, [123, 1.23];

  $result
});

=example-2 move

  # given: synopsis

  package main;

  $unpack = $unpack->move(0 => 'arg1', 2 => 'arg3');

  # bless({..., arg1 => 'hello', arg3 => 1.23}, 'Venus::Unpack')

=cut

$test->for('example', 2, 'move', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{arg1} eq 'hello';
  ok !$result->{arg2};
  ok $result->{arg3} == 1.23;
  is_deeply $result->{args}, [123];

  $result
});

=example-3 move

  # given: synopsis

  package main;

  $unpack = $unpack->move(0 => 'arg1', 1 => 'arg2', 2 => 'arg3');

  # bless({..., arg1 => 'hello', arg2 => 123, arg3 => 1.23}, 'Venus::Unpack')

=cut

$test->for('example', 3, 'move', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{arg1} eq 'hello';
  ok $result->{arg2} == 123;
  ok $result->{arg3} == 1.23;
  is_deeply $result->{args}, [];

  $result
});

=method name

The name method names the unpacking operation and is used in exception messages
whenever the L<Venus::Unpack/signature> operation fails. This method returns
the invocant.

=signature name

  name(Str $data) (Unpack)

=metadata name

{
  since => '2.23',
}

=example-1 name

  # given: synopsis

  package main;

  $unpack = $unpack->name;

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok !exists $result->{name};

  $result
});

=example-2 name

  # given: synopsis

  package main;

  $unpack = $unpack->name('example');

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  ok $result->{name} eq 'example';

  $result
});

=method one

The one method returns the first result of the dispatched method call.

=signature one

  one(Str | CodeRef $code, Any @args) (Any)

=metadata one

{
  since => '2.01',
}

=example-1 one

  # given: synopsis

  package main;

  my $one = $unpack->all->one('cast');

  # (
  #   bless(..., 'Venus::String'),
  # )

=cut

$test->for('example', 1, 'one', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->value eq 'hello';

  $result
});

=example-2 one

  # given: synopsis

  package main;

  my $one = $unpack->all->one('cast', 'string');

  # (
  #   bless(..., 'Venus::String'),
  # )

=cut

$test->for('example', 2, 'one', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->value eq 'hello';

  $result
});

=method reset

The reset method resets the arugments list (if provided) and deselects all
arguments (selected for processing) and returns the invocant.

=signature reset

  reset(Any @args) (Unpack)

=metadata reset

{
  since => '2.01',
}

=example-1 reset

  # given: synopsis

  package main;

  $unpack = $unpack->all->reset;

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  is_deeply $result->{args}, ['hello', 123, 1.23];
  is_deeply $result->{uses}, [];

  $result
});

=example-2 reset

  # given: synopsis

  package main;

  $unpack = $unpack->all->reset(1.23, 123, "hello");

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 2, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');
  is_deeply $result->{args}, [1.23, 123, "hello"];
  is_deeply $result->{uses}, [];

  $result
});

=method set

The set method assigns the value provided at the index specified and returns
the value.

=signature set

  set(Str $index, Any $value) (Any)

=metadata set

{
  since => '2.01',
}

=example-1 set

  # given: synopsis

  package main;

  my $set = $unpack->set;

  # ["hello", 123, 1.23]

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ["hello", 123, 1.23];

  $result
});

=example-2 set

  # given: synopsis

  package main;

  my $set = $unpack->set(0, 'howdy');

  # "howdy"

=cut

$test->for('example', 2, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'howdy';

  $result
});

=example-3 set

  # given: synopsis

  package main;

  my $set = $unpack->set(1, 987);

  # 987

=cut

$test->for('example', 3, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 987;

  $result
});

=example-4 set

  # given: synopsis

  package main;

  my $set = $unpack->set(2, 12.3);

  # 12.3

=cut

$test->for('example', 4, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12.3;

  $result
});

=example-5 set

  # given: synopsis

  package main;

  my $set = $unpack->set(3, 'goodbye');

  # "goodbye"

=cut

$test->for('example', 5, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'goodbye';

  $result
});

=method signature

The signature method processes the selected arguments, passing each value to
the L<Venus::Assert/validate> method with the type expression provided and
throws an exception on failure and otherise returns the results as an arrayref,
or as a list in list context.

=signature signature

  signature(Str $name, Str @types) (ArrayRef)

=metadata signature

{
  since => '2.01',
}

=example-1 signature

  # given: synopsis

  package main;

  my ($string, $number, $float) = $unpack->all->name('example-1')->signature(
    'string | number | float',
  );

  # ("hello", 123, 1.23)

=cut

$test->for('example', 1, 'signature', sub {
  my ($tryable) = @_;
  ok my $result = [$tryable->result];
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=example-2 signature

  # given: synopsis

  package main;

  my ($string, $number, $float) = $unpack->all->name('example-2')->signature(
    'string', 'number', 'float',
 );

  # ("hello", 123, 1.23)

=cut

$test->for('example', 2, 'signature', sub {
  my ($tryable) = @_;
  ok my $result = [$tryable->result];
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=example-3 signature

  # given: synopsis

  package main;

  my $results = $unpack->all->name('example-3')->signature(
    'string', 'number',
  );

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 3, 'signature', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'argument #3\ for signature "example-3" in package "main"';

  $result
});

=example-4 signature

  # given: synopsis

  package main;

  my $results = $unpack->all->name('example-4')->signature(
    'string',
  );

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 4, 'signature', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'argument #2\ for signature "example-4" in package "main"';

  $result
});

=example-5 signature

  # given: synopsis

  package main;

  my $results = $unpack->all->name('example-5')->from('t/Venus_Unpack.t')->signature(
    'object',
  );

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 5, 'signature', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'argument #1\ for signature "example-5" from "t/Venus_Unpack.t"';

  $result
});

=method types

The types method processes the selected arguments, passing each value to the
L<Venus::Assert/validate> method with the type expression provided, and unlike
the L</validate> method returns the invocant.

=signature types

  types(Str @types) (Unpack)

=metadata types

{
  since => '2.01',
}

=example-1 types

  # given: synopsis

  package main;

  $unpack = $unpack->all->types('string | number | float');

  # bless({...}, 'Venus::Unpack')

=cut

$test->for('example', 1, 'types', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');

  $result
});

=example-2 types

  # given: synopsis

  package main;

  $unpack = $unpack->all->types('string', 'number', 'float');

  # bless({...}, 'Venus::Unpack')

=cut

$test->for('example', 2, 'types', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Unpack');

  $result
});

=example-3 types

  # given: synopsis

  package main;

  $unpack = $unpack->all->types('string', 'number');

  # Exception! (isa Venus::Error)

  # argument #3 error

=cut

$test->for('example', 3, 'types', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'assertion \(argument #3\) failed';

  $result
});

=example-4 types

  # given: synopsis

  package main;

  $unpack = $unpack->all->types('string');

  # Exception! (isa Venus::Error)

  # argument #2 error

=cut

$test->for('example', 4, 'types', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'assertion \(argument #2\) failed';

  $result
});

=method use

The use method selects the arguments specified (by index) for processing
returns the invocant.

=signature use

  use(Int @args) (Unpack)

=metadata use

{
  since => '2.01',
}

=example-1 use

  # given: synopsis

  package main;

  $unpack = $unpack->use(1,2);

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 1, 'use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->{uses}, [1,2];

  $result
});

=example-2 use

  # given: synopsis

  package main;

  $unpack = $unpack->use(1,0);

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 2, 'use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->{uses}, [1,0];

  $result
});

=example-3 use

  # given: synopsis

  package main;

  $unpack = $unpack->use(2,1,0);

  # bless(..., 'Venus::Unpack')

=cut

$test->for('example', 3, 'use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->{uses}, [2,1,0];

  $result
});

=method validate

The validate method processes the selected arguments, passing each value to the
L<Venus::Assert/validate> method with the type expression provided and throws
an exception on failure and otherise returns the resuts.

=signature validate

  validate(Str @types) (Unpack)

=metadata validate

{
  since => '2.01',
}

=example-1 validate

  # given: synopsis

  package main;

  my $results = $unpack->all->validate('string | number | float');

  # ["hello", 123, 1.23]

=cut

$test->for('example', 1, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=example-2 validate

  # given: synopsis

  package main;

  my $results = $unpack->all->validate('string', 'number', 'float');

  # ["hello", 123, 1.23]

=cut

$test->for('example', 2, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=example-3 validate

  # given: synopsis

  package main;

  my $results = $unpack->all->validate('string', 'number');

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 3, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'assertion \(argument #3\) failed';

  $result
});

=example-4 validate

  # given: synopsis

  package main;

  my $results = $unpack->all->validate('string');

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 4, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ 'assertion \(argument #2\) failed';

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Unpack.pod') if $ENV{RENDER};

ok 1 and done_testing;
