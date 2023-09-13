package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Role::Mockable

=cut

$test->for('name');

=tagline

Mockable Role

=cut

$test->for('tagline');

=abstract

Mockable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: mock

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class 'with';

  with 'Venus::Role::Mockable';

  sub execute {
    [1..4];
  }

  package main;

  my $example = Example->new;

  # my $mock = $example->mock(execute => sub {
  #   my ($next) = @_;
  #
  #   return sub {
  #     [@{$next->()}, @_]
  #   }
  # });

  # sub { ... }

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Mockable');
  ok $result->can('mock');
  is_deeply $result->execute, [1..4];

  $result
});

=description

This package provides a mechanism for mocking subroutines.

=cut

$test->for('description');

=method mock

The mock method mocks the subroutine specified using the callback given. The
coderef provided will be passed the original subroutine coderef as its first
argument. The coderef provided should always return a coderef that will serve
as the subroutine mock.

=signature mock

  mock(string $name, coderef $code) (coderef)

=metadata mock

{
  since => '2.32',
}

=example-1 mock

  package main;

  my $example = Example->new;

  my $mock = $example->mock(execute => sub {
    my ($next) = @_;

    return sub {
      [@{$next->()}, @_]
    }
  });

  # sub { ... }

  # $example->execute;

  # [1..4]

  # $example->execute(5, 6);

  # [1..6]

=cut

$test->for('example', 1, 'mock', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref $result eq 'CODE';
  is_deeply $result->(), [1..4];
  is_deeply $result->(5, 6), [1..6];

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Mockable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
