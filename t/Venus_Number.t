package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Number

=cut

$test->for('name');

=tagline

Number Class

=cut

$test->for('tagline');

=abstract

Number Class for Perl 5

=cut

$test->for('abstract');

=includes

method: abs
method: atan2
method: cast
method: cos
method: decr
method: default
method: eq
method: exp
method: ge
method: gele
method: gt
method: gtlt
method: hex
method: incr
method: int
method: le
method: log
method: lt
method: mod
method: ne
method: neg
method: numified
method: pow
method: range
method: sin
method: sqrt
method: tv

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1_000);

  # $number->abs;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating number data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method abs

The abs method returns the absolute value of the number.

=signature abs

  abs() (Num)

=metadata abs

{
  since => '0.01',
}

=example-1 abs

  # given: synopsis;

  my $abs = $number->abs;

  # 1000

=cut

$test->for('example', 1, 'abs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1000;

  $result
});

=example-2 abs

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $abs = $number->abs;

  # 12

=cut

$test->for('example', 2, 'abs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12;

  $result
});

=example-3 abs

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(-12);

  my $abs = $number->abs;

  # 12

=cut

$test->for('example', 3, 'abs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12;

  $result
});

=method atan2

The atan2 method returns the arctangent of Y/X in the range -PI to PI.

=signature atan2

  atan2() (Num)

=metadata atan2

{
  since => '0.01',
}

=example-1 atan2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1);

  my $atan2 = $number->atan2(1);

  # 0.785398163397448

=cut

$test->for('example', 1, 'atan2', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  like $result, qr/0.78539/;

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

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('array');

  # bless({ value => [0] }, "Venus::Array")

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Array');
  is_deeply $result->get, [0];

  $result
});

=example-2 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('boolean');

  # bless({ value => 0 }, "Venus::Boolean")

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Boolean');
  is $result->get, 0;

  !$result
});

=example-3 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('code');

  # bless({ value => sub { ... } }, "Venus::Code")

=cut

$test->for('example', 3, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Code');
  is $result->get->(), 0;

  $result
});

=example-4 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('float');

  # bless({ value => "0.0" }, "Venus::Float")

=cut

$test->for('example', 4, 'cast', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Float');
  is $result->get, '0.0';

  1
});

=example-5 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('hash');

  # bless({ value => { "0" => 0 } }, "Venus::Hash")

=cut

$test->for('example', 5, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Hash');
  is_deeply $result->get, {0,0};

  $result
});

=example-6 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('number');

  # bless({ value => 0 }, "Venus::Number")

=cut

$test->for('example', 6, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Number');
  is $result->get, 0;

  !$result
});

=example-7 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('regexp');

  # bless({ value => qr/(?^u:0)/ }, "Venus::Regexp")

=cut

$test->for('example', 7, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Regexp');
  is $result->get, qr/0/;

  $result
});

=example-8 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('scalar');

  # bless({ value => \0 }, "Venus::Scalar")

=cut

$test->for('example', 8, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Scalar');
  is_deeply $result->get, \0;

  $result
});

=example-9 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('string');

  # bless({ value => 0 }, "Venus::String")

=cut

$test->for('example', 9, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::String');
  is $result->get, '0';

  !$result
});

=example-10 cast

  package main;

  use Venus::Number;

  my $number = Venus::Number->new;

  my $cast = $number->cast('undef');

  # bless({ value => undef }, "Venus::Undef")

=cut

$test->for('example', 10, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Undef');

  !$result
});

=method cos

The cos method computes the cosine of the number (expressed in radians).

=signature cos

  cos() (Num)

=metadata cos

{
  since => '0.01',
}

=example-1 cos

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $cos = $number->cos;

  # 0.843853958732492

=cut

$test->for('example', 1, 'cos', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  like $result, qr/0.84385/;

  $result
});

=method decr

The decr method returns the numeric number decremented by 1.

=signature decr

  decr() (Num)

=metadata decr

{
  since => '0.01',
}

=example-1 decr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $decr = $number->decr;

  # 123456788

=cut

$test->for('example', 1, 'decr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456788;

  $result
});

=example-2 decr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $decr = $number->decr(123456788);

  # 1

=cut

$test->for('example', 2, 'decr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method default

The default method returns the default value, i.e. C<0>.

=signature default

  default() (Int)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $number->default;

  # 0

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 2, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 eq

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 3, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 eq

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 5, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 eq

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 8, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 eq

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 9, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method exp

The exp method returns e (the natural logarithm base) to the power of the
number.

=signature exp

  exp() (Num)

=metadata exp

{
  since => '0.01',
}

=example-1 exp

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(0);

  my $exp = $number->exp;

  # 1

=cut

$test->for('example', 1, 'exp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 exp

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1);

  my $exp = $number->exp;

  # 2.71828182845905

=cut

$test->for('example', 2, 'exp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  like $result, qr/2.71828/;

  $result
});

=example-3 exp

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1.5);

  my $exp = $number->exp;

  # 4.48168907033806

=cut

$test->for('example', 3, 'exp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  like $result, qr/4.48168/;

  $result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 1, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 ge

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 2, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 ge

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 4, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 ge

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 6, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 ge

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 7, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 ge

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=cut

$test->for('example', 3, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 gele

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=cut

$test->for('example', 5, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 gele

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=cut

$test->for('example', 8, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 gele

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=cut

$test->for('example', 9, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 1, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 gt

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 3, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 gt

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 4, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 gt

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 5, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 gt

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 6, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 gt

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 7, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 gt

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 8, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 gt

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 9, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
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

=method hex

The hex method returns a hex string representing the value of the number.

=signature hex

  hex() (Str)

=metadata hex

{
  since => '0.01',
}

=example-1 hex

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(175);

  my $hex = $number->hex;

  # "0xaf"

=cut

$test->for('example', 1, 'hex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "0xaf";

  $result
});

=method incr

The incr method returns the numeric number incremented by 1.

=signature incr

  incr() (Num)

=metadata incr

{
  since => '0.01',
}

=example-1 incr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $incr = $number->incr;

  # 123456790

=cut

$test->for('example', 1, 'incr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456790;

  $result
});

=example-2 incr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456790);

  my $incr = $number->incr(-1);

  # 123456789

=cut

$test->for('example', 2, 'incr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456789;

  $result
});

=method int

The int method returns the integer portion of the number. Do not use this
method for rounding.

=signature int

  int() (Int)

=metadata int

{
  since => '0.01',
}

=example-1 int

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12.5);

  my $int = $number->int;

  # 12

=cut

$test->for('example', 1, 'int', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12;

  $result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 1, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 le

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 3, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 le

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 4, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 le

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 5, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 le

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 6, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 le

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 7, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 le

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 8, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 le

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 9, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method log

The log method returns the natural logarithm (base e) of the number.

=signature log

  log() (Num)

=metadata log

{
  since => '0.01',
}

=example-1 log

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $log = $number->log;

  # 9.42100640177928

=cut

$test->for('example', 1, 'log', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  like $result, qr/9.42100/;

  $result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 1, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 lt

  package main;

  use Venus::Code;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 2, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 lt

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 4, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 lt

  package main;

  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 6, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 lt

  package main;

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 7, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 lt

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
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

=method mod

The mod method returns the division remainder of the number divided by the
argment.

=signature mod

  mod() (Int)

=metadata mod

{
  since => '0.01',
}

=example-1 mod

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(1);

  # 0

=cut

$test->for('example', 1, 'mod', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-2 mod

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(2);

  # 0

=cut

$test->for('example', 2, 'mod', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-3 mod

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(5);

  # 2

=cut

$test->for('example', 3, 'mod', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 2, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 ne

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 3, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 ne

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 5, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 ne

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 8, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 ne

  package main;

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 9, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method neg

The neg method returns a negative version of the number.

=signature neg

  neg() (Num)

=metadata neg

{
  since => '0.01',
}

=example-1 neg

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $neg = $number->neg;

  # -12345

=cut

$test->for('example', 1, 'neg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == -12345;

  $result
});

=method numified

The numified method returns the numerical representation of the object. For
number objects this method returns the object's underlying value.

=signature numified

  numified() (Int)

=metadata numified

{
  since => '0.08',
}

=example-1 numified

  # given: synopsis;

  my $numified = $number->numified;

  # 1000

=cut

$test->for('example', 1, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1000;

  $result
});

=example-2 numified

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(2_000);

  my $numified = $number->numified;

  # 2000

=cut

$test->for('example', 2, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 2000;

  $result
});

=example-3 numified

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(10_000);

  my $numified = $number->numified;

  # 10000

=cut

$test->for('example', 3, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 10_000;

  $result
});

=method pow

The pow method returns a number, the result of a math operation, which is the
number to the power of the argument.

=signature pow

  pow() (Num)

=metadata pow

{
  since => '0.01',
}

=example-1 pow

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $pow = $number->pow(3);

  # 1881365963625

=cut

$test->for('example', 1, 'pow', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1881365963625;

  $result
});

=method range

The range method returns an array reference containing integer increasing values
up-to or down-to the limit specified.

=signature range

  range() (ArrayRef)

=metadata range

{
  since => '0.01',
}

=example-1 range

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(5);

  my $range = $number->range(9);

  # [5..9]

=cut

$test->for('example', 1, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [5..9];

  $result
});

=example-2 range

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(5);

  my $range = $number->range(1);

  # [5, 4, 3, 2, 1]

=cut

$test->for('example', 2, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [5, 4, 3, 2, 1];

  $result
});

=method sin

The sin method returns the sine of the number (expressed in radians).

=signature sin

  sin() (Num)

=metadata sin

{
  since => '0.01',
}

=example-1 sin

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $sin = $number->sin;

  # -0.993771636455681

=cut

$test->for('example', 1, 'sin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ '-0.993';

  $result
});

=method sqrt

The sqrt method returns the positive square root of the number.

=signature sqrt

  sqrt() (Num)

=metadata sqrt

{
  since => '0.01',
}

=example-1 sqrt

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $sqrt = $number->sqrt;

  # 111.108055513541

=cut

$test->for('example', 1, 'sqrt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ '111.10';

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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 2, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 tv

  package main;

  use Venus::Float;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=cut

$test->for('example', 3, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 tv

  package main;

  use Venus::Hash;
  use Venus::Number;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;

  my $lvalue = Venus::Number->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=cut

$test->for('example', 5, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 tv

  package main;

  use Venus::Number;
  use Venus::Regexp;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Scalar;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::Number->new;
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

  use Venus::Number;
  use Venus::Undef;

  my $lvalue = Venus::Number->new;
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

$test->render('lib/Venus/Number.pod') if $ENV{RENDER};

ok 1 and done_testing;