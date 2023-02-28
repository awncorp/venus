package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Role::Deferrable

=cut

$test->for('name');

=tagline

Deferrable Role

=cut

$test->for('tagline');

=abstract

Deferrable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: defer

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Deferrable';

  sub test {
    my ($self, @args) = @_;

    return $self->okay(@args);
  }

  sub okay {
    my ($self, @args) = @_;

    return [@args];
  }

  package main;

  my $example = Example->new;

  # my $code = $example->defer('test');

  # sub {...}

  # $code->();

  # [...]

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Deferrable');
  ok $result->can('defer');
  my $return = $result->defer('test');
  is_deeply $return->(), [];

  $result
});

=description

This package provides a mechanism for returning callbacks (i.e. closures) that
dispatches method calls.

=cut

$test->for('description');

=method defer

The defer method returns the named method as a callback (i.e. closure) which
dispatches to the method call specified.

=signature defer

  defer(Str $method, Any @args) (CodeRef)

=metadata defer

{
  since => '1.80',
}

=example-1 defer

  # given: synopsis

  package main;

  $example = Example->new;

  # bless({}, 'Example1')

  # my $result = $example->defer('test', 1..4);

  # $result->();

  # [1..4]

=cut

$test->for('example', 1, 'defer', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Deferrable');
  is_deeply $result->defer('test', 1..4)->(), [1..4];

  $result
});

=example-2 defer

  # given: synopsis

  package main;

  $example = Example->new;

  # bless({}, 'Example1')

  # my $result = $example->defer('test', 1..4);

  # $result->(1..4);

  # [1..4, 1..4]

=cut

$test->for('example', 1, 'defer', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Deferrable');
  is_deeply $result->defer('test', 1..4)->(1..4), [1..4, 1..4];

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Deferrable.pod') if $ENV{RENDER};

ok 1 and done_testing;
