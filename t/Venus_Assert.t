package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Assert

=cut

$test->for('name');

=tagline

Assert Class

=cut

$test->for('tagline');

=abstract

Assert Class for Perl 5

=cut

$test->for('abstract');

=includes

method: accept
method: check
method: clear
method: coerce
method: coercion
method: conditions
method: constraint
method: ensure
method: expression
method: format
method: parse
method: render
method: result
method: valid
method: validate
method: validator

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Assert;

  my $assert = Venus::Assert->new('Float');

  # $assert->accept('float');

  # $assert->format(sub{sprintf('%.2f', $_)});

  # $assert->result(123.456);

  # 123.46

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=description

This package provides a mechanism for asserting type constraints and coercions
on data. Type constraints are handled via L<Venus::Constraint>, and coercions
are handled via L<Venus::Coercion>, using L<Venus::Check> to perform data type
validations.

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

=attribute name

The name attribute is read-write, accepts C<(string)> values, and is
optional.

=signature name

  name(string $data) (string)

=metadata name

{
  since => '1.40',
}

=cut

=example-1 name

  # given: synopsis

  package main;

  my $set_name = $assert->name("Example");

  # "Example"

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Example";

  $result
});

=example-2 name

  # given: synopsis

  # given: example-1 name

  package main;

  my $get_name = $assert->name;

  # "Example"

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Example";

  $result
});

=method accept

The accept method registers a condition via L</check> based on the arguments
provided. The built-in types are defined as methods in L<Venus::Check>.

=signature accept

  accept(string $name, any @args) (Venus::Assert)

=metadata accept

{
  since => '1.40',
}

=example-1 accept

  # given: synopsis

  package main;

  $assert = $assert->accept('float');

  # bless(..., "Venus::Assert")

  # $assert->valid;

  # false

  # $assert->valid(1.01);

  # true

=cut

$test->for('example', 1, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->valid, 0;
  is $result->valid(1), 0;
  is $result->valid(1.01), 1;

  $result
});

=example-2 accept

  # given: synopsis

  package main;

  $assert = $assert->accept('number');

  # bless(..., "Venus::Assert")

  # $assert->valid(1.01);

  # false

  # $assert->valid(1_01);

  # true

=cut

$test->for('example', 2, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->valid, 0;
  is $result->valid(1.01), 0;
  is $result->valid(1_01), 1;

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

  $assert = $assert->accept('object');

  # bless(..., "Venus::Assert")

  # $assert->valid;

  # false

  # $assert->valid(qr//);

  # false

  # $assert->valid(Example1->new);

  # true

  # $assert->valid(Example2->new);

  # true

=cut

$test->for('example', 3, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->valid, 0;
  is $result->valid(qr//), 0;
  is $result->valid(Example1->new), 1;
  is $result->valid(Example2->new), 1;

  require Venus::Space;
  Venus::Space->new('Example')->unload;

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

  $assert = $assert->accept('Example1');

  # bless(..., "Venus::Assert")

  # $assert->valid;

  # false

  # $assert->valid(qr//);

  # false

  # $assert->valid(Example1->new);

  # true

  # $assert->valid(Example2->new);

  # false

=cut

$test->for('example', 4, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->valid, 0;
  is $result->valid(qr//), 0;
  is $result->valid(Example1->new), 1;
  is $result->valid(Example2->new), 0;

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

  my $check = $assert->check(Venus::Check->new);

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

  $assert->check(Venus::Check->new);

  my $check = $assert->check;

  # bless(..., 'Venus::Check')

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Check');

  $result
});

=method clear

The clear method resets the L</check>, L</constraint>, and L</coercion>
attributes and returns the invocant.

=signature clear

  clear() (Venus::Assert)

=metadata clear

{
  since => '1.40',
}

=cut

=example-1 clear

  # given: synopsis

  package main;

  $assert->accept('string');

  $assert = $assert->clear;

  # bless(..., "Venus::Assert")

=cut

$test->for('example', 1, 'clear', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is_deeply $result->check->on_eval, [];
  is_deeply $result->constraint->on_eval, [];
  is_deeply $result->coercion->on_eval, [];

  $result
});

=method coerce

The coerce method dispatches to the L</coercion> object and returns the result
of the L<Venus::Coercion/result> operation.

=signature coerce

  coerce(any $data) (any)

=metadata coerce

{
  since => '3.55',
}

=cut

=example-1 coerce

  # given: synopsis

  package main;

  $assert->accept('float');

  $assert->format(sub{sprintf('%.2f', $_)});

  my $coerce = $assert->coerce(123.456);

  # 123.46

=cut

$test->for('example', 1, 'coerce', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 123.46;

  $result
});

=example-2 coerce

  # given: synopsis

  package main;

  $assert->accept('string');

  $assert->format(sub{ucfirst lc $_});

  my $coerce = $assert->coerce('heLLo');

  # "Hello"

=cut

$test->for('example', 2, 'coerce', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "Hello";

  $result
});

=method coercion

The coercion method gets or sets the L<Venus::Coercion> object used for
performing runtime data type coercions.

=signature coercion

  coercion(Venus::Coercion $data) (Venus::Coercion)

=metadata coercion

{
  since => '3.55',
}

=cut

=example-1 coercion

  # given: synopsis

  package main;

  my $coercion = $assert->coercion(Venus::Coercion->new);

  # bless(..., 'Venus::Coercion')

=cut

$test->for('example', 1, 'coercion', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Coercion');

  $result
});

=example-2 coercion

  # given: synopsis

  package main;

  $assert->coercion(Venus::Coercion->new);

  my $coercion = $assert->coercion;

  # bless(..., 'Venus::Coercion')

=cut

$test->for('example', 2, 'coercion', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Coercion');

  $result
});

=method conditions

The conditions method is an object construction hook that allows subclasses to
configure the object on construction setting up constraints and coercions and
returning the invocant.

=signature conditions

  conditions() (Venus::Assert)

=metadata conditions

{
  since => '1.40',
}

=example-1 conditions

  # given: synopsis

  package main;

  $assert = $assert->conditions;

  # bless(..., 'Venus::Assert')

=cut

$test->for('example', 1, 'conditions', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=example-2 conditions

  package Example::Type::PositveNumber;

  use base 'Venus::Assert';

  sub conditions {
    my ($self) = @_;

    $self->accept('number', sub {
      $_ >= 0
    });

    return $self;
  }

  package main;

  my $assert = Example::Type::PositveNumber->new;

  # $assert->valid(0);

  # true

  # $assert->valid(1);

  # true

  # $assert->valid(-1);

  # false

=cut

$test->for('example', 2, 'conditions', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example::Type::PositveNumber');
  is $result->valid(0), true;
  is $result->valid(1), true;
  ok !$result->valid(-1);

  require Venus::Space;
  Venus::Space->new('Example::Type::PositiveNumber')->unload;

  $result
});

=method constraint

The constraint method gets or sets the L<Venus::Constraint> object used for
performing runtime data type constraints.

=signature constraint

  constraint(Venus::Constraint $data) (Venus::Constraint)

=metadata constraint

{
  since => '3.55',
}

=cut

=example-1 constraint

  # given: synopsis

  package main;

  my $constraint = $assert->constraint(Venus::Constraint->new);

  # bless(..., 'Venus::Constraint')

=cut

$test->for('example', 1, 'constraint', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Constraint');

  $result
});

=example-2 constraint

  # given: synopsis

  package main;

  $assert->constraint(Venus::Constraint->new);

  my $constraint = $assert->constraint;

  # bless(..., 'Venus::Constraint')

=cut

$test->for('example', 2, 'constraint', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Constraint');

  $result
});

=method ensure

The ensure method registers a custom (not built-in) constraint condition and
returns the invocant.

=signature ensure

  ensure(coderef $code) (Venus::Assert)

=metadata ensure

{
  since => '3.55',
}

=cut

=example-1 ensure

  # given: synopsis

  package main;

  $assert->accept('number');

  my $ensure = $assert->ensure(sub {
    $_ >= 0
  });

  # bless(.., "Venus::Assert")

=cut

$test->for('example', 1, 'ensure', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Assert";
  is $result->valid(0), true;
  is $result->valid(1), true;
  is $result->valid(-1), false;

  $result
});

=method expression

The expression method parses a string representation of an type assertion,
registers the subexpressions using the L</accept> method, and returns the
invocant.

=signature expression

  expression(string $expr) (Venus::Assert)

=metadata expression

{
  since => '1.71',
}

=example-1 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('string');

  # bless(..., 'Venus::Assert')

  # $assert->valid('hello');

  # true

  # $assert->valid(['goodbye']);

  # false

=cut

$test->for('example', 1, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is $result->valid('hello'), true;
  is $result->valid(['goodbye']), false;

  $result
});

=example-2 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('string | coderef');

  # bless(..., 'Venus::Assert')

  # $assert->valid('hello');

  # true

  # $assert->valid(sub{'hello'});

  # true

  # $assert->valid(['goodbye']);

  # false

=cut

$test->for('example', 2, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is $result->valid('hello'), true;
  is $result->valid(sub{'hello'}), true;
  is $result->valid(['goodbye']), false;

  $result
});

=example-3 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('string | coderef | Venus::Assert');

  # bless(..., 'Venus::Assert')

  # $assert->valid('hello');

  # true

  # $assert->valid(sub{'hello'});

  # true

  # $assert->valid($assert);

  # true

  # $assert->valid(['goodbye']);

  # false

=cut

$test->for('example', 3, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is $result->valid('hello'), true;
  is $result->valid(sub{'hello'}), true;
  is $result->valid($result), true;
  is $result->valid(['goodbye']), false;

  $result
});

=example-4 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('Venus::Assert | within[arrayref, Venus::Assert]');

  # bless(..., 'Venus::Assert')

  # $assert->valid('hello');

  # false

  # $assert->valid(sub{'hello'});

  # false

  # $assert->valid($assert);

  # true

  # $assert->valid(['goodbye']);

  # false

  # $assert->valid([$assert]);

  # true

=cut

$test->for('example', 4, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is $result->valid('hello'), false;
  is $result->valid(sub{'hello'}), false;
  is $result->valid($result), true;
  is $result->valid(['goodbye']), false;
  is $result->valid([$result]), true;

  $result
});

=example-5 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('
    string
    | within[
        arrayref, within[
          hashref, string
        ]
      ]
  ');

  # bless(..., 'Venus::Assert')

  # $assert->valid('hello');

  # true

  # $assert->valid(sub{'hello'});

  # false

  # $assert->valid($assert);

  # false

  # $assert->valid([]);

  # false

  # $assert->valid([{'test' => ['okay']}]);

  # false

  # $assert->valid([{'test' => 'okay'}]);

  # true

=cut

$test->for('example', 5, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is $result->valid('hello'), true;
  is $result->valid(sub{'hello'}), false;
  is $result->valid($result), false;
  is $result->valid([]), false;
  is $result->valid($result), false;
  is $result->valid([{'test' => ['okay']}]), false;
  is $result->valid([{'test' => 'okay'}]), true;

  $result
});

=method format

The format method registers a custom (not built-in) coercion condition and
returns the invocant.

=signature format

  format(coderef $code) (Venus::Assert)

=metadata format

{
  since => '3.55',
}

=cut

=example-1 format

  # given: synopsis

  package main;

  $assert->accept('number');

  my $format = $assert->format(sub {
    sprintf '%.2f', $_
  });

  # bless(.., "Venus::Assert")

=cut

$test->for('example', 1, 'format', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Assert";
  is $result->coerce(0), '0.00';
  is $result->coerce(1), '1.00';
  is $result->coerce(100), '100.00';

  $result
});

=method parse

The parse method accepts a string representation of a type assertion and
returns a data structure representing one or more method calls to be used for
validating the assertion signature.

=signature parse

  parse(string $expr) (any)

=metadata parse

{
  since => '2.01',
}

=example-1 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('');

  # ['']

=cut

$test->for('example', 1, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [''];

  $result
});

=example-2 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('any');

  # ['any']

=cut

$test->for('example', 2, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['any'];

  $result
});

=example-3 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('string | number');

  # ['either', 'string', 'number']

=cut

$test->for('example', 3, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['either', 'string', 'number'];

  $result
});

=example-4 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('enum[up,down,left,right]');

  # [['enum', 'up', 'down', 'left', 'right']]

=cut

$test->for('example', 4, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [['enum', 'up', 'down', 'left', 'right']];

  $result
});

=example-5 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('number | float | boolean');

  # ['either', 'number', 'float', 'boolean']

=cut

$test->for('example', 5, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['either', 'number', 'float', 'boolean'];

  $result
});

=example-6 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('Example');

  # ['Example']

=cut

$test->for('example', 6, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['Example'];

  $result
});

=example-7 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('coderef | Venus::Code');

  # ['either', 'coderef', 'Venus::Code']

=cut

$test->for('example', 7, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['either', 'coderef', 'Venus::Code'];

  $result
});

=example-8 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('tuple[number, arrayref, coderef]');

  # [['tuple', 'number', 'arrayref', 'coderef']]

=cut

$test->for('example', 8, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [['tuple', 'number', 'arrayref', 'coderef']];

  $result
});

=example-9 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse('tuple[number, within[arrayref, hashref], coderef]');

  # [['tuple', 'number', ['within', 'arrayref', 'hashref'], 'coderef']]

=cut

$test->for('example', 9, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    ['tuple', 'number', ['within', 'arrayref', 'hashref'], 'coderef']
  ];

  $result
});

=example-10 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse(
    'tuple[number, within[arrayref, hashref] | arrayref, coderef]'
  );

  # [
  #   ['tuple', 'number',
  #     ['either', ['within', 'arrayref', 'hashref'], 'arrayref'], 'coderef']
  # ]


=cut

$test->for('example', 10, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    ['tuple', 'number',
    ['either', ['within', 'arrayref', 'hashref'], 'arrayref'], 'coderef']
  ];

  $result
});

=example-11 parse

  # given: synopsis

  package main;

  my $parsed = $assert->parse(
    'hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]'
  );

  # [[
  #   'hashkeys',
  #   'id',
  #     ['either', 'number', 'float'],
  #   'upvotes',
  #     ['within', 'arrayref', 'boolean']
  # ]]

=cut

$test->for('example', 11, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [[
    'hashkeys', 'id',
    ['either', 'number', 'float'], 'upvotes',
    ['within', 'arrayref', 'boolean']
  ]];

  $result
});

=method render

The render method builds and returns a type expressions suitable for providing
to L</expression> based on the data provided.

=signature render

  render(string $into, string $expression) (string)

=metadata render

{
  since => '2.55',
}

=cut

=example-1 render

  # given: synopsis

  package main;

  $assert = $assert->render;

  # undef

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 render

  # given: synopsis

  package main;

  $assert = $assert->render(undef, 'string');

  # "string"

=cut

$test->for('example', 2, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'string';

  $result
});

=example-3 render

  # given: synopsis

  package main;

  $assert = $assert->render('routines', ['say', 'say_pretty']);

  # 'routines["say", "say_pretty"]'

=cut

$test->for('example', 3, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'routines["say", "say_pretty"]';

  $result
});

=example-4 render

  # given: synopsis

  package main;

  $assert = $assert->render('hashkeys', {id => 'number', name => 'string'});

  # 'hashkeys["id", number, "name", string]'

=cut

$test->for('example', 4, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'hashkeys["id", number, "name", string]';

  $result
});

=example-5 render

  # given: synopsis

  package main;

  $assert = $assert->render('hashkeys', {
    id => 'number',
    profile => {
      level => 'string',
    },
  });

  # 'hashkeys["id", number, "profile", hashkeys["level", string]]'

=cut

$test->for('example', 5, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'hashkeys["id", number, "profile", hashkeys["level", string]]';

  $result
});

=method result

The result method validates the value provided against the registered
constraints and if valid returns the result of the value having any registered
coercions applied. If the value is invalid an exception from L<Venus::Check>
will be thrown.

=signature result

  result(any $data) (any)

=metadata result

{
  since => '3.55',
}

=cut

=example-1 result

  # given: synopsis

  package main;

  $assert->accept('number')->format(sub{sprintf '%.2f', $_});

  my $result = $assert->result(1);

  # "1.00"

=cut

$test->for('example', 1, 'result', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "1.00";

  $result
});

=example-2 result

  # given: synopsis

  package main;

  $assert->accept('number')->format(sub{sprintf '%.2f', $_});

  my $result = $assert->result('hello');

  # Exception! (isa Venus::Check::Error) (see error_on_coded)

=cut

$test->for('example', 2, 'result', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  ok defined $result;
  ok $result->isa('Venus::Check::Error');
  is $result->name, 'on_coded';

  $result
});

=method valid

The valid method dispatches to the L</constraint> object and returns the result
of the L<Venus::Constraint/result> operation.

=signature valid

  valid(any $data) (any)

=metadata valid

{
  since => '3.55',
}

=cut

=example-1 valid

  # given: synopsis

  package main;

  $assert->accept('float');

  $assert->ensure(sub{$_ >= 1});

  my $valid = $assert->valid('1.00');

  # true

=cut

$test->for('example', 1, 'valid', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 valid

  # given: synopsis

  package main;

  $assert->accept('float');

  $assert->ensure(sub{$_ >= 1});

  my $valid = $assert->valid('0.99');

  # false

=cut

$test->for('example', 2, 'valid', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=method validate

The validate method validates the value provided against the registered
constraints and if valid returns the value. If the value is invalid an
exception from L<Venus::Check> will be thrown.

=signature validate

  validate(any $data) (any)

=metadata validate

{
  since => '3.55',
}

=cut

=example-1 validate

  # given: synopsis

  package main;

  $assert->accept('number');

  my $validate = $assert->validate(1);

  # 1

=cut

$test->for('example', 1, 'validate', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 validate

  # given: synopsis

  package main;

  $assert->accept('number');

  my $validate = $assert->validate('hello');

  # Exception! (isa Venus::Check::Error) (see error_on_coded)

=cut

$test->for('example', 2, 'validate', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  ok defined $result;
  ok $result->isa('Venus::Check::Error');
  is $result->name, 'on_coded';

  $result
});

=method validator

The validator method returns a coderef which calls the L</validate> method with
the invocant when called.

=signature validator

  validator(any @args) (coderef)

=metadata validator

{
  since => '3.55',
}

=example-1 validator

  # given: synopsis

  package main;

  $assert->accept('string');

  my $validator = $assert->validator;

  # sub{...}

  # my $result = $validator->();

  # Exception! (isa Venus::Check::Error) (see error_on_coded)

=cut

$test->for('example', 1, 'validator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'CODE';
  my $error = catch{$result->()};
  ok $error->isa('Venus::Check::Error');
  is $error->name, 'on_coded';

  $result
});

=example-2 validator

  # given: synopsis

  package main;

  $assert->accept('string');

  my $validator = $assert->validator;

  # sub{...}

  # my $result = $validator->('hello');

  # "hello"

=cut

$test->for('example', 2, 'validator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  ok ref $result eq 'CODE';
  is $result->('hello'), 'hello';

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

subtest 'test_for_parser', sub {
  my $assert = Venus::Assert->new;

  my $string = 'string';
  is_deeply scalar $assert->parse($string), [
    'string',
  ];

  $string = 'string | number';
  is_deeply scalar $assert->parse($string), [
    'either',
    'string',
    'number',
  ];

  $string = 'string | number | Venus::Code';
  is_deeply scalar $assert->parse($string), [
    'either',
    'string',
    'number',
    'Venus::Code',
  ];

  $string = <<'EOF';
    number
    | hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]
    | tuple[number | string]
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    'number',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    'boolean'
    ],
    ],
    [
    'tuple',
    [
    'either',
    'number',
    'string'
    ],
    ],
  ];

  $string = <<'EOF';
    number
    | hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    'number',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    'boolean'
    ],
    ],
    ];

  $string = 'within[arrayref, hashref] | arrayref';
  is_deeply scalar $assert->parse($string), [
    'either',
    [
    'within',
    'arrayref',
    'hashref',
    ],
    'arrayref',
    ];

  $string = <<'EOF';
    number
    | hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]
    | tuple[number | string]
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    'number',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    'boolean'
    ],
    ],
    [
    'tuple',
    [
    'either',
    'number',
    'string'
    ],
    ],
    ];

  $string = 'string | number | tuple[string, number]';
  is_deeply scalar $assert->parse($string), [
    'either',
    'string',
    'number',
    [
    'tuple',
    'string',
    'number',
    ],
    ];

  $string = <<'EOF';
    hashkeys["id", number | float, "upvotes", within[arrayref, number | boolean]]
    | string
    | number
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    [
    'either',
    'number',
    'boolean',
    ],
    ],
    ],
    'string',
    'number',
    ];

  $string = <<'EOF';
    hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]
    | string
    | Example::Thing
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    'boolean',
    ],
    ],
    'string',
    'Example::Thing',
    ];

  $string = <<'EOF';
    Example::String
    | hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]
    | Example::Thing
    | string
    | number
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    'Example::String',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    'boolean',
    ],
    ],
    'Example::Thing',
    'string',
    'number',
    ];

  $string = <<'EOF';
    hashkeys[
      "id", number | float, "upvotes",
      within[
        arrayref, number | boolean | hashkeys["id", number | float]
      ]
    ]
    | hashkeys[
      "id", number | float, "upvotes",
      within[
        arrayref, number | boolean | hashkeys["id", number | float]
      ]
    ]
    | Example
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    'either',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    [
    'either',
    'number',
    'boolean',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float',
    ],
    ],
    ],
    ],
    ],
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float'
    ],
    'upvotes',
    [
    'within',
    'arrayref',
    [
    'either',
    'number',
    'boolean',
    [
    'hashkeys',
    'id',
    [
    'either',
    'number',
    'float',
    ],
    ],
    ],
    ],
    ],
    'Example',
    ];

  $string = <<'EOF';
  hashkeys[
    "name", string,
    "type", enum[string, number, boolean, yesno],
    "alias", within[arrayref, string]
  ]
EOF
  $string =~ s/\s*\n+\s*/ /g;
  is_deeply scalar $assert->parse($string), [
    [
    'hashkeys',
    'name',
    'string',
    'type',
    [
    'enum',
    'string',
    'number',
    'boolean',
    'yesno'
    ],
    'alias',
    [
    'within',
    'arrayref',
    'string'
    ]
    ]
    ];
};

# END

$test->render('lib/Venus/Assert.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
