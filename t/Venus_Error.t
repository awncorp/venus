package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Error

=cut

$test->for('name');

=tagline

Error Class

=cut

$test->for('tagline');

=abstract

Error Class for Perl 5

=cut

$test->for('abstract');

=includes

method: explain
method: frames
method: throw
method: trace

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Error;

  my $error = Venus::Error->new;

  # $error->throw;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package represents a context-aware error (exception object).

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Explainable
Venus::Role::Stashable

=cut

$test->for('integrates');

=attributes

context: rw, opt, Str, C<'(None)'>
message: rw, opt, Str, C<'Exception!'>

=cut

$test->for('attributes');

=method explain

The explain method returns the error message and is used in stringification
operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $error->explain;

  # "Exception! in ...

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ /^Exception! /;

  $result
});

=method frames

The frames method returns the compiled and stashed stack trace data.

=signature frames

  frames() (ArrayRef)

=metadata frames

{
  since => '0.01',
}

=example-1 frames

  # given: synopsis;

  my $frames = $error->frames;

  # [
  #   ...
  #   [
  #     "main",
  #     "t/Venus_Error.t",
  #     ...
  #   ],
  # ]

=cut

$test->for('example', 1, 'frames', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  my $last_frame = $result->[-1];
  ok $last_frame->[0] eq 'main';
  ok $last_frame->[1] =~ m{t/Venus_Error.t$};

  $result
});

=method throw

The throw method throws an error if the invocant is an object, or creates an
error object using the arguments provided and throws the created object.

=signature throw

  throw(Any @data) (Error)

=metadata throw

{
  since => '0.01',
}

=example-1 throw

  # given: synopsis;

  my $throw = $error->throw;

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 1, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Error');

  $result
});

=method trace

The trace method compiles a stack trace and returns the object. By default it
skips the first frame.

=signature trace

  trace(Int $offset, Int $limit) (Error)

=metadata trace

{
  since => '0.01',
}

=example-1 trace

  # given: synopsis;

  my $trace = $error->trace;

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 1, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok @{$result->frames} > 0;

  $result
});

=example-2 trace

  # given: synopsis;

  my $trace = $error->trace(0, 1);

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 2, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok @{$result->frames} == 1;

  $result
});

=example-3 trace

  # given: synopsis;

  my $trace = $error->trace(0, 2);

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 3, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok @{$result->frames} == 2;

  $result
});

=operator (.)

This package overloads the C<.> operator.

=cut

$test->for('operator', '(.)');

=example-1 (.)

  # given: synopsis;

  my $string = $error . ' Unknown';

  # "Exception! Unknown"

=cut

$test->for('example', 1, '(.)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Exception! Unknown";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $error eq 'Exception!';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $error ne 'exception!';

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $test = 'Exception!' =~ qr/$error/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

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

$test->render('lib/Venus/Error.pod') if $ENV{RENDER};

ok 1 and done_testing;