package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

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

method: defined
method: explain

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  extends 'Venus::Kind::Value';

  package main;

  my $example = Example->new;

  # $example->defined;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Example');

  !$result
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
Venus::Role::Valuable

=cut

$test->for('integrates');

=method defined

The defined method returns truthy or falsy if the underlying value is
L</defined>.

=signature defined

  defined() (Int)

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

  explain() (Any)

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

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Kind/Value.pod') if $ENV{RENDER};

ok 1 and done_testing;