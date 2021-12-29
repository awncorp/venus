package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

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

  has 'time';

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
the invocant.

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

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Role/Doable.pod') if $ENV{RENDER};

ok 1 and done_testing;