package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Constraint

=cut

$test->for('name');

=tagline

Constraint Class

=cut

$test->for('tagline');

=abstract

Constraint Class for Perl 5

=cut

$test->for('abstract');

=includes

method: accept
method: check
method: clear
method: ensure
method: eval
method: evaler
method: result

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Constraint;

  my $constraint = Venus::Constraint->new;

  # $constraint->accept('float');

  # $constraint->ensure(sub{$_ > 1});

  # $constraint->result(1.01);

  # true

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Constraint');
  ok $result->accept('float');
  ok $result->ensure(sub{$_ > 1});
  is $result->result(1.01), true;

  $result
});

=description

This package provides a mechanism for evaluating type constraints on data.
Built-in type constraints are handled via L<Venus::Check>.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable

=cut

$test->for('integrates');

=method accept

The accept method registers a condition via L</check> based on the arguments
provided. The built-in types are defined as methods in L<Venus::Check>.

=signature accept

  accept(string $name, any @args) (Venus::Constraint)

=metadata accept

{
  since => '3.55',
}

=example-1 accept

  # given: synopsis

  package main;

  $constraint = $constraint->accept('float');

  # bless(..., "Venus::Constraint")

  # $constraint->result;

  # false

  # $constraint->result(1.01);

  # true

=cut

$test->for('example', 1, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, 0;
  is $result->result(1), 0;
  is $result->result(1.01), 1;

  $result
});

=example-2 accept

  # given: synopsis

  package main;

  $constraint = $constraint->accept('number');

  # bless(..., "Venus::Constraint")

  # $constraint->result(1.01);

  # false

  # $constraint->result(1_01);

  # true

=cut

$test->for('example', 2, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, 0;
  is $result->result(1.01), 0;
  is $result->result(1_01), 1;

  $result
});

=example-3 accept

  # given: synopsis

  package Example1;

  sub new {
    bless {};
  }

  package Example2;

  sub new {
    bless {};
  }

  package main;

  $constraint = $constraint->accept('object');

  # bless(..., "Venus::Constraint")

  # $constraint->result;

  # false

  # $constraint->result(qr//);

  # false

  # $constraint->result(Example1->new);

  # true

  # $constraint->result(Example2->new);

  # true

=cut

$test->for('example', 3, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, 0;
  is $result->result(qr//), 0;
  is $result->result(Example1->new), 1;
  is $result->result(Example2->new), 1;

  require Venus::Space;
  Venus::Space->new('Example1')->unload;
  Venus::Space->new('Example2')->unload;

  $result
});

=example-4 accept

  # given: synopsis

  package Example1;

  sub new {
    bless {};
  }

  package Example2;

  sub new {
    bless {};
  }

  package main;

  $constraint = $constraint->accept('Example1');

  # bless(..., "Venus::Constraint")

  # $constraint->result;

  # false

  # $constraint->result(qr//);

  # false

  # $constraint->result(Example1->new);

  # true

  # $constraint->result(Example2->new);

  # false

=cut

$test->for('example', 4, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, 0;
  is $result->result(qr//), 0;
  is $result->result(Example1->new), 1;
  is $result->result(Example2->new), 0;

  require Venus::Space;
  Venus::Space->new('Example1')->unload;
  Venus::Space->new('Example2')->unload;

  $result
});

=method check

The check method gets or sets the L<Venus::Check> object used for performing
runtime data type validation.

=signature check

  check(Venus::Check $data) (Venus::Check)

=metadata check

{
  since => '3.55',
}

=cut

=example-1 check

  # given: synopsis

  package main;

  my $check = $constraint->check(Venus::Check->new);

  # bless(..., 'Venus::Check')

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Check');

  $result
});

=example-2 check

  # given: synopsis

  package main;

  $constraint->check(Venus::Check->new);

  my $check = $constraint->check;

  # bless(..., 'Venus::Check')

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Check');

  $result
});

=method clear

The clear method resets the L</check> attributes and returns the invocant.

=signature clear

  clear() (Venus::Constraint)

=metadata clear

{
  since => '3.55',
}

=cut

=example-1 clear

  # given: synopsis

  package main;

  $constraint->accept('string');

  $constraint = $constraint->clear;

  # bless(..., "Venus::Constraint")

=cut

$test->for('example', 1, 'clear', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Constraint');
  is_deeply $result->check->on_eval, [];
  is_deeply $result->on_eval, [];

  $result
});

=method ensure

The ensure method registers a custom (not built-in) constraint condition and
returns the invocant.

=signature ensure

  ensure(coderef $code) (Venus::Constraint)

=metadata ensure

{
  since => '3.55',
}

=cut

=example-1 ensure

  # given: synopsis

  package main;

  $constraint->accept('number');

  my $ensure = $constraint->ensure(sub {
    $_ >= 0
  });

  # bless(.., "Venus::Constraint")

=cut

$test->for('example', 1, 'ensure', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Constraint";
  is $result->eval(0), true;
  is $result->eval(1), true;
  is $result->eval(-1), false;

  $result
});

=example-2 ensure

  # given: synopsis

  package main;

  $constraint->accept('number');

  my $ensure = $constraint->ensure(sub {
    my ($source, $value) = @_;

    if ($value >= 0) {
      return 1;
    }
    else {
      return 0;
    }
  });

  # bless(..., "Venus::Constraint")

=cut

$test->for('example', 2, 'ensure', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Constraint";
  is $result->eval(0), true;
  is $result->eval(1), true;
  is $result->eval(-1), false;

  $result
});

=method eval

The eval method dispatches to the L</check> object as well as evaluating any
custom conditions, and returns true if all conditions pass, and false if any
condition fails.

=signature eval

  eval(any $data) (boolean)

=metadata eval

{
  since => '3.55',
}

=cut

=example-1 eval

  # given: synopsis

  package main;

  $constraint->accept('float');

  $constraint->ensure(sub{$_ >= 1});

  my $eval = $constraint->eval('1.00');

  # true

=cut

$test->for('example', 1, 'eval', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 eval

  # given: synopsis

  package main;

  $constraint->accept('float');

  $constraint->ensure(sub{$_ >= 1});

  my $eval = $constraint->eval('0.99');

  # false

=cut

$test->for('example', 2, 'eval', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=method evaler

The evaler method returns a coderef which calls the L</eval> method with the
invocant when called.

=signature evaler

  evaler(any @args) (coderef)

=metadata evaler

{
  since => '3.55',
}

=example-1 evaler

  # given: synopsis

  package main;

  my $evaler = $constraint->evaler;

  # sub{...}

  # my $result = $evaler->();

  # false

=cut

$test->for('example', 1, 'evaler', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  ok ref $result eq 'CODE';
  is $result->(), false;

  $result
});

=example-2 evaler

  # given: synopsis

  package main;

  my $evaler = $constraint->accept('any')->evaler;

  # sub{...}

  # my $result = $evaler->();

  # true

=cut

$test->for('example', 2, 'evaler', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  ok ref $result eq 'CODE';
  is $result->(), true;

  $result
});

=method result

The result method dispatches to the L</eval> method and returns the result.

=signature result

  result(any $data) (boolean)

=metadata result

{
  since => '3.55',
}

=cut

=example-1 result

  # given: synopsis

  package main;

  $constraint->accept('float');

  $constraint->ensure(sub{$_ >= 1});

  my $result = $constraint->result('1.00');

  # true

=cut

$test->for('example', 1, 'result', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 result

  # given: synopsis

  package main;

  $constraint->accept('float');

  $constraint->ensure(sub{$_ >= 1});

  my $result = $constraint->result('0.99');

  # false

=cut

$test->for('example', 2, 'result', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Constraint.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
