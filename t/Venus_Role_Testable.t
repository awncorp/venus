package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

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

method: isfalse
method: istrue

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Testable';

  has 'value';

  sub execute {
    return pop;
  }

  package main;

  my $example = Example->new;

  # $example->istrue(sub{0});

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

=method isfalse

The isfalse method dispatches the method call or executes the callback and
returns truthy returns as C<false> and falsy returns as C<true>
L<"boolean"|Venus::Boolean> values.

=signature isfalse

  isfalse(Str | CodeRef $method, Any @args) (Bool)

=metadata isfalse

{
  since => '0.08',
}

=example-1 isfalse

  package main;

  my $example = Example->new;

  my $true = $example->isfalse(execute => 0);

  # 1

=cut

$test->for('example', 1, 'isfalse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 isfalse

  package main;

  my $example = Example->new;

  my $true = $example->isfalse(sub{0});

  # 1

=cut

$test->for('example', 2, 'isfalse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 isfalse

  package main;

  my $example = Example->new;

  my $false = $example->isfalse(execute => 1);

  # 0

=cut

$test->for('example', 3, 'isfalse', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method istrue

The istrue method dispatches the method call or executes the callback and
returns truthy returns as C<true> and falsy returns as C<false>
L<"boolean"|Venus::Boolean> values.

=signature istrue

  istrue(Str | CodeRef $method, Any @args) (Bool)

=metadata istrue

{
  since => '0.08',
}

=example-1 istrue

  package main;

  my $example = Example->new;

  my $true = $example->istrue(execute => 1);

  # 1

=cut

$test->for('example', 1, 'istrue', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 istrue

  package main;

  my $example = Example->new;

  my $true = $example->istrue(sub{1});

  # 1

=cut

$test->for('example', 2, 'istrue', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 istrue

  package main;

  my $example = Example->new;

  my $false = $example->istrue(execute => 0);

  # 0

=cut

$test->for('example', 3, 'istrue', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Role/Testable.pod') if $ENV{RENDER};

ok 1 and done_testing;
