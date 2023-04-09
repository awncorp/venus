package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Scalar::Util 'refaddr';

my $test = test(__FILE__);

=name

Venus::Kind

=cut

$test->for('name');

=tagline

Kind Base Class

=cut

$test->for('tagline');

=abstract

Kind Base Class for Perl 5

=cut

$test->for('abstract');

=includes

method: assertion
method: checksum
method: numified
method: renew
method: safe
method: self
method: stringified
method: trap

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  base 'Venus::Kind';

  package main;

  my $example = Example->new;

  # bless({}, "Example")

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=description

This package provides identity and methods common across all L<Venus> classes.

=cut

$test->for('description');

=integrates

Venus::Role::Assertable
Venus::Role::Boxable
Venus::Role::Catchable
Venus::Role::Comparable
Venus::Role::Deferrable
Venus::Role::Digestable
Venus::Role::Doable
Venus::Role::Dumpable
Venus::Role::Matchable
Venus::Role::Mockable
Venus::Role::Printable
Venus::Role::Reflectable
Venus::Role::Serializable
Venus::Role::Testable
Venus::Role::Throwable
Venus::Role::Tryable

=cut

$test->for('integrates');

=method assertion

The assertion method returns a L<Venus::Assert> object based on the invocant.

=signature assertion

  assertion() (Assert)

=metadata assertion

{
  since => '1.23',
}

=example-1 assertion

  # given: synopsis

  package main;

  my $assertion = $example->assertion;

  # bless({name => "Example"}, "Venus::Assert")

=cut

$test->for('example', 1, 'assertion', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Assert');
  ok $result->name eq 'Example';
  ok $result->message
    eq 'Type assertion (%s) failed: received (%s), expected (%s)';

  $result
});

=method checksum

The checksum method returns an md5 hash string representing the stringified
object value (or the object itself).

=signature checksum

  checksum() (Str)

=metadata checksum

{
  since => '0.08',
}

=example-1 checksum

  # given: synopsis;

  my $checksum = $example->checksum;

  # "859a86eed4b2d97eb7b830b02f06de32"

=cut

$test->for('example', 1, 'checksum', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "859a86eed4b2d97eb7b830b02f06de32";

  $result
});

=example-2 checksum

  package Checksum::Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'value';

  package main;

  my $example = Checksum::Example->new(value => 'example');

  my $checksum = $example->checksum;

  # "1a79a4d60de6718e8e5b326e338ae533"

=cut

$test->for('example', 2, 'checksum', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "1a79a4d60de6718e8e5b326e338ae533";

  $result
});

=method numified

The numified method returns the numerical representation of the object which is
typically the length (or character count) of the stringified object.

=signature numified

  numified() (Int)

=metadata numified

{
  since => '0.08',
}

=example-1 numified

  # given: synopsis;

  my $numified = $example->numified;

  # 22

=cut

$test->for('example', 1, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 22;

  $result
});

=example-2 numified

  package Numified::Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'value';

  package main;

  my $example = Numified::Example->new(value => 'example');

  my $numified = $example->numified;

  # 7

=cut

$test->for('example', 2, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 7;

  $result
});

=method renew

The renew method returns a new instance of the invocant by instantiating the
underlying class passing all recognized class attributes to the constructor.
B<Note:> This method is not analogous to C<clone>, i.e. attributes which are
references will be passed to the new object as references.

=signature renew

  renew(Any @args) (Object)

=metadata renew

{
  since => '1.23',
}

=example-1 renew

  # given: synopsis

  package main;

  my $renew = $example->renew;

  # bless({}, "Example")

=cut

$test->for('example', 1, 'renew', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  my $e1 = refaddr $result;
  my $e2 = refaddr $result->renew;
  isnt $e1, $e2;

  $result
});

=example-2 renew

  package Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'values';

  package main;

  my $example = Example->new(values => [1,2]);

  my $renew = $example->renew;

  # bless({values => [1,2]}, "Example")

=cut

$test->for('example', 2, 'renew', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is_deeply $result->values, [1,2];
  my $e1 = $result;
  my $e2 = $e1->renew;
  isnt refaddr($e1), refaddr($e2);
  is_deeply $e1->values, $e2->values;

  $result
});

=example-3 renew

  package Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'keys';
  attr 'values';

  package main;

  my $example = Example->new(values => [1,2]);

  my $renew = $example->renew(keys => ['a','b']);

  # bless({keys => ["a","b"], values => [1,2]}, "Example")

=cut

$test->for('example', 3, 'renew', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is_deeply $result->keys, ['a','b'];
  is_deeply $result->values, [1,2];
  my $e1 = $result;
  my $e2 = $result->renew;
  isnt refaddr($e1), refaddr($e2);
  is_deeply $e1->keys, $e2->keys;
  is_deeply $e1->values, $e2->values;
  my $e3 = $result->renew(values => [1..4]);
  isnt refaddr($e1), refaddr($e3);
  isnt refaddr($e2), refaddr($e3);
  is_deeply $e1->keys, $e3->keys;
  is_deeply $e2->keys, $e3->keys;
  is_deeply $e3->values, [1..4];

  $result
});

=method safe

The safe method dispatches the method call or executes the callback and returns
the result, supressing warnings and exceptions. If an exception is thrown this
method will return C<undef>. This method supports dispatching, i.e. providing a
method name and arguments whose return value will be acted on by this method.

=signature safe

  safe(Str | CodeRef $code, Any @args) (Any)

=metadata safe

{
  since => '0.08',
}

=example-1 safe

  # given: synopsis;

  my $safe = $example->safe('class');

  # "Example"

=cut

$test->for('example', 1, 'safe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Example";

  $result
});

=example-2 safe

  # given: synopsis;

  my $safe = $example->safe(sub {
    ${_}->class / 2
  });

  # '0'

=cut

$test->for('example', 2, 'safe', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok defined $result;
  is $result, 0;

  !$result
});

=example-3 safe

  # given: synopsis;

  my $safe = $example->safe(sub {
    die;
  });

  # undef

=cut

$test->for('example', 3, 'safe', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok not defined $result;

  !$result
});

=method self

The self method returns the invocant.

=signature self

  self() (Any)

=metadata self

{
  since => '1.23',
}

=example-1 self

  # given: synopsis

  package main;

  my $self = $example->self;

  # bless({}, "Example")

=cut

$test->for('example', 1, 'self', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  my $e1 = refaddr $result;
  my $e2 = refaddr $result->self;
  is $e1, $e2;

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

  my $stringified = $example->stringified;

  # bless({}, 'Example')


=cut

$test->for('example', 1, 'stringified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "bless( {}, 'Example' )";

  $result
});

=example-2 stringified

  package Stringified::Example;

  use Venus::Class;

  base 'Venus::Kind';

  attr 'value';

  package main;

  my $example = Stringified::Example->new(value => 'example');

  my $stringified = $example->stringified;

  # "example"

=cut

$test->for('example', 2, 'stringified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'example';

  $result
});

=method trap

The trap method dispatches the method call or executes the callback and returns
a tuple (i.e. a 3-element arrayref) with the results, warnings, and exceptions
from the code execution. If an exception is thrown, the results (i.e. the
1st-element) will be an empty arrayref. This method supports dispatching, i.e.
providing a method name and arguments whose return value will be acted on by
this method.

=signature trap

  trap(Str | CodeRef $code, Any @args) (Tuple[ArrayRef, ArrayRef, ArrayRef])

=metadata trap

{
  since => '0.08',
}

=example-1 trap

  # given: synopsis;

  my $result = $example->trap('class');

  # ["Example"]

=cut

$test->for('example', 1, 'trap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["Example"];

  $result
});

=example-2 trap

  # given: synopsis;

  my ($results, $warnings, $errors) = $example->trap('class');

  # (["Example"], [], [])

=cut

$test->for('example', 2, 'trap', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is_deeply \@result, [["Example"],[],[]];

  @result
});

=example-3 trap

  # given: synopsis;

  my $trap = $example->trap(sub {
    ${_}->class / 2
  });

  # ["0"]

=cut

$test->for('example', 3, 'trap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['0'];

  $result
});

=example-4 trap

  # given: synopsis;

  my ($results, $warnings, $errors) = $example->trap(sub {
    ${_}->class / 2
  });

  # (["0"], ["Argument ... isn't numeric in division ..."], [])

=cut

$test->for('example', 4, 'trap', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is @result, 3;
  is $result[0][0], 0;
  like $result[1][0], qr/argument.*isn't numeric in division.*/i;
  ok !@{$result[2]};

  @result
});

=example-5 trap

  # given: synopsis;

  my $trap = $example->trap(sub {
    die;
  });

  # []

=cut

$test->for('example', 5, 'trap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-6 trap

  # given: synopsis;

  my ($results, $warnings, $errors) = $example->trap(sub {
    die;
  });

  # ([], [], ["Died..."])

=cut

$test->for('example', 6, 'trap', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is @result, 3;
  ok !@{$result[0]};
  ok !@{$result[1]};
  like $result[2][0], qr/died/i;

  @result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Kind.pod') if $ENV{RENDER};

ok 1 and done_testing;