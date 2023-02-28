package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Valuable

=cut

$test->for('name');

=tagline

Valuable Role

=cut

$test->for('tagline');

=abstract

Valuable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: default
method: get
method: set

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Valuable';

  package main;

  my $example = Example->new;

  # $example->value;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Valuable');

  $result
});

=description

This package modifies the consuming package and provides a C<value> attribute
which defaults to what's returned by the C<default> method, as well as C<get>
and C<set> methods for modifying the value.

=cut

$test->for('description');

=attributes

value: rw, opt, Any

=cut

$test->for('attributes');

=method default

The default method returns the default value, i.e. C<undef>.

=signature default

  default() (Any)

=metadata default

{
  since => '0.01',
}

=example-1 default

  package main;

  my $example = Example->new;

  my $default = $example->default;

  # undef

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method get

The get method gets and returns the value.

=signature get

  get() (Any)

=metadata get

{
  since => '0.01',
}

=example-1 get

  package main;

  my $example = Example->new(value => 'hey, there');

  my $get = $example->get;

  # "hey, there"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hey, there";

  $result
});

=method set

The set method set the value and returns the value set.

=signature set

  set(Any $value) (Any)

=metadata set

{
  since => '0.01',
}

=example-1 set

  package main;

  my $example = Example->new(value => 'hey, there');

  my $set = $example->set('hi, there');

  # "hi, there"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hi, there";

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Valuable.pod') if $ENV{RENDER};

ok 1 and done_testing;