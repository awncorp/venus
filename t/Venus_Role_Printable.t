package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Printable

=cut

$test->for('name');

=tagline

Printable Role

=cut

$test->for('tagline');

=abstract

Printable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: print
method: print_pretty
method: say
method: say_pretty

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Printable';

  has 'test';

  sub execute {
    return [@_];
  }

  sub printer {
    return [@_];
  }

  package main;

  my $example = Example->new(test => 123);

  # $example->say;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Printable');

  $result
});

=description

This package provides a mechanism for outputting (printing) objects or the
return value of a dispatched method call to STDOUT.

=cut

$test->for('description');

=integrates

Venus::Role::Dumpable

=cut

$test->for('integrates');

=method print

The print method prints a stringified representation of the underlying data.

=signature print

  print(Any @data) (Any)

=metadata print

{
  since => '0.01',
}

=example-1 print

  package main;

  my $example = Example->new(test => 123);

  my $print = $example->print;

  # bless({test => 123}, 'Example')

  # 1

=cut

$test->for('example', 1, 'print', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=example-2 print

  package main;

  my $example = Example->new(test => 123);

  my $print = $example->print('execute', 1, 2, 3);

  # [bless({test => 123}, 'Example'),1,2,3]

  # 1

=cut

$test->for('example', 2, 'print', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method print_pretty

The print_pretty method prints a stringified human-readable representation of
the underlying data.

=signature print_pretty

  print_pretty(Any @data) (Any)

=metadata print_pretty

{
  since => '0.01',
}

=example-1 print_pretty

  package main;

  my $example = Example->new(test => 123);

  my $print_pretty = $example->print_pretty;

  # bless({ test => 123 }, 'Example')

  # 1

=cut

$test->for('example', 1, 'print_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=example-2 print_pretty

  package main;

  my $example = Example->new(test => 123);

  my $print_pretty = $example->print_pretty('execute', 1, 2, 3);

  # [
  #   bless({ test => 123 }, 'Example'),
  #   1,
  #   2,
  #   3
  # ]

  # 1

=cut

$test->for('example', 2, 'print_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method say

The say method prints a stringified representation of the underlying data, with
a trailing newline.

=signature say

  say(Any @data) (Any)

=metadata say

{
  since => '0.01',
}

=example-1 say

  package main;

  my $example = Example->new(test => 123);

  my $say = $example->say;

  # bless({test => 123}, 'Example')\n

  # 1

=cut

$test->for('example', 1, 'say', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=example-2 say

  package main;

  my $example = Example->new(test => 123);

  my $say = $example->say;

  # [bless({test => 123}, 'Example'),1,2,3]\n

  # 1

=cut

$test->for('example', 2, 'say', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=method say_pretty

The say_pretty method prints a stringified human-readable representation of the
underlying data, with a trailing newline.

=signature say_pretty

  say_pretty(Any @data) (Any)

=metadata say_pretty

{
  since => '0.01',
}

=example-1 say_pretty

  package main;

  my $example = Example->new(test => 123);

  my $say_pretty = $example->say_pretty;

  # bless({ test => 123 }, 'Example')\n

  # 1

=cut

$test->for('example', 1, 'say_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=example-2 say_pretty

  package main;

  my $example = Example->new(test => 123);

  my $say_pretty = $example->say_pretty;

  # [
  #   bless({ test => 123 }, 'Example'),
  #   1,
  #   2,
  #   3
  # ]\n

  # 1

=cut

$test->for('example', 2, 'say_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

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

$test->render('lib/Venus/Role/Printable.pod') if $ENV{RENDER};

ok 1 and done_testing;