package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Explainable

=cut

$test->for('name');

=tagline

Explainable Role

=cut

$test->for('tagline');

=abstract

Explainable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: explain

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  attr 'test';

  sub explain {
    "okay"
  }

  with 'Venus::Role::Explainable';

  package main;

  my $example = Example->new(test => 123);

  # $example->explain;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Explainable');

  $result
});

=description

This package modifies the consuming package and provides methods for making the
object stringifiable.

=cut

$test->for('description');

=method explain

The explain method takes no arguments and returns the value to be used in
stringification operations.

=signature explain

  explain() (any)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  package main;

  my $example = Example->new(test => 123);

  my $explain = $example->explain;

  # "okay"

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "okay";

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Explainable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;