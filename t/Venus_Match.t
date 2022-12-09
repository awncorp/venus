package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Match

=cut

$test->for('name');

=tagline

Match Class

=cut

$test->for('tagline');

=abstract

Match Class for Perl 5

=cut

$test->for('abstract');

=includes

method: clear
method: data
method: expr
method: just
method: none
method: only
method: result
method: then
method: when
method: where

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(5);

  $match->when(sub{$_ < 5})->then(sub{"< 5"});
  $match->when(sub{$_ > 5})->then(sub{"> 5"});

  $match->none(sub{"?"});

  my $result = $match->result;

  # "?"

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "?";

  $result
});

=description

This package provides an object-oriented interface for complex pattern matching
operations on scalar values. See L<Venus::Gather> for operating on collections
of data, e.g. array references.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Valuable

=cut

$test->for('inherits');

=attributes

on_none: rw, opt, CodeRef, C<sub{}>
on_only: rw, opt, CodeRef, C<sub{1}>
on_then: rw, opt, ArrayRef[CodeRef], C<[]>
on_when: rw, opt, ArrayRef[CodeRef], C<[]>

=cut

$test->for('attributes');

=method clear

The clear method resets all match conditions and returns the invocant.

=signature clear

  clear() (Match)

=metadata clear

{
  since => '1.23',
}

=example-1 clear

  # given: synopsis

  package main;

  my $clear = $match->clear;

  # bless(..., "Venus::Match")

=cut

$test->for('example', 1, 'clear', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->on_none;
  ok !$result->on_none->();
  ok $result->on_only;
  ok $result->on_only->() == 1;
  ok $result->on_then;
  ok ref($result->on_then) eq 'ARRAY';
  ok $#{$result->on_then} == -1;
  ok $result->on_when;
  ok ref($result->on_when) eq 'ARRAY';
  ok $#{$result->on_when} == -1;

  $result
});

=method data

The data method takes a hashref (i.e. lookup table) and creates match
conditions and actions based on the keys and values found.

=signature data

  data(HashRef $data) (Match)

=metadata data

{
  since => '0.07',
}

=example-1 data

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->data({
    'a' => 'b',
    'c' => 'd',
    'e' => 'f',
    'g' => 'h',
  });

  my $result = $match->none('z')->result;

  # "b"

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'b';

  $result
});

=example-2 data

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('x');

  $match->data({
    'a' => 'b',
    'c' => 'd',
    'e' => 'f',
    'g' => 'h',
  });

  my $result = $match->none('z')->result;

  # "z"

=cut

$test->for('example', 2, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'z';

  $result
});

=method expr

The expr method registers a L</when> condition that check if the match value is
an exact string match of the C<$topic> if the topic is a string, or that it
matches against the topic if the topic is a regular expression.

=signature expr

  expr(Str | RegexpRef $expr) (Match)

=metadata expr

{
  since => '0.07',
}

=example-1 expr

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('1901-01-01');

  $match->expr('1901-01-01')->then(sub{[split /-/]});

  my $result = $match->result;

  # ["1901", "01", "01"]

=cut

$test->for('example', 1, 'expr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["1901", "01", "01"];

  $result
});

=example-2 expr

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('1901-01-01');

  $match->expr(qr/^1901-/)->then(sub{[split /-/]});

  my $result = $match->result;

  # ["1901", "01", "01"]

=cut

$test->for('example', 2, 'expr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["1901", "01", "01"];

  $result
});

=method just

The just method registers a L</when> condition that check if the match value is
an exact string match of the C<$topic> provided.

=signature just

  just(Str $topic) (Match)

=metadata just

{
  since => '0.03',
}

=example-1 just

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "a"

=cut

$test->for('example', 1, 'just', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'a';

  $result
});

=example-2 just

  package main;

  use Venus::Match;
  use Venus::String;

  my $match = Venus::Match->new(Venus::String->new('a'));

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "a"

=cut

$test->for('example', 2, 'just', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'a';

  $result
});

=example-3 just

  package main;

  use Venus::Match;
  use Venus::String;

  my $match = Venus::Match->new(Venus::String->new('c'));

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "c"

=cut

$test->for('example', 3, 'just', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'c';

  $result
});

=example-4 just

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(1.23);

  $match->just('1.230')->then('1.230');
  $match->just(01.23)->then('123');
  $match->just(1.230)->then(1.23);

  my $result = $match->result;

  # "1.23"

=cut

$test->for('example', 4, 'just', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, '1.23';

  $result
});

=example-5 just

  package main;

  use Venus::Match;
  use Venus::Number;

  my $match = Venus::Match->new(Venus::Number->new(1.23));

  $match->just('1.230')->then('1.230');
  $match->just(01.23)->then('123');
  $match->just(1.230)->then(1.23);

  my $result = $match->result;

  # "1.23"

=cut

$test->for('example', 5, 'just', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, '1.23';

  $result
});

=example-6 just

  package main;

  use Venus::Match;
  use Venus::Number;

  my $match = Venus::Match->new(1.23);

  $match->just(Venus::Number->new('1.230'))->then('1.230');
  $match->just(Venus::Number->new(01.23))->then('123');
  $match->just(Venus::Number->new(1.230))->then(1.23);

  my $result = $match->result;

  # "1.23"

=cut

$test->for('example', 6, 'just', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, '1.23';

  $result
});

=method none

The none method registers a special condition that returns a result only when
no other conditions have been matched.

=signature none

  none(Any | CodeRef $code) (Match)

=metadata none

{
  since => '0.03',
}

=example-1 none

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('z');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  $match->none('z');

  my $result = $match->result;

  # "z"

=cut

$test->for('example', 1, 'none', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'z';

  $result
});

=example-2 none

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('z');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  $match->none(sub{"($_) not found"});

  my $result = $match->result;

  # "(z) not found"

=cut

$test->for('example', 2, 'none', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "(z) not found";

  $result
});

=method only

The only method registers a special condition that only allows matching on the
match value only if the code provided returns truthy.

=signature only

  only(CodeRef $code) (Match)

=metadata only

{
  since => '0.03',
}

=example-1 only

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(5);

  $match->only(sub{$_ != 5});

  $match->just(5)->then(5);
  $match->just(6)->then(6);

  my $result = $match->result;

  # undef

=cut

$test->for('example', 1, 'only', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=example-2 only

  package main;

  use Venus::Match;

  my $match = Venus::Match->new(6);

  $match->only(sub{$_ != 5});

  $match->just(5)->then(5);
  $match->just(6)->then(6);

  my $result = $match->result;

  # 6

=cut

$test->for('example', 2, 'only', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 6;

  $result
});

=method result

The result method evaluates the registered conditions and returns the result of
the action (i.e. the L</then> code) or the special L</none> condition if there
were no matches. In list context, this method returns both the result and
whether or not a condition matched. Optionally, when passed an argument this
method assign the argument as the value/topic and then perform the operation.

=signature result

  result(Any $data) (Any)

=metadata result

{
  since => '0.03',
}

=example-1 result

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result;

  # "a"

=cut

$test->for('example', 1, 'result', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'a';

  $result
});

=example-2 result

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my ($result, $matched) = $match->result;

  # ("a", 1)

=cut

$test->for('example', 2, 'result', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is $result[0], 'a';
  is $result[1], 1;

  $result[0]
});

=example-3 result

  package main;

  use Venus::Match;

  sub fibonacci {
    my ($n) = @_;
    my $match = Venus::Match->new($n)
      ->just(1)->then(1)
      ->just(2)->then(1)
      ->none(sub{fibonacci($n - 1) + fibonacci($n - 2)})
      ->result
  }

  my $result = [fibonacci(4), fibonacci(6), fibonacci(12)]

  # [3, 8, 144]

=cut

$test->for('example', 3, 'result', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [3, 8, 144];
  $result
});

=example-4 result

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result('b');

  # "b"

=cut

$test->for('example', 4, 'result', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'b';

  $result
});

=example-5 result

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->just('a')->then('a');
  $match->just('b')->then('b');
  $match->just('c')->then('c');

  my $result = $match->result('z');

  # undef

=cut

$test->for('example', 5, 'result', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method test

The test method evaluates the registered conditions and returns truthy if a
match can be made, without executing any of the actions (i.e. the L</then>
code) or the special L</none> condition.

=signature test

  test() (Bool)

=metadata test

{
  since => '1.02',
}

=example-1 test

  package Match;

  use Venus::Match;

  our $TEST = 0;

  my $match = Venus::Match->new('a');

  $match->just('a')->then(sub{$TEST = 1});
  $match->just('b')->then(sub{$TEST = 2});
  $match->just('c')->then(sub{$TEST = 3});

  my $test = $match->test;

  # 1

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;
  is $Match::TEST, 0;

  $result
});

=example-2 test

  package Match;

  use Venus::Match;

  our $TEST = 0;

  my $match = Venus::Match->new('b');

  $match->just('a')->then(sub{$TEST = 1});
  $match->just('b')->then(sub{$TEST = 2});
  $match->just('c')->then(sub{$TEST = 3});

  my $test = $match->test;

  # 1

=cut

$test->for('example', 2, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;
  is $Match::TEST, 0;

  $result
});

=example-3 test

  package Match;

  use Venus::Match;

  our $TEST = 0;

  my $match = Venus::Match->new('z');

  $match->just('a')->then(sub{$TEST = 1});
  $match->just('b')->then(sub{$TEST = 2});
  $match->just('c')->then(sub{$TEST = 3});

  my $test = $match->test;

  # 0

=cut

$test->for('example', 3, 'test', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;
  is $Match::TEST, 0;

  !$result
});

=method then

The then method registers an action to be executed if the corresponding match
condition returns truthy.

=signature then

  then(Any | CodeRef $code) (Match)

=metadata then

{
  since => '0.03',
}

=example-1 then

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('b');

  $match->just('a');
  $match->then('a');

  $match->just('b');
  $match->then('b');

  my $result = $match->result;

  # "b"

=cut

$test->for('example', 1, 'then', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'b';

  $result
});

=example-2 then

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('b');

  $match->just('a');
  $match->then('a');

  $match->just('b');
  $match->then('b');
  $match->then('x');

  my $result = $match->result;

  # "x"

=cut

$test->for('example', 2, 'then', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'x';

  $result
});

=method when

The when method registers a match condition that will be passed the match value
during evaluation. If the match condition returns truthy the corresponding
action will be used to return a result. If the match value is an object, this
method can take a method name and arguments which will be used as a match
condition.

=signature when

  when(Str | CodeRef $code, Any @args) (Match)

=metadata when

{
  since => '0.03',
}

=example-1 when

  package main;

  use Venus::Match;

  my $match = Venus::Match->new('a');

  $match->when(sub{$_ eq 'a'});
  $match->then('a');

  $match->when(sub{$_ eq 'b'});
  $match->then('b');

  $match->when(sub{$_ eq 'c'});
  $match->then('c');

  my $result = $match->result;

  # "a"

=cut

$test->for('example', 1, 'when', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'a';

  $result
});

=example-2 when

  package main;

  use Venus::Match;
  use Venus::Type;

  my $match = Venus::Match->new(Venus::Type->new(1)->deduce);

  $match->when('isa', 'Venus::Number');
  $match->then('Venus::Number');

  $match->when('isa', 'Venus::String');
  $match->then('Venus::String');

  my $result = $match->result;

  # "Venus::Number"

=cut

$test->for('example', 2, 'when', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'Venus::Number';

  $result
});

=example-3 when

  package main;

  use Venus::Match;
  use Venus::Type;

  my $match = Venus::Match->new(Venus::Type->new('1')->deduce);

  $match->when('isa', 'Venus::Number');
  $match->then('Venus::Number');

  $match->when('isa', 'Venus::String');
  $match->then('Venus::String');

  my $result = $match->result;

  # "Venus::String"

=cut

$test->for('example', 3, 'when', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'Venus::String';

  $result
});

=method where

The where method registers an action as a sub-match operation, to be executed
if the corresponding match condition returns truthy. This method returns the
sub-match object.

=signature where

  where() (Match)

=metadata where

{
  since => '1.40',
}

=example-1 where

  package main;

  use Venus::Match;

  my $match = Venus::Match->new;

  my $submatch1 = $match->expr(qr/^p([a-z]+)ch/)->where;

  $submatch1->just('peach')->then('peach-123');
  $submatch1->just('patch')->then('patch-456');
  $submatch1->just('punch')->then('punch-789');

  my $submatch2 = $match->expr(qr/^m([a-z]+)ch/)->where;

  $submatch2->just('merch')->then('merch-123');
  $submatch2->just('march')->then('march-456');
  $submatch2->just('mouch')->then('mouch-789');

  my $result = $match->result('peach');

  # "peach-123"

=cut

$test->for('example', 1, 'where', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'peach-123';

  $result
});

=example-2 where

  package main;

  use Venus::Match;

  my $match = Venus::Match->new;

  my $submatch1 = $match->expr(qr/^p([a-z]+)ch/)->where;

  $submatch1->just('peach')->then('peach-123');
  $submatch1->just('patch')->then('patch-456');
  $submatch1->just('punch')->then('punch-789');

  my $submatch2 = $match->expr(qr/^m([a-z]+)ch/)->where;

  $submatch2->just('merch')->then('merch-123');
  $submatch2->just('march')->then('march-456');
  $submatch2->just('mouch')->then('mouch-789');

  my $result = $match->result('march');

  # "march-456"

=cut

$test->for('example', 2, 'where', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'march-456';

  $result
});

=example-3 where

  package main;

  use Venus::Match;

  my $match = Venus::Match->new;

  my $submatch1 = $match->expr(qr/^p([a-z]+)ch/)->where;

  $submatch1->just('peach')->then('peach-123');
  $submatch1->just('patch')->then('patch-456');
  $submatch1->just('punch')->then('punch-789');

  my $submatch2 = $match->expr(qr/^m([a-z]+)ch/)->where;

  $submatch2->just('merch')->then('merch-123');
  $submatch2->just('march')->then('march-456');
  $submatch2->just('mouch')->then('mouch-789');

  my $result = $match->result('pirch');

  # undef

=cut

$test->for('example', 3, 'where', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

# END

$test->render('lib/Venus/Match.pod') if $ENV{RENDER};

ok 1 and done_testing;
