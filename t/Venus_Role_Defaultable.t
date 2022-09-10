package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Defaultable

=cut

$test->for('name');

=tagline

Defaultable Role

=cut

$test->for('tagline');

=abstract

Defaultable Role for Perl 5

=cut

$test->for('abstract');

=synopsis

  package Example;

  use Venus::Class 'attr', 'with';

  with 'Venus::Role::Defaultable';

  attr 'name';

  sub defaults {
    {
      name => 'example',
    }
  }

  package main;

  my $example = Example->new;

  # bless({name => 'example'}, "Example")

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Defaultable');
  is $result->{name}, 'example';
  my $example = Example->new(name => 'another_example');
  ok $example->isa('Example');
  ok $example->does('Venus::Role::Defaultable');
  is $example->{name}, 'another_example';

  $result
});

=description

This package provides a mechanism for setting default values for missing
constructor arguments.

=cut

$test->for('description');

# END

$test->render('lib/Venus/Role/Defaultable.pod') if $ENV{RENDER};

ok 1 and done_testing;
