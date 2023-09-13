package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Unpackable

=cut

$test->for('name');

=tagline

Unpackable Role

=cut

$test->for('tagline');

=abstract

Unpackable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: unpack

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Unpackable';

  sub execute {
    return shift;
  }

  package main;

  my $example = Example->new;

  # $example->unpack("hello", 123, 1.23)->signature(
  #   'string', 'number', 'float',
  # );

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Unpackable');

  $result
});

=description

This package modifies the consuming package and provides methods for unpacking
and validating argument lists.

=cut

$test->for('description');

=method unpack

The unpack method passes the arguments provided to L<Venus::Unpack> for
unpacking and validating arbitrary argument lists.

=signature unpack

  unpack(any @args) (Venus::Unpack)

=metadata unpack

{
  since => '2.01',
}

=example-1 unpack

  package main;

  my $example = Example->new;

  my $results = $example->unpack("hello", 123, 1.23)->signature(
    'any',
  );

  # ["hello", 123, 1.23]

=cut

$test->for('example', 1, 'unpack', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=example-2 unpack

  package main;

  my $example = Example->new;

  my $results = $example->unpack("hello", 123, 1.23)->signature(
    'string',
    'number | float',
  );

  # ["hello", 123, 1.23]

=cut

$test->for('example', 2, 'unpack', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=example-3 unpack

  package main;

  my $example = Example->new;

  my $results = $example->unpack("hello", 123, 1.23)->signature(
    'string',
    'number',
    'float',
  );

  # ["hello", 123, 1.23]

=cut

$test->for('example', 3, 'unpack', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['hello', 123, 1.23];

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Unpackable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
