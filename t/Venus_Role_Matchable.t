package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Matchable

=cut

$test->for('name');

=tagline

Matchable Role

=cut

$test->for('tagline');

=abstract

Matchable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: match

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Matchable';

  attr 'active';

  sub validate {
    my ($self) = @_;

    return $self->match->when('active')->then(true)->none(false);
  }

  package main;

  my $example = Example->new;

  # $example->validate->result;

  # 0

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Matchable');
  is $result->validate->result, 0;

  $result
});

=description

This package modifies the consuming package and provides a mechanism for
assembling complex pattern matching operations.

=cut

$test->for('description');

=method match

The match method returns a L<Venus::Match> object having the match value set to
the invocant or the result of a dispatch. This method supports dispatching,
i.e. providing a method name and arguments whose return value will be acted on
by this method.

=signature match

  match(Str | CodeRef $method, Any @args) (Match)

=metadata match

{
  since => '0.04',
}

=example-1 match

  package main;

  my $example = Example->new;

  my $match = $example->match;

  # bless({..., value => bless(..., 'Example')}, 'Venus::Match')

=cut

$test->for('example', 1, 'match', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');
  ok $result->value->isa('Example');

  $result
});

=example-2 match

  package main;

  my $example = Example->new;

  my $match = $example->match('active');

  # bless({..., value => undef}, 'Venus::Match')

=cut

$test->for('example', 2, 'match', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');
  ok !defined $result->value;

  $result
});

=example-3 match

  package main;

  my $example = Example->new(active => 1);

  my $match = $example->match('active');

  # bless({..., value => 1}, 'Venus::Match')

=cut

$test->for('example', 3, 'match', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');
  is $result->value, 1;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Matchable.pod') if $ENV{RENDER};

ok 1 and done_testing;
