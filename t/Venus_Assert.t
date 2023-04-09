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

method: any
method: accept
method: array
method: arrayref
method: attributes
method: boolean
method: check
method: checker
method: clear
method: code
method: coderef
method: coerce
method: coercion
method: coercions
method: conditions
method: constraint
method: constraints
method: defined
method: either
method: enum
method: expression
method: format
method: float
method: hash
method: hashkeys
method: hashref
method: identity
method: inherits
method: integrates
method: maybe
method: number
method: object
method: package
method: parse
method: reference
method: regexp
method: routines
method: scalar
method: scalarref
method: string
method: tuple
method: undef
method: validate
method: validator
method: value
method: within
method: yesno

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Assert;

  my $assert = Venus::Assert->new('Example');

  # $assert->format(float => sub {sprintf('%.2f', $_->value)});

  # $assert->accept(float => sub {$_->value > 1});

  # $assert->check;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  is $result->message, 'Type assertion (%s) failed: received (%s), expected (%s)';

  $result
});

=description

This package provides a mechanism for asserting type constraints and coercions
on data.

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

=attributes

expects: rw, opt, ArrayRef
message: rw, opt, Str
name: rw, opt, Str

=cut

$test->for('attributes');

=method any

The any method configures the object to accept any value and returns the
invocant.

=signature any

  any() (Assert)

=metadata any

{
  since => '1.40',
}

=example-1 any

  # given: synopsis

  package main;

  $assert = $assert->any;

  # $assert->check;

  # true

=cut

$test->for('example', 1, 'any', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check(0);
  ok $result->check(1);
  ok $result->check({});
  ok $result->check([]);
  ok $result->check(bless{});

  $result
});

=method accept

The accept method registers a constraint based on the built-in type or package
name provided as the first argument. The built-in types are I<"array">,
I<"boolean">, I<"code">, I<"float">, I<"hash">, I<"number">, I<"object">,
I<"regexp">, I<"scalar">, I<"string">, or I<"undef">.  Any name given that is
not a built-in type is assumed to be a method (i.e. a method call) or an
I<"object"> of the name provided. Additional arguments are assumed to be
arguments for the dispatched method call. Optionally, you can provide a
callback to further constrain/validate the provided value, returning truthy or
falsy, for methods that support it.

=signature accept

  accept(Str $name, Any @args) (Object)

=metadata accept

{
  since => '1.40',
}

=example-1 accept

  # given: synopsis

  package main;

  $assert = $assert->accept('float');

  # bless(..., "Venus::Assert")

  # ...

  # $assert->check;

  # 0

  # $assert->check(1.01);

  # 1

=cut

$test->for('example', 1, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->check, 0;
  is $result->check(1), 0;
  is $result->check(1.01), 1;

  $result
});

=example-2 accept

  # given: synopsis

  package main;

  $assert = $assert->accept('number');

  # bless(..., "Venus::Assert")

  # ...

  # $assert->check(1.01);

  # 0

  # $assert->check(1_01);

  # 1

=cut

$test->for('example', 2, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->check, 0;
  is $result->check(1.01), 0;
  is $result->check(1_01), 1;

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

  # ...

  # $assert->check;

  # 0

  # $assert->check(qr//);

  # 0

  # $assert->check(Example1->new);

  # 1

  # $assert->check(Example2->new);

  # 1

=cut

$test->for('example', 3, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->check, 0;
  is $result->check(qr//), 0;
  is $result->check(Example1->new), 1;
  is $result->check(Example2->new), 1;

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

  # ...

  # $assert->check;

  # 0

  # $assert->check(qr//);

  # 0

  # $assert->check(Example1->new);

  # 1

  # $assert->check(Example2->new);

  # 0

=cut

$test->for('example', 4, 'accept', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->check, 0;
  is $result->check(qr//), 0;
  is $result->check(Example1->new), 1;
  is $result->check(Example2->new), 0;

  $result
});

=method array

The array method configures the object to accept array references and returns
the invocant.

=signature array

  array(CodeRef $check) (Assert)

=metadata array

{
  since => '1.40',
}

=example-1 array

  # given: synopsis

  package main;

  $assert = $assert->array;

  # $assert->check([]);

  # true

=cut

$test->for('example', 1, 'array', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check([]);
  ok !$result->check(0);
  ok !$result->check({});
  ok !$result->check(bless{});

  $result
});

=method arrayref

The arrayref method configures the object to accept array references and
returns the invocant.

=signature arrayref

  arrayref(CodeRef $check) (Assert)

=metadata arrayref

{
  since => '1.71',
}

=example-1 arrayref

  # given: synopsis

  package main;

  $assert = $assert->arrayref;

  # $assert->check([]);

  # true

=cut

$test->for('example', 1, 'arrayref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check([]);
  ok !$result->check(0);
  ok !$result->check({});
  ok !$result->check(bless{});

  $result
});

=method attributes

The attributes method configures the object to accept objects containing
attributes whose values' match the attribute names and types specified, and
returns the invocant.

=signature attributes

  attributes(Str | ArrayRef[Str] @pairs) (Assert)

=metadata attributes

{
  since => '2.01',
}

=example-1 attributes

  # given: synopsis

  package main;

  $assert = $assert->attributes;

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 1, 'attributes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check(Venus::Assert->new);

  $result
});

=example-2 attributes

  # given: synopsis

  package main;

  $assert = $assert->attributes(name => 'string');

  # $assert->check(bless{});

  # false

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 2, 'attributes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check(bless{});
  ok $result->check(Venus::Assert->new);

  $result
});

=example-3 attributes

  # given: synopsis

  package Example3;

  use Venus::Class;

  attr 'name';

  package main;

  $assert = $assert->attributes(name => 'string', message => 'string');

  # $assert->check(bless{});

  # false

  # $assert->check(Venus::Assert->new);

  # true

  # $assert->check(Example3->new);

  # false

=cut

$test->for('example', 3, 'attributes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check(bless{});
  ok $result->check(Venus::Assert->new);
  ok !$result->check(Example3->new);

  $result
});

=method boolean

The boolean method configures the object to accept boolean values and returns
the invocant.

=signature boolean

  boolean(CodeRef $check) (Assert)

=metadata boolean

{
  since => '1.40',
}

=example-1 boolean

  # given: synopsis

  package main;

  $assert = $assert->boolean;

  # $assert->check(false);

  # true

=cut

$test->for('example', 1, 'boolean', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(false);
  ok $result->check(true);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method check

The check method returns true or false if the data provided passes the
registered constraints.

=signature check

  check(Any $data) (Bool)

=metadata check

{
  since => '1.23',
}

=example-1 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check;

  # 0

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check('0.01');

  # 0

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-3 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check('1.01');

  # 1

=cut

$test->for('example', 3, 'check', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-4 check

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $check = $assert->check(time);

  # 0

=cut

$test->for('example', 4, 'check', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method checker

The checker method calls L</expression> with the type assertion signature
provided and returns a coderef which calls the L</check> method when called.

=signature checker

  checker(Str $expr) (CodeRef)

=metadata checker

{
  since => '2.32',
}

=example-1 checker

  # given: synopsis

  package main;

  my $checker = $assert->checker('string');

  # sub { ... }

  # $checker->('hello');

  # true

  # $checker->(['goodbye']);

  # false

=cut

$test->for('example', 1, 'checker', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref $result, 'CODE';
  ok $result->('hello');
  ok !$result->(['goodbye']);

  $result
});

=method clear

The clear method resets all match conditions for both constraints and coercions
and returns the invocant.

=signature clear

  clear() (Assert)

=metadata clear

{
  since => '1.40',
}

=example-1 clear

  # given: synopsis

  package main;

  $assert = $assert->clear;

  # bless(..., "Venus::Assert")

=cut

$test->for('example', 1, 'clear', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $constraints = $result->constraints;
  ok $constraints->on_none;
  ok !$constraints->on_none->();
  ok $constraints->on_only;
  ok $constraints->on_only->() == 1;
  ok $constraints->on_then;
  ok ref($constraints->on_then) eq 'ARRAY';
  ok $#{$constraints->on_then} == -1;
  ok $constraints->on_when;
  ok ref($constraints->on_when) eq 'ARRAY';
  ok $#{$constraints->on_when} == -1;

  my $coercions = $result->coercions;
  ok $coercions->on_none;
  ok !$coercions->on_none->();
  ok $coercions->on_only;
  ok $coercions->on_only->() == 1;
  ok $coercions->on_then;
  ok ref($coercions->on_then) eq 'ARRAY';
  ok $#{$coercions->on_then} == -1;
  ok $coercions->on_when;
  ok ref($coercions->on_when) eq 'ARRAY';
  ok $#{$coercions->on_when} == -1;

  $result
});

=method code

The code method configures the object to accept code references and returns
the invocant.

=signature code

  code(CodeRef $check) (Assert)

=metadata code

{
  since => '1.40',
}

=example-1 code

  # given: synopsis

  package main;

  $assert = $assert->code;

  # $assert->check(sub{});

  # true

=cut

$test->for('example', 1, 'code', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(sub{});
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method coderef

The coderef method configures the object to accept code references and returns
the invocant.

=signature coderef

  coderef(CodeRef $check) (Assert)

=metadata coderef

{
  since => '1.71',
}

=example-1 coderef

  # given: synopsis

  package main;

  $assert = $assert->coderef;

  # $assert->check(sub{});

  # true

=cut

$test->for('example', 1, 'coderef', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(sub{});
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method coerce

The coerce method returns the coerced data if the data provided matches any of
the registered coercions.

=signature coerce

  coerce(Any $data) (Any)

=metadata coerce

{
  since => '1.23',
}

=example-1 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce;

  # undef

=cut

$test->for('example', 1, 'coerce', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce('1.01');

  # "1.01"

=cut

$test->for('example', 2, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == '1.01';

  $result
});

=example-3 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce('1.00001');

  # "1.00"

=cut

$test->for('example', 3, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == '1.00';

  $result
});

=example-4 coerce

  # given: synopsis

  package main;

  $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  my $coerce = $assert->coerce('hello world');

  # "hello world"

=cut

$test->for('example', 4, 'coerce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello world';

  $result
});

=method coercion

The coercion method registers a coercion based on the type provided.

=signature coercion

  coercion(Str $type, CodeRef $code) (Object)

=metadata coercion

{
  since => '1.23',
}

=example-1 coercion

  # given: synopsis

  package main;

  $assert = $assert->coercion(float => sub { sprintf('%.2f', $_->value) });

  # bless(..., "Venus::Assert")

=cut

$test->for('example', 1, 'coercion', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=method coercions

The coercions method returns the registered coercions as a L<Venus::Match> object.

=signature coercions

  coercions() (Match)

=metadata coercions

{
  since => '1.23',
}

=example-1 coercions

  # given: synopsis

  package main;

  my $coercions = $assert->coercions;

  # bless(..., "Venus::Match")

=cut

$test->for('example', 1, 'coercions', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');

  $result
});

=method conditions

The conditions method is an object construction hook that allows subclasses to
configure the object on construction setting up constraints and coercions and
returning the invocant.

=signature conditions

  conditions() (Assert)

=metadata conditions

{
  since => '1.40',
}

=example-1 conditions

  # given: synopsis

  package main;

  $assert = $assert->conditions;

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

    $self->number(sub {
      $_->value >= 0
    });

    return $self;
  }

  package main;

  my $assert = Example::Type::PositveNumber->new;

  # $assert->check(0);

  # true

  # $assert->check(1);

  # true

  # $assert->check(-1);

  # false

=cut

$test->for('example', 2, 'conditions', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example::Type::PositveNumber');
  ok $result->check(0);
  ok $result->check(1);
  ok !$result->check(-1);

  $result
});

=method constraint

The constraint method registers a constraint based on the type provided.

=signature constraint

  constraint(Str $type, CodeRef $code) (Object)

=metadata constraint

{
  since => '1.23',
}

=example-1 constraint

  # given: synopsis

  package main;

  $assert = $assert->constraint(float => sub { $_->value > 1 });

  # bless(..., "Venus::Assert")

=cut

$test->for('example', 1, 'constraint', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');

  $result
});

=method constraints

The constraints method returns the registered constraints as a L<Venus::Match>
object.

=signature constraints

  constraints() (Match)

=metadata constraints

{
  since => '1.23',
}

=example-1 constraints

  # given: synopsis

  package main;

  my $constraints = $assert->constraints;

  # bless(..., "Venus::Match")

=cut

$test->for('example', 1, 'constraints', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Match');

  $result
});

=method consumes

The consumes method configures the object to accept objects which consume the
role provided, and returns the invocant.

=signature consumes

  consumes(Str $name) (Assert)

=metadata consumes

{
  since => '1.40',
}

=example-1 consumes

  # given: synopsis

  package main;

  $assert = $assert->consumes('Venus::Role::Doable');

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 1, 'consumes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(Venus::Assert->new);
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method defined

The defined method configures the object to accept any value that's not
undefined and returns the invocant.

=signature defined

  defined(CodeRef $check) (Assert)

=metadata defined

{
  since => '1.40',
}

=example-1 defined

  # given: synopsis

  package main;

  $assert = $assert->defined;

  # $assert->check(0);

  # true

=cut

$test->for('example', 1, 'defined', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(0);
  ok !$result->check(undef);
  ok $result->check('');
  ok $result->check(1);
  ok $result->check(bless{});

  $result
});

=method either

The either method configures the object to accept "either" of the conditions
provided, which may be a string or arrayref representing a method call, and
returns the invocant.

=signature either

  either(Str | ArrayRef[Str|ArrayRef] $dispatch) (Assert)

=metadata either

{
  since => '2.01',
}

=example-1 either

  # given: synopsis

  package main;

  $assert = $assert->either('string');

  # $assert->check('1');

  # true

  # $assert->check(1);

  # false

=cut

$test->for('example', 1, 'either', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check('1');
  ok !$result->check(1);

  $result
});

=example-2 either

  # given: synopsis

  package main;

  $assert = $assert->either('string', 'number');

  # $assert->check(true);

  # false

  # $assert->check('1');

  # true

  # $assert->check(1);

  # true

=cut

$test->for('example', 2, 'either', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check(true);
  ok $result->check('1');
  ok $result->check(1);

  $result
});

=example-3 either

  # given: synopsis

  package main;

  $assert = $assert->either('number', 'boolean');

  # $assert->check(true);

  # true

  # $assert->check('1');

  # false

  # $assert->check(1);

  # true

=cut

$test->for('example', 3, 'either', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check(true);
  ok !$result->check('1');
  ok $result->check(1);

  $result
});

=method enum

The enum method configures the object to accept any one of the provide options,
and returns the invocant.

=signature enum

  enum(Any @data) (Assert)

=metadata enum

{
  since => '1.40',
}

=example-1 enum

  # given: synopsis

  package main;

  $assert = $assert->enum('s', 'm', 'l', 'xl');

  # $assert->check('s');

  # true

  # $assert->check('xs');

  # false

=cut

$test->for('example', 1, 'enum', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check('s');
  ok $result->check('m');
  ok $result->check('l');
  ok $result->check('xl');
  ok !$result->check('xs');
  ok !$result->check('');
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method expression

The expression method parses a string representation of an type assertion
signature, registers the subexpressions using the L</either> and L</accept>
methods, and returns the invocant.

=signature expression

  expression(Str $expr) (Assert)

=metadata expression

{
  since => '1.71',
}

=example-1 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('string');

  # $assert->check('hello');

  # true

  # $assert->check(['goodbye']);

  # false

=cut

$test->for('example', 1, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check('hello');
  ok !$result->check(['goodbye']);

  $result
});

=example-2 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('string | coderef');

  # $assert->check('hello');

  # true

  # $assert->check(sub{'hello'});

  # true

  # $assert->check(['goodbye']);

  # false

=cut

$test->for('example', 2, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check('hello');
  ok $result->check(sub{'hello'});
  ok !$result->check(['goodbye']);

  $result
});

=example-3 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('string | coderef | Venus::Assert');

  # $assert->check('hello');

  # true

  # $assert->check(sub{'hello'});

  # true

  # $assert->check($assert);

  # true

  # $assert->check(['goodbye']);

  # false

=cut

$test->for('example', 3, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->check('hello');
  ok $result->check(sub{'hello'});
  ok $result->check($result);
  ok !$result->check(['goodbye']);

  $result
});

=example-4 expression

  # given: synopsis

  package main;

  $assert = $assert->expression('Venus::Assert | within[arrayref, Venus::Assert]');

  # $assert->check('hello');

  # false

  # $assert->check(sub{'hello'});

  # false

  # $assert->check($assert);

  # true

  # $assert->check(['goodbye']);

  # false

  # $assert->check([$assert]);

  # true

=cut

$test->for('example', 4, 'expression', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check('hello');
  ok !$result->check(sub{'hello'});
  ok $result->check($result);
  ok !$result->check(['goodbye']);
  ok $result->check([$result]);

  $result
});

=method float

The float method configures the object to accept floating-point values and
returns the invocant.

=signature float

  float(CodeRef $check) (Assert)

=metadata float

{
  since => '1.40',
}

=example-1 float

  # given: synopsis

  package main;

  $assert = $assert->float;

  # $assert->check(1.23);

  # true

=cut

$test->for('example', 1, 'float', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(1.23);
  ok $result->check(rand || '0.0');
  ok !$result->check(1);
  ok !$result->check('0');
  ok !$result->check('1');
  ok !$result->check(bless{});

  $result
});

=method format

The format method registers a coercion based on the built-in type or package
name and callback provided. The built-in types are I<"array">, I<"boolean">,
I<"code">, I<"float">, I<"hash">, I<"number">, I<"object">, I<"regexp">,
I<"scalar">, I<"string">, or I<"undef">.  Any name given that is not a built-in
type is assumed to be an I<"object"> of the name provided.

=signature format

  format(Str $name, CodeRef $callback) (Object)

=metadata format

{
  since => '1.40',
}

=example-1 format

  # given: synopsis

  package main;

  $assert = $assert->format('float', sub{int $_->value});

  # bless(..., "Venus::Assert")

  # ...

  # $assert->coerce;

  # undef

  # $assert->coerce(1.01);

  # 1

=cut

$test->for('example', 1, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->coerce, undef;
  is $result->coerce(1.01), 1;

  $result
});

=example-2 format

  # given: synopsis

  package main;

  $assert = $assert->format('number', sub{ sprintf('%.2f', $_->value) });

  # bless(..., "Venus::Assert")

  # ...

  # $assert->coerce(1.01);

  # 1.01

  # $assert->coerce(1_01);

  # 101.00

=cut

$test->for('example', 2, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->coerce(1.01), 1.01;
  is $result->coerce(1_01), '101.00';

  $result
});

=example-3 format

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

  $assert = $assert->format('object', sub{ ref $_->value });

  # bless(..., "Venus::Assert")

  # ...

  # $assert->coerce(qr//);

  # qr//

  # $assert->coerce(Example1->new);

  # "Example1"

  # $assert->coerce(Example2->new);

  # "Example2"

=cut

$test->for('example', 3, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->coerce(qr//), qr//;
  is $result->coerce(Example1->new), "Example1";
  is $result->coerce(Example2->new), "Example2";

  $result
});

=example-4 format

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

  $assert = $assert->format('Example1', sub{ ref $_->value });

  # bless(..., "Venus::Assert")

  # ...

  # $assert->coerce(qr//);

  # qr//

  # $assert->coerce(Example1->new);

  # "Example1"

  # $assert->coerce(Example2->new);

  # bless({}, "Example2")

=cut

$test->for('example', 4, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result->coerce(qr//), qr//;
  is $result->coerce(Example1->new), "Example1";
  my $object = Example2->new;
  is $result->coerce($object), $object;

  $result
});

=method hash

The hash method configures the object to accept hash references and returns
the invocant.

=signature hash

  hash(CodeRef $check) (Assert)

=metadata hash

{
  since => '1.40',
}

=example-1 hash

  # given: synopsis

  package main;

  $assert = $assert->hash;

  # $assert->check({});

  # true

=cut

$test->for('example', 1, 'hash', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check({});
  ok !$result->check(0);
  ok !$result->check([]);
  ok !$result->check(bless{});

  $result
});

=method hashkeys

The hashkeys method configures the object to accept hash based values
containing the keys whose values' match the specified types, and returns the
invocant.

=signature hashkeys

  hashkeys(Str | ArrayRef[Str] @pairs) (Assert)

=metadata hashkeys

{
  since => '2.01',
}

=example-1 hashkeys

  # given: synopsis

  package main;

  $assert = $assert->hashkeys;

  # $assert->check({});

  # false

  # $assert->check({random => rand});

  # true

=cut

$test->for('example', 1, 'hashkeys', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check({});
  ok $result->check({random => rand});

  $result
});

=example-2 hashkeys

  # given: synopsis

  package main;

  $assert = $assert->hashkeys(random => 'float');

  # $assert->check({});

  # false

  # $assert->check({random => rand});

  # true

  # $assert->check({random => time});

  # false

=cut

$test->for('example', 2, 'hashkeys', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check({});
  ok $result->check({random => rand});
  ok !$result->check({random => time});

  $result
});

=example-3 hashkeys

  # given: synopsis

  package main;

  $assert = $assert->hashkeys(random => ['either', 'float', 'number']);

  # $assert->check({});

  # false

  # $assert->check({random => rand});

  # true

  # $assert->check({random => time});

  # true

  # $assert->check({random => 'okay'});

  # false

  # $assert->check(bless{random => rand});

  # true

  # $assert->check(bless{random => time});

  # true

  # $assert->check(bless{random => 'okay'});

  # false

=cut

$test->for('example', 3, 'hashkeys', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check({});
  ok $result->check({random => rand});
  ok $result->check({random => time});
  ok !$result->check({random => 'okay'});
  ok $result->check(bless{random => rand});
  ok $result->check(bless{random => time});
  ok !$result->check(bless{random => 'okay'});

  $result
});

=method hashref

The hashref method configures the object to accept hash references and returns
the invocant.

=signature hashref

  hashref(CodeRef $check) (Assert)

=metadata hashref

{
  since => '1.71',
}

=example-1 hashref

  # given: synopsis

  package main;

  $assert = $assert->hashref;

  # $assert->check({});

  # true

=cut

$test->for('example', 1, 'hashref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check({});
  ok !$result->check(0);
  ok !$result->check([]);
  ok !$result->check(bless{});

  $result
});

=method identity

The identity method configures the object to accept objects of the type
specified as the argument, and returns the invocant.

=signature identity

  identity(Str $name) (Assert)

=metadata identity

{
  since => '1.40',
}

=example-1 identity

  # given: synopsis

  package main;

  $assert = $assert->identity('Venus::Assert');

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 1, 'identity', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(Venus::Assert->new);
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method inherits

The inherits method configures the object to accept objects of the type
specified as the argument, and returns the invocant. This method is a proxy for
the L</identity> method.

=signature inherits

  inherits(Str $name) (Assert)

=metadata inherits

{
  since => '2.01',
}

=example-1 inherits

  # given: synopsis

  package main;

  $assert = $assert->inherits('Venus::Assert');

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 1, 'inherits', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(Venus::Assert->new);
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method integrates

The integrates method configures the object to accept objects that support the
C<"does"> behavior and consumes the "role" specified as the argument, and
returns the invocant.

=signature integrates

  integrates(Str $name) (Assert)

=metadata integrates

{
  since => '2.01',
}

=example-1 integrates

  # given: synopsis

  package main;

  $assert = $assert->integrates('Venus::Role::Doable');

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 1, 'integrates', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(Venus::Assert->new);
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method maybe

The maybe method configures the object to accept the type provided as an
argument, or undef, and returns the invocant.

=signature maybe

  maybe(Str $type, Any @args) (Assert)

=metadata maybe

{
  since => '1.40',
}

=example-1 maybe

  # given: synopsis

  package main;

  $assert = $assert->maybe('code');

  # $assert->check(sub{});

  # true

  # $assert->check(undef);

  # true

=cut

$test->for('example', 1, 'maybe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(undef);
  ok $result->check(sub{});
  ok !$result->check('');
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method number

The number method configures the object to accept numberic values and returns
the invocant.

=signature number

  number(CodeRef $check) (Assert)

=metadata number

{
  since => '1.40',
}

=example-1 number

  # given: synopsis

  package main;

  $assert = $assert->number;

  # $assert->check(0);

  # true

=cut

$test->for('example', 1, 'number', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(0);
  ok $result->check(1);
  ok !$result->check('0');
  ok !$result->check('1');
  ok !$result->check(bless{});

  $result
});

=method object

The object method configures the object to accept objects and returns the
invocant.

=signature object

  object(CodeRef $check) (Assert)

=metadata object

{
  since => '1.40',
}

=example-1 object

  # given: synopsis

  package main;

  $assert = $assert->object;

  # $assert->check(bless{});

  # true

=cut

$test->for('example', 1, 'object', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(bless{});
  ok !$result->check(1);
  ok !$result->check('main');
  ok !$result->check({});
  ok !$result->check([]);

  $result
});

=method package

The package method configures the object to accept package names (which are
loaded) and returns the invocant.

=signature package

  package() (Assert)

=metadata package

{
  since => '1.40',
}

=example-1 package

  # given: synopsis

  package main;

  $assert = $assert->package;

  # $assert->check('Venus');

  # true

=cut

$test->for('example', 1, 'package', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check('Venus');
  ok $result->check('Venus::Assert');
  ok !$result->check('Example');
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method parse

The parse method accepts a string representation of a type assertion signature
and returns a data structure representing one or more method calls to be used
for validating the assertion signature.

=signature parse

  parse(Str $expr) (Any)

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

=method reference

The reference method configures the object to accept references and returns the
invocant.

=signature reference

  reference(CodeRef $check) (Assert)

=metadata reference

{
  since => '1.40',
}

=example-1 reference

  # given: synopsis

  package main;

  $assert = $assert->reference;

  # $assert->check(sub{});

  # true

=cut

$test->for('example', 1, 'reference', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(sub{});
  ok $result->check({});
  ok $result->check([]);
  ok !$result->check(1);
  ok !$result->check('main');
  ok !$result->check(true);
  ok $result->check(bless{});

  $result
});

=method regexp

The regexp method configures the object to accept regular expression objects
and returns the invocant.

=signature regexp

  regexp(CodeRef $check) (Assert)

=metadata regexp

{
  since => '1.40',
}

=example-1 regexp

  # given: synopsis

  package main;

  $assert = $assert->regexp;

  # $assert->check(qr//);

  # true

=cut

$test->for('example', 1, 'regexp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(qr//);
  ok !$result->check('');
  ok !$result->check([]);
  ok !$result->check(1);
  ok !$result->check('main');
  ok !$result->check(true);
  ok !$result->check(bless{});

  $result
});

=method routines

The routines method configures the object to accept an object having all of the
routines provided, and returns the invocant.

=signature routines

  routines(Str @names) (Assert)

=metadata routines

{
  since => '1.40',
}

=example-1 routines

  # given: synopsis

  package main;

  $assert = $assert->routines('new', 'print', 'say');

  # $assert->check(Venus::Assert->new);

  # true

=cut

$test->for('example', 1, 'routines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(Venus::Assert->new);
  ok !$result->check(bless{});
  ok !$result->check(1);
  ok !$result->check('main');
  ok !$result->check({});
  ok !$result->check([]);

  $result
});

=method scalar

The scalar method configures the object to accept scalar references and returns
the invocant.

=signature scalar

  scalar(CodeRef $check) (Assert)

=metadata scalar

{
  since => '1.40',
}

=example-1 scalar

  # given: synopsis

  package main;

  $assert = $assert->scalar;

  # $assert->check(\1);

  # true

=cut

$test->for('example', 1, 'scalar', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(\1);
  ok !$result->check(0);
  ok !$result->check({});
  ok !$result->check([]);
  ok !$result->check(bless{});

  $result
});

=method scalarref

The scalarref method configures the object to accept scalar references and returns
the invocant.

=signature scalarref

  scalarref(CodeRef $check) (Assert)

=metadata scalarref

{
  since => '1.71',
}

=example-1 scalarref

  # given: synopsis

  package main;

  $assert = $assert->scalarref;

  # $assert->check(\1);

  # true

=cut

$test->for('example', 1, 'scalarref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(\1);
  ok !$result->check(0);
  ok !$result->check({});
  ok !$result->check([]);
  ok !$result->check(bless{});

  $result
});

=method string

The string method configures the object to accept string values and returns the
invocant.

=signature string

  string(CodeRef $check) (Assert)

=metadata string

{
  since => '1.40',
}

=example-1 string

  # given: synopsis

  package main;

  $assert = $assert->string;

  # $assert->check('');

  # true

=cut

$test->for('example', 1, 'string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check('');
  ok $result->check('hello');
  ok $result->check('hello world');
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(qr//);
  ok !$result->check(bless{});

  $result
});

=method tuple

The tuple method configures the object to accept array references which conform
to a tuple specification, and returns the invocant. The value being evaluated
must contain at-least one element to match.

=signature tuple

  tuple(Str | ArrayRef[Str] @types) (Assert)

=metadata tuple

{
  since => '1.40',
}

=example-1 tuple

  # given: synopsis

  package main;

  $assert = $assert->tuple('number', ['maybe', 'array'], 'code');

  # $assert->check([200, [], sub{}]);

  # true

=cut

$test->for('example', 1, 'tuple', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check([200, [], sub{}]);
  ok !$result->check([200, []]);
  ok $result->check([200, undef, sub{}]);
  ok !$result->check(['200', [], sub{}]);
  ok !$result->check([200, {}, sub{}]);
  ok !$result->check([200, [], bless{}]);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(qr//);
  ok !$result->check(bless{});

  $result
});

=method undef

The undef method configures the object to accept undefined values and returns
the invocant.

=signature undef

  undef(CodeRef $check) (Assert)

=metadata undef

{
  since => '1.40',
}

=example-1 undef

  # given: synopsis

  package main;

  $assert = $assert->undef;

  # $assert->check(undef);

  # true

=cut

$test->for('example', 1, 'undef', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(undef);
  ok !$result->check(true);
  ok !$result->check(false);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});

  $result
});

=method validate

The validate method returns the data provided if the data provided passes the
registered constraints, or throws an exception.

=signature validate

  validate(Any $data) (Any)

=metadata validate

{
  since => '1.23',
}

=example-1 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate;

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 1, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Assert::Error');
  ok $result->isa('Venus::Error');
  ok $result->is('on.validate');
  ok $result->stash('identity') eq 'undef';

  $result
});

=example-2 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate('0.01');

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 2, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Assert::Error');
  ok $result->isa('Venus::Error');
  ok $result->is('on.validate');
  ok $result->stash('identity') eq 'float';

  $result
});

=example-3 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate('1.01');

  # "1.01"

=cut

$test->for('example', 3, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1.01;

  $result
});

=example-4 validate

  # given: synopsis

  package main;

  $assert->constraint(float => sub { $_->value > 1 });

  my $result = $assert->validate(time);

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 4, 'validate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $result->isa('Venus::Assert::Error');
  ok $result->isa('Venus::Error');
  ok $result->is('on.validate');
  ok $result->stash('identity') eq 'number';

  $result
});

=method validator

The validator method returns a coderef that can be used as a value validator,
which returns the data provided if the data provided passes the registered
constraints, or throws an exception.

=signature validator

  validator(Str $expr) (CodeRef)

=metadata validator

{
  since => '1.40',
}

=example-1 validator

  # given: synopsis

  package main;

  my $validator = $assert->validator('string');

  # sub { ... }

  # $validator->('hello');

  # "hello"

  # $validator->(['goodbye']);

  # Exception! (isa Venus::Error)

=cut

$test->for('example', 1, 'validator', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref $result eq 'CODE';
  is $result->('hello'), 'hello';
  my ($return, $error) = catch {$result->(['goodbye'])};
  ok $return->isa('Venus::Error');
  ok $return->is('on.validate');
  ok $return->stash('identity') eq 'array';

  $result
});

=method value

The value method configures the object to accept defined, non-reference,
values, and returns the invocant.

=signature value

  value(CodeRef $check) (Assert)

=metadata value

{
  since => '1.40',
}

=example-1 value

  # given: synopsis

  package main;

  $assert = $assert->value;

  # $assert->check(1_000_000);

  # true

=cut

$test->for('example', 1, 'value', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->check(1_000_000);
  ok !$result->check({});
  ok !$result->check([]);
  ok $result->check(1);
  ok $result->check('main');
  ok $result->check(true);
  ok !$result->check(bless{});

  $result
});

=method within

The within method configures the object, registering a constraint action as a
sub-match operation, to accept array or hash based values, and returns a
L<Venus::Assert> instance for the sub-match operation (not the invocant).  This
operation can traverse blessed array or hash based values. The value being
evaluated must contain at-least one element to match.

=signature within

  within(Str $type) (Assert)

=metadata within

{
  since => '1.40',
}

=example-1 within

  # given: synopsis

  package main;

  my $within = $assert->within('array')->code;

  my $action = $assert;

  # $assert->check([]);

  # false

  # $assert->check([sub{}]);

  # true

  # $assert->check([{}]);

  # false

  # $assert->check(bless[]);

  # false

  # $assert->check(bless[sub{}]);

  # true

=cut

$test->for('example', 1, 'within', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !$result->check([]);
  ok $result->check([sub{}]);
  ok !$result->check([{}]);
  ok !$result->check([sub{}, 1]);
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless{});
  ok !$result->check(bless[]);
  ok $result->check(bless[sub{}]);
  ok !$result->check(bless[{}]);

  $result
});

=example-2 within

  # given: synopsis

  package main;

  my $within = $assert->within('hash')->code;

  my $action = $assert;

  # $assert->check({});

  # false

  # $assert->check({test => sub{}});

  # true

  # $assert->check({test => {}});

  # false

  # $assert->check({test => bless{}});

  # false

  # $assert->check({test => bless sub{}});

  # false

=cut

$test->for('example', 2, 'within', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !$result->check({});
  ok $result->check({test => sub{}});
  ok !$result->check({test => {}});
  ok !$result->check({test => sub{}, name => 1});
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless[]);
  ok !$result->check(bless{});
  ok $result->check(bless{test => sub{}});
  ok !$result->check(bless{test => sub{}, name => 1});
  ok !$result->check({test => bless{}});
  ok !$result->check({test => bless sub{}});

  $result
});

=example-3 within

  # given: synopsis

  package main;

  my $within = $assert->within('hashref', 'code');

  my $action = $assert;

  # $assert->check({});

  # false

  # $assert->check({test => sub{}});

  # true

  # $assert->check({test => {}});

  # false

  # $assert->check({test => bless{}});

  # false

  # $assert->check({test => bless sub{}});

  # false

=cut

$test->for('example', 3, 'within', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !$result->check({});
  ok $result->check({test => sub{}});
  ok !$result->check({test => {}});
  ok !$result->check({test => sub{}, name => 1});
  ok !$result->check(undef);
  ok !$result->check(0);
  ok !$result->check(1);
  ok !$result->check(bless[]);
  ok !$result->check(bless{});
  ok $result->check(bless{test => sub{}});
  ok !$result->check(bless{test => sub{}, name => 1});
  ok !$result->check({test => bless{}});
  ok !$result->check({test => bless sub{}});

  $result
});

=method yesno

The yesno method configures the object to accept a string value that's either
C<"yes"> or C<1>, C<"no"> or C<0>, and returns the invocant.

=signature yesno

  yesno(CodeRef $check) (Assert)

=metadata yesno

{
  since => '2.01',
}

=example-1 yesno

  # given: synopsis

  package main;

  $assert = $assert->yesno;

  # $assert->check(undef);

  # false

  # $assert->check(0);

  # true

  # $assert->check('No');

  # true

  # $assert->check('n');

  # true

  # $assert->check(1);

  # true

  # $assert->check('Yes');

  # true

  # $assert->check('y');

  # true

  # $assert->check('Okay');

  # false

=cut

$test->for('example', 1, 'yesno', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok !$result->check(undef);
  ok $result->check(0);
  ok $result->check('No');
  ok $result->check('n');
  ok $result->check(1);
  ok $result->check('Yes');
  ok $result->check('y');
  ok !$result->check('Okay');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

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

  $string = join ' | ',
    'number',
    'hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]',
    'tuple[number | string]';
  is_deeply scalar $assert->parse($string),
    [
    'either', 'number',
    [
      'hashkeys', 'id',
      ['either', 'number', 'float'], 'upvotes',
      ['within', 'arrayref', 'boolean'],
    ],
    ['tuple', ['either', 'number', 'string'],],
    ];

  $string = join ' | ',
    'number',
    'hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]';
  is_deeply scalar $assert->parse($string),
    [
    'either', 'number',
    [
      'hashkeys', 'id',
      ['either', 'number', 'float'], 'upvotes',
      ['within', 'arrayref', 'boolean'],
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

  $string = join ' | ',
    'number',
    'hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]',
    'tuple[number | string]';
  is_deeply scalar $assert->parse($string),
    [
    'either', 'number',
    [
      'hashkeys', 'id',
      ['either', 'number', 'float'], 'upvotes',
      ['within', 'arrayref', 'boolean'],
    ],
    ['tuple', ['either', 'number', 'string'],],
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

  $string = join ' | ',
    'hashkeys["id", number | float, "upvotes", within[arrayref, number | boolean]]',
    'string',
    'number';
  is_deeply scalar $assert->parse($string),
    [
    'either',
    [
      'hashkeys', 'id', ['either', 'number', 'float'],
      'upvotes', ['within', 'arrayref', ['either', 'number', 'boolean',],],
    ],
    'string', 'number',
    ];

  $string = join ' | ',
    'hashkeys["id", number | float, "upvotes", within[arrayref, boolean]]',
    'string',
    'Example::Thing';
  is_deeply scalar $assert->parse($string),
    [
    'either',
    [
      'hashkeys', 'id',
      ['either', 'number', 'float'], 'upvotes',
      ['within', 'arrayref', 'boolean',],
    ],
    'string',
    'Example::Thing',
    ];

  $string = join ' | ',
    'Example::String',
    'hashkeys["id", number', 'float, "upvotes", within[arrayref, boolean]]',
    'Example::Thing',
    'string',
    'number';
  is_deeply scalar $assert->parse($string),
    [
    'either',
    'Example::String',
    [
      'hashkeys', 'id',
      ['either', 'number', 'float'], 'upvotes',
      ['within', 'arrayref', 'boolean',],
    ],
    'Example::Thing',
    'string', 'number',
    ];

  $string = join ' | ',
    'hashkeys["id", number | float, "upvotes", within[arrayref, number | boolean | hashkeys["id", number | float]]]',
    'hashkeys["id", number | float, "upvotes", within[arrayref, number | boolean | hashkeys["id", number | float]]]',
    'Example';
  is_deeply scalar $assert->parse($string),
    [
    'either',
    [
      'hashkeys',
      'id',
      ['either', 'number', 'float'],
      'upvotes',
      [
        'within',
        'arrayref',
        [
          'either', 'number',
          'boolean', ['hashkeys', 'id', ['either', 'number', 'float',],],
        ],
      ],
    ],
    [
      'hashkeys',
      'id',
      ['either', 'number', 'float'],
      'upvotes',
      [
        'within',
        'arrayref',
        [
          'either', 'number',
          'boolean', ['hashkeys', 'id', ['either', 'number', 'float',],],
        ],
      ],
    ],
    'Example',
    ];
};

# END

$test->render('lib/Venus/Assert.pod') if $ENV{RENDER};

ok 1 and done_testing;
