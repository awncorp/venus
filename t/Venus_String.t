package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::String

=cut

$test->for('name');

=tagline

String Class

=cut

$test->for('tagline');

=abstract

String Class for Perl 5

=cut

$test->for('abstract');

=includes

method: append
method: append_with
method: camelcase
method: cast
method: chomp
method: chop
method: concat
method: contains
method: default
method: eq
method: ge
method: gele
method: gt
method: gtlt
method: hex
method: index
method: kebabcase
method: lc
method: lcfirst
method: le
method: length
method: lines
method: lowercase
method: lt
method: ne
method: numified
method: pascalcase
method: prepend
method: prepend_with
method: render
method: repeat
method: replace
method: reverse
method: rindex
method: search
method: snakecase
method: split
method: stringified
method: strip
method: substr
method: template
method: titlecase
method: trim
method: tv
method: uc
method: ucfirst
method: uppercase
method: words

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  # $string->camelcase;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating string data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method append

The append method appends arugments to the string using spaces.

=signature append

  append(Str @parts) (Str)

=metadata append

{
  since => '0.01',
}

=example-1 append

  # given: synopsis;

  my $append = $string->append('welcome');

  # "hello world welcome"

=cut

$test->for('example', 1, 'append', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world welcome";

  $result
});

=method append_with

The append_with method appends arugments to the string using the delimiter
provided.

=signature append_with

  append_with(Str $delimiter, Str @parts) (Str)

=metadata append_with

{
  since => '0.01',
}

=example-1 append_with

  # given: synopsis;

  my $append = $string->append_with(', ', 'welcome');

  # "hello world, welcome"

=cut

$test->for('example', 1, 'append_with', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world, welcome";

  $result
});

=method camelcase

The camelcase method converts the string to camelcase.

=signature camelcase

  camelcase() (Str)

=metadata camelcase

{
  since => '0.01',
}

=example-1 camelcase

  # given: synopsis;

  my $camelcase = $string->camelcase;

  # "helloWorld"

=cut

$test->for('example', 1, 'camelcase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "helloWorld";

  $result
});

=method cast

The cast method converts L<"value"|Venus::Kind::Value> objects between
different I<"value"> object types, based on the name of the type provided. This
method will return C<undef> if the invocant is not a L<Venus::Kind::Value>.

=signature cast

  cast(Str $kind) (Object | Undef)

=metadata cast

{
  since => '0.08',
}

=example-1 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('array');

  # bless({ value => [""] }, "Venus::Array")

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Array');
  is_deeply $result->get, [''];

  $result
});

=example-2 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('boolean');

  # bless({ value => 0 }, "Venus::Boolean")

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Boolean');
  is $result->get, 0;

  !$result
});

=example-3 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('code');

  # bless({ value => sub { ... } }, "Venus::Code")

=cut

$test->for('example', 3, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Code');
  is_deeply $result->get->(), '';

  $result
});

=example-4 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('float');

  # bless({ value => "0.0" }, "Venus::Float")

=cut

$test->for('example', 4, 'cast', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Float');
  is $result->get, '0.0';

  1
});

=example-5 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('hash');

  # bless({ value => { "" => "" } }, "Venus::Hash")

=cut

$test->for('example', 5, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Hash');
  is_deeply $result->get, {'',''};

  $result
});

=example-6 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('number');

  # bless({ value => 0 }, "Venus::Float")

=cut

$test->for('example', 6, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Number');
  is $result->get, 0;

  !$result
});

=example-7 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('regexp');

  # bless({ value => qr/(?^u:)/ }, "Venus::Regexp")

=cut

$test->for('example', 7, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Regexp');
  is $result->get, qr//;

  $result
});

=example-8 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('scalar');

  # bless({ value => \"" }, "Venus::Scalar")

=cut

$test->for('example', 8, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Scalar');
  is_deeply $result->get, \"";

  $result
});

=example-9 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('string');

  # bless({ value => "" }, "Venus::String")

=cut

$test->for('example', 9, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::String');
  is $result->get, '';

  !$result
});

=example-10 cast

  package main;

  use Venus::String;

  my $string = Venus::String->new;

  my $cast = $string->cast('undef');

  # bless({ value => undef }, "Venus::Undef")

=cut

$test->for('example', 10, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Kind::Value');
  ok $result->isa('Venus::Undef');

  !$result
});

=method chomp

The chomp method removes the newline (or the current value of $/) from the end
of the string.

=signature chomp

  chomp() (Str)

=metadata chomp

{
  since => '0.01',
}

=example-1 chomp

  package main;

  use Venus::String;

  my $string = Venus::String->new("name, age, dob, email\n");

  my $chomp = $string->chomp;

  # "name, age, dob, email"

=cut

$test->for('example', 1, 'chomp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "name, age, dob, email";

  $result
});

=example-2 chomp

  package main;

  use Venus::String;

  my $string = Venus::String->new("name, age, dob, email\n\n");

  my $chomp = $string->chomp;

  # "name, age, dob, email\n"

=cut

$test->for('example', 2, 'chomp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "name, age, dob, email\n";

  $result
});

=method chop

The chop method removes and returns the last character of the string.

=signature chop

  chop() (Str)

=metadata chop

{
  since => '0.01',
}

=example-1 chop

  package main;

  use Venus::String;

  my $string = Venus::String->new("this is just a test.");

  my $chop = $string->chop;

  # "this is just a test"

=cut

$test->for('example', 1, 'chop', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "this is just a test";

  $result
});

=method concat

The concat method returns the string with the argument list appended to it.

=signature concat

  concat(Str @parts) (Str)

=metadata concat

{
  since => '0.01',
}

=example-1 concat

  package main;

  use Venus::String;

  my $string = Venus::String->new('ABC');

  my $concat = $string->concat('DEF', 'GHI');

  # "ABCDEFGHI"

=cut

$test->for('example', 1, 'concat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "ABCDEFGHI";

  $result
});

=method contains

The contains method searches the string for a substring or expression returns
true or false if found.

=signature contains

  contains(Str $expr) (Bool)

=metadata contains

{
  since => '0.01',
}

=example-1 contains

  package main;

  use Venus::String;

  my $string = Venus::String->new('Nullam ultrices placerat.');

  my $contains = $string->contains('trices');

  # 1

=cut

$test->for('example', 1, 'contains', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 contains

  package main;

  use Venus::String;

  my $string = Venus::String->new('Nullam ultrices placerat.');

  my $contains = $string->contains('itrices');

  # 0

=cut

$test->for('example', 2, 'contains', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-3 contains

  package main;

  use Venus::String;

  my $string = Venus::String->new('Nullam ultrices placerat.');

  my $contains = $string->contains(qr/trices/);

  # 1

=cut

$test->for('example', 3, 'contains', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method default

The default method returns the default value, i.e. C<''>.

=signature default

  default() (Str)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $string->default;

  # ""

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result eq '';

  !$result
});

=method eq

The eq method performs an I<"equals"> operation using the argument provided.

=signature eq

  eq(Any $arg) (Bool)

=metadata eq

{
  since => '0.08',
}

=example-1 eq

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 1, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 eq

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 2, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 eq

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 3, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 eq

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 4, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 eq

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 5, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 eq

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 6, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 eq

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->eq($rvalue);

  # 0

=cut

$test->for('example', 7, 'eq', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 eq

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 8, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 eq

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->eq($rvalue);

  # 1

=cut

$test->for('example', 9, 'eq', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method ge

The ge method performs a I<"greater-than-or-equal-to"> operation using the
argument provided.

=signature ge

  ge(Any $arg) (Bool)

=metadata ge

{
  since => '0.08',
}

=example-1 ge

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 1, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 ge

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 2, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 ge

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 3, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 ge

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 4, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 ge

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 5, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 ge

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 6, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 ge

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ge($rvalue);

  # 0

=cut

$test->for('example', 7, 'ge', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 ge

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 8, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 ge

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ge($rvalue);

  # 1

=cut

$test->for('example', 9, 'ge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method gele

The gele method performs a I<"greater-than-or-equal-to"> operation on the 1st
argument, and I<"lesser-than-or-equal-to"> operation on the 2nd argument.

=signature gele

  gele(Any $arg1, Any $arg2) (Bool)

=metadata gele

{
  since => '0.08',
}

=example-1 gele

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 1, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 gele

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 2, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 gele

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 3, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 gele

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 4, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 gele

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 5, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 gele

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 6, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 gele

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gele($rvalue);

  # 0

=cut

$test->for('example', 7, 'gele', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 gele

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=cut

$test->for('example', 8, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 gele

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gele($rvalue);

  # 1

=cut

$test->for('example', 9, 'gele', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method gt

The gt method performs a I<"greater-than"> operation using the argument provided.

=signature gt

  gt(Any $arg) (Bool)

=metadata gt

{
  since => '0.08',
}

=example-1 gt

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 1, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 gt

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 2, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 gt

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 3, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 gt

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 4, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 gt

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 5, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 gt

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 6, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 gt

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 7, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 gt

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 8, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 gt

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gt($rvalue);

  # 0

=cut

$test->for('example', 9, 'gt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method gtlt

The gtlt method performs a I<"greater-than"> operation on the 1st argument, and
I<"lesser-than"> operation on the 2nd argument.

=signature gtlt

  gtlt(Any $arg1, Any $arg2) (Bool)

=metadata gtlt

{
  since => '0.08',
}

=example-1 gtlt

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 1, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 gtlt

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 2, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 gtlt

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 3, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 gtlt

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 4, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 gtlt

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 5, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 gtlt

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 6, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 gtlt

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 7, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 gtlt

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 8, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 gtlt

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->gtlt($rvalue);

  # 0

=cut

$test->for('example', 9, 'gtlt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method hex

The hex method returns the value resulting from interpreting the string as a
hex string.

=signature hex

  hex() (Str)

=metadata hex

{
  since => '0.01',
}

=example-1 hex

  package main;

  use Venus::String;

  my $string = Venus::String->new('0xaf');

  my $hex = $string->hex;

  # 175

=cut

$test->for('example', 1, 'hex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 175;

  $result
});

=method index

The index method searches for the argument within the string and returns the
position of the first occurrence of the argument.

=signature index

  index(Str $substr, Int $start) (Num)

=metadata index

{
  since => '0.01',
}

=example-1 index

  package main;

  use Venus::String;

  my $string = Venus::String->new('unexplainable');

  my $index = $string->index('explain');

  # 2

=cut

$test->for('example', 1, 'index', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
});

=example-2 index

  package main;

  use Venus::String;

  my $string = Venus::String->new('unexplainable');

  my $index = $string->index('explain', 1);

  # 2

=cut

$test->for('example', 2, 'index', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
});

=example-3 index

  package main;

  use Venus::String;

  my $string = Venus::String->new('unexplainable');

  my $index = $string->index('explained');

  # -1

=cut

$test->for('example', 3, 'index', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == -1;

  $result
});

=method kebabcase

The kebabcase method converts the string to kebabcase.

=signature kebabcase

  kebabcase() (Str)

=metadata kebabcase

{
  since => '0.09',
}

=example-1 kebabcase

  # given: synopsis;

  my $kebabcase = $string->kebabcase;

  # "hello-world"

=cut

$test->for('example', 1, 'kebabcase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello-world";

  $result
});

=method lc

The lc method returns a lowercased version of the string.

=signature lc

  lc() (Str)

=metadata lc

{
  since => '0.01',
}

=example-1 lc

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hello World');

  my $lc = $string->lc;

  # "hello world"

=cut

$test->for('example', 1, 'lc', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world";

  $result
});

=method lcfirst

The lcfirst method returns a the string with the first character lowercased.

=signature lcfirst

  lcfirst() (Str)

=metadata lcfirst

{
  since => '0.01',
}

=example-1 lcfirst

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hello World');

  my $lcfirst = $string->lcfirst;

  # "hello World"

=cut

$test->for('example', 1, 'lcfirst', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello World";

  $result
});

=method le

The le method performs a I<"lesser-than-or-equal-to"> operation using the
argument provided.

=signature le

  le(Any $arg) (Bool)

=metadata le

{
  since => '0.08',
}

=example-1 le

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 1, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 le

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 2, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 le

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 3, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 le

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 4, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 le

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 5, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 le

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 6, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 le

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 7, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 le

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 8, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 le

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->le($rvalue);

  # 1

=cut

$test->for('example', 9, 'le', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method length

The length method returns the number of characters within the string.

=signature length

  length() (Int)

=metadata length

{
  since => '0.01',
}

=example-1 length

  # given: synopsis;

  my $length = $string->length;

  # 11

=cut

$test->for('example', 1, 'length', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 11;

  $result
});

=method lines

The lines method returns an arrayref of parts by splitting on 1 or more newline
characters.

=signature lines

  lines() (ArrayRef[Str])

=metadata lines

{
  since => '0.01',
}

=example-1 lines

  # given: synopsis;

  my $lines = $string->lines;

  # ["hello world"]

=cut

$test->for('example', 1, 'lines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["hello world"];

  $result
});

=example-2 lines

  package main;

  use Venus::String;

  my $string = Venus::String->new("who am i?\nwhere am i?\nhow did I get here");

  my $lines = $string->lines;

  # ["who am i?", "where am i?", "how did I get here"]

=cut

$test->for('example', 2, 'lines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["who am i?", "where am i?", "how did I get here"];

  $result
});

=method lt

The lt method performs a I<"lesser-than"> operation using the argument provided.

=signature lt

  lt(Any $arg) (Bool)

=metadata lt

{
  since => '0.08',
}

=example-1 lt

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 1, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 lt

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 2, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 lt

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 3, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 lt

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 4, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 lt

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 5, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 lt

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 6, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 lt

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->lt($rvalue);

  # 1

=cut

$test->for('example', 7, 'lt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 lt

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 8, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 lt

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->lt($rvalue);

  # 0

=cut

$test->for('example', 9, 'lt', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method ne

The ne method performs a I<"not-equal-to"> operation using the argument provided.

=signature ne

  ne(Any $arg) (Bool)

=metadata ne

{
  since => '0.08',
}

=example-1 ne

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 1, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 ne

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 2, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 ne

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 3, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 ne

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 4, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-5 ne

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 5, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 ne

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 6, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 ne

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->ne($rvalue);

  # 1

=cut

$test->for('example', 7, 'ne', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-8 ne

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 8, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-9 ne

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->ne($rvalue);

  # 0

=cut

$test->for('example', 9, 'ne', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method pascalcase

The pascalcase method converts the string to pascalcase.

=signature pascalcase

  pascalcase() (Str)

=metadata pascalcase

{
  since => '0.01',
}

=example-1 pascalcase

  # given: synopsis;

  my $pascalcase = $string->pascalcase;

  # "HelloWorld"

=cut

$test->for('example', 1, 'pascalcase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HelloWorld";

  $result
});

=method prepend

The prepend method prepends arugments to the string using spaces.

=signature prepend

  prepend(Str @parts) (Str)

=metadata prepend

{
  since => '0.01',
}

=example-1 prepend

  # given: synopsis;

  my $prepend = $string->prepend('welcome');

  # "welcome hello world"

=cut

$test->for('example', 1, 'prepend', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "welcome hello world";

  $result
});

=method prepend_with

The prepend_with method prepends arugments to the string using the delimiter
provided.

=signature prepend_with

  prepend_with(Str $delimiter, Str @parts) (Str)

=metadata prepend_with

{
  since => '0.01',
}

=example-1 prepend_with

  # given: synopsis;

  my $prepend = $string->prepend_with(', ', 'welcome');

  # "welcome, hello world"

=cut

$test->for('example', 1, 'prepend_with', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "welcome, hello world";

  $result
});

=method lowercase

The lowercase method is an alias to the lc method.

=signature lowercase

  lowercase() (Str)

=metadata lowercase

{
  since => '0.01',
}

=example-1 lowercase

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hello World');

  my $lowercase = $string->lowercase;

  # "hello world"

=cut

$test->for('example', 1, 'lowercase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world";

  $result
});

=method repeat

The repeat method repeats the string value N times based on the number provided
and returns a new concatenated string. Optionally, a delimiter can be provided
and be place between the occurences.

=signature repeat

  repeat(Num $number, Str $delimiter) (Str)

=metadata repeat

{
  since => '0.01',
}

=example-1 repeat

  package main;

  use Venus::String;

  my $string = Venus::String->new('999');

  my $repeat = $string->repeat(2);

  # "999999"

=cut

$test->for('example', 1, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "999999";

  $result
});

=example-2 repeat

  package main;

  use Venus::String;

  my $string = Venus::String->new('999');

  my $repeat = $string->repeat(2, ',');

  # "999,999"

=cut

$test->for('example', 2, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "999,999";

  $result
});

=method numified

The numified method returns the numerical representation of the object. For
string objects this method returns the underlying value, if that value looks
like a number, or C<0>.

=signature numified

  numified() (Int)

=metadata numified

{
  since => '0.08',
}

=example-1 numified

  # given: synopsis;

  my $numified = $string->numified;

  # 11

=cut

$test->for('example', 1, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 11;

  $result
});

=example-2 numified

  package main;

  use Venus::String;

  my $string = Venus::String->new(1_000_000);

  my $numified = $string->numified;

  # 1000000

=cut

$test->for('example', 2, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1000000;

  $result
});

=method render

The render method treats the string as a template and performs a simple token
replacement using the argument provided.

=signature render

  render(HashRef $tokens) (Str)

=metadata render

{
  since => '0.01',
}

=example-1 render

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hi, {{name}}!');

  my $render = $string->render({name => 'Friend'});

  # "Hi, Friend!"

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Hi, Friend!";

  $result
});

=method search

The search method performs a search operation and returns the L<Venus::Search>
object.

=signature search

  search(Regexp $regexp) (Search)

=metadata search

{
  since => '0.01',
}

=example-1 search

  # given: synopsis;

  my $search = $string->search('world');

  # bless({
  #   ...,
  #   "flags"   => "",
  #   "regexp"  => "world",
  #   "string"  => "hello world",
  # }, "Venus::Search")

=cut

$test->for('example', 1, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Search');

  $result
});

=method replace

The replace method performs a search and replace operation and returns the
L<Venus::Replace> object.

=signature replace

  replace(Regexp $regexp, Str $replace, Str $flags) (Replace)

=metadata replace

{
  since => '0.01',
}

=example-1 replace

  # given: synopsis;

  my $replace = $string->replace('world', 'universe');

  # bless({
  #   ...,
  #   "flags"   => "",
  #   "regexp"  => "world",
  #   "string"  => "hello world",
  #   "substr"  => "universe",
  # }, "Venus::Replace")

=cut

$test->for('example', 1, 'replace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Replace');

  $result
});

=method reverse

The reverse method returns a string where the characters in the string are in
the opposite order.

=signature reverse

  reverse() (Str)

=metadata reverse

{
  since => '0.01',
}

=example-1 reverse

  # given: synopsis;

  my $reverse = $string->reverse;

  # "dlrow olleh"

=cut

$test->for('example', 1, 'reverse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "dlrow olleh";

  $result
});

=method rindex

The rindex method searches for the argument within the string and returns the
position of the last occurrence of the argument.

=signature rindex

  rindex(Str $substr, Int $start) (Str)

=metadata rindex

{
  since => '0.01',
}

=example-1 rindex

  package main;

  use Venus::String;

  my $string = Venus::String->new('explain the unexplainable');

  my $rindex = $string->rindex('explain');

  # 14

=cut

$test->for('example', 1, 'rindex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 14;

  $result
});

=example-2 rindex

  package main;

  use Venus::String;

  my $string = Venus::String->new('explain the unexplainable');

  my $rindex = $string->rindex('explained');

  # -1

=cut

$test->for('example', 2, 'rindex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == -1;

  $result
});

=example-3 rindex

  package main;

  use Venus::String;

  my $string = Venus::String->new('explain the unexplainable');

  my $rindex = $string->rindex('explain', 21);

  # 14

=cut

$test->for('example', 3, 'rindex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 14;

  $result
});

=method snakecase

The snakecase method converts the string to snakecase.

=signature snakecase

  snakecase() (Str)

=metadata snakecase

{
  since => '0.01',
}

=example-1 snakecase

  # given: synopsis;

  my $snakecase = $string->snakecase;

  # "hello_world"

=cut

$test->for('example', 1, 'snakecase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello_world";

  $result
});

=method split

The split method returns an arrayref by splitting the string on the argument.

=signature split

  split(Str | Regexp $expr, Maybe[Int] $limit) (ArrayRef)

=metadata split

{
  since => '0.01',
}

=example-1 split

  package main;

  use Venus::String;

  my $string = Venus::String->new('name, age, dob, email');

  my $split = $string->split(', ');

  # ["name", "age", "dob", "email"]

=cut

$test->for('example', 1, 'split', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["name", "age", "dob", "email"];

  $result
});

=example-2 split

  package main;

  use Venus::String;

  my $string = Venus::String->new('name, age, dob, email');

  my $split = $string->split(', ', 2);

  # ["name", "age, dob, email"]

=cut

$test->for('example', 2, 'split', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["name", "age, dob, email"];

  $result
});

=example-3 split

  package main;

  use Venus::String;

  my $string = Venus::String->new('name, age, dob, email');

  my $split = $string->split(qr/\,\s*/);

  # ["name", "age", "dob", "email"]

=cut

$test->for('example', 3, 'split', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["name", "age", "dob", "email"];

  $result
});

=method stringified

The stringified method returns the object, stringified (i.e. a dump of the
object's value).

=signature stringified

  stringified() (Str)

=metadata stringified

{
  since => '0.08',
}

=example-1 stringified

  # given: synopsis;

  my $stringified = $string->stringified;

  # "hello world"

=cut

$test->for('example', 1, 'stringified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "hello world";

  $result
});

=example-2 stringified

  package main;

  use Venus::String;

  my $string = Venus::String->new("hello\nworld");

  my $stringified = $string->stringified;

  # "hello\\nworld"

=cut

$test->for('example', 2, 'stringified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'hello\\nworld';

  $result
});

=method strip

The strip method returns the string replacing occurences of 2 or more
whitespaces with a single whitespace.

=signature strip

  strip() (Str)

=metadata strip

{
  since => '0.01',
}

=example-1 strip

  package main;

  use Venus::String;

  my $string = Venus::String->new('one,  two,  three');

  my $strip = $string->strip;

  # "one, two, three"

=cut

$test->for('example', 1, 'strip', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "one, two, three";

  $result
});

=method substr

The substr method calls the core L</substr> function with the object's string
value. In list context returns the result and the subject.

=signature substr

  substr(Num $offset, Num $length, Str $replace) (Str)

=metadata substr

{
  since => '0.01',
}

=example-1 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my $substr = $string->substr(0, 5);

  # "hello"

=cut

$test->for('example', 1, 'substr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello";

  $result
});

=example-2 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my $substr = $string->substr(6, 5);

  # "world"

=cut

$test->for('example', 2, 'substr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "world";

  $result
});

=example-3 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my $substr = $string->substr(6, 5, 'universe');

  # "hello universe"

=cut

$test->for('example', 3, 'substr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello universe";

  $result
});

=example-4 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my ($result, $subject) = $string->substr(6, 5, 'universe');

  # ("world", "hello universe")

=cut

$test->for('example', 4, 'substr', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  ok $result[0] eq "world";
  ok $result[1] eq "hello universe";

  @result
});

=method template

The template method uses the underlying string value to build and return a
L<Venus::Template> object, or dispatches to the coderef or method provided.

=signature template

  template(Str | CodeRef $code, Any @args) (Any)

=metadata template

{
  since => '3.04',
}

=cut

=example-1 template

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello {{name}}');

  my $template = $string->template;

  # bless({...}, "Venus::Template")

=cut

$test->for('example', 1, 'template', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Template';
  is $result->get, 'hello {{name}}';

  $result
});

=example-2 template

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello {{name}}');

  my $template = $string->template('render', undef, {
    name => 'user',
  });

  # "hello user"

=cut

$test->for('example', 2, 'template', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'hello user';

  $result
});

=method titlecase

The titlecase method returns the string capitalizing the first character of
each word.

=signature titlecase

  titlecase() (Str)

=metadata titlecase

{
  since => '0.01',
}

=example-1 titlecase

  # given: synopsis;

  my $titlecase = $string->titlecase;

  # "Hello World"

=cut

$test->for('example', 1, 'titlecase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Hello World";

  $result
});

=method trim

The trim method removes one or more consecutive leading and/or trailing spaces
from the string.

=signature trim

  trim() (Str)

=metadata trim

{
  since => '0.01',
}

=example-1 trim

  package main;

  use Venus::String;

  my $string = Venus::String->new('   system is   ready   ');

  my $trim = $string->trim;

  # "system is   ready"

=cut

$test->for('example', 1, 'trim', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "system is   ready";

  $result
});

=method tv

The tv method performs a I<"type-and-value-equal-to"> operation using argument
provided.

=signature tv

  tv(Any $arg) (Bool)

=metadata tv

{
  since => '0.08',
}

=example-1 tv

  package main;

  use Venus::Array;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Array->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 1, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 tv

  package main;

  use Venus::Code;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Code->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 2, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 tv

  package main;

  use Venus::Float;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Float->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 3, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-4 tv

  package main;

  use Venus::Hash;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Hash->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 4, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-5 tv

  package main;

  use Venus::Number;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Number->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 5, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-6 tv

  package main;

  use Venus::Regexp;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Regexp->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 6, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-7 tv

  package main;

  use Venus::Scalar;
  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Scalar->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 7, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-8 tv

  package main;

  use Venus::String;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::String->new;

  my $result = $lvalue->tv($rvalue);

  # 1

=cut

$test->for('example', 8, 'tv', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-9 tv

  package main;

  use Venus::String;
  use Venus::Undef;

  my $lvalue = Venus::String->new;
  my $rvalue = Venus::Undef->new;

  my $result = $lvalue->tv($rvalue);

  # 0

=cut

$test->for('example', 9, 'tv', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=method uc

The uc method returns an uppercased version of the string.

=signature uc

  uc() (Str)

=metadata uc

{
  since => '0.01',
}

=example-1 uc

  # given: synopsis;

  my $uc = $string->uc;

  # "HELLO WORLD"

=cut

$test->for('example', 1, 'uc', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HELLO WORLD";

  $result
});

=method ucfirst

The ucfirst method returns a the string with the first character uppercased.

=signature ucfirst

  ucfirst() (Str)

=metadata ucfirst

{
  since => '0.01',
}

=example-1 ucfirst

  # given: synopsis;

  my $ucfirst = $string->ucfirst;

  # "Hello world"

=cut

$test->for('example', 1, 'ucfirst', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Hello world";

  $result
});

=method uppercase

The uppercase method is an alias to the uc method.

=signature uppercase

  uppercase() (Str)

=metadata uppercase

{
  since => '0.01',
}

=example-1 uppercase

  # given: synopsis;

  my $uppercase = $string->uppercase;

  # "HELLO WORLD"

=cut

$test->for('example', 1, 'uppercase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HELLO WORLD";

  $result
});

=method words

The words method returns an arrayref by splitting on 1 or more consecutive
spaces.

=signature words

  words() (ArrayRef[Str])

=metadata words

{
  since => '0.01',
}

=example-1 words

  package main;

  use Venus::String;

  my $string = Venus::String->new(
    'is this a bug we\'re experiencing'
  );

  my $words = $string->words;

  # ["is", "this", "a", "bug", "we're", "experiencing"]

=cut

$test->for('example', 1, 'words', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["is", "this", "a", "bug", "we're", "experiencing"];

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$string";

  # "hello world"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "hello world";

  $result
});

=example-2 ("")

  # given: synopsis;

  my $result = "$string, $string";

  # "hello world, hello world"

=cut

$test->for('example', 2, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "hello world, hello world";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $string eq 'hello world';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (eq)

  package main;

  use Venus::String;

  my $string1 = Venus::String->new('hello world');
  my $string2 = Venus::String->new('hello world');

  my $result = $string1 eq $string2;

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $string ne 'Hello world';

  1;

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (ne)

  package main;

  use Venus::String;

  my $string1 = Venus::String->new('hello world');
  my $string2 = Venus::String->new('Hello world');

  my $result = $string1 ne $string2;

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $test = 'hello world' =~ qr/$string/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/String.pod') if $ENV{RENDER};

ok 1 and done_testing;