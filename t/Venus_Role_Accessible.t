package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Accessible

=cut

$test->for('name');

=tagline

Accessible Role

=cut

$test->for('tagline');

=abstract

Accessible Role for Perl 5

=cut

$test->for('abstract');

=includes

method: access
method: assign

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Accessible';

  attr 'value';

  sub downcase {
    lc $_[0]->value
  }

  sub upcase {
    uc $_[0]->value
  }

  package main;

  my $example = Example->new(value => 'hello, there');

  # $example->value;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Accessible');
  ok $result->value eq 'hello, there';

  $result
});

=description

This package modifies the consuming package and provides the C<access> method
for getting and setting attributes.

=cut

$test->for('description');

=method access

The access method gets or sets the class attribute specified.

=signature access

  access(Str $name, Any $value) (Any)

=metadata access

{
  since => '1.23',
}

=example-1 access

  # given: synopsis

  package main;

  my $access = $example->access;

  # undef

=cut

$test->for('example', 1, 'access', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 access

  # given: synopsis

  package main;

  my $access = $example->access('value');

  # "hello, there"

=cut

$test->for('example', 2, 'access', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello, there';

  $result
});

=example-3 access

  # given: synopsis

  package main;

  my $access = $example->access('value', 'something');

  # "something"

=cut

$test->for('example', 3, 'access', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'something';

  $result
});

=example-4 access

  # given: synopsis

  package main;

  my $instance = $example;

  # bless({}, "Example")

  $example->access('value', 'something');

  # "something"

  $instance = $example;

  # bless({value => "something"}, "Example")

=cut

$test->for('example', 4, 'access', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->value eq 'something';
  ok $result->access('value') eq 'something';
  ok $result->access('value', 'anything') eq 'anything';
  ok $result->value eq 'anything';

  $result
});

=method assign

The assign method dispatches the method call or executes the callback, sets the
class attribute specified to the result, and returns the result.

=signature assign

  assign(Str $name, Str | CodeRef $code, Any @args) (Any)

=metadata assign

{
  since => '1.23',
}

=example-1 assign

  # given: synopsis

  package main;

  my $assign = $example->assign('value', 'downcase');

  # "hello, there"

=cut

$test->for('example', 1, 'assign', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello, there";

  $result
});

=example-2 assign

  # given: synopsis

  package main;

  my $assign = $example->assign('value', 'upcase');

  # "HELLO, THERE"

=cut

$test->for('example', 2, 'assign', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HELLO, THERE";

  $result
});

=example-3 assign

  # given: synopsis

  package main;

  my $instance = $example;

  # bless({value => "hello, there"}, "Example")

  my $assign = $example->assign('value', 'downcase');

  # "hello, there"

  $instance = $example;

  # bless({value => "hello, there"}, "Example")

=cut

$test->for('example', 3, 'assign', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->value eq 'hello, there';
  ok $result->assign('value', 'upcase') eq 'HELLO, THERE';
  ok $result->value eq 'HELLO, THERE';

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Accessible.pod') if $ENV{RENDER};

ok 1 and done_testing;