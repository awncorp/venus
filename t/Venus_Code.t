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
method: comparer
method: compose
method: conjoin
method: curry
method: default
method: disjoin
method: next
method: numified
method: rcurry

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

  my $comparer = $code->comparer;

  # "stringified"

=cut

$test->for('example', 1, 'comparer', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'stringified';

  $result
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

=method numified

The numified method returns the numerical representation of the object. For code
objects this method always returns C<0>.

=signature numified

  numified() (Int)

=metadata numified

{
  since => '0.08',
}

=example-1 numified

  # given: synopsis;

  my $numified = $code->numified;

  # 0

=cut

$test->for('example', 1, 'numified', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 numified

  package main;

  use Venus::Code;

  my $code = Venus::Code->new(sub {
    return;
  });

  my $numified = $code->numified;

  # 0

=cut

$test->for('example', 2, 'numified', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
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