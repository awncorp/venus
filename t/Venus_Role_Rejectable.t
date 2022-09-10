package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Rejectable

=cut

$test->for('name');

=tagline

Rejectable Role

=cut

$test->for('tagline');

=abstract

Rejectable Role for Perl 5

=cut

$test->for('abstract');

=synopsis

  package ExampleAccept;

  use Venus::Class 'attr';

  attr 'name';

  package ExampleReject;

  use Venus::Class 'attr', 'with';

  with 'Venus::Role::Rejectable';

  attr 'name';

  package main;

  my $example = ExampleReject->new(name => 'example', test => 12345);

  # bless({name => 'example'}, "Example")

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('ExampleReject');
  ok $result->does('Venus::Role::Rejectable');
  is $result->{name}, 'example';
  ok !exists $result->{test};
  my $example = ExampleAccept->new(name => 'example', test => 12345);
  ok $example->isa('ExampleAccept');
  ok !$example->does('Venus::Role::Rejectable');
  is $example->{name}, 'example';
  is $example->{test}, 12345;

  $result
});

=description

This package provides a mechanism for rejecting unexpected constructor arguments.

=cut

$test->for('description');

# END

$test->render('lib/Venus/Role/Rejectable.pod') if $ENV{RENDER};

ok 1 and done_testing;
