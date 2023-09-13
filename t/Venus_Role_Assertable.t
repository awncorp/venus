package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Assertable

=cut

$test->for('name');

=tagline

Assertable Role

=cut

$test->for('tagline');

=abstract

Assertable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: assert
method: assertion
method: check
method: coerce
method: make

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;
  use Venus::Assert;

  with 'Venus::Role::Assertable';

  sub assertion {
    Venus::Assert->new('Example')->accept('Example')
  }

  package main;

  my $example = Example->new;

  # $example->check;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Assertable');

  $result
});

=description

This package modifies the consuming package and requires methods for making the
object assertable.

=cut

$test->for('description');

=method assert

The assert method returns the data provided if it passes the registered type
constraints, or throws an exception.

=signature assert

  assert(any $data) (any)

=metadata assert

{
  since => '1.23',
}

=example-1 assert

  # given: synopsis

  package main;

  my $assert = $example->assert;

  # Exception! (isa Venus::Check::Error)

=cut

$test->for('example', 1, 'assert', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error->result;
  ok $result->isa('Venus::Check::Error');

  $result
});

=example-2 assert

  # given: synopsis

  package main;

  my $assert = $example->assert({});

  # Exception! (isa Venus::Check::Error)

=cut

$test->for('example', 2, 'assert', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Check::Error');

  $result
});

=example-3 assert

  # given: synopsis

  package main;

  my $assert = $example->assert($example);

  # bless({}, "Example")

=cut

$test->for('example', 3, 'assert', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=method assertion

The assertion method receives no arguments and should returns a
L<Venus::Assert> object.

=signature assertion

  assertion() (Venus::Assert)

=metadata assertion

{
  since => '1.23',
}

=example-1 assertion

  package main;

  my $example = Example->new;

  my $assertion = $example->assertion;

  # bless({name => "Example"}, "Venus::Assert")

=cut

$test->for('example', 1, 'assertion', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=method check

The check method returns true if the data provided passes the registered type
constraints, or returns false.

=signature check

  check(any $data) (boolean)

=metadata check

{
  since => '1.23',
}

=example-1 check

  # given: synopsis

  package main;

  my $check = $example->check;

  # 0

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-2 check

  # given: synopsis

  package main;

  my $check = $example->check({});

  # 0

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-3 check

  # given: synopsis

  package main;

  my $check = $example->check($example);

  # 1

=cut

$test->for('example', 3, 'check', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method coerce

The coerce method returns a coerced value if the data provided matches any of
the registered type coercions, or returns the data provided.

=signature coerce

  coerce(any $data) (any)

=metadata coerce

{
  since => '1.23',
}

=example-1 coerce

  # given: synopsis

  package main;

  my $assertion = $example->assertion;

  $assertion->match('string')->format(sub{ucfirst(lc($_))});

  my $coerce = $assertion->coerce;

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

  my $assertion = $example->assertion;

  $assertion->match('string')->format(sub{ucfirst(lc($_))});

  my $coerce = $assertion->coerce({});

  # {}

=cut

$test->for('example', 2, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref($result) eq 'HASH';

  $result
});

=example-3 coerce

  # given: synopsis

  package main;

  my $assertion = $example->assertion;

  $assertion->match('string')->format(sub{ucfirst(lc($_))});

  my $coerce = $assertion->coerce('hello');

  # "Hello"

=cut

$test->for('example', 3, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Hello';

  $result
});

=method make

The make method returns an instance of the invocant, if the data provided
passes the registered type constraints, allowing for any coercion, or throws an
exception. If the data provided is itself an instance of the invocant it will
be returned unaltered.

=signature make

  make(any $data) (object)

=metadata make

{
  since => '1.23',
}

=example-1 make

  # given: synopsis

  package main;

  my $make = $example->make;

  # Exception! (isa Venus::Check::Error)

=cut

$test->for('example', 1, 'make', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error->result;
  ok $result->isa('Venus::Check::Error');

  $result
});

=example-2 make

  # given: synopsis

  package main;

  my $make = $example->make($example);

  # bless({}, "Example")

=cut

$test->for('example', 2, 'make', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=example-3 make

  # given: synopsis

  package main;

  my $make = $example->make({});

  # Exception! (isa Venus::Check::Error)

=cut

$test->for('example', 3, 'make', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Check::Error');

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Assertable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
