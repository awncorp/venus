package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Coercion

=cut

$test->for('name');

=tagline

Coercion Class

=cut

$test->for('tagline');

=abstract

Coercion Class for Perl 5

=cut

$test->for('abstract');

=includes

method: accept
method: check
method: clear
method: eval
method: evaler
method: format
method: result

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Coercion;

  my $coercion = Venus::Coercion->new;

  # $coercion->accept('float');

  # $coercion->format(sub{sprintf '%.2f', $_});

  # $coercion->result(123.456);

  # 123.46

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Coercion');
  ok $result->accept('float');
  ok $result->format(sub{sprintf '%.2f', $_});;
  is $result->result(123.456), 123.46;

  $result
});

=description

This package provides a mechanism for evaluating type coercions on data.
Built-in type coercions are handled via L<Venus::Check>.

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

  accept(string $name, any @args) (Venus::Coercion)

=metadata accept

{
  since => '3.55',
}

=example-1 accept

  # given: synopsis

  package main;

  $coercion = $coercion->accept('float');

  # bless(..., "Venus::Coercion")

  # $coercion->result;

  # undef

  # $coercion->result(1.01);

  # 1.01

=cut

$test->for('example', 1, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, undef;
  is $result->result(1), 1;
  is $result->result(1.01), 1.01;

  $result
});

=example-2 accept

  # given: synopsis

  package main;

  $coercion = $coercion->accept('number');

  # bless(..., "Venus::Coercion")

  # $coercion->result(1.01);

  # 1.01

  # $coercion->result(1_01);

  # 101

=cut

$test->for('example', 2, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, undef;
  is $result->result(1.01), 1.01;
  is $result->result(1_01), 101;

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

  $coercion = $coercion->accept('object');

  # bless(..., "Venus::Coercion")

  # $coercion->result;

  # undef

  # $coercion->result(qr//);

  # qr//

  # $coercion->result(Example1->new);

  # bless(..., "Example1")

  # $coercion->result(Example2->new);

  # bless(..., "Example2")

=cut

$test->for('example', 3, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, undef;
  is $result->result(qr//), qr//;
  isa_ok $result->result(Example1->new), 'Example1';
  isa_ok $result->result(Example2->new), 'Example2';

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

  $coercion = $coercion->accept('Example1');

  # bless(..., "Venus::Coercion")

  # $coercion->result;

  # undef

  # $coercion->result(qr//);

  # qr//

  # $coercion->result(Example1->new);

  # bless(..., "Example1")

  # $coercion->result(Example2->new);

  # bless(..., "Example2")

=cut

$test->for('example', 4, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->result, undef;
  is $result->result(qr//), qr//;
  isa_ok $result->result(Example1->new), 'Example1';
  isa_ok $result->result(Example2->new), 'Example2';

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

  my $check = $coercion->check(Venus::Check->new);

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

  $coercion->check(Venus::Check->new);

  my $check = $coercion->check;

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

  clear() (Venus::Coercion)

=metadata clear

{
  since => '3.55',
}

=cut

=example-1 clear

  # given: synopsis

  package main;

  $coercion->accept('string');

  $coercion = $coercion->clear;

  # bless(..., "Venus::Coercion")

=cut

$test->for('example', 1, 'clear', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Coercion');
  is_deeply $result->check->on_eval, [];
  is_deeply $result->on_eval, [];

  $result
});

=method eval

The eval method dispatches to the L</check> object as well as evaluating any
custom conditions, and returns the coerced value if all conditions pass, and
the original value if any condition fails.

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

  use Venus::Float;

  $coercion->accept('float');

  $coercion->format(sub{Venus::Float->new($_)});

  my $eval = $coercion->eval('1.00');

  # bless(..., "Venus::Float")

=cut

$test->for('example', 1, 'eval', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  ok $result->isa('Venus::Float');
  is $result->value, '1.00';

  $result
});

=example-2 eval

  # given: synopsis

  package main;

  use Venus::Float;

  $coercion->accept('float');

  $coercion->format(sub{Venus::Float->new($_)});

  my $eval = $coercion->eval(1_00);

  # 100

=cut

$test->for('example', 2, 'eval', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 100;

  $result
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

  my $evaler = $coercion->evaler;

  # sub{...}

  # my $result = $evaler->();

  # undef

=cut

$test->for('example', 1, 'evaler', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  ok ref $result eq 'CODE';
  is $result->(), undef;

  $result
});

=example-2 evaler

  # given: synopsis

  package main;

  my $evaler = $coercion->accept('any')->evaler;

  # sub{...}

  # my $result = $evaler->('hello');

  # "hello"

=cut

$test->for('example', 2, 'evaler', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  ok ref $result eq 'CODE';
  is $result->('hello'), 'hello';

  $result
});

=method format

The format method registers a custom (not built-in) coercion condition and
returns the invocant.

=signature format

  format(coderef $code) (Venus::Coercion)

=metadata format

{
  since => '3.55',
}

=cut

=example-1 format

  # given: synopsis

  package main;

  $coercion->accept('either', 'float', 'number');

  my $format = $coercion->format(sub {
    int $_
  });

  # bless(.., "Venus::Coercion")

=cut

$test->for('example', 1, 'format', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Coercion";
  is $result->eval(0), 0;
  is $result->eval(1), 1;
  is $result->eval(-1), -1;
  is $result->eval(123.45), 123;

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

  $coercion->accept('float');

  $coercion->format(sub{int $_});

  my $result = $coercion->result('1.00');

  # 1

=cut

$test->for('example', 1, 'result', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 result

  # given: synopsis

  package main;

  $coercion->accept('float');

  $coercion->format(sub{int $_});

  my $result = $coercion->result('0.99');

  # 0

=cut

$test->for('example', 2, 'result', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Coercion.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
