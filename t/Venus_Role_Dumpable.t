package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Dumpable

=cut

$test->for('name');

=tagline

Dumpable Role

=cut

$test->for('tagline');

=abstract

Dumpable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: dump
method: dump_pretty

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  has 'test';

  with 'Venus::Role::Dumpable';

  package main;

  my $example = Example->new(test => 123);

  # $example->dump;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Dumpable');

  $result
});

=description

This package modifies the consuming package and provides methods for dumping
the object or the return value of a dispatched method call.

=cut

$test->for('description');

=method dump

The dump method returns a string representation of the underlying data.

=signature dump

  dump(Str | CodeRef $method, Any @args) (Str)

=metadata dump

{
  since => '0.01',
}

=example-1 dump

  package main;

  my $example = Example->new(test => 123);

  my $dump = $example->dump;

  # "bless( {test => 123}, 'Example' )"

=cut

$test->for('example', 1, 'dump', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "bless( {test => 123}, 'Example' )";

  $result
});

=method dump_pretty

The dump_pretty method returns a string representation of the underlying data
that is human-readable and useful for debugging.

=signature dump_pretty

  dump_pretty(Str | CodeRef $method, Any @args) (Str)

=metadata dump_pretty

{
  since => '0.01',
}

=example-1 dump_pretty

  package main;

  my $example = Example->new(test => 123);

  my $dump_pretty = $example->dump_pretty;

  # bless( {
  #          test => 123
  #        }, 'Example' )

=cut

$test->for('example', 1, 'dump_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "bless( {\n         test => 123\n       }, 'Example' )";

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

$test->render('lib/Venus/Role/Dumpable.pod') if $ENV{RENDER};

ok 1 and done_testing;