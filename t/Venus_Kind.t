package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Kind

=cut

$test->for('name');

=tagline

Kind Base Class

=cut

$test->for('tagline');

=abstract

Kind Base Class for Perl 5

=cut

$test->for('abstract');

=includes

method: class
method: space
method: type

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  extends 'Venus::Kind';

  package main;

  my $example = Example->new;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=description

This package provides identity and methods common across all L<Venus> classes.

=cut

$test->for('description');

=integrates

Venus::Role::Boxable
Venus::Role::Catchable
Venus::Role::Doable
Venus::Role::Dumpable
Venus::Role::Printable
Venus::Role::Throwable

=cut

$test->for('integrates');

=method class

The class method returns the class name for the given class or object.

=signature class

  class() (Str)

=metadata class

{
  since => '0.01',
}

=example-1 class

  # given: synopsis;

  my $class = $example->class;

  # "Example"

=cut

$test->for('example', 1, 'class', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Example";

  $result
});

=method space

The space method returns a L<Venus::Space> object for the given object.

=signature space

  space() (Space)

=metadata space

{
  since => '0.01',
}

=example-1 space

  # given: synopsis;

  my $space = $example->space;

  # bless({ value => "Example" }, "Venus::Space")

=cut

$test->for('example', 1, 'space', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');

  $result
});

=method type

The type method returns a L<Venus::Type> object for the given object.

=signature type

  type() (Type)

=metadata type

{
  since => '0.01',
}

=example-1 type

  # given: synopsis;

  my $type = $example->type;

  # bless({ value => bless({}, "Example") }, "Venus::Type")

=cut

$test->for('example', 1, 'type', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Type');
  ok $result->value->isa('Example');

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

$test->render('lib/Venus/Kind.pod') if $ENV{RENDER};

ok 1 and done_testing;