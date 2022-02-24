package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Comparable

=cut

$test->for('name');

=tagline

Comparable Role

=cut

$test->for('tagline');

=abstract

Comparable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: eq
method: ge
method: gele
method: gt
method: gtlt
method: le
method: lt
method: ne
method: tv

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  extends 'Venus::Kind';

  with 'Venus::Role::Comparable';

  sub numified {
    return 2;
  }

  package main;

  my $example = Example->new;

  # my $result = $example->eq(2);

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Comparable');

  $result
});

=description

This package modifies the consuming package and provides methods for performing
numerical and stringwise comparision operations or any object or raw data type.

=cut

$test->for('description');

=method eq

The eq method performs an I<"equals"> operation using the invocant and the
argument provided. The operation will be performed as either a numerical or
stringwise operation based upon the preference (i.e. the return value of the
L</comparer> method) of the invocant.

=signature eq

  eq(Any $arg) (Bool)

=metadata eq

{
  since => '0.08',
}

=example-1 eq

  package main;

  my $example = Example->new;

  my $result = $example->eq(2);

  # 1

=cut

$test->for('example', 1, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 eq

  package main;

  my $example = Example->new;

  my $result = $example->eq([1,2]);

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

  my $example = Example->new;

  my $result = $example->eq({1..4});

  # 1

=cut

$test->for('example', 3, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method ge

The ge method performs a I<"greater-than-or-equal-to"> operation using the
invocant and argument provided. The operation will be performed as either a
numerical or stringwise operation based upon the preference (i.e. the return
value of the L</comparer> method) of the invocant.

=signature ge

  ge(Any $arg) (Bool)

=metadata ge

{
  since => '0.08',
}

=example-1 ge

  package main;

  my $example = Example->new;

  my $result = $example->ge(3);

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

  my $example = Example->new;

  my $result = $example->ge([]);

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

  my $example = Example->new;

  my $result = $example->ge([1,2,3]);

  # 0

=cut

$test->for('example', 3, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method gele

The gele method performs a I<"greater-than-or-equal-to"> operation on the 1st
argument, and I<"lesser-than-or-equal-to"> operation on the 2nd argument. The
operation will be performed as either a numerical or stringwise operation based
upon the preference (i.e. the return value of the L</comparer> method) of the
invocant.

=signature gele

  gele(Any $arg1, Any $arg2) (Bool)

=metadata gele

{
  since => '0.08',
}

=example-1 gele

  package main;

  my $example = Example->new;

  my $result = $example->gele(1, 3);

  # 1

=cut

$test->for('example', 1, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 gele

  package main;

  my $example = Example->new;

  my $result = $example->gele(2, [1,2,3]);

  # 1

=cut

$test->for('example', 2, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 gele

  package main;

  my $example = Example->new;

  my $result = $example->gele(0, '3');

  # 1

=cut

$test->for('example', 3, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method gt

The gt method performs a I<"greater-than"> operation using the invocant and
argument provided. The operation will be performed as either a numerical or
stringwise operation based upon the preference (i.e. the return value of the
L</comparer> method) of the invocant.

=signature gt

  gt(Any $arg) (Bool)

=metadata gt

{
  since => '0.08',
}

=example-1 gt

  package main;

  my $example = Example->new;

  my $result = $example->gt({1..2});

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

  my $example = Example->new;

  my $result = $example->gt([9]);

  # 1

=cut

$test->for('example', 2, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 gt

  package main;

  my $example = Example->new;

  my $result = $example->gt(\1_000_000);

  # 1

=cut

$test->for('example', 3, 'gt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method gtlt

The gtlt method performs a I<"greater-than"> operation on the 1st argument, and
I<"lesser-than"> operation on the 2nd argument. The operation will be performed
as either a numerical or stringwise operation based upon the preference (i.e.
the return value of the L</comparer> method) of the invocant.

=signature gtlt

  gtlt(Any $arg1, Any $arg2) (Bool)

=metadata gtlt

{
  since => '0.08',
}

=example-1 gtlt

  package main;

  my $example = Example->new;

  my $result = $example->gtlt('1', 3);

  # 1

=cut

$test->for('example', 1, 'gtlt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 gtlt

  package main;

  my $example = Example->new;

  my $result = $example->gtlt({1..2}, {1..4});

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

  my $example = Example->new;

  my $result = $example->gtlt([9], [0,1,2]);

  # 1

=cut

$test->for('example', 3, 'gtlt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method le

The le method performs a I<"lesser-than-or-equal-to"> operation using the
invocant and argument provided. The operation will be performed as either a
numerical or stringwise operation based upon the preference (i.e. the return
value of the L</comparer> method) of the invocant.

=signature le

  le(Any $arg) (Bool)

=metadata le

{
  since => '0.08',
}

=example-1 le

  package main;

  my $example = Example->new;

  my $result = $example->le('9');

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

  my $example = Example->new;

  my $result = $example->le([1..2]);

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

  my $example = Example->new;

  my $result = $example->le(\1);

  # 0

=cut

$test->for('example', 3, 'le', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method lt

The lt method performs a I<"lesser-than"> operation using the invocant and
argument provided. The operation will be performed as either a numerical or
stringwise operation based upon the preference (i.e. the return value of the
L</comparer> method) of the invocant.

=signature lt

  lt(Any $arg) (Bool)

=metadata lt

{
  since => '0.08',
}

=example-1 lt

  package main;

  my $example = Example->new;

  my $result = $example->lt(qr/.*/);

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

  my $example = Example->new;

  my $result = $example->lt('.*');

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

  my $example = Example->new;

  my $result = $example->lt('5');

  # 1

=cut

$test->for('example', 3, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method ne

The ne method performs a I<"not-equal-to"> operation using the invocant and
argument provided. The operation will be performed as either a numerical or
stringwise operation based upon the preference (i.e. the return value of the
L</comparer> method) of the invocant.

=signature ne

  ne(Any $arg) (Bool)

=metadata ne

{
  since => '0.08',
}

=example-1 ne

  package main;

  my $example = Example->new;

  my $result = $example->ne([1,2]);

  # 0

=cut

$test->for('example', 1, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 ne

  package main;

  my $example = Example->new;

  my $result = $example->ne([2]);

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

  my $example = Example->new;

  my $result = $example->ne(qr/2/);

  # 1

=cut

$test->for('example', 3, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method tv

The tv method performs a I<"type-and-value-equal-to"> operation using the
invocant and argument provided. The operation will be performed as either a
numerical or stringwise operation based upon the preference (i.e. the return
value of the L</comparer> method) of the invocant.

=signature tv

  tv(Any $arg) (Bool)

=metadata tv

{
  since => '0.08',
}

=example-1 tv

  package main;

  my $example = Example->new;

  my $result = $example->tv($example);

  # 1

=cut

$test->for('example', 1, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 tv

  package main;

  use Venus::Number;

  my $example = Example->new;

  my $result = $example->tv(Venus::Number->new(2));

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

  use Venus::String;

  my $example = Example->new;

  my $result = $example->tv(Venus::String->new('2'));

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

  use Venus::String;

  my $example = Example->new;

  my $result = $example->tv(Example->new);

  # 1

=cut

$test->for('example', 4, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

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

$test->render('lib/Venus/Role/Comparable.pod') if $ENV{RENDER};

ok 1 and done_testing;
