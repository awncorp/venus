package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Code

=cut

$test->for('name');

=tagline

Code Class

=cut

$test->for('tagline');

=abstract

Code Class for Perl 5

=cut

$test->for('abstract');

=includes

method: call
method: cast
method: compose
method: conjoin
method: curry
method: default
method: disjoin
method: eq
method: ge
method: gele
method: gt
method: gtlt
method: le
method: lt
method: ne
method: next
method: rcurry
method: tv

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub {
    my (@args) = @_;

    return [@args];
  });

  # $code->call(1..4);

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Code');
  is_deeply $result->value->(1..4), [1..4];

  $result
});

=description

This package provides methods for manipulating code data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method call

The call method executes and returns the result of the code.

=signature call

  call(Any @data) (Any)

=metadata call

{
  since => '0.01',
}

=example-1 call

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { ($_[0] // 0) + 1 });

  my $call = $code->call;

  # 1

=cut

$test->for('example', 1, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 call

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { ($_[0] // 0) + 1 });

  my $call = $code->call(1);

  # 2

=cut

$test->for('example', 2, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
});

=example-3 call

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { ($_[0] // 0) + 1 });

  my $call = $code->call(2);

  # 3

=cut

$test->for('example', 3, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 3;

  $result
});

=method cast

The cast method converts L<"value"|Venus::Kind::Value> objects between
different I<"value"> object types, based on the name of the type provided. This
method will return C<undef> if the invocant is not a L<Venus::Kind::Value>.

=signature cast

  cast(Str $kind) (Object | Undef)

=metadata cast

{
  since => '0.08',
}

=example-1 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub{[@_]});

  my $cast = $code->cast('array');

  # bless({ value => [sub { ... }] }, "Venus::Array")

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Array');
  ok ref($result->get->[0]), 'CODE';
  is_deeply $result->get->[0]->(0), [0];

  $result
});

=example-2 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('boolean');

  # bless({ value => 1 }, "Venus::Boolean")

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Boolean');
  is $result->get, 1;

  $result
});

=example-3 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub{[@_]});

  my $cast = $code->cast('code');

  # bless({ value => sub { ... } }, "Venus::Code")

=cut

$test->for('example', 3, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Code');
  is_deeply $result->get->(), [];

  $result
});

=example-4 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('float');

  # bless({ value => "1.0" }, "Venus::Float")

=cut

$test->for('example', 4, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Float');
  is $result->get, '1.0';

  $result
});

=example-5 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub{[@_]});

  my $cast = $code->cast('hash');

  # bless({ value => { "0" => sub { ... } } }, "Venus::Hash")

=cut

$test->for('example', 5, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Hash');
  ok ref($result->get->{0}), 'CODE';
  is_deeply(scalar($result->get->{0}->(0)), [0]);

  $result
});

=example-6 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('number');

  # bless({ value => 112 }, "Venus::Number")

=cut

$test->for('example', 6, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Number');
  is $result->get, 112;

  $result
});

=example-7 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('regexp');

  # bless({ value => qr/.../, }, "Venus::Regexp")

=cut

$test->for('example', 7, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Regexp');
  is ref($result->get), 'Regexp';

  $result
});

=example-8 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('scalar');

  # bless({ value => \sub {...} }, "Venus::Scalar")

=cut

$test->for('example', 8, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Scalar');
  is ref($result->get), 'REF';
  is ref(${$result->get}), 'CODE';

  $result
});

=example-9 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('string');

  # bless({ value => "sub {...}" }, "Venus::String")

=cut

$test->for('example', 9, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::String');
  like $result->get, qr/sub.*{.*}/;

  $result
});

=example-10 cast

  package main;

  use Venus::Code;

  my $code = Venus::Code->new;

  my $cast = $code->cast('undef');

  # bless({ value => undef }, "Venus::Undef")

=cut

$test->for('example', 10, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Undef');

  !$result
});

=method compose

The compose method creates a code reference which executes the first argument
(another code reference) using the result from executing the code as it's
argument, and returns a code reference which executes the created code
reference passing it the remaining arguments when executed.

=signature compose

  compose(CodeRef $code, Any @data) (CodeRef)

=metadata compose

{
  since => '0.01',
}

=example-1 compose

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { [@_] });

  my $compose = $code->compose($code, 1, 2, 3);

  # sub { ... }

  # $compose->(4, 5, 6); # [[1,2,3,4,5,6]]

=cut

$test->for('example', 1, 'compose', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->(4,5,6), [[1,2,3,4,5,6]];

  $result
});

=method conjoin

The conjoin method creates a code reference which execute the code and the
argument in a logical AND operation having the code as the lvalue and the
argument as the rvalue.

=signature conjoin

  conjoin(CodeRef $code) (CodeRef)

=metadata conjoin

{
  since => '0.01',
}

=example-1 conjoin

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { $_[0] % 2 });

  my $conjoin = $code->conjoin(sub { 1 });

  # sub { ... }

  # $conjoin->(0); # 0
  # $conjoin->(1); # 1
  # $conjoin->(2); # 0
  # $conjoin->(3); # 1
  # $conjoin->(4); # 0

=cut

$test->for('example', 1, 'conjoin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->(0), 0;
  is $result->(1), 1;
  is $result->(2), 0;
  is $result->(3), 1;
  is $result->(4), 0;

  $result
});

=method curry

The curry method returns a code reference which executes the code passing it
the arguments and any additional parameters when executed.

=signature curry

  curry(Any @data) (CodeRef)

=metadata curry

{
  since => '0.01',
}

=example-1 curry

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { [@_] });

  my $curry = $code->curry(1, 2, 3);

  # sub { ... }

  # $curry->(4,5,6); # [1,2,3,4,5,6]

=cut

$test->for('example', 1, 'curry', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->(4,5,6), [1,2,3,4,5,6];

  $result
});

=method default

The default method returns the default value, i.e. C<sub{}>.

=signature default

  default() (CodeRef)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $code->default;

  # sub {}

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !defined $result->();

  $result
});

=method disjoin

The disjoin method creates a code reference which execute the code and the
argument in a logical OR operation having the code as the lvalue and the
argument as the rvalue.

=signature disjoin

  disjoin(CodeRef $code) (CodeRef)

=metadata disjoin

{
  since => '0.01',
}

=example-1 disjoin

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { $_[0] % 2 });

  my $disjoin = $code->disjoin(sub { -1 });

  # sub { ... }

  # disjoin->(0); # -1
  # disjoin->(1); #  1
  # disjoin->(2); # -1
  # disjoin->(3); #  1
  # disjoin->(4); # -1

=cut

$test->for('example', 1, 'disjoin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->(0), -1;
  is $result->(1),  1;
  is $result->(2), -1;
  is $result->(3),  1;
  is $result->(4), -1;

  $result
});

=method eq

The eq method performs an I<"equals"> operation using the argument provided.

=signature eq

  eq(Any $arg) (Bool)

=metadata eq

{
  since => '0.08',
}

=example-1 eq

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 1, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 eq

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 2, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 eq

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 3, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 eq

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 4, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 eq

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 5, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 eq

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 6, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 eq

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 7, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 eq

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 8, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 eq

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 9, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method ge

The ge method performs a I<"greater-than-or-equal-to"> operation using the
argument provided.

=signature ge

  ge(Any $arg) (Bool)

=metadata ge

{
  since => '0.08',
}

=example-1 ge

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 1, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 ge

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 2, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 ge

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 3, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 ge

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 4, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 ge

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 5, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 ge

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 6, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 ge

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 7, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 ge

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 8, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 ge

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 9, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method gele

The gele method performs a I<"greater-than-or-equal-to"> operation on the 1st
argument, and I<"lesser-than-or-equal-to"> operation on the 2nd argument.

=signature gele

  gele(Any $arg1, Any $arg2) (Bool)

=metadata gele

{
  since => '0.08',
}

=example-1 gele

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 1, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 gele

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 2, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 gele

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 3, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 gele

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 4, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 gele

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 5, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 gele

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 6, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 gele

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 7, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 gele

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 8, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 gele

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 9, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method gt

The gt method performs a I<"greater-than"> operation using the argument provided.

=signature gt

  gt(Any $arg) (Bool)

=metadata gt

{
  since => '0.08',
}

=example-1 gt

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 1, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 gt

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 2, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 gt

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 3, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 gt

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 4, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 gt

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 5, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 gt

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 6, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 gt

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 7, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 gt

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 8, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 gt

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gt($rvalue);

  # 1

=cut

$test->for('example', 9, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method gtlt

The gtlt method performs a I<"greater-than"> operation on the 1st argument, and
I<"lesser-than"> operation on the 2nd argument.

=signature gtlt

  gtlt(Any $arg1, Any $arg2) (Bool)

=metadata gtlt

{
  since => '0.08',
}

=example-1 gtlt

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 1, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 gtlt

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 2, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 gtlt

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 3, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 gtlt

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 4, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 gtlt

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 5, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 gtlt

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 6, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 gtlt

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 7, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 gtlt

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 8, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 gtlt

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 9, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method le

The le method performs a I<"lesser-than-or-equal-to"> operation using the
argument provided.

=signature le

  le(Any $arg) (Bool)

=metadata le

{
  since => '0.08',
}

=example-1 le

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 1, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 le

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 2, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 le

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 3, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 le

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 4, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 le

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 5, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 le

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 6, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 le

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 7, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 le

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 8, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 le

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->le($rvalue);

  # 0

=cut

$test->for('example', 9, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method lt

The lt method performs a I<"lesser-than"> operation using the argument provided.

=signature lt

  lt(Any $arg) (Bool)

=metadata lt

{
  since => '0.08',
}

=example-1 lt

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 1, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 lt

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 2, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 lt

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 3, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 lt

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 4, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 lt

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 5, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 lt

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 6, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 lt

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 7, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 lt

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 8, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 lt

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 9, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method ne

The ne method performs a I<"not-equal-to"> operation using the argument provided.

=signature ne

  ne(Any $arg) (Bool)

=metadata ne

{
  since => '0.08',
}

=example-1 ne

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 1, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 ne

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 2, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 ne

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 3, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 ne

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 4, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 ne

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 5, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 ne

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 6, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 ne

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 7, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 ne

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 8, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 ne

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 9, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method next

The next method is an alias to the call method. The naming is especially useful
(i.e. helps with readability) when used with closure-based iterators.

=signature next

  next(Any @data) (Any)

=metadata next

{
  since => '0.01',
}

=example-1 next

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { $_[0] * 2 });

  my $next = $code->next(72);

  # 144

=cut

$test->for('example', 1, 'next', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 144;

  $result
});

=method rcurry

The rcurry method returns a code reference which executes the code passing it
the any additional parameters and any arguments when executed.

=signature rcurry

  rcurry(Any @data) (CodeRef)

=metadata rcurry

{
  since => '0.01',
}

=example-1 rcurry

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub { [@_] });

  my $rcurry = $code->rcurry(1,2,3);

  # sub { ... }

  # $rcurry->(4,5,6); # [4,5,6,1,2,3]

=cut

$test->for('example', 1, 'rcurry', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->(4,5,6), [4,5,6,1,2,3];

  $result
});

=operator (&{})

This package overloads the C<&{}> operator.

=cut

$test->for('operator', '(&{})');

=example-1 (&{})

  # given: synopsis;

  my $result = &$code(1..4);

  # [1..4]

=cut

$test->for('example', 1, '(&{})', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1..4];

  $result
});

=method tv

The tv method performs a I<"type-and-value-equal-to"> operation using argument
provided.

=signature tv

  tv(Any $arg) (Bool)

=metadata tv

{
  since => '0.08',
}

=example-1 tv

  package main;

  use Venus::Array;
  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 1, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 tv

  package main;

  use Venus::Code;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=cut

$test->for('example', 2, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 tv

  package main;

  use Venus::Code;
  use Venus::Float;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 3, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 tv

  package main;

  use Venus::Code;
  use Venus::Hash;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 4, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 tv

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 5, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 tv

  package main;

  use Venus::Code;
  use Venus::Regexp;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 6, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 tv

  package main;

  use Venus::Code;
  use Venus::Scalar;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 7, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 tv

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 8, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 tv

  package main;

  use Venus::Code;
  use Venus::Undef;

  my $lvalue = Venus::Code->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 9, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Code.pod') if $ENV{RENDER};

ok 1 and done_testing;