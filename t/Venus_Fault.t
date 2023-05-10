package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);
my $fsds = qr/[:\\\/\.]+/;

=name

Venus::Fault

=cut

$test->for('name');

=tagline

Fault Class

=cut

$test->for('tagline');

=abstract

Fault Class for Perl 5

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

  use Venus::Fault;

  my $fault = Venus::Fault->new;

  # $fault->throw;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package represents a generic system error (exception object).

=cut

$test->for('description');

=method explain

The explain method returns the error message and is used in stringification
operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '1.80',
}

=example-1 explain

  # given: synopsis;

  my $explain = $fault->explain;

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
  since => '1.80',
}

=example-1 frames

  # given: synopsis;

  my $frames = $fault->frames;

  # [
  #   ...
  #   [
  #     "main",
  #     "t/Venus_Fault.t",
  #     ...
  #   ],
  # ]

=cut

$test->for('example', 1, 'frames', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  my $last_frame = $result->[-1];
  ok $last_frame->[0] eq 'main';
  ok $last_frame->[1] =~ m{t${fsds}Venus_Fault.t$};

  $result
});

=method throw

The throw method throws an error if the invocant is an object, or creates an
error object using the arguments provided and throws the created object.

=signature throw

  throw(Str $message) (Fault)

=metadata throw

{
  since => '1.80',
}

=example-1 throw

  # given: synopsis;

  my $throw = $fault->throw;

  # bless({ ... }, 'Venus::Fault')

=cut

$test->for('example', 1, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Fault');

  $result
});

=method trace

The trace method compiles a stack trace and returns the object. By default it
skips the first frame.

=signature trace

  trace(Int $offset, Int $limit) (Fault)

=metadata trace

{
  since => '1.80',
}

=example-1 trace

  # given: synopsis;

  my $trace = $fault->trace;

  # bless({ ... }, 'Venus::Fault')

=cut

$test->for('example', 1, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Fault');
  ok @{$result->frames} > 0;

  $result
});

=example-2 trace

  # given: synopsis;

  my $trace = $fault->trace(0, 1);

  # bless({ ... }, 'Venus::Fault')

=cut

$test->for('example', 2, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Fault');
  ok @{$result->frames} == 1;

  $result
});

=example-3 trace

  # given: synopsis;

  my $trace = $fault->trace(0, 2);

  # bless({ ... }, 'Venus::Fault')

=cut

$test->for('example', 3, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Fault');
  ok @{$result->frames} == 2;

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $fault eq 'Exception!';

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

  my $result = $fault ne 'exception!';

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

  my $test = 'Exception!' =~ qr/$fault/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$fault";

  # "Exception!"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ 'Exception!';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $fault ~~ 'Exception!';

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Fault.pod') if $ENV{RENDER};

ok 1 and done_testing;
