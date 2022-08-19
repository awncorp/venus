package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

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

method: checksum
method: class
method: numified
method: safe
method: space
method: stringified
method: trap
method: type

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  base 'Venus::Kind';

  package main;

  my $example = Example->new;

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

Venus::Role::Boxable
Venus::Role::Catchable
Venus::Role::Comparable
Venus::Role::Digestable
Venus::Role::Doable
Venus::Role::Dumpable
Venus::Role::Matchable
Venus::Role::Printable
Venus::Role::Testable
Venus::Role::Throwable

=cut

$test->for('integrates');

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

=method class

The class method returns the class name for the given class or object.

=signature class

  class() (Str)

=metadata class

{
  since => '0.01',
}

=example-1 class

  # given: synopsis;

  my $class = $example->class;

  # "Example"

=cut

$test->for('example', 1, 'class', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Example";

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

=method space

The space method returns a L<Venus::Space> object for the given object.

=signature space

  space() (Space)

=metadata space

{
  since => '0.01',
}

=example-1 space

  # given: synopsis;

  my $space = $example->space;

  # bless({ value => "Example" }, "Venus::Space")

=cut

$test->for('example', 1, 'space', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');

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

=method type

The type method returns a L<Venus::Type> object for the given object.

=signature type

  type() (Type)

=metadata type

{
  since => '0.01',
}

=example-1 type

  # given: synopsis;

  my $type = $example->type;

  # bless({ value => bless({}, "Example") }, "Venus::Type")

=cut

$test->for('example', 1, 'type', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Type');
  ok $result->value->isa('Example');

  $result
});

# END

$test->render('lib/Venus/Kind.pod') if $ENV{RENDER};

ok 1 and done_testing;