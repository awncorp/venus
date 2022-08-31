package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Assert

=cut

$test->for('name');

=tagline

Assert Class

=cut

$test->for('tagline');

=abstract

Assert Class for Perl 5

=cut

$test->for('abstract');

=includes

method: check
method: coerce
method: coercion
method: coercions
method: constraint
method: constraints
method: validate

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Assert;

  my $assert = Venus::Assert->new('Example');

  # $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  # $assert->constraint(float => sub { $_->value > 1 });

  # $assert->check;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=description

This package provides a mechanism for asserting type constraints and coercions
on data.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable

=cut

$test->for('integrates');

=attributes

message: rw, opt, Str
name: rw, opt, Str

=cut

$test->for('attributes');

=method check

The check method returns true or false if the data provided passes the
registered constraints.

=signature check

  check(Any $data) (Bool)

=metadata check

{
  since => '1.23',
}

=example-1 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check;

  # 0

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check('0.01');

  # 0

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-3 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check('1.01');

  # 1

=cut

$test->for('example', 3, 'check', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-4 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check(time);

  # 0

=cut

$test->for('example', 4, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method coerce

The coerce method returns the coerced data if the data provided matches any of
the registered coercions.

=signature coerce

  coerce(Any $data) (Any)

=metadata coerce

{
  since => '1.23',
}

=example-1 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce;

  # undef

=cut

$test->for('example', 1, 'coerce', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce('1.01');

  # "1.01"

=cut

$test->for('example', 2, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == '1.01';

  $result
});

=example-3 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce('1.00001');

  # "1.00"

=cut

$test->for('example', 3, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == '1.00';

  $result
});

=example-4 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce('hello world');

  # "hello world"

=cut

$test->for('example', 4, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello world';

  $result
});

=method coercion

The coercion method returns registers a coercion based on the type provided.

=signature coercion

  coercion(Str $type, CodeRef $code) (Object)

=metadata coercion

{
  since => '1.23',
}

=example-1 coercion

  # given: synopsis

  package main;

  my $coercion = $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  # bless(..., "Venus::Assert")

=cut

$test->for('example', 1, 'coercion', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=method coercions

The coercions method returns the registered coercions as a L<Venus::Match> object.

=signature coercions

  coercions() (Match)

=metadata coercions

{
  since => '1.23',
}

=example-1 coercions

  # given: synopsis

  package main;

  my $coercions = $assert->coercions;

  # bless(..., "Venus::Match")

=cut

$test->for('example', 1, 'coercions', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');

  $result
});

=method constraint

The constraint method returns registers a constraint based on the type provided.

=signature constraint

  constraint(Str $type, CodeRef $code) (Object)

=metadata constraint

{
  since => '1.23',
}

=example-1 constraint

  # given: synopsis

  package main;

  my $constraint = $assert->constraint(float => sub { $_->value > 1 });

  # bless(..., "Venus::Assert")

=cut

$test->for('example', 1, 'constraint', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=method constraints

The constraints method returns the registered constraints as a L<Venus::Match>
object.

=signature constraints

  constraints() (Match)

=metadata constraints

{
  since => '1.23',
}

=example-1 constraints

  # given: synopsis

  package main;

  my $constraints = $assert->constraints;

  # bless(..., "Venus::Match")

=cut

$test->for('example', 1, 'constraints', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');

  $result
});

=method validate

The validate method returns the data provided if the data provided passes the
registered constraints, or throws an exception.

=signature validate

  validate(Any $data) (Any)

=metadata validate

{
  since => '1.23',
}

=example-1 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate;

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 1, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Assert::Error');
  ok $result->isa('Venus::Error');
  ok $result->is('on.validate');
  ok $result->stash('identity') eq 'undef';

  $result
});

=example-2 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate('0.01');

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 2, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Assert::Error');
  ok $result->isa('Venus::Error');
  ok $result->is('on.validate');
  ok $result->stash('identity') eq 'float';

  $result
});

=example-3 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate('1.01');

  # "1.01"

=cut

$test->for('example', 3, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1.01;

  $result
});

=example-4 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate(time);

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 4, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Assert::Error');
  ok $result->isa('Venus::Error');
  ok $result->is('on.validate');
  ok $result->stash('identity') eq 'number';

  $result
});

# END

$test->render('lib/Venus/Assert.pod') if $ENV{RENDER};

ok 1 and done_testing;
