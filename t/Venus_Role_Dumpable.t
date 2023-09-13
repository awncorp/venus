package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

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

  attr 'test';

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

The dump method returns a string representation of the underlying data. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method.

=signature dump

  dump(string | coderef $method, any @args) (string)

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
that is human-readable and useful for debugging. This method supports
dispatching, i.e. providing a method name and arguments whose return value will
be acted on by this method.

=signature dump_pretty

  dump_pretty(string | coderef $method, any @args) (string)

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

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Dumpable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;