package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Boxable

=cut

$test->for('name');

=tagline

Boxable Role

=cut

$test->for('tagline');

=abstract

Boxable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: box

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Boxable';

  attr 'text';

  package main;

  my $example = Example->new(text => 'hello, world');

  # $example->box('text')->lc->ucfirst->concat('.')->unbox->get;

  # "Hello, world."

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Boxable');

  $result
});

=description

This package modifies the consuming package and provides a method for boxing
itself. This makes it possible to chain method calls across objects and values.

=cut

$test->for('description');

=method box

The box method returns the invocant boxed, i.e. encapsulated, using
L<Venus::Box>. This method supports dispatching, i.e. providing a method name
and arguments whose return value will be acted on by this method.

=signature box

  box(Str | CodeRef $method, Any @args) (Self)

=metadata box

{
  since => '0.01',
}

=example-1 box

  package main;

  my $example = Example->new(text => 'hello, world');

  my $box = $example->box;

  # bless({ value => bless(..., "Example") }, "Venus::Box")

=cut

$test->for('example', 1, 'box', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Box');
  ok $result->{value};
  ok $result->{value}->isa('Example');

  $result
});

=example-2 box

  package main;

  my $example = Example->new(text => 'hello, world');

  my $box = $example->box('text');

  # bless({ value => bless(..., "Venus::String") }, "Venus::Box")

  # $example->box('text')->lc->ucfirst->concat('.')->unbox->get;

=cut

$test->for('example', 2, 'box', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Box');
  ok $result->{value};
  ok $result->{value}->isa('Venus::String');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Boxable.pod') if $ENV{RENDER};

ok 1 and done_testing;