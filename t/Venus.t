package main;

use 5.018;

use strict;
use warnings;

use Config;
use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus

=cut

$test->for('name');

=tagline

OO Library

=cut

$test->for('tagline');

=abstract

OO Standard Library for Perl 5

=cut

$test->for('abstract');

=includes

function: args
function: assert
function: box
function: call
function: cast
function: catch
function: caught
function: chain
function: check
function: cop
function: error
function: false
function: fault
function: json
function: load
function: log
function: make
function: merge
function: perl
function: raise
function: roll
function: space
function: then
function: true
function: unpack
function: venus
function: work
function: wrap
function: yaml

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus qw(
    catch
    error
    raise
  );

  # error handling
  my ($error, $result) = catch {
    error;
  };

  # boolean keywords
  if ($result and $result eq false) {
    true;
  }

  # raise exceptions
  if (false) {
    raise 'MyApp::Error';
  }

  # and much more!
  true ne false;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This library provides an object-orientation framework and extendible standard
library for Perl 5 with classes which wrap most native Perl data types. Venus
has a simple modular architecture, robust library of classes, methods, and
roles, supports pure-Perl autoboxing, advanced exception handling, "true" and
"false" functions, package introspection, command-line options parsing, and
more. This package will always automatically exports C<true> and C<false>
keyword functions (unless existing routines of the same name already exist in
the calling package or its parents), otherwise exports keyword functions as
requested at import. This library requires Perl C<5.18+>.

+=head1 CAPABILITIES

The following is a short list of capabilities:

+=over 4

+=item *

Perl 5.18.0+

+=item *

Zero Dependencies

+=item *

Fast Object-Orientation

+=item *

Robust Standard Library

+=item *

Intuitive Value Classes

+=item *

Pure Perl Autoboxing

+=item *

Convenient Utility Classes

+=item *

Simple Package Reflection

+=item *

Flexible Exception Handling

+=item *

Composable Standards

+=item *

Pluggable (no monkeypatching)

+=item *

Proxyable Methods

+=item *

Type Assertions

+=item *

Type Coercions

+=item *

Value Casting

+=item *

Boolean Values

+=item *

Complete Documentation

+=item *

Complete Test Coverage

+=back

=cut

$test->for('description');

=function args

The args function takes a list of arguments and returns a hashref.

=signature args

  args(Any @args) (HashRef)

=metadata args

{
  since => '2.32',
}

=example-1 args

  package main;

  use Venus 'args';

  my $args = args(content => 'example');

  # {content => "example"}

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => "example"};

  $result
});

=example-2 args

  package main;

  use Venus 'args';

  my $args = args({content => 'example'});

  # {content => "example"}

=cut

$test->for('example', 2, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => "example"};

  $result
});

=example-3 args

  package main;

  use Venus 'args';

  my $args = args('content');

  # {content => undef}

=cut

$test->for('example', 3, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => undef};

  $result
});

=example-4 args

  package main;

  use Venus 'args';

  my $args = args('content', 'example', 'algorithm');

  # {content => "example", algorithm => undef}

=cut

$test->for('example', 4, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => "example", algorithm => undef};

  $result
});

=function assert

The assert function builds a L<Venus::Assert> object and returns the result of
a L<Venus::Assert/validate> operation.

=signature assert

  assert(Any $data, Str $expr) (Any)

=metadata assert

{
  since => '2.40',
}

=cut

=example-1 assert

  package main;

  use Venus 'assert';

  my $assert = assert(1234567890, 'number');

  # 1234567890

=cut

$test->for('example', 1, 'assert', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1234567890;

  $result
});

=example-2 assert

  package main;

  use Venus 'assert';

  my $assert = assert(1234567890, 'float');

  # Exception! (isa Venus::Assert::Error)

=cut

$test->for('example', 2, 'assert', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  ok defined $result;
  isa_ok $result, 'Venus::Assert::Error';

  $result
});

=function box

The box function returns a L<Venus::Box> object for the argument provided.

=signature box

  box(Any $data) (Box)

=metadata box

{
  since => '2.32',
}

=example-1 box

  package main;

  use Venus 'box';

  my $box = box({});

  # bless({value => bless({value => {}}, 'Venus::Hash')}, 'Venus::Box')

=cut

$test->for('example', 1, 'box', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Box');
  ok $result->unbox->isa('Venus::Hash');
  is_deeply $result->unbox->value, {};

  $result
});

=example-2 box

  package main;

  use Venus 'box';

  my $box = box([]);

  # bless({value => bless({value => []}, 'Venus::Array')}, 'Venus::Box')

=cut

$test->for('example', 2, 'box', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Box');
  ok $result->unbox->isa('Venus::Array');
  is_deeply $result->unbox->value, [];

  $result
});

=function call

The call function dispatches function and method calls to a package and returns
the result.

=signature call

  call(Str | Object | CodeRef $data, Any @args) (Any)

=metadata call

{
  since => '2.32',
}

=example-1 call

  package main;

  use Venus 'call';

  require Digest::SHA;

  my $result = call(\'Digest::SHA', 'new');

  # bless(do{\(my $o = '...')}, 'digest::sha')

=cut

$test->for('example', 1, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Digest::SHA');

  $result
});

=example-2 call

  package main;

  use Venus 'call';

  require Digest::SHA;

  my $result = call('Digest::SHA', 'sha1_hex');

  # "da39a3ee5e6b4b0d3255bfef95601890afd80709"

=cut

$test->for('example', 2, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, "da39a3ee5e6b4b0d3255bfef95601890afd80709";

  $result
});

=example-3 call

  package main;

  use Venus 'call';

  require Venus::Hash;

  my $result = call(sub{'Venus::Hash'->new(@_)}, {1..4});

  # bless({value => {1..4}}, 'Venus::Hash')

=cut

$test->for('example', 3, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Hash');
  is_deeply $result->value, {1..4};

  $result
});

=example-4 call

  package main;

  use Venus 'call';

  require Venus::Box;

  my $result = call(Venus::Box->new(value => {}), 'merge', {1..4});

  # bless({value => bless({value => {1..4}}, 'Venus::Hash')}, 'Venus::Box')

=cut

$test->for('example', 4, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Box');
  ok $result->unbox->isa('Venus::Hash');
  is_deeply $result->unbox->value, {1..4};

  $result
});

=function cast

The cast function returns the argument provided as an object, promoting native
Perl data types to data type objects. The optional second argument can be the
name of the type for the object to cast to explicitly.

=signature cast

  cast(Any $data, Str $type) (Object)

=metadata cast

{
  since => '1.40',
}

=example-1 cast

  package main;

  use Venus 'cast';

  my $undef = cast;

  # bless({value => undef}, "Venus::Undef")

=cut

$test->for('example', 1, 'cast', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::Undef');

  !$result
});

=example-2 cast

  package main;

  use Venus 'cast';

  my @booleans = map cast, true, false;

  # (bless({value => 1}, "Venus::Boolean"), bless({value => 0}, "Venus::Boolean"))

=cut

$test->for('example', 2, 'cast', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  ok $result[0]->isa('Venus::Boolean');
  is $result[0]->get, 1;
  ok $result[1]->isa('Venus::Boolean');
  is $result[1]->get, 0;

  @result
});

=example-3 cast

  package main;

  use Venus 'cast';

  my $example = cast bless({}, "Example");

  # bless({value => 1}, "Example")

=cut

$test->for('example', 3, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=example-4 cast

  package main;

  use Venus 'cast';

  my $float = cast 1.23;

  # bless({value => "1.23"}, "Venus::Float")

=cut

$test->for('example', 4, 'cast', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Float');
  is $result->get, 1.23;

  $result
});

=function catch

The catch function executes the code block trapping errors and returning the
caught exception in scalar context, and also returning the result as a second
argument in list context.

=signature catch

  catch(CodeRef $block) (Error, Any)

=metadata catch

{
  since => '0.01',
}

=example-1 catch

  package main;

  use Venus 'catch';

  my $error = catch {die};

  $error;

  # "Died at ..."

=cut

$test->for('example', 1, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !ref($result);

  $result
});

=example-2 catch

  package main;

  use Venus 'catch';

  my ($error, $result) = catch {error};

  $error;

  # bless({...}, 'Venus::Error')

=cut

$test->for('example', 2, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');

  $result
});

=example-3 catch

  package main;

  use Venus 'catch';

  my ($error, $result) = catch {true};

  $result;

  # 1

=cut

$test->for('example', 3, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=function caught

The caught function evaluates the exception object provided and validates its
identity and name (if provided) then executes the code block provided returning
the result of the callback. If no callback is provided this function returns
the exception object on success and C<undef> on failure.

=signature caught

  caught(Object $error, Str | Tuple[Str, Str] $identity, CodeRef $block) (Any)

=metadata caught

{
  since => '1.95',
}

=example-1 caught

  package main;

  use Venus 'catch', 'caught', 'error';

  my $error = catch { error };

  my $result = caught $error, 'Venus::Error';

  # bless(..., 'Venus::Error')

=cut

$test->for('example', 1, 'caught', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok !$result->name;

  $result
});

=example-2 caught

  package main;

  use Venus 'catch', 'caught', 'raise';

  my $error = catch { raise 'Example::Error' };

  my $result = caught $error, 'Venus::Error';

  # bless(..., 'Venus::Error')

=cut

$test->for('example', 2, 'caught', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example::Error');
  ok $result->isa('Venus::Error');
  ok !$result->name;

  $result
});

=example-3 caught

  package main;

  use Venus 'catch', 'caught', 'raise';

  my $error = catch { raise 'Example::Error' };

  my $result = caught $error, 'Example::Error';

  # bless(..., 'Venus::Error')

=cut

$test->for('example', 3, 'caught', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example::Error');
  ok $result->isa('Venus::Error');
  ok !$result->name;

  $result
});

=example-4 caught

  package main;

  use Venus 'catch', 'caught', 'raise';

  my $error = catch { raise 'Example::Error', { name => 'on.test' } };

  my $result = caught $error, ['Example::Error', 'on.test'];

  # bless(..., 'Venus::Error')

=cut

$test->for('example', 4, 'caught', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example::Error');
  ok $result->isa('Venus::Error');
  ok $result->name;
  is $result->name, 'on_test';

  $result
});

=example-5 caught

  package main;

  use Venus 'catch', 'caught', 'raise';

  my $error = catch { raise 'Example::Error', { name => 'on.recv' } };

  my $result = caught $error, ['Example::Error', 'on.send'];

  # undef

=cut

$test->for('example', 5, 'caught', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-6 caught

  package main;

  use Venus 'catch', 'caught', 'error';

  my $error = catch { error };

  my $result = caught $error, ['Example::Error', 'on.send'];

  # undef

=cut

$test->for('example', 6, 'caught', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-7 caught

  package main;

  use Venus 'catch', 'caught', 'error';

  my $error = catch { error };

  my $result = caught $error, ['Example::Error'];

  # undef

=cut

$test->for('example', 7, 'caught', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-8 caught

  package main;

  use Venus 'catch', 'caught', 'error';

  my $error = catch { error };

  my $result = caught $error, 'Example::Error';

  # undef

=cut

$test->for('example', 8, 'caught', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-9 caught

  package main;

  use Venus 'catch', 'caught', 'error';

  my $error = catch { error { name => 'on.send' } };

  my $result = caught $error, ['Venus::Error', 'on.send'];

  # bless(..., 'Venus::Error')

=cut

$test->for('example', 9, 'caught', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok $result->name;
  is $result->name, 'on_send';

  $result
});

=example-10 caught

  package main;

  use Venus 'catch', 'caught', 'error';

  my $error = catch { error { name => 'on.send.open' } };

  my $result = caught $error, ['Venus::Error', 'on.send'], sub {
    $error->stash('caught', true) if $error->is('on.send.open');
    return $error;
  };

  # bless(..., 'Venus::Error')

=cut

$test->for('example', 10, 'caught', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok $result->stash('caught');
  ok $result->name;
  is $result->name, 'on_send_open';

  $result
});

=function chain

The chain function chains function and method calls to a package (and return
values) and returns the result.

=signature chain

  chain(Str | Object | CodeRef $self, Str | ArrayRef[Str] @args) (Any)

=metadata chain

{
  since => '2.32',
}

=example-1 chain

  package main;

  use Venus 'chain';

  my $result = chain('Venus::Path', ['new', 't'], 'exists');

  # 1

=cut

$test->for('example', 1, 'chain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 chain

  package main;

  use Venus 'chain';

  my $result = chain('Venus::Path', ['new', 't'], ['test', 'd']);

  # 1

=cut

$test->for('example', 2, 'chain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=function check

The check function builds a L<Venus::Assert> object and returns the result of
a L<Venus::Assert/check> operation.

=signature check

  check(Any $data, Str $expr) (Bool)

=metadata check

{
  since => '2.40',
}

=cut

=example-1 check

  package main;

  use Venus 'check';

  my $check = check(rand, 'float');

  # true

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 check

  package main;

  use Venus 'check';

  my $check = check(rand, 'string');

  # false

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=function cop

The cop function attempts to curry the given subroutine on the object or class
and if successful returns a closure.

=signature cop

  cop(Str | Object | CodeRef $self, Str $name) (CodeRef)

=metadata cop

{
  since => '2.32',
}

=example-1 cop

  package main;

  use Venus 'cop';

  my $coderef = cop('Digest::SHA', 'sha1_hex');

  # sub { ... }

=cut

$test->for('example', 1, 'cop', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref($result), 'CODE';

  $result
});

=example-2 cop

  package main;

  use Venus 'cop';

  require Digest::SHA;

  my $coderef = cop(Digest::SHA->new, 'digest');

  # sub { ... }

=cut

$test->for('example', 2, 'cop', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref($result), 'CODE';

  $result
});

=function error

The error function throws a L<Venus::Error> exception object using the
exception object arguments provided.

=signature error

  error(Maybe[HashRef] $args) (Error)

=metadata error

{
  since => '0.01',
}

=example-1 error

  package main;

  use Venus 'error';

  my $error = error;

  # bless({...}, 'Venus::Error')

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=example-2 error

  package main;

  use Venus 'error';

  my $error = error {
    message => 'Something failed!',
  };

  # bless({message => 'Something failed!', ...}, 'Venus::Error')

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Something failed!';

  $result
});

=function false

The false function returns a falsy boolean value which is designed to be
practically indistinguishable from the conventional numerical C<0> value.

=signature false

  false() (Bool)

=metadata false

{
  since => '0.01',
}

=example-1 false

  package main;

  use Venus;

  my $false = false;

  # 0

=cut

$test->for('example', 1, 'false', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-2 false

  package main;

  use Venus;

  my $true = !false;

  # 1

=cut

$test->for('example', 2, 'false', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=function fault

The fault function throws a L<Venus::Fault> exception object and represents a
system failure, and isn't meant to be caught.

=signature fault

  fault(Str $args) (Fault)

=metadata fault

{
  since => '1.80',
}

=example-1 fault

  package main;

  use Venus 'fault';

  my $fault = fault;

  # bless({message => 'Exception!'}, 'Venus::Fault')

=cut

$test->for('example', 1, 'fault', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Venus::Fault');
  ok $error->{message} eq 'Exception!';

  $result
});

=example-2 fault

  package main;

  use Venus 'fault';

  my $fault = fault 'Something failed!';

  # bless({message => 'Something failed!'}, 'Venus::Fault')

=cut

$test->for('example', 2, 'fault', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('Venus::Fault');
  ok $error->{message} eq 'Something failed!';

  $result
});

=function json

The json function builds a L<Venus::Json> object and will either
L<Venus::Json/decode> or L<Venus::Json/encode> based on the argument provided
and returns the result.

=signature json

  json(Str $call, Any $data) (Any)

=metadata json

{
  since => '2.40',
}

=cut

=example-1 json

  package main;

  use Venus 'json';

  my $decode = json 'decode', '{"codename":["Ready","Robot"],"stable":true}';

  # { codename => ["Ready", "Robot"], stable => 1 }

=cut

$test->for('example', 1, 'json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, { codename => ["Ready", "Robot"], stable => 1 };

  $result
});

=example-2 json

  package main;

  use Venus 'json';

  my $encode = json 'encode', { codename => ["Ready", "Robot"], stable => true };

  # '{"codename":["Ready","Robot"],"stable":true}'

=cut

$test->for('example', 2, 'json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  $result =~ s/[\s\n]+//g;
  is $result, '{"codename":["Ready","Robot"],"stable":true}';

  $result
});

=function load

The load function loads the package provided and returns a L<Venus::Space> object.

=signature load

  load(Any $name) (Space)

=metadata load

{
  since => '2.32',
}

=example-1 load

  package main;

  use Venus 'load';

  my $space = load 'Venus::Scalar';

  # bless({value => 'Venus::Scalar'}, 'Venus::Space')

=cut

$test->for('example', 1, 'load', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  is $result->value, 'Venus::Scalar';

  $result
});

=function log

The log function prints the arguments provided to STDOUT, stringifying complex
values, and returns a L<Venus::Log> object.

=signature log

  log(Any @args) (Log)

=metadata log

{
  since => '2.40',
}

=cut

=example-1 log

  package main;

  use Venus 'log';

  my $log = log;

  # bless({...}, 'Venus::Log')

  # log time, rand, 1..9;

  # 00000000 0.000000, 1..9

=cut

$test->for('example', 1, 'log', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';

  $result
});

=function make

The make function L<"calls"|Venus/call> the C<new> routine on the invocant and
returns the result which should be a package string or an object.

=signature make

  make(Str $package, Any @args) (Any)

=metadata make

{
  since => '2.32',
}

=example-1 make

  package main;

  use Venus 'make';

  my $made = make('Digest::SHA');

  # bless(do{\(my $o = '...')}, 'Digest::SHA')

=cut

$test->for('example', 1, 'make', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Digest::SHA');

  $result
});

=example-2 make

  package main;

  use Venus 'make';

  my $made = make('Digest', 'SHA');

  # bless(do{\(my $o = '...')}, 'Digest::SHA')

=cut

$test->for('example', 2, 'make', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Digest::SHA');

  $result
});

=function merge

The merge function returns a hash reference which is a merger of all of the
hashref arguments provided.

=signature merge

  merge(HashRef @args) (HashRef)

=metadata merge

{
  since => '2.32',
}

=example-1 merge

  package main;

  use Venus 'merge';

  my $merged = merge({1..4}, {5, 6});

  # {1..6}

=cut

$test->for('example', 1, 'merge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {1..6};

  $result
});

=example-2 merge

  package main;

  use Venus 'merge';

  my $merged = merge({1..4}, {5, 6}, {7, 8, 9, 0});

  # {1..9, 0}

=cut

$test->for('example', 2, 'merge', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {1..9,0};

  $result
});

=function perl

The perl function builds a L<Venus::Dump> object and will either
L<Venus::Dump/decode> or L<Venus::Dump/encode> based on the argument provided
and returns the result.

=signature perl

  perl(Str $call, Any $data) (Any)

=metadata perl

{
  since => '2.40',
}

=cut

=example-1 perl

  package main;

  use Venus 'perl';

  my $decode = perl 'decode', '{stable=>bless({},\'Venus::True\')}';

  # { stable => 1 }

=cut

$test->for('example', 1, 'perl', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, { stable => 1 };

  $result
});

=example-2 perl

  package main;

  use Venus 'perl';

  my $encode = perl 'encode', { stable => true };

  # '{stable=>bless({},\'Venus::True\')}'

=cut

$test->for('example', 2, 'perl', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $result =~ s/[\s\n]+//g;
  is $result, '{stable=>bless({},\'Venus::True\')}';

  $result
});

=function raise

The raise function generates and throws a named exception object derived from
L<Venus::Error>, or provided base class, using the exception object arguments
provided.

=signature raise

  raise(Str $class | Tuple[Str, Str] $class, Maybe[HashRef] $args) (Error)

=metadata raise

{
  since => '0.01',
}

=example-1 raise

  package main;

  use Venus 'raise';

  my $error = raise 'MyApp::Error';

  # bless({...}, 'MyApp::Error')

=cut

$test->for('example', 1, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('MyApp::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=example-2 raise

  package main;

  use Venus 'raise';

  my $error = raise ['MyApp::Error', 'Venus::Error'];

  # bless({...}, 'MyApp::Error')

=cut

$test->for('example', 2, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('MyApp::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Exception!';

  $result
});

=example-3 raise

  package main;

  use Venus 'raise';

  my $error = raise ['MyApp::Error', 'Venus::Error'], {
    message => 'Something failed!',
  };

  # bless({message => 'Something failed!', ...}, 'MyApp::Error')

=cut

$test->for('example', 3, 'raise', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\(my $error))->result;
  ok $error;
  ok $error->isa('MyApp::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'Something failed!';

  $result
});

=function roll

The roll function takes a list of arguments, assuming the first argument is
invokable, and reorders the list such that the routine name provided comes
after the invocant (i.e. the 1st argument), creating a list acceptable to the
L</call> function.

=signature roll

  roll(Str $name, Any @args) (Any)

=metadata roll

{
  since => '2.32',
}

=example-1 roll

  package main;

  use Venus 'roll';

  my @list = roll('sha1_hex', 'Digest::SHA');

  # ('Digest::SHA', 'sha1_hex');

=cut

$test->for('example', 1, 'roll', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is_deeply [@result], ['Digest::SHA', 'sha1_hex'];

  @result
});

=example-2 roll

  package main;

  use Venus 'roll';

  my @list = roll('sha1_hex', call(\'Digest::SHA', 'new'));

  # (bless(do{\(my $o = '...')}, 'Digest::SHA'), 'sha1_hex');

=cut

$test->for('example', 2, 'roll', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  ok $result[0]->isa('Digest::SHA');
  is $result[1], 'sha1_hex';

  @result
});

=function space

The space function returns a L<Venus::Space> object for the package provided.

=signature space

  space(Any $name) (Space)

=metadata space

{
  since => '2.32',
}

=example-1 space

  package main;

  use Venus 'space';

  my $space = space 'Venus::Scalar';

  # bless({value => 'Venus::Scalar'}, 'Venus::Space')

=cut

$test->for('example', 1, 'space', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  is $result->value, 'Venus::Scalar';

  $result
});

=function then

The then function proxies the call request to the L</call> function and returns
the result as a list, prepended with the invocant.

=signature then

  then(Str | Object | CodeRef $self, Any @args) (Any)

=metadata then

{
  since => '2.32',
}

=example-1 then

  package main;

  use Venus 'then';

  my @list = then('Digest::SHA', 'sha1_hex');

  # ("Digest::SHA", "da39a3ee5e6b4b0d3255bfef95601890afd80709")

=cut

$test->for('example', 1, 'then', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is_deeply [@result], ["Digest::SHA", "da39a3ee5e6b4b0d3255bfef95601890afd80709"];

  @result
});

=function true

The true function returns a truthy boolean value which is designed to be
practically indistinguishable from the conventional numerical C<1> value.

=signature true

  true() (Bool)

=metadata true

{
  since => '0.01',
}

=example-1 true

  package main;

  use Venus;

  my $true = true;

  # 1

=cut

$test->for('example', 1, 'true', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 true

  package main;

  use Venus;

  my $false = !true;

  # 0

=cut

$test->for('example', 2, 'true', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=function unpack

The unpack function builds and returns a L<Venus::Unpack> object.

=signature unpack

  unpack(Any @args) (Unpack)

=metadata unpack

{
  since => '2.40',
}

=cut

=example-1 unpack

  package main;

  use Venus 'unpack';

  my $unpack = unpack;

  # bless({...}, 'Venus::Unpack')

  # $unpack->checks('string');

  # false

  # $unpack->checks('undef');

  # false

=cut

$test->for('example', 1, 'unpack', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Unpack';
  is_deeply scalar $result->args, [];
  is_deeply scalar $result->checks('string'), [];
  is_deeply scalar $result->checks('undef'), [];

  $result
});

=example-2 unpack

  package main;

  use Venus 'unpack';

  my $unpack = unpack rand;

  # bless({...}, 'Venus::Unpack')

  # $unpack->check('number');

  # false

  # $unpack->check('float');

  # true

=cut

$test->for('example', 2, 'unpack', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Unpack';
  ok scalar @{$result->args};
  is_deeply scalar $result->checks('number'), [0];
  is_deeply scalar $result->checks('float'), [1];

  $result
});

=function venus

The venus function build a L<Venus> package via the L</chain> function based on
the name provided and returns an instance of that package.

=signature venus

  venus(Str $name, Any @args) (Any)

=metadata venus

{
  since => '2.40',
}

=cut

=example-1 venus

  package main;

  use Venus 'venus';

  my $space = venus 'space';

  # bless({value => 'Venus'}, 'Venus::Space')

=cut

$test->for('example', 1, 'venus', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Space';
  is $result->value, 'Venus';

  $result
});

=example-2 venus

  package main;

  use Venus 'venus';

  my $space = venus 'space', ['new', 'venus/string'];

  # bless({value => 'Venus::String'}, 'Venus::Space')

=cut

$test->for('example', 2, 'venus', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Space';
  is $result->value, 'Venus::String';

  $result
});

=example-3 venus

  package main;

  use Venus 'venus';

  my $space = venus 'code';

  # bless({value => sub{...}}, 'Venus::Code')

=cut

$test->for('example', 3, 'venus', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Code';

  $result
});

=function work

The work function builds a L<Venus::Process> object, forks the current process
using the callback provided via the L<Venus::Process/work> operation, and
returns an instance of L<Venus::Process> representing the current process.

=signature work

  work(CodeRef $callback) (Process)

=metadata work

{
  since => '2.40',
}

=cut

=example-1 work

  package main;

  use Venus 'work';

  my $parent = work sub {
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  };

  # bless({...}, 'Venus::Process')

=cut

our $TEST_VENUS_PROCESS_ALARM = 0;
our $TEST_VENUS_PROCESS_CHDIR = 1;
our $TEST_VENUS_PROCESS_EXIT = 0;
our $TEST_VENUS_PROCESS_EXITCODE = 0;
our $TEST_VENUS_PROCESS_FORK = undef;
our $TEST_VENUS_PROCESS_FORKABLE = 1;
our $TEST_VENUS_PROCESS_KILL = 0;
our $TEST_VENUS_PROCESS_OPEN = 1;
our $TEST_VENUS_PROCESS_PID = 12345;
our $TEST_VENUS_PROCESS_SETSID = 1;
our $TEST_VENUS_PROCESS_WAITPID = undef;

# _alarm
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_alarm"} = sub {
    $TEST_VENUS_PROCESS_ALARM = $_[0]
  };
}

# _chdir
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_chdir"} = sub {
    $TEST_VENUS_PROCESS_CHDIR
  };
}

# _exit
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_exit"} = sub {
    $TEST_VENUS_PROCESS_EXIT
  };
}

# _exitcode
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_exitcode"} = sub {
    $TEST_VENUS_PROCESS_EXITCODE
  };
}

# _fork
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_fork"} = sub {
    if (defined $TEST_VENUS_PROCESS_FORK) {
      return $TEST_VENUS_PROCESS_FORK;
    }
    else {
      return $TEST_VENUS_PROCESS_PID++;
    }
  };
}

# _forkable
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_forkable"} = sub {
    return $TEST_VENUS_PROCESS_FORKABLE;
  };
}

# _kill
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_kill"} = sub {
    $TEST_VENUS_PROCESS_KILL;
  };
}

# _open
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_open"} = sub {
    $TEST_VENUS_PROCESS_OPEN
  };
}

# _pid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_pid"} = sub {
    $TEST_VENUS_PROCESS_PID
  };
}

# _setsid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_setsid"} = sub {
    $TEST_VENUS_PROCESS_SETSID
  };
}

# _waitpid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_waitpid"} = sub {
    if (defined $TEST_VENUS_PROCESS_WAITPID) {
      return $TEST_VENUS_PROCESS_WAITPID;
    }
    else {
      return --$TEST_VENUS_PROCESS_PID;
    }
  };
}

$test->for('example', 1, 'work', sub {
  if ($Config{d_pseudofork}) {
    plan skip_all => 'Fork emulation not supported';
  }
  return 1;
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  is $result, $TEST_VENUS_PROCESS_PID;

  $result
});

=function wrap

The wrap function installs a wrapper function in the calling package which when
called either returns the package string if no arguments are provided, or calls
L</make> on the package with whatever arguments are provided and returns the
result. Unless an alias is provided as a second argument, special characters
are stripped from the package to create the function name.

=signature wrap

  wrap(Str $data, Str $name) (CodeRef)

=metadata wrap

{
  since => '2.32',
}

=example-1 wrap

  package main;

  use Venus 'wrap';

  my $coderef = wrap('Digest::SHA');

  # sub { ... }

  # my $digest = DigestSHA();

  # "Digest::SHA"

  # my $digest = DigestSHA(1);

  # bless(do{\(my $o = '...')}, 'Digest::SHA')

=cut

$test->for('example', 1, 'wrap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, '*main::DigestSHA';
  is DigestSHA(), "Digest::SHA";
  ok DigestSHA(1)->isa("Digest::SHA");

  $result
});

=example-2 wrap

  package main;

  use Venus 'wrap';

  my $coderef = wrap('Digest::SHA', 'SHA');

  # sub { ... }

  # my $digest = SHA();

  # "Digest::SHA"

  # my $digest = SHA(1);

  # bless(do{\(my $o = '...')}, 'Digest::SHA')

=cut

$test->for('example', 2, 'wrap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, '*main::SHA';
  is SHA(), "Digest::SHA";
  ok SHA(1)->isa("Digest::SHA");

  $result
});

=function yaml

The yaml function builds a L<Venus::Yaml> object and will either
L<Venus::Yaml/decode> or L<Venus::Yaml/encode> based on the argument provided
and returns the result.

=signature yaml

  yaml(Str $call, Any $data) (Any)

=metadata yaml

{
  since => '2.40',
}

=cut

=example-1 yaml

  package main;

  use Venus 'yaml';

  my $decode = yaml 'decode', "---\nname:\n- Ready\n- Robot\nstable: true\n";

  # { name => ["Ready", "Robot"], stable => 1 }

=cut

$test->for('example', 1, 'yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, { name => ["Ready", "Robot"], stable => 1 };

  $result
});

=example-2 yaml

  package main;

  use Venus 'yaml';

  my $encode = yaml 'encode', { name => ["Ready", "Robot"], stable => true };

  # '---\nname:\n- Ready\n- Robot\nstable: true\n'

=cut

$test->for('example', 2, 'yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  $result =~ s/\n/\\n/g;
  is $result, '---\nname:\n- Ready\n- Robot\nstable: true\n';

  $result
});

=feature venus-args

This library contains a L<Venus::Args> class which provides methods for
accessing C<@ARGS> items.

=cut

$test->for('feature', 'venus-args');

=feature venus-array

This library contains a L<Venus::Array> class which provides methods for
manipulating array data.

=cut

$test->for('feature', 'venus-array');

=feature venus-assert

This library contains a L<Venus::Assert> class which provides a mechanism for
asserting type constraints and coercion.

=cut

$test->for('feature', 'venus-assert');

=feature venus-boolean

This library contains a L<Venus::Boolean> class which provides a representation
for boolean values.

=cut

$test->for('feature', 'venus-boolean');

=feature venus-box

This library contains a L<Venus::Box> class which provides a pure Perl boxing
mechanism.

=cut

$test->for('feature', 'venus-box');

=feature venus-class

This library contains a L<Venus::Class> class which provides a class builder.

=cut

$test->for('feature', 'venus-class');

=feature venus-cli

This library contains a L<Venus::Cli> class which provides a superclass for
creating CLIs.

=cut

$test->for('feature', 'venus-cli');

=feature venus-code

This library contains a L<Venus::Code> class which provides methods for
manipulating subroutines.

=cut

$test->for('feature', 'venus-code');

=feature venus-config

This library contains a L<Venus::Config> class which provides methods for
loading Perl, YAML, and JSON configuration data.

=cut

$test->for('feature', 'venus-config');

=feature venus-data

This library contains a L<Venus::Data> class which provides methods for
extracting C<DATA> sections and POD block.

=cut

$test->for('feature', 'venus-data');

=feature venus-date

This library contains a L<Venus::Date> class which provides methods for
formatting, parsing, and manipulating dates.

=cut

$test->for('feature', 'venus-date');

=feature venus-dump

This library contains a L<Venus::Dump> class which provides methods for reading
and writing dumped Perl data.

=cut

$test->for('feature', 'venus-dump');

=feature venus-error

This library contains a L<Venus::Error> class which represents a context-aware
error (exception object).

=cut

$test->for('feature', 'venus-error');

=feature venus-false

This library contains a L<Venus::False> class which provides the global
C<false> value.

=cut

$test->for('feature', 'venus-false');

=feature venus-fault

This library contains a L<Venus::Fault> class which represents a generic system
error (exception object).

=cut

$test->for('feature', 'venus-fault');

=feature venus-float

This library contains a L<Venus::Float> class which provides methods for
manipulating float data.

=cut

$test->for('feature', 'venus-float');

=feature venus-gather

This library contains a L<Venus::Gather> class which provides an
object-oriented interface for complex pattern matching operations on
collections of data, e.g. array references.

=cut

$test->for('feature', 'venus-gather');

=feature venus-hash

This library contains a L<Venus::Hash> class which provides methods for
manipulating hash data.

=cut

$test->for('feature', 'venus-hash');

=feature venus-json

This library contains a L<Venus::Json> class which provides methods for reading
and writing JSON data.

=cut

$test->for('feature', 'venus-json');

=feature venus-log

This library contains a L<Venus::Log> class which provides methods for logging
information using various log levels.

=cut

$test->for('feature', 'venus-log');

=feature venus-match

This library contains a L<Venus::Match> class which provides an object-oriented
interface for complex pattern matching operations on scalar values.

=cut

$test->for('feature', 'venus-match');

=feature venus-meta

This library contains a L<Venus::Meta> class which provides configuration
information for L<Venus> derived classes.

=cut

$test->for('feature', 'venus-meta');

=feature venus-mixin

This library contains a L<Venus::Mixin> class which provides a mixin builder.

=cut

$test->for('feature', 'venus-mixin');

=feature venus-name

This library contains a L<Venus::Name> class which provides methods for parsing
and formatting package namespaces.

=cut

$test->for('feature', 'venus-name');

=feature venus-number

This library contains a L<Venus::Number> class which provides methods for
manipulating number data.

=cut

$test->for('feature', 'venus-number');

=feature venus-opts

This library contains a L<Venus::Opts> class which provides methods for
handling command-line arguments.

=cut

$test->for('feature', 'venus-opts');

=feature venus-path

This library contains a L<Venus::Path> class which provides methods for working
with file system paths.

=cut

$test->for('feature', 'venus-path');

=feature venus-process

This library contains a L<Venus::Process> class which provides methods for
handling and forking processes.

=cut

$test->for('feature', 'venus-process');

=feature venus-prototype

This library contains a L<Venus::Prototype> class which provides a simple
construct for enabling prototype-base programming.

=cut

$test->for('feature', 'venus-prototype');

=feature venus-random

This library contains a L<Venus::Random> class which provides an
object-oriented interface for Perl's pseudo-random number generator.

=cut

$test->for('feature', 'venus-random');

=feature venus-regexp

This library contains a L<Venus::Regexp> class which provides methods for
manipulating regexp data.

=cut

$test->for('feature', 'venus-regexp');

=feature venus-replace

This library contains a L<Venus::Replace> class which provides methods for
manipulating regexp replacement data.

=cut

$test->for('feature', 'venus-replace');

=feature venus-scalar

This library contains a L<Venus::Scalar> class which provides methods for
manipulating scalar data.

=cut

$test->for('feature', 'venus-scalar');

=feature venus-search

This library contains a L<Venus::Search> class which provides methods for
manipulating regexp search data.

=cut

$test->for('feature', 'venus-search');

=feature venus-space

This library contains a L<Venus::Space> class which provides methods for
parsing and manipulating package namespaces.

=cut

$test->for('feature', 'venus-space');

=feature venus-string

This library contains a L<Venus::String> class which provides methods for
manipulating string data.

=cut

$test->for('feature', 'venus-string');

=feature venus-template

This library contains a L<Venus::Template> class which provides a templating
system, and methods for rendering template.

=cut

$test->for('feature', 'venus-template');

=feature venus-test

This library contains a L<Venus::Test> class which aims to provide a standard
for documenting L<Venus> derived software projects.

=cut

$test->for('feature', 'venus-test');

=feature venus-throw

This library contains a L<Venus::Throw> class which provides a mechanism for
generating and raising error objects.

=cut

$test->for('feature', 'venus-throw');

=feature venus-true

This library contains a L<Venus::True> class which provides the global C<true>
value.

=cut

$test->for('feature', 'venus-true');

=feature venus-try

This library contains a L<Venus::Try> class which provides an object-oriented
interface for performing complex try/catch operations.

=cut

$test->for('feature', 'venus-try');

=feature venus-type

This library contains a L<Venus::Type> class which provides methods for casting
native data types to objects.

=cut

$test->for('feature', 'venus-type');

=feature venus-undef

This library contains a L<Venus::Undef> class which provides methods for
manipulating undef data.

=cut

$test->for('feature', 'venus-undef');

=feature venus-unpack

This library contains a L<Venus::Unpack> class which provides methods for
validating, coercing, and otherwise operating on lists of arguments.

=cut

$test->for('feature', 'venus-unpack');

=feature venus-vars

This library contains a L<Venus::Vars> class which provides methods for
accessing C<%ENV> items.

=cut

$test->for('feature', 'venus-vars');

=feature venus-yaml

This library contains a L<Venus::Yaml> class which provides methods for reading
and writing YAML data.

=cut

$test->for('feature', 'venus-yaml');

=authors

Awncorp, C<awncorp@cpan.org>

=cut

$test->for('authors');

=license

Copyright (C) 2000, Al Newkirk.

This program is free software, you can redistribute it and/or modify it under
the terms of the Apache license version 2.0.

=cut

$test->for('license');

# END

$test->render('lib/Venus.pod') if $ENV{RENDER};

ok 1 and done_testing;
