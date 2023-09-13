package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Testable

=cut

$test->for('name');

=tagline

Testable Role

=cut

$test->for('tagline');

=abstract

Testable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: is_false
method: is_true

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Testable';

  attr 'value';

  sub execute {
    return pop;
  }

  package main;

  my $example = Example->new;

  # $example->is_true(sub{0});

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Testable');

  $result
});

=description

This package modifies the consuming package and provides methods for
dispatching method calls and returning truthy returns as true and falsy returns
as false boolean values.

=cut

$test->for('description');

=method is_false

The is_false method dispatches the method call or executes the callback and
returns truthy returns as C<false> and falsy returns as C<true>
L<"boolean"|Venus::Boolean> values.

=signature is_false

  is_false(string | coderef $method, any @args) (boolean)

=metadata is_false

{
  since => '0.08',
}

=example-1 is_false

  package main;

  my $example = Example->new;

  my $true = $example->is_false(execute => 0);

  # 1

=cut

$test->for('example', 1, 'is_false', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 is_false

  package main;

  my $example = Example->new;

  my $true = $example->is_false(sub{0});

  # 1

=cut

$test->for('example', 2, 'is_false', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_false

  package main;

  my $example = Example->new;

  my $false = $example->is_false(execute => 1);

  # 0

=cut

$test->for('example', 3, 'is_false', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method is_true

The is_true method dispatches the method call or executes the callback and
returns truthy returns as C<true> and falsy returns as C<false>
L<"boolean"|Venus::Boolean> values.

=signature is_true

  is_true(string | coderef $method, any @args) (boolean)

=metadata is_true

{
  since => '0.08',
}

=example-1 is_true

  package main;

  my $example = Example->new;

  my $true = $example->is_true(execute => 1);

  # 1

=cut

$test->for('example', 1, 'is_true', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 is_true

  package main;

  my $example = Example->new;

  my $true = $example->is_true(sub{1});

  # 1

=cut

$test->for('example', 2, 'is_true', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_true

  package main;

  my $example = Example->new;

  my $false = $example->is_true(execute => 0);

  # 0

=cut

$test->for('example', 3, 'is_true', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Testable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
