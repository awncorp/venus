package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Doable

=cut

$test->for('name');

=tagline

Doable Role

=cut

$test->for('tagline');

=abstract

Doable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: do

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Doable';

  attr 'time';

  sub execute {
    return;
  }

  package main;

  my $example = Example->new;

  # $example->do(time => time)->execute;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Doable');

  $result
});

=description

This package modifies the consuming package and provides methods for chaining
any chainable and non-chainable methods (by ignoring their return values).

=cut

$test->for('description');

=method do

The do method dispatches the method call or executes the callback and returns
the invocant. This method supports dispatching, i.e. providing a method name
and arguments whose return value will be acted on by this method.

=signature do

  do(Str | CodeRef $method, Any @args) (Self)

=metadata do

{
  since => '0.01',
}

=example-1 do

  package main;

  my $example = Example->new;

  $example = $example->do(time => time);

  # bless({ time => 0000000000 }, "Example")

  # $example->execute;

=cut

$test->for('example', 1, 'do', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->time;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Doable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;