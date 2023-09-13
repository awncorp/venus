package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;
use Venus;

my $test = test(__FILE__);

=name

Venus::Enum

=cut

$test->for('name');

=tagline

Enum Class

=cut

$test->for('tagline');

=abstract

Enum Class for Perl 5

=cut

$test->for('abstract');

=includes

method: get
method: has
method: is
method: items
method: list
method: name
method: names
method: value
method: values

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Enum;

  my $enum = Venus::Enum->new(['n', 's', 'e', 'w']);

  # my $north = $enum->get('n');

  # "n"

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Enum');

  !$result
});

=description

This package provides an interface for working with enumerations.

=cut

$test->for('description');

=inherits

Venus::Sealed

=cut

$test->for('inherits');

=method get

The get method returns a new object representing the enum member specified.

=signature get

  get(string $name) (Venus::Enum)

=metadata get

{
  since => '3.55',
}

=cut

=example-1 get

  # given: synopsis

  package main;

  my $get = $enum->get('n');

  # bless(..., "Venus::Enum")

  # $get->value

  # "n"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result->value, "n";

  $result
});

=example-2 get

  # given: synopsis

  package main;

  my $get = $enum->get('s');

  # bless(..., "Venus::Enum")

  # $get->value

  # "s"

=cut

$test->for('example', 2, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result->value, "s";

  $result
});

=method has

The has method returns true if the member name or value exists in the enum,
otherwise returns false.

=signature has

  has(string $name) (boolean)

=metadata has

{
  since => '3.55',
}

=cut

=example-1 has

  # given: synopsis

  package main;

  my $has = $enum->has('n');

  # true

=cut

$test->for('example', 1, 'has', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 has

  # given: synopsis

  package main;

  my $has = $enum->has('z');

  # false

=cut

$test->for('example', 2, 'has', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=method is

The is method returns true if the member name or value specified matches the
member selected in the enum, otherwise returns false.

=signature is

  is(string $name) (boolean)

=metadata is

{
  since => '3.55',
}

=cut

=example-1 is

  # given: synopsis

  package main;

  my $is = $enum->get('n')->is('n');

  # true

=cut

$test->for('example', 1, 'is', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 is

  # given: synopsis

  package main;

  my $is = $enum->get('s')->is('n');

  # false

=cut

$test->for('example', 2, 'is', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=method items

The items method returns an arrayref of arrayrefs containing the name and value
pairs for the enumerations. Returns a list in list context.

=signature items

  items() (tuple[string, string])

=metadata items

{
  since => '3.55',
}

=cut

=example-1 items

  # given: synopsis

  package main;

  my $items = $enum->items;

  # [["e", "e"], ["n", "n"], ["s", "s"], ["w", "w"]]

=cut

$test->for('example', 1, 'items', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, [["e", "e"], ["n", "n"], ["s", "s"], ["w", "w"]];

  $result
});

=example-2 items

  # given: synopsis

  package main;

  my @items = $enum->items;

  # (["e", "e"], ["n", "n"], ["s", "s"], ["w", "w"])

=cut

$test->for('example', 2, 'items', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, [["e", "e"], ["n", "n"], ["s", "s"], ["w", "w"]];

  @result
});

=method list

The list method returns an arrayref containing the values for the enumerations.
Returns a list in list context.

=signature list

  list() (within[arrayref, string])

=metadata list

{
  since => '3.55',
}

=cut

=example-1 list

  # given: synopsis

  package main;

  my $list = $enum->list;

  # ["e", "n", "s", "w"]

=cut

$test->for('example', 1, 'list', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["e", "n", "s", "w"];

  $result
});

=example-2 list

  # given: synopsis

  package main;

  my @list = $enum->list;

  # ("e", "n", "s", "w")

=cut

$test->for('example', 2, 'list', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, ["e", "n", "s", "w"];

  @result
});

=method name

The name method returns the name of the member selected or returns undefined.

=signature name

  name() (maybe[string])

=metadata name

{
  since => '3.55',
}

=cut

=example-1 name

  # given: synopsis

  package main;

  my $name = $enum->name;

  # undef

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=example-2 name

  # given: synopsis

  package main;

  my $n = $enum->get('n');

  my $name = $n->name;

  # "n"

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "n";

  $result
});

=method names

The names method returns an arrayref containing the names for the enumerations.
Returns a list in list context.

=signature names

  names() (within[arrayref, string])

=metadata names

{
  since => '3.55',
}

=cut

=example-1 names

  # given: synopsis

  package main;

  my $names = $enum->names;

  # ["e", "n", "s", "w"]

=cut

$test->for('example', 1, 'names', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["e", "n", "s", "w"];

  $result
});

=example-2 names

  # given: synopsis

  package main;

  my @names = $enum->names;

  # ("e", "n", "s", "w")

=cut

$test->for('example', 2, 'names', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, ["e", "n", "s", "w"];

  @result
});

=method value

The value method returns the value of the member selected or returns undefined.

=signature value

  value() (maybe[string])

=metadata value

{
  since => '3.55',
}

=cut

=example-1 value

  # given: synopsis

  package main;

  my $value = $enum->value;

  # undef

=cut

$test->for('example', 1, 'value', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=example-2 value

  # given: synopsis

  package main;

  my $n = $enum->get('n');

  my $value = $n->value;

  # "n"

=cut

$test->for('example', 2, 'value', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "n";

  $result
});

=method values

The values method returns an arrayref containing the values for the
enumerations. Returns a list in list context.

=signature values

  values() (within[arrayref, string])

=metadata values

{
  since => '3.55',
}

=cut

=example-1 values

  # given: synopsis

  package main;

  my $values = $enum->values;

  # ["e", "n", "s", "w"]

=cut

$test->for('example', 1, 'values', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["e", "n", "s", "w"];

  $result
});

=example-2 values

  # given: synopsis

  package main;

  my @values = $enum->values;

  # ("e", "n", "s", "w")

=cut

$test->for('example', 2, 'values', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, ["e", "n", "s", "w"];

  @result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$enum";

  # ""

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "";

  !$result
});

=example-2 ("")

  # given: synopsis;

  my $n = $enum->get("n");

  my $result = "$n";

  # "n"

=cut

$test->for('example', 2, '("")', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "n";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $enum eq "";

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (eq)

  # given: synopsis;

  my $s = $enum->get("s");

  my $result = $s eq "s";

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $enum ne "";

  # 0

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !$result;

  !$result
});

=example-2 (ne)

  # given: synopsis;

  my $n = $enum->get("n");

  my $result = $n ne "";

  # 1

=cut

$test->for('example', 2, '(ne)', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $n = $enum->get('n');

  my $test = 'north' =~ qr/$n/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result == 1;

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Enum.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
