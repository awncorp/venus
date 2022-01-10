package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Buildable

=cut

$test->for('name');

=tagline

Buildable Role

=cut

$test->for('tagline');

=abstract

Buildable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: build_arg
method: build_args
method: build_self
method: build_nil

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Buildable';

  has 'test';

  package main;

  my $example = Example->new;

  # $example->test;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Buildable');

  $result
});

=description

This package modifies the consuming package and provides methods for hooking
into object construction of the consuming class, e.g. handling single-arg
object construction.

=cut

$test->for('description');

=method build_arg

The build_arg method, if defined, is only called during object construction
when a single non-hashref is provided.


=signature build_arg

  build_arg(Any $data) (HashRef)

=metadata build_arg

{
  since => '0.01',
}

=example-1 build_arg

  package Example1;

  use Venus::Class;

  has 'x';
  has 'y';

  with 'Venus::Role::Buildable';

  sub build_arg {
    my ($self, $data) = @_;

    $data = { x => $data, y => $data };

    return $data;
  }

  package main;

  my $example = Example1->new(10);

  # $example->x;
  # $example->y;

=cut

$test->for('example', 1, 'build_arg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example1');
  ok $result->does('Venus::Role::Buildable');
  ok $result->x == 10;
  ok $result->y == 10;

  $result
});

=method build_args

The build_args method, if defined, is only called during object construction to
hook into the handling of the arguments provided.

=signature build_args

  build_args(HashRef $data) (HashRef)

=metadata build_args

{
  since => '0.01',
}

=example-1 build_args

  package Example2;

  use Venus::Class;

  has 'x';
  has 'y';

  with 'Venus::Role::Buildable';

  sub build_args {
    my ($self, $data) = @_;

    $data->{x} ||= int($data->{x} || 100);
    $data->{y} ||= int($data->{y} || 100);

    return $data;
  }

  package main;

  my $example = Example2->new(x => 10, y => 10);

  # $example->x;
  # $example->y;

=cut

$test->for('example', 1, 'build_args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example2');
  ok $result->does('Venus::Role::Buildable');
  ok $result->x == 10;
  ok $result->y == 10;

  $result
});

=method build_self

The build_self method, if defined, is only called during object construction
after all arguments have been handled and set.

=signature build_self

  build_self(HashRef $data) (Self)

=metadata build_self

{
  since => '0.01',
}

=example-1 build_self

  package Example3;

  use Venus::Class;

  has 'x';
  has 'y';

  with 'Venus::Role::Buildable';

  sub build_self {
    my ($self, $data) = @_;

    die if !$self->x;
    die if !$self->y;

    return $self;
  }

  package main;

  my $example = Example3->new(x => 10, y => 10);

  # $example->x;
  # $example->y;

=cut

$test->for('example', 1, 'build_self', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example3');
  ok $result->does('Venus::Role::Buildable');
  ok $result->x == 10;
  ok $result->y == 10;

  $result
});

=method build_nil

The build_nil method, if defined, is only called during object construction
when a single empty hashref is provided.

=signature build_nil

  build_nil(HashRef $data) (Any)

=metadata build_nil

{
  since => '0.01',
}

=example-1 build_nil

  package Example4;

  use Venus::Class;

  has 'x';
  has 'y';

  with 'Venus::Role::Buildable';

  sub build_nil {
    my ($self, $data) = @_;

    $data = { x => 10, y => 10 };

    return $data;
  }

  package main;

  my $example = Example4->new({});

  # $example->x;
  # $example->y;

=cut

$test->for('example', 1, 'build_nil', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example4');
  ok $result->does('Venus::Role::Buildable');
  ok $result->x == 10;
  ok $result->y == 10;

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

$test->render('lib/Venus/Role/Buildable.pod') if $ENV{RENDER};

ok 1 and done_testing;