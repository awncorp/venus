package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Stashable

=cut

$test->for('name');

=tagline

Stashable Role

=cut

$test->for('tagline');

=abstract

Stashable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: stash

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Stashable';

  attr 'test';

  package main;

  my $example = Example->new(test => time);

  # $example->stash;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Stashable');

  $result
});

=description

This package modifies the consuming package and provides methods for stashing
data within the object.

=cut

$test->for('description');

=method stash

The stash method is used to fetch and stash named values associated with the
object. Calling this method without arguments returns all values.

=signature stash

  stash(Any $key, Any $value) (Any)

=metadata stash

{
  since => '0.01',
}

=example-1 stash

  package main;

  my $example = Example->new(test => time);

  my $stash = $example->stash;

  # {}

=cut

$test->for('example', 1, 'stash', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=example-2 stash

  package main;

  my $example = Example->new(test => time);

  my $stash = $example->stash('test', {1..4});

  # { 1 => 2, 3 => 4 }

=cut

$test->for('example', 2, 'stash', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { 1 => 2, 3 => 4 };

  $result
});

=example-3 stash

  package main;

  my $example = Example->new(test => time);

  my $stash = $example->stash('test');

  # undef

=cut

$test->for('example', 3, 'stash', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Stashable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;