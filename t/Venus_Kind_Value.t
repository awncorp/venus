package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Scalar::Util 'refaddr';

my $test = test(__FILE__);

=name

Venus::Kind::Value

=cut

$test->for('name');

=tagline

Value Base Class

=cut

$test->for('tagline');

=abstract

Value Base Class for Perl 5

=cut

$test->for('abstract');

=includes

method: cast
method: defined
method: explain
method: mutate

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  base 'Venus::Kind::Value';

  sub test {
    $_[0]->get + 1
  }

  package main;

  my $example = Example->new(1);

  # $example->defined;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=description

This package provides identity and methods common across all L<Venus> value
classes.

=cut

$test->for('description');

=inherits

Venus::Kind

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Explainable
Venus::Role::Pluggable
Venus::Role::Proxyable
Venus::Role::Valuable

=cut

$test->for('integrates');

=method cast

The cast method converts L<"value"|Venus::Kind::Value> objects between
different I<"value"> object types, based on the name of the type provided. This
method will return C<undef> if the invocant is not a L<Venus::Kind::Value>.

=signature cast

  cast(string $kind) (object | undef)

=metadata cast

{
  since => '0.08',
}

=example-1 cast

  package main;

  my $example = Example->new;

  my $cast = $example->cast;

  # bless({value => undef}, "Venus::Undef")

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Undef');
  is $result->value, undef;

  !$result
});

=example-2 cast

  package main;

  my $example = Example->new(
    value => 123.45,
  );

  my $cast = $example->cast('array');

  # bless({value => [123.45]}, "Venus::Array")

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Array');
  is_deeply $result->value, [123.45];

  $result
});

=example-3 cast

  package main;

  my $example = Example->new(
    value => 123.45,
  );

  my $cast = $example->cast('hash');

  # bless({value => {'123.45' => 123.45}, "Venus::Hash")

=cut

$test->for('example', 3, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Hash');
  is_deeply $result->value, {'123.45' => 123.45};

  $result
});

=method defined

The defined method returns truthy or falsy if the underlying value is
L</defined>.

=signature defined

  defined() (number)

=metadata defined

{
  since => '0.01',
}

=example-1 defined

  package main;

  my $example = Example->new;

  my $defined = $example->defined;

  # 0

=cut

$test->for('example', 1, 'defined', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 defined

  package main;

  my $example = Example->new(time);

  my $defined = $example->defined;

  # 1

=cut

$test->for('example', 2, 'defined', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method explain

The explain method returns the value set and is used in stringification
operations.

=signature explain

  explain() (any)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  package main;

  my $example = Example->new('hello, there');

  my $explain = $example->explain;

  # "hello, there"

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello, there";

  $result
});

=method mutate

The mutate method dispatches the method call or executes the callback and
returns the result, which if is of the same type as the invocant's underlying
data type will update the object's internal state or will throw an exception.

=signature mutate

  mutate(string | coderef $code, any @args) (object)

=metadata mutate

{
  since => '1.23',
}

=example-1 mutate

  # given: synopsis

  package main;

  $example->mutate('test');

  $example;

  # bless({value => 2}, "Example")

=cut

$test->for('example', 1, 'mutate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->get eq 2;
  my $e1 = refaddr $result;
  $result->mutate('test');
  ok $result->isa('Example');
  ok $result->get eq 3;
  my $e2 = refaddr $result;
  is $e1, $e2;

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Kind/Value.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;