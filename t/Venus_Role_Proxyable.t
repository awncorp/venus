package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Proxyable

=cut

$test->for('name');

=tagline

Proxyable Role

=cut

$test->for('tagline');

=abstract

Proxyable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: build_proxy

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Proxyable';

  attr 'test';

  sub build_proxy {
    my ($self, $package, $method, @args) = @_;
    return sub { [$self, $package, $method, @args] } if $method eq 'anything';
    return undef;
  }

  package main;

  my $example = Example->new(test => time);

  # $example->anything(1..4);

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Proxyable');
  my $returned = $result->anything(1..4);
  ok $returned->[0]->isa('Example');
  ok $returned->[1] eq 'Example';
  ok $returned->[2] eq 'anything';
  ok $returned->[3] == 1;
  ok $returned->[4] == 2;
  ok $returned->[5] == 3;
  ok $returned->[6] == 4;

  $result
});

=description

This package provides a hook into method dispatch resoluton via a wrapper
around the C<AUTOLOAD> routine which processes calls to routines which don't
exist.

=cut

$test->for('description');

=method build_proxy

The build_proxy method should return a code reference to fulfill the method
dispatching request, or undef to result in a method not found error.

=signature build_proxy

  build_proxy(Str $package, Str $method, Any @args) (CodeRef | Undef)

=metadata build_proxy

{
  since => '0.01',
}

=example-1 build_proxy

  package main;

  my $example = Example->new(test => 123);

  my $build_proxy = $example->build_proxy('Example', 'everything', 1..4);

  # undef

=cut

$test->for('example', 1, 'build_proxy', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=example-2 build_proxy

  package main;

  my $example = Example->new(test => 123);

  my $build_proxy = $example->build_proxy('Example', 'anything', 1..4);

  # sub { ... }

=cut

$test->for('example', 2, 'build_proxy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref($result) eq 'CODE';
  my $returned = $result->(1..4);
  ok $returned->[0]->isa('Example');
  ok $returned->[1] eq 'Example';
  ok $returned->[2] eq 'anything';
  ok $returned->[3] == 1;
  ok $returned->[4] == 2;
  ok $returned->[5] == 3;
  ok $returned->[6] == 4;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Proxyable.pod') if $ENV{RENDER};

ok 1 and done_testing;