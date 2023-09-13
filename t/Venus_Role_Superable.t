package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Superable

=cut

$test->for('name');

=tagline

Superable Role

=cut

$test->for('tagline');

=abstract

Superable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: super

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Superable';

  package main;

  my $example = Example->new;

  # $example->super;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Superable');

  require Venus::Space;
  Venus::Space->new('Example')->unload;

  $result
});

=description

This package modifies the consuming package and provides methods for
dispatching to superclasses using L<mro/next::method>.

=cut

$test->for('description');

=method super

The super method dispatches to superclasses uses the C3 method resolution order
to get better consistency in multiple inheritance situations.

=signature super

  super(any @args) (any)

=metadata super

{
  since => '3.55',
}

=example-1 super

  package Example::A;

  use Venus::Class;

  sub test {
    my ($self, @args) = @_;

    return [$self, @args];
  }

  package Example::B;

  use Venus::Class;

  base 'Example::A';

  with 'Venus::Role::Superable';

  sub test {
    my ($self) = @_;

    return $self->super(1..4);
  }

  package main;

  my $example = Example::B->new;

  my $result = $example->test;

=cut

$test->for('example', 1, 'super', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok defined $result;
  is 0+@{$result}, 5;
  is ref $result->[0], 'Example::B';
  is $result->[1], 1;
  is $result->[2], 2;
  is $result->[3], 3;
  is $result->[4], 4;

  require Venus::Space;
  Venus::Space->new('Example::A')->unload;
  Venus::Space->new('Example::B')->unload;

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Superable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
