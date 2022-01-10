package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Valuable

=cut

$test->for('name');

=tagline

Valuable Role

=cut

$test->for('tagline');

=abstract

Valuable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: default

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Valuable';

  package main;

  my $example = Example->new;

  # $example->value;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Valuable');

  $result
});

=description

This package modifies the consuming package and provides a C<value> attribute
which defaults to what's returned by the C<default> method.

=cut

$test->for('description');

=attributes

value: rw, opt, Any

=cut

$test->for('attributes');

=method default

The default method returns the default value, i.e. C<undef>.

=signature default

  default() (Any)

=metadata default

{
  since => '0.01',
}

=example-1 default

  package main;

  my $example = Example->new;

  my $default = $example->default;

  # undef

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Role/Valuable.pod') if $ENV{RENDER};

ok 1 and done_testing;