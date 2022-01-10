package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Accessible

=cut

$test->for('name');

=tagline

Accessible Role

=cut

$test->for('tagline');

=abstract

Accessible Role for Perl 5

=cut

$test->for('abstract');

=includes

method: get
method: set

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Accessible';

  package main;

  my $example = Example->new('hello, there');

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=description

This package modifies the consuming package and provides a C<value> attribute
as well as C<get> and C<set> methods for modifying the value.

=cut

$test->for('description');

=integrates

Venus::Role::Buildable
Venus::Role::Valuable

=cut

$test->for('integrates');

=method get

The get method gets and returns the value.

=signature get

  get() (Any)

=metadata get

{
  since => '0.01',
}

=example-1 get

  package main;

  my $example = Example->new(value => 'hey, there');

  my $get = $example->get;

  # "hey, there"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hey, there";

  $result
});

=method set

The set method set the value and returns the value set.

=signature set

  set(Any $value) (Any)

=metadata set

{
  since => '0.01',
}

=example-1 set

  package main;

  my $example = Example->new(value => 'hey, there');

  my $set = $example->set('hi, there');

  # "hi, there"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hi, there";

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

$test->render('lib/Venus/Role/Accessible.pod') if $ENV{RENDER};

ok 1 and done_testing;