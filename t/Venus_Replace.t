package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Replace

=cut

$test->for('name');

=tagline

Replace Class

=cut

$test->for('tagline');

=abstract

Replace Class for Perl 5

=cut

$test->for('abstract');

=includes

method: captures
method: count
method: evaluate
method: explain
method: get
method: initial
method: last_match_end
method: last_match_start
method: matched
method: named_captures
method: prematched
method: postmatched
method: set

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Replace;

  my $replace = Venus::Replace->new(
    string => 'hello world',
    regexp => '(world)',
    substr => 'universe',
  );

  # $replace->captures;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating regexp replacement data.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Explainable
Venus::Role::Stashable

=cut

$test->for('integrates');

=attributes

flags: rw, opt, Str, C<''>
regexp: rw, opt, Regexp, C<qr//>
string: rw, opt, Str, C<''>
substr: rw, opt, Str, C<''>

=cut

$test->for('attributes');

=method captures

The captures method returns the capture groups from the result object which
contains information about the results of the regular expression operation.
This method can return a list of values in list-context.

=signature captures

  captures() (ArrayRef)

=metadata captures

{
  since => '0.01',
}

=example-1 captures

  # given: synopsis;

  my $captures = $replace->captures;

  # ["world"]

=cut

$test->for('example', 1, 'captures', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["world"];

  $result
});

=method count

The count method returns the number of match occurrences from the result object
which contains information about the results of the regular expression
operation.

=signature count

  count() (Num)

=metadata count

{
  since => '0.01',
}

=example-1 count

  # given: synopsis;

  my $count = $replace->count;

  # 1

=cut

$test->for('example', 1, 'count', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method evaluate

The evaluate method performs the regular expression operation and returns an
arrayref representation of the results.

=signature evaluate

  evaluate() (ArrayRef)

=metadata evaluate

{
  since => '0.01',
}

=example-1 evaluate

  # given: synopsis;

  my $evaluate = $replace->evaluate;

  # [
  #   "(world)",
  #   "hello universe",
  #   1,
  #   [6, 6],
  #   [11, 11],
  #   {},
  #   "hello world",
  # ]

=cut

$test->for('example', 1, 'evaluate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    "(world)",
    "hello universe",
    1,
    [6, 6],
    [11, 11],
    {},
    "hello world",
  ];

  $result
});

=example-2 evaluate

  package main;

  use Venus::Replace;

  my $replace = Venus::Replace->new(
    string => 'hello world',
    regexp => 'world)(',
    substr => 'universe',
  );

  my $evaluate = $replace->evaluate;

  # Exception! (isa Venus::Replace::Error) (see error_on_evaluate)

=cut

$test->for('example', 2, 'evaluate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Replace::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method explain

The explain method returns the subject of the regular expression operation and
is used in stringification operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $replace->explain;

  # "hello universe"

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello universe";

  $result
});

=method get

The get method returns the subject of the regular expression operation.

=signature get

  get() (Str)

=metadata get

{
  since => '0.01',
}

=example-1 get

  # given: synopsis;

  my $get = $replace->get;

  # "hello universe"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello universe";

  $result
});

=method initial

The initial method returns the unaltered string from the result object which
contains information about the results of the regular expression operation.

=signature initial

  initial() (Str)

=metadata initial

{
  since => '0.01',
}

=example-1 initial

  # given: synopsis;

  my $initial = $replace->initial;

  # "hello world"

=cut

$test->for('example', 1, 'initial', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world";

  $result
});

=method last_match_end

The last_match_end method returns an array of offset positions into the string
where the capture(s) stopped matching from the result object which contains
information about the results of the regular expression operation.

=signature last_match_end

  last_match_end() (Maybe[ArrayRef[Int]])

=metadata last_match_end

{
  since => '0.01',
}

=example-1 last_match_end

  # given: synopsis;

  my $last_match_end = $replace->last_match_end;

  # [11, 11]

=cut

$test->for('example', 1, 'last_match_end', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [11, 11];

  $result
});

=method last_match_start

The last_match_start method returns an array of offset positions into the
string where the capture(s) matched from the result object which contains
information about the results of the regular expression operation.

=signature last_match_start

  last_match_start() (Maybe[ArrayRef[Int]])

=metadata last_match_start

{
  since => '0.01',
}

=example-1 last_match_start

  # given: synopsis;

  my $last_match_start = $replace->last_match_start;

  # [6, 6]

=cut

$test->for('example', 1, 'last_match_start', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [6, 6];

  $result
});

=method matched

The matched method returns the portion of the string that matched from the
result object which contains information about the results of the regular
expression operation.

=signature matched

  matched() (Maybe[Str])

=metadata matched

{
  since => '0.01',
}

=example-1 matched

  # given: synopsis;

  my $matched = $replace->matched;

  # "world"

=cut

$test->for('example', 1, 'matched', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "world";

  $result
});

=method named_captures

The named_captures method returns a hash containing the requested named regular
expressions and captured string pairs from the result object which contains
information about the results of the regular expression operation.

=signature named_captures

  named_captures() (HashRef)

=metadata named_captures

{
  since => '0.01',
}

=example-1 named_captures

  # given: synopsis;

  my $named_captures = $replace->named_captures;

  # {}

=cut

$test->for('example', 1, 'named_captures', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=example-2 named_captures

  package main;

  use Venus::Replace;

  my $replace = Venus::Replace->new(
    string => 'hello world',
    regexp => '(?<locale>world)',
    substr => 'universe',
  );

  my $named_captures = $replace->named_captures;

  # { locale => ["world"] }

=cut

$test->for('example', 2, 'named_captures', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { locale => ["world"] };

  $result
});

=method prematched

The prematched method returns the portion of the string before the regular
expression matched from the result object which contains information about the
results of the regular expression operation.

=signature prematched

  prematched() (Maybe[Str)

=metadata prematched

{
  since => '0.01',
}

=example-1 prematched

  # given: synopsis;

  my $prematched = $replace->prematched;

  # "hello "

=cut

$test->for('example', 1, 'prematched', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello ";

  $result
});

=method postmatched

The postmatched method returns the portion of the string after the regular
expression matched from the result object which contains information about the
results of the regular expression operation.

=signature postmatched

  postmatched() (Maybe[Str)

=metadata postmatched

{
  since => '0.01',
}

=example-1 postmatched

  # given: synopsis;

  my $postmatched = $replace->postmatched;

  # ""

=cut

$test->for('example', 1, 'postmatched', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result eq "";

  !$result
});

=method set

The set method sets the subject of the regular expression operation.

=signature set

  set(Str $data) (Str)

=metadata set

{
  since => '0.01',
}

=example-1 set

  # given: synopsis;

  my $set = $replace->set('hello universe');

  # "hello universe"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello universe";

  $result
});

=operator (.)

This package overloads the C<.> operator.

=cut

$test->for('operator', '(.)');

=example-1 (.)

  # given: synopsis;

  my $result = $replace . ', welcome';

  # "hello universe, welcome"

=cut

$test->for('example', 1, '(.)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello universe, welcome";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $replace eq 'hello universe';

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

  my $result = $replace ne 'Hello universe';

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

  my $result = 'hello universe, welcome' =~ qr/$replace/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$replace";

  # "hello universe"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello universe';

  $result
});

=example-2 ("")

  # given: synopsis;

  my $result = "$replace, $replace";

  # "hello universe, hello universe"

=cut

$test->for('example', 2, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'hello universe, hello universe';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $replace ~~ 'hello universe';

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

=error error_on_evaluate

This package may raise an error_on_evaluate exception.

=cut

$test->for('error', 'error_on_evaluate');

=example-1 error_on_evaluate

  # given: synopsis;

  my @args = ('Exception!');

  my $error = $replace->throw('error_on_evaluate', @args)->catch('error');

  # my $name = $error->name;

  # "on_evaluate"

  # my $message = $error->message;

  # "Exception!"

=cut

$test->for('example', 1, 'error_on_evaluate', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_evaluate";
  my $message = $result->message;
  is $message, "Exception!";

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Replace.pod') if $ENV{RENDER};

ok 1 and done_testing;