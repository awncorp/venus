package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Type

=cut

$test->for('name');

=tagline

Type Class

=cut

$test->for('tagline');

=abstract

Type Class for Perl 5

=cut

$test->for('abstract');

=includes

method: code
method: deduce
method: deduce_deep
method: detract
method: detract_deep
method: package

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Type;

  my $type = Venus::Type->new([]);

  # $type->code;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for casting native data types to objects and the
reverse.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible

=cut

$test->for('integrates');

=method code

The code method returns the name of the value's data type.

=signature code

  code() (Str | Undef)

=metadata code

{
  since => '0.01',
}

=example-1 code

  # given: synopsis;

  my $code = $type->code;

  # "ARRAY"

=cut

$test->for('example', 1, 'code', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "ARRAY";

  $result
});

=example-2 code

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => {});

  my $code = $type->code;

  # "HASH"

=cut

$test->for('example', 2, 'code', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HASH";

  $result
});

=example-3 code

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => qr//);

  my $code = $type->code;

  # "REGEXP"

=cut

$test->for('example', 3, 'code', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "REGEXP";

  $result
});

=method deduce

The deduce methods returns the argument as a data type object.

=signature deduce

  deduce() (Object)

=metadata deduce

{
  since => '0.01',
}

=example-1 deduce

  # given: synopsis;

  my $deduce = $type->deduce;

  # bless({ value => [] }, "Venus::Array")

=cut

$test->for('example', 1, 'deduce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Array');

  $result
});

=example-2 deduce

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => {});

  my $deduce = $type->deduce;

  # bless({ value => {} }, "Venus::Hash")

=cut

$test->for('example', 2, 'deduce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Hash');

  $result
});

=example-3 deduce

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => qr//);

  my $deduce = $type->deduce;

  # bless({ value => qr// }, "Venus::Regexp")

=cut

$test->for('example', 3, 'deduce', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Regexp');

  $result
});

=method deduce_deep

The deduce_deep function returns any arguments as data type objects, including
nested data.

=signature deduce_deep

  deduce_deep() (Object)

=metadata deduce_deep

{
  since => '0.01',
}

=example-1 deduce_deep

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => [1..4]);

  my $deduce_deep = $type->deduce_deep;

  # bless({
  #   value => [
  #     bless({ value => 1 }, "Venus::Number"),
  #     bless({ value => 2 }, "Venus::Number"),
  #     bless({ value => 3 }, "Venus::Number"),
  #     bless({ value => 4 }, "Venus::Number"),
  #   ],
  # }, "Venus::Array")

=cut

$test->for('example', 1, 'deduce_deep', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Array');
  ok $result->get(0)->isa('Venus::Number');
  ok $result->get(1)->isa('Venus::Number');
  ok $result->get(2)->isa('Venus::Number');
  ok $result->get(3)->isa('Venus::Number');

  $result
});

=example-2 deduce_deep

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => {1..4});

  my $deduce_deep = $type->deduce_deep;

  # bless({
  #   value => {
  #     1 => bless({ value => 2 }, "Venus::Number"),
  #     3 => bless({ value => 4 }, "Venus::Number"),
  #   },
  # }, "Venus::Hash")

=cut

$test->for('example', 2, 'deduce_deep', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Hash');
  ok $result->get(1)->isa('Venus::Number');
  ok $result->get(1)->get == 2;
  ok $result->get(3)->isa('Venus::Number');
  ok $result->get(3)->get == 4;

  $result
});

=method detract

The detract method returns the argument as native Perl data type value.

=signature detract

  detract() (Any)

=metadata detract

{
  since => '0.01',
}

=example-1 detract

  package main;

  use Venus::Type;
  use Venus::Hash;

  my $type = Venus::Type->new(Venus::Hash->new({1..4}));

  my $detract = $type->detract;

  # { 1 => 2, 3 => 4 }

=cut

$test->for('example', 1, 'detract', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { 1 => 2, 3 => 4 };

  $result
});

=example-2 detract

  package main;

  use Venus::Type;
  use Venus::Array;

  my $type = Venus::Type->new(Venus::Array->new([1..4]));

  my $detract = $type->detract;

  # [1..4]

=cut

$test->for('example', 2, 'detract', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1..4];

  $result
});

=example-3 detract

  package main;

  use Venus::Type;
  use Venus::Regexp;

  my $type = Venus::Type->new(Venus::Regexp->new(qr/\w+/));

  my $detract = $type->detract;

  # qr/\w+/

=cut

$test->for('example', 3, 'detract', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq qr/\w+/;

  $result
});

=method detract_deep

The detract_deep method returns any arguments as native Perl data type values,
including nested data.

=signature detract_deep

  detract_deep() (Any)

=metadata detract_deep

{
  since => '0.01',
}

=example-1 detract_deep

  package main;

  use Venus::Type;
  use Venus::Hash;

  my $type = Venus::Type->new(Venus::Hash->new({1..4}));

  my $detract_deep = Venus::Type->new($type->deduce_deep)->detract_deep;

  # { 1 => 2, 3 => 4 }

=cut

$test->for('example', 1, 'detract_deep', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { 1 => 2, 3 => 4 };

  $result
});

=example-2 detract_deep

  package main;

  use Venus::Type;
  use Venus::Array;

  my $type = Venus::Type->new(Venus::Array->new([1..4]));

  my $detract_deep = Venus::Type->new($type->deduce_deep)->detract_deep;

  # [1..4]

=cut

$test->for('example', 2, 'detract_deep', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1..4];

  $result
});

=method package

The code method returns the package name of the objectified value, i.e.
C<ref()>.

=signature package

  package() (Str)

=metadata package

{
  since => '0.01',
}

=example-1 package

  # given: synopsis;

  my $package = $type->package;

  # "Venus::Array"

=cut

$test->for('example', 1, 'package', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Venus::Array";

  $result
});

=example-2 package

  package main;

  use Venus::Type;

  my $type = Venus::Type->new(value => {});

  my $package = $type->package;

  # "Venus::Hash"

=cut

$test->for('example', 2, 'package', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Venus::Hash";

  $result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Type.pod') if $ENV{RENDER};

ok 1 and done_testing;