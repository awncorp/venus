package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Throw

=cut

$test->for('name');

=tagline

Throw Class

=cut

$test->for('tagline');

=abstract

Throw Class for Perl 5

=cut

$test->for('abstract');

=includes

method: error

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Throw;

  my $throw = Venus::Throw->new;

  # $throw->error;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides a mechanism for generating and raising errors (exception
objects).

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Stashable

=cut

$test->for('integrates');

=attributes

message: rw, opt, Str
package: ro, opt, Str
parent: ro, opt, Str, C<'Venus::Error'>
context: ro, opt, Str

=cut

$test->for('attributes');

=method error

The error method throws the prepared error object.


=signature error

  error(HashRef $data) (Error)

=metadata error

{
  since => '0.01',
}

=example-1 error

  # given: synopsis;

  my $error = $throw->error;

  # bless({
  #   ...,
  #   "context"  => "(eval)",
  #   "message"  => "Exception!",
  # }, "Main::Error")

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Main::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';
  ok $error->context;

  $result
});

=example-2 error

  # given: synopsis;

  my $error = $throw->error({
    message => 'Something failed!',
    context => 'Test.error',
  });

  # bless({
  #   ...,
  #   "context"  => "Test.error",
  #   "message"  => "Something failed!",
  # }, "Main::Error")

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Main::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Something failed!';
  ok $error->context eq 'Test.error';

  $result
});

=example-3 error

  package main;

  use Venus::Throw;

  my $throw = Venus::Throw->new('Example::Error');

  my $error = $throw->error;

  # bless({
  #   ...,
  #   "context"  => "(eval)",
  #   "message"  => "Exception!",
  # }, "Example::Error")

=cut

$test->for('example', 3, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Example::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';
  ok $error->context eq '(eval)';

  $result
});

=example-4 error

  package main;

  use Venus::Throw;

  my $throw = Venus::Throw->new(
    package => 'Example::Error',
    parent => 'Venus::Error',
  );

  my $error = $throw->error({
    message => 'Example error!',
  });

  # bless({
  #   ...,
  #   "context"  => "(eval)",
  #   "message"  => "Example error!",
  # }, "Example::Error")

=cut

$test->for('example', 4, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Example::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Example error!';
  ok $error->context eq '(eval)';

  $result
});

=example-5 error

  package Example::Error;

  use base 'Venus::Error';

  package main;

  use Venus::Throw;

  my $throw = Venus::Throw->new(
    package => 'Example::Error::Unknown',
    parent => 'Example::Error',
  );

  my $error = $throw->error({
    message => 'Example error (unknown)!',
  });

  # bless({
  #   ...,
  #   "context"  => "(eval)",
  #   "message"  => "Example error (unknown)!",
  # }, "Example::Error::Unknown")

=cut

$test->for('example', 5, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Example::Error::Unknown');
  ok $error->isa('Example::Error');
  ok $error->message eq 'Example error (unknown)!';
  ok $error->context eq '(eval)';

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

$test->render('lib/Venus/Throw.pod') if $ENV{RENDER};

ok 1 and done_testing;