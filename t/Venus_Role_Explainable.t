package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

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

  has 'test';

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

  explain() (Any)

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

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  package main;

  my $example = Example->new(test => 123);

  my $string = "$example";

  # "okay"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'okay';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  package main;

  my $example = Example->new(test => 123);

  my $result = $example ~~ 'okay';

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Role/Explainable.pod') if $ENV{RENDER};

ok 1 and done_testing;