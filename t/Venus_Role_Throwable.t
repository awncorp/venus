package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Throwable

=cut

$test->for('name');

=tagline

Throwable Role

=cut

$test->for('tagline');

=abstract

Throwable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: throw

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Throwable';

  package main;

  my $example = Example->new;

  # $example->throw;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Throwable');

  $result
});

=description

This package modifies the consuming package and provides a mechanism for
throwing context-aware errors (exceptions).

=cut

$test->for('description');

=method throw

The throw method builds a L<Venus::Throw> object, which can raise errors
(exceptions).

=signature throw

  throw(Maybe[Str | HashRef] $data) (Throw)

=metadata throw

{
  since => '0.01',
}

=example-1 throw

  package main;

  my $example = Example->new;

  my $throw = $example->throw;

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 1, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';

  $result
});

=example-2 throw

  package main;

  my $example = Example->new;

  my $throw = $example->throw('Example::Error::Unknown');

  # bless({ "package" => "Example::Error::Unknown", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 2, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error::Unknown';

  $result
});

=example-3 throw

  package main;

  my $example = Example->new;

  my $throw = $example->throw({
    name => 'on.example',
    capture => [$example],
    stash => {
      time => time,
    },
  });

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 3, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';
  is $result->name, 'on.example';
  ok $result->stash('captured');
  ok $result->stash('time');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Throwable.pod') if $ENV{RENDER};

ok 1 and done_testing;