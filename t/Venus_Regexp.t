package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Regexp

=cut

$test->for('name');

=tagline

Regexp Class

=cut

$test->for('tagline');

=abstract

Regexp Class for Perl 5

=cut

$test->for('abstract');

=includes

method: comparer
method: default
method: eq
method: ge
method: gele
method: gt
method: gtlt
method: le
method: lt
method: ne
method: numified
method: replace
method: search
method: stringified
method: tv

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<greet>\w+) (?<username>\w+)/u,
  );

  # $regexp->search;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating regexp data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method comparer

The comparer method returns the name of the method which will produce a value
to be used in comparison operations.

=signature comparer

  comparer() (Str)

=metadata comparer

{
  since => '0.08',
}

=example-1 comparer

  # given: synopsis;

  my $comparer = $regexp->comparer;

  # "stringified"

=cut

$test->for('example', 1, 'comparer', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'stringified';

  $result
});

=method default

The default method returns the default value, i.e. C<qr//>.

=signature default

  default() (Regexp)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $regexp->default;

  # qr/(?^u:)/

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq qr//;

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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 6, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 eq

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 6, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 ne

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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

=method numified

The numified method returns the numerical representation of the object. For
regexp objects the method returns the length (or character count) of the
stringified object.

=signature numified

  numified() (Int)

=metadata numified

{
  since => '0.08',
}

=example-1 numified

  # given: synopsis;

  my $numified = $regexp->numified;

  # 36

=cut

$test->for('example', 1, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 35;

  $result
});

=example-2 numified

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/.*/u,
  );

  my $numified = $regexp->numified;

  # 7

=cut

$test->for('example', 2, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 7;

  $result
});

=method replace

The replace method performs a regular expression substitution on the given
string. The first argument is the string to match against. The second argument
is the replacement string. The optional third argument might be a string
representing flags to append to the s///x operator, such as 'g' or 'e'.  This
method will always return a L<Venus::Replace> object which can be used to
introspect the result of the operation.

=signature replace

  replace(Str $string, Str $substr, Str $flags) (Replace)

=metadata replace

{
  since => '0.01',
}

=example-1 replace

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<username>\w+)$/,
  );

  my $replace = $regexp->replace('Hey, unknown', 'cpanery');

  # bless({ ... }, 'Venus::Replace')

=cut

$test->for('example', 1, 'replace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Replace');

  $result
});

=method search

The search method performs a regular expression match against the given string,
this method will always return a L<Venus::Search> object which can be used to
introspect the result of the operation.

=signature search

  search(Str $string) (Search)

=metadata search

{
  since => '0.01',
}

=example-1 search

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<greet>\w+), (?<username>\w+)/,
  );

  my $search = $regexp->search('hey, cpanery');

  # bless({ ... }, 'Venus::Search')

=cut

$test->for('example', 1, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Search');

  $result
});

=method stringified

The stringified method returns the object, stringified (i.e. a dump of the
object's value).

=signature stringified

  stringified() (Str)

=metadata stringified

{
  since => '0.08',
}

=example-1 stringified

  # given: synopsis;

  my $stringified = $regexp->stringified;

  # qr/(?<greet>\w+) (?<username>\w+)/u


=cut

$test->for('example', 1, 'stringified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'qr/(?<greet>\w+) (?<username>\w+)/u';

  $result
});

=example-2 stringified

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/.*/,
  );

  my $stringified = $regexp->stringified;

  # qr/.*/u

=cut

$test->for('example', 2, 'stringified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'qr/.*/u';

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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Hash;
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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
  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;

  my $lvalue = Venus::Regexp->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=cut

$test->for('example', 6, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 tv

  package main;

  use Venus::Regexp;
  use Venus::Scalar;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::Regexp->new;
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

  use Venus::Regexp;
  use Venus::Undef;

  my $lvalue = Venus::Regexp->new;
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

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $regexp eq '(?^u:(?<greet>\\w+) (?<username>\\w+))';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $regexp ne '(?<greet>\w+) (?<username>\w+)';

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $result = 'Hello Friend' =~  $regexp;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Regexp.pod') if $ENV{RENDER};

ok 1 and done_testing;