package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Schema

=cut

$test->for('name');

=tagline

Schema Class

=cut

$test->for('tagline');

=abstract

Schema Class for Perl 5

=cut

$test->for('abstract');

=includes

method: assert
method: check
method: deduce
method: error
method: validate

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Schema;

  my $schema = Venus::Schema->new;

  # bless({...}, 'Venus::Schema')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Schema');

  $result
});

=description

This package provides methods for validating whether objects and complex data
structures conform to a schema.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=attribute definition

The definition attribute is read-write, accepts C<(HashRef)> values, and is
optional.

=signature definition

  definition(HashRef $data) (HashRef)

=metadata definition

{
  since => '2.55',
}

=cut

=example-1 definition

  # given: synopsis

  package main;

  my $definition = $schema->definition({});

  # {}

=cut

$test->for('example', 1, 'definition', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=example-2 definition

  # given: synopsis

  # given: example-1 definition

  package main;

  $definition = $schema->definition;

  # {}

=cut

$test->for('example', 2, 'definition', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=method assert

The assert method builds and returns a L<Venus::Assert> object based on the
L</definition>.

=signature assert

  assert() (Assert)

=metadata assert

{
  since => '2.55',
}

=cut

=example-1 assert

  # given: synopsis

  package main;

  my $assert = $schema->assert;

  # bless({...}, 'Venus::Assert')

=cut

$test->for('example', 1, 'assert', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Assert';
  is_deeply $result->expects, ['hashkeys[]'];

  $result
});

=example-2 assert

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
  });

  my $assert = $schema->assert;

  # bless({...}, 'Venus::Assert')

=cut

$test->for('example', 2, 'assert', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Assert';
  is_deeply $result->expects, ['hashkeys["name", string]'];

  $result
});

=method check

The check method builds an assert object using L</assert> and returns the
result of the L<Venus::Assert/check> method.

=signature check

  check(HashRef $data) (Bool)

=metadata check

{
  since => '2.55',
}

=cut

=example-1 check

  # given: synopsis

  package main;

  my $check = $schema->check;

  # 0

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 check

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $check = $schema->check({});

  # 0

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-3 check

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $check = $schema->check({
    name => 'someone',
    role => {},
  });

  # 0

=cut

$test->for('example', 3, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-4 check

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $check = $schema->check({
    name => 'someone',
    role => {
      title => 'engineer',
      level => 1,
    },
  });

  # 1

=cut

$test->for('example', 4, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=method deduce

The deduce method builds an assert object using L</assert> and validates the
value provided using L<Venus::Assert/validate>, passing the result to
L<Venus::Type/deduce_deep> unless the validation throws an exception.

=signature deduce

  deduce(HashRef $data) (Hash)

=metadata deduce

{
  since => '2.55',
}

=cut

=example-1 deduce

  # given: synopsis

  package main;

  my $deduce = $schema->deduce;

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 1, 'deduce', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-2 deduce

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $deduce = $schema->deduce({});

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 2, 'deduce', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-3 deduce

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $deduce = $schema->deduce({
    name => 'someone',
    role => {},
  });

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 3, 'deduce', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-4 deduce

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $deduce = $schema->deduce({
    name => 'someone',
    role => {
      title => 'engineer',
      level => 1,
    },
  });

  # bless({...}, 'Venus::Hash')

=cut

$test->for('example', 4, 'deduce', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Hash';

  $result
});

=method error

The error method builds an assert object using L</assert> and validates the
value provided using L<Venus::Assert/validate>, catching any error thrown and
returning it, otherwise returning undefined.

=signature error

  error(HashRef $data) (Error)

=metadata error

{
  since => '2.55',
}

=cut

=example-1 error

  # given: synopsis

  package main;

  my $error = $schema->error;

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-2 error

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $error = $schema->error({});

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-3 error

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $error = $schema->error({
    name => 'someone',
    role => {},
  });

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 3, 'error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-4 error

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $error = $schema->error({
    name => 'someone',
    role => {
      title => 'engineer',
      level => 1,
    },
  });

  # undef

=cut

$test->for('example', 4, 'error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=method validate

The validate method builds an assert object using L</assert> and validates the
value provided using L<Venus::Assert/validate>, returning the result unless the
validation throws an exception.

=signature validate

  validate(HashRef $data) (HashRef)

=metadata validate

{
  since => '2.55',
}

=cut

=example-1 validate

  # given: synopsis

  package main;

  my $validate = $schema->validate;

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 1, 'validate', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-2 validate

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $validate = $schema->validate({});

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 2, 'validate', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-3 validate

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $validate = $schema->validate({
    name => 'someone',
    role => {},
  });

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 3, 'validate', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=example-4 validate

  # given: synopsis

  package main;

  $schema->definition({
    name => 'string',
    role => {
      title => 'string',
      level => 'number',
    },
  });

  my $validate = $schema->validate({
    name => 'someone',
    role => {
      title => 'engineer',
      level => 1,
    },
  });

  # {name => 'someone', role => {title => 'engineer', level => 1,},}

=cut

$test->for('example', 4, 'validate', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    name => 'someone',
    role => {
      title => 'engineer',
      level => 1,
    },
  };

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Schema.pod') if $ENV{RENDER};

ok 1 and done_testing;
