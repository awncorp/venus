package main;

use 5.018;

use strict;
use warnings;

use Config;
use Test::More;
use Venus::Test;

use_ok "Venus";

my $test = test(__FILE__);
my $fsds = qr/[:\\\/\.]+/;

our $TEST_VENUS_QX_DATA = '';
our $TEST_VENUS_QX_EXIT = 0;
our $TEST_VENUS_QX_CODE = 0;

# _qx
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::_qx"} = sub {
    (
      $TEST_VENUS_QX_DATA,
      $TEST_VENUS_QX_EXIT,
      $TEST_VENUS_QX_CODE
    )
  };
}

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
function: array
function: arrayref
function: assert
function: bool
function: box
function: call
function: cast
function: catch
function: caught
function: chain
function: check
function: clargs
function: cli
function: code
function: config
function: cop
function: data
function: date
function: error
function: false
function: fault
function: float
function: gather
function: hash
function: hashref
function: is_bool
function: is_false
function: is_true
function: json
function: list
function: load
function: log
function: make
function: match
function: merge
function: meta
function: name
function: number
function: opts
function: pairs
function: path
function: perl
function: process
function: proto
function: raise
function: random
function: regexp
function: render
function: replace
function: roll
function: search
function: space
function: schema
function: string
function: syscall
function: template
function: test
function: then
function: throw
function: true
function: try
function: type
function: unpack
function: vars
function: venus
function: work
function: wrap
function: yaml

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus 'catch', 'error', 'raise';

  # error handling
  my ($error, $result) = catch {
    error;
  };

  # boolean keywords
  if ($result) {
    error;
  }

  # raise exceptions
  if ($result) {
    raise 'MyApp::Error';
  }

  # boolean keywords, and more!
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

The args function builds and returns a L<Venus::Args> object, or dispatches to
the coderef or method provided.

=signature args

  args(ArrayRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata args

{
  since => '3.10',
}

=cut

=example-1 args

  package main;

  use Venus 'args';

  my $args = args ['--resource', 'users'];

  # bless({...}, 'Venus::Args')

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Args';

  $result
});

=example-2 args

  package main;

  use Venus 'args';

  my $args = args ['--resource', 'users'], 'indexed';

  # {0 => '--resource', 1 => 'users'}

=cut

$test->for('example', 2, 'args', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {0 => '--resource', 1 => 'users'};

  $result
});

=function array

The array function builds and returns a L<Venus::Array> object, or dispatches
to the coderef or method provided.

=signature array

  array(ArrayRef | HashRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata array

{
  since => '2.55',
}

=cut

=example-1 array

  package main;

  use Venus 'array';

  my $array = array [];

  # bless({...}, 'Venus::Array')

=cut

$test->for('example', 1, 'array', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Array';
  is_deeply $result->get, [];

  $result
});

=example-2 array

  package main;

  use Venus 'array';

  my $array = array [1..4], 'push', 5..9;

  # [1..9]

=cut

$test->for('example', 2, 'array', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1..9];

  $result
});

=function arrayref

The arrayref function takes a list of arguments and returns a arrayref.

=signature arrayref

  arrayref(Any @args) (ArrayRef)

=metadata arrayref

{
  since => '3.10',
}

=example-1 arrayref

  package main;

  use Venus 'arrayref';

  my $arrayref = arrayref(content => 'example');

  # [content => "example"]

=cut

$test->for('example', 1, 'arrayref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [content => "example"];

  $result
});

=example-2 arrayref

  package main;

  use Venus 'arrayref';

  my $arrayref = arrayref([content => 'example']);

  # [content => "example"]

=cut

$test->for('example', 2, 'arrayref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [content => "example"];

  $result
});

=example-3 arrayref

  package main;

  use Venus 'arrayref';

  my $arrayref = arrayref('content');

  # ['content']

=cut

$test->for('example', 3, 'arrayref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['content'];

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

=function bool

The bool function builds and returns a L<Venus::Boolean> object.

=signature bool

  bool(Any $value) (Boolean)

=metadata bool

{
  since => '2.55',
}

=cut

=example-1 bool

  package main;

  use Venus 'bool';

  my $bool = bool;

  # bless({value => 0}, 'Venus::Boolean')

=cut

$test->for('example', 1, 'bool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Boolean';
  is $result->get, 0;

  !$result
});

=example-2 bool

  package main;

  use Venus 'bool';

  my $bool = bool 1_000;

  # bless({value => 1}, 'Venus::Boolean')

=cut

$test->for('example', 2, 'bool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Boolean';
  is $result->get, 1;

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

=function clargs

The clargs function accepts a single arrayref of L<Getopt::Long> specs, or an
arrayref of arguments followed by an arrayref of L<Getopt::Long> specs, and
returns a three element list of L<Venus::Args>, L<Venus::Opts>, and
L<Venus::Vars> objects. If only a single arrayref is provided, the arguments
will be taken from C<@ARGV>.

=signature clargs

  clargs(ArrayRef $args, ArrayRef $spec) (Args, Opts, Vars)

=metadata clargs

{
  since => '3.10',
}

=cut

=example-1 clargs

  package main;

  use Venus 'clargs';

  my ($args, $opts, $vars) = clargs;

  # (
  #   bless(..., 'Venus::Args'),
  #   bless(..., 'Venus::Opts'),
  #   bless(..., 'Venus::Vars')
  # )

=cut

$test->for('example', 1, 'clargs', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  isa_ok $result[0], 'Venus::Args';
  is_deeply $result[0]->value, [];
  isa_ok $result[1], 'Venus::Opts';
  is_deeply $result[1]->value, [];
  isa_ok $result[2], 'Venus::Vars';

  @result
});

=example-2 clargs

  package main;

  use Venus 'clargs';

  my ($args, $opts, $vars) = clargs ['resource|r=s', 'help|h'];

  # (
  #   bless(..., 'Venus::Args'),
  #   bless(..., 'Venus::Opts'),
  #   bless(..., 'Venus::Vars')
  # )

=cut

$test->for('example', 2, 'clargs', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  isa_ok $result[0], 'Venus::Args';
  is_deeply $result[0]->value, [];
  isa_ok $result[1], 'Venus::Opts';
  is_deeply $result[1]->value, [];
  is_deeply $result[1]->specs, ['resource|r=s', 'help|h'];
  isa_ok $result[2], 'Venus::Vars';

  @result
});

=example-3 clargs

  package main;

  use Venus 'clargs';

  my ($args, $opts, $vars) = clargs ['--resource', 'help'],
    ['resource|r=s', 'help|h'];

  # (
  #   bless(..., 'Venus::Args'),
  #   bless(..., 'Venus::Opts'),
  #   bless(..., 'Venus::Vars')
  # )

=cut

$test->for('example', 3, 'clargs', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  isa_ok $result[0], 'Venus::Args';
  is_deeply $result[0]->value, ['--resource', 'help'];
  isa_ok $result[1], 'Venus::Opts';
  is_deeply $result[1]->value, ['--resource', 'help'];
  is_deeply $result[1]->specs, ['resource|r=s', 'help|h'];
  isa_ok $result[2], 'Venus::Vars';

  @result
});

=function cli

The cli function builds and returns a L<Venus::Cli> object.

=signature cli

  cli(ArrayRef $args) (Cli)

=metadata cli

{
  since => '2.55',
}

=cut

=example-1 cli

  package main;

  use Venus 'cli';

  my $cli = cli;

  # bless({...}, 'Venus::Cli')

=cut

$test->for('example', 1, 'cli', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Cli';

  $result
});

=example-2 cli

  package main;

  use Venus 'cli';

  my $cli = cli ['--help'];

  # bless({...}, 'Venus::Cli')

  # $cli->set('opt', 'help', {})->opt('help');

  # 1

=cut

$test->for('example', 2, 'cli', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Cli';
  is_deeply $result->data, ['--help'];

  $result
});

=function code

The code function builds and returns a L<Venus::Code> object, or dispatches
to the coderef or method provided.

=signature code

  code(CodeRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata code

{
  since => '2.55',
}

=cut

=example-1 code

  package main;

  use Venus 'code';

  my $code = code sub {};

  # bless({...}, 'Venus::Code')

=cut

$test->for('example', 1, 'code', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Code';
  ok ref $result->get eq 'CODE';
  ok !defined $result->call;

  $result
});

=example-2 code

  package main;

  use Venus 'code';

  my $code = code sub {[1, @_]}, 'curry', 2,3,4;

  # sub {...}

=cut

$test->for('example', 2, 'code', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'CODE';
  is_deeply $result->(), [1..4];
  is_deeply $result->(5..9), [1..9];

  $result
});

=function config

The config function builds and returns a L<Venus::Config> object, or dispatches
to the coderef or method provided.

=signature config

  config(HashRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata config

{
  since => '2.55',
}

=cut

=example-1 config

  package main;

  use Venus 'config';

  my $config = config {};

  # bless({...}, 'Venus::Config')

=cut

$test->for('example', 1, 'config', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Config';
  is_deeply $result->get, {};

  $result
});

=example-2 config

  package main;

  use Venus 'config';

  my $config = config {}, 'read_perl', '{"data"=>1}';

  # bless({...}, 'Venus::Config')

=cut

$test->for('example', 2, 'config', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Config';
  is_deeply $result->get, {data => 1};

  $result
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

=function data

The data function builds and returns a L<Venus::Data> object, or dispatches
to the coderef or method provided.

=signature data

  data(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata data

{
  since => '2.55',
}

=cut

=example-1 data

  package main;

  use Venus 'data';

  my $data = data 't/data/sections';

  # bless({...}, 'Venus::Data')

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Data';
  is $result->get, 't/data/sections';

  $result
});

=example-2 data

  package main;

  use Venus 'data';

  my $data = data 't/data/sections', 'string', undef, 'name';

  # "Example #1\nExample #2"

=cut

$test->for('example', 2, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Example #1\nExample #2";

  $result
});

=function date

The date function builds and returns a L<Venus::Date> object, or dispatches to
the coderef or method provided.

=signature date

  date(Int $value, Str | CodeRef $code, Any @args) (Any)

=metadata date

{
  since => '2.40',
}

=cut

=example-1 date

  package main;

  use Venus 'date';

  my $date = date time, 'string';

  # '0000-00-00T00:00:00Z'

=cut

$test->for('example', 1, 'date', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  like $result, qr/\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d/;

  $result
});

=example-2 date

  package main;

  use Venus 'date';

  my $date = date time, 'reset', 570672000;

  # bless({...}, 'Venus::Date')

  # $date->string;

  # '1988-02-01T00:00:00Z'

=cut

$test->for('example', 2, 'date', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result->string, '1988-02-01T00:00:00Z';

  $result
});

=example-3 date

  package main;

  use Venus 'date';

  my $date = date time;

  # bless({...}, 'Venus::Date')

=cut

$test->for('example', 3, 'date', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Date';

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

=function float

The float function builds and returns a L<Venus::Float> object, or dispatches
to the coderef or method provided.

=signature float

  float(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata float

{
  since => '2.55',
}

=cut

=example-1 float

  package main;

  use Venus 'float';

  my $float = float 1.23;

  # bless({...}, 'Venus::Float')

=cut

$test->for('example', 1, 'float', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Float';
  is $result->get, 1.23;

  $result
});

=example-2 float

  package main;

  use Venus 'float';

  my $float = float 1.23, 'int';

  # 1

=cut

$test->for('example', 2, 'float', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=function gather

The gather function builds a L<Venus::Gather> object, passing it and the value
provided to the callback provided, and returns the return value from
L<Venus::Gather/result>.

=signature gather

  gather(Any $value, CodeRef $callback) (Any)

=metadata gather

{
  since => '2.50',
}

=cut

=example-1 gather

  package main;

  use Venus 'gather';

  my $gather = gather ['a'..'d'];

  # bless({...}, 'Venus::Gather')

  # $gather->result;

  # undef

=cut

$test->for('example', 1, 'gather', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Gather';

  $result
});

=example-2 gather

  package main;

  use Venus 'gather';

  my $gather = gather ['a'..'d'], sub {{
    a => 1,
    b => 2,
    c => 3,
  }};

  # [1..3]

=cut

$test->for('example', 2, 'gather', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1..3];

  $result
});

=example-3 gather

  package main;

  use Venus 'gather';

  my $gather = gather ['e'..'h'], sub {{
    a => 1,
    b => 2,
    c => 3,
  }};

  # []

=cut

$test->for('example', 3, 'gather', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-4 gather

  package main;

  use Venus 'gather';

  my $gather = gather ['a'..'d'], sub {
    my ($case) = @_;

    $case->when(sub{lc($_) eq 'a'})->then('a -> A');
    $case->when(sub{lc($_) eq 'b'})->then('b -> B');
  };

  # ['a -> A', 'b -> B']

=cut

$test->for('example', 4, 'gather', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ['a -> A', 'b -> B'];

  $result
});

=example-5 gather

  package main;

  use Venus 'gather';

  my $gather = gather ['a'..'d'], sub {

    $_->when(sub{lc($_) eq 'a'})->then('a -> A');
    $_->when(sub{lc($_) eq 'b'})->then('b -> B');
  };

  # ['a -> A', 'b -> B']

=cut

$test->for('example', 5, 'gather', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ['a -> A', 'b -> B'];

  $result
});

=function hash

The hash function builds and returns a L<Venus::Hash> object, or dispatches
to the coderef or method provided.

=signature hash

  hash(HashRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata hash

{
  since => '2.55',
}

=cut

=example-1 hash

  package main;

  use Venus 'hash';

  my $hash = hash {1..4};

  # bless({...}, 'Venus::Hash')

=cut

$test->for('example', 1, 'hash', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Hash';
  is_deeply $result->get, {1..4};

  $result
});

=example-2 hash

  package main;

  use Venus 'hash';

  my $hash = hash {1..8}, 'pairs';

  # [[1, 2], [3, 4], [5, 6], [7, 8]]

=cut

$test->for('example', 2, 'hash', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [[1, 2], [3, 4], [5, 6], [7, 8]];

  $result
});

=function hashref

The hashref function takes a list of arguments and returns a hashref.

=signature hashref

  hashref(Any @args) (HashRef)

=metadata hashref

{
  since => '3.10',
}

=example-1 hashref

  package main;

  use Venus 'hashref';

  my $hashref = hashref(content => 'example');

  # {content => "example"}

=cut

$test->for('example', 1, 'hashref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => "example"};

  $result
});

=example-2 hashref

  package main;

  use Venus 'hashref';

  my $hashref = hashref({content => 'example'});

  # {content => "example"}

=cut

$test->for('example', 2, 'hashref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => "example"};

  $result
});

=example-3 hashref

  package main;

  use Venus 'hashref';

  my $hashref = hashref('content');

  # {content => undef}

=cut

$test->for('example', 3, 'hashref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => undef};

  $result
});

=example-4 hashref

  package main;

  use Venus 'hashref';

  my $hashref = hashref('content', 'example', 'algorithm');

  # {content => "example", algorithm => undef}

=cut

$test->for('example', 4, 'hashref', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {content => "example", algorithm => undef};

  $result
});

=function is_bool

The is_bool function returns L</true> if the value provided is a boolean value,
not merely truthy, and L</false> otherwise.

=signature is_bool

  is_bool(Any $arg) (Bool)

=metadata is_bool

{
  since => '3.18',
}

=cut

=example-1 is_bool

  package main;

  use Venus 'is_bool';

  my $is_bool = is_bool true;

  # true

=cut

$test->for('example', 1, 'is_bool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 is_bool

  package main;

  use Venus 'is_bool';

  my $is_bool = is_bool false;

  # true

=cut

$test->for('example', 2, 'is_bool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-3 is_bool

  package main;

  use Venus 'is_bool';

  my $is_bool = is_bool 1;

  # false

=cut

$test->for('example', 3, 'is_bool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-4 is_bool

  package main;

  use Venus 'is_bool';

  my $is_bool = is_bool 0;

  # false

=cut

$test->for('example', 4, 'is_bool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=function is_false

The is_false function accepts a scalar value and returns true if the value is
falsy.

=signature is_false

  is_false(Any $data) (Bool)

=metadata is_false

{
  since => '3.04',
}

=cut

=example-1 is_false

  package main;

  use Venus 'is_false';

  my $is_false = is_false 0;

  # true

=cut

$test->for('example', 1, 'is_false', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 is_false

  package main;

  use Venus 'is_false';

  my $is_false = is_false 1;

  # false

=cut

$test->for('example', 2, 'is_false', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=function is_true

The is_true function accepts a scalar value and returns true if the value is
truthy.

=signature is_true

  is_true(Any $data) (Bool)

=metadata is_true

{
  since => '3.04',
}

=cut

=example-1 is_true

  package main;

  use Venus 'is_true';

  my $is_true = is_true 1;

  # true

=cut

$test->for('example', 1, 'is_true', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 is_true

  package main;

  use Venus 'is_true';

  my $is_true = is_true 0;

  # false

=cut

$test->for('example', 2, 'is_true', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
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

=example-3 json

  package main;

  use Venus 'json';

  my $json = json;

  # bless({...}, 'Venus::Json')

=cut

$test->for('example', 3, 'json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Json';

  $result
});

=example-4 json

  package main;

  use Venus 'json';

  my $json = json 'class', {data => "..."};

  # Exception! (isa Venus::Fault)

=cut

$test->for('example', 4, 'json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->catch('Venus::Fault')->result;
  isa_ok $result, 'Venus::Fault';
  like $result, qr/Invalid "json" action "class"/;

  $result
});

=function list

The list function accepts a list of values and flattens any arrayrefs,
returning a list of scalars.

=signature list

  list(Any @args) (Any)

=metadata list

{
  since => '3.04',
}

=cut

=example-1 list

  package main;

  use Venus 'list';

  my @list = list 1..4;

  # (1..4)

=cut

$test->for('example', 1, 'list', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], [1..4];

  @result
});

=example-2 list

  package main;

  use Venus 'list';

  my @list = list [1..4];

  # (1..4)

=cut

$test->for('example', 2, 'list', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], [1..4];

  @result
});

=example-3 list

  package main;

  use Venus 'list';

  my @list = list [1..4], 5, [6..10];

  # (1..10)

=cut

$test->for('example', 3, 'list', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], [1..10];

  @result
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

=function match

The match function builds a L<Venus::Match> object, passing it and the value
provided to the callback provided, and returns the return value from
L<Venus::Match/result>.

=signature match

  match(Any $value, CodeRef $callback) (Any)

=metadata match

{
  since => '2.50',
}

=cut

=example-1 match

  package main;

  use Venus 'match';

  my $match = match 5;

  # bless({...}, 'Venus::Match')

  # $match->result;

  # undef

=cut

$test->for('example', 1, 'match', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Match';

  $result
});

=example-2 match

  package main;

  use Venus 'match';

  my $match = match 5, sub {{
    1 => 'one',
    2 => 'two',
    5 => 'five',
  }};

  # 'five'

=cut

$test->for('example', 2, 'match', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'five';

  $result
});

=example-3 match

  package main;

  use Venus 'match';

  my $match = match 5, sub {{
    1 => 'one',
    2 => 'two',
    3 => 'three',
  }};

  # undef

=cut

$test->for('example', 3, 'match', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-4 match

  package main;

  use Venus 'match';

  my $match = match 5, sub {
    my ($case) = @_;

    $case->when(sub{$_ < 5})->then('< 5');
    $case->when(sub{$_ > 5})->then('> 5');
  };

  # undef

=cut

$test->for('example', 4, 'match', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-5 match

  package main;

  use Venus 'match';

  my $match = match 6, sub {
    my ($case, $data) = @_;

    $case->when(sub{$_ < 5})->then("$data < 5");
    $case->when(sub{$_ > 5})->then("$data > 5");
  };

  # '6 > 5'

=cut

$test->for('example', 5, 'match', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, '6 > 5';

  $result
});

=example-6 match

  package main;

  use Venus 'match';

  my $match = match 4, sub {

    $_->when(sub{$_ < 5})->then("$_[1] < 5");
    $_->when(sub{$_ > 5})->then("$_[1] > 5");
  };

  # '4 < 5'

=cut

$test->for('example', 6, 'match', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, '4 < 5';

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

=function meta

The meta function builds and returns a L<Venus::Meta> object, or dispatches to
the coderef or method provided.

=signature meta

  meta(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata meta

{
  since => '2.55',
}

=cut

=example-1 meta

  package main;

  use Venus 'meta';

  my $meta = meta 'Venus';

  # bless({...}, 'Venus::Meta')

=cut

$test->for('example', 1, 'meta', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Meta";
  is $result->{name}, 'Venus';

  $result
});

=example-2 meta

  package main;

  use Venus 'meta';

  my $result = meta 'Venus', 'sub', 'meta';

  # 1

=cut

$test->for('example', 2, 'meta', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=function name

The name function builds and returns a L<Venus::Name> object, or dispatches to
the coderef or method provided.

=signature name

  name(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata name

{
  since => '2.55',
}

=cut

=example-1 name

  package main;

  use Venus 'name';

  my $name = name 'Foo/Bar';

  # bless({...}, 'Venus::Name')

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Name';
  is $result->package, 'Foo::Bar';

  $result
});

=example-2 name

  package main;

  use Venus 'name';

  my $name = name 'Foo/Bar', 'package';

  # "Foo::Bar"

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'Foo::Bar';

  $result
});

=function number

The number function builds and returns a L<Venus::Number> object, or dispatches
to the coderef or method provided.

=signature number

  number(Num $value, Str | CodeRef $code, Any @args) (Any)

=metadata number

{
  since => '2.55',
}

=cut

=example-1 number

  package main;

  use Venus 'number';

  my $number = number 1_000;

  # bless({...}, 'Venus::Number')

=cut

$test->for('example', 1, 'number', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Number';
  is $result->get, 1_000;

  $result
});

=example-2 number

  package main;

  use Venus 'number';

  my $number = number 1_000, 'prepend', 1;

  # 11_000

=cut

$test->for('example', 2, 'number', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 11_000;

  $result
});

=function opts

The opts function builds and returns a L<Venus::Opts> object, or dispatches to
the coderef or method provided.

=signature opts

  opts(ArrayRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata opts

{
  since => '2.55',
}

=cut

=example-1 opts

  package main;

  use Venus 'opts';

  my $opts = opts ['--resource', 'users'];

  # bless({...}, 'Venus::Opts')

=cut

$test->for('example', 1, 'opts', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Opts';

  $result
});

=example-2 opts

  package main;

  use Venus 'opts';

  my $opts = opts ['--resource', 'users'], 'reparse', ['resource|r=s', 'help|h'];

  # bless({...}, 'Venus::Opts')

  # my $resource = $opts->get('resource');

  # "users"

=cut

$test->for('example', 2, 'opts', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Opts';
  is $result->get('resource'), "users";

  $result
});

=function pairs

The pairs function accepts an arrayref or hashref and returns an arrayref of
arrayrefs holding keys (or indices) and values. The function returns an empty
arrayref for all other values provided. Returns a list in list context.

=signature pairs

  pairs(Any $data) (ArrayRef)

=metadata pairs

{
  since => '3.04',
}

=cut

=example-1 pairs

  package main;

  use Venus 'pairs';

  my $pairs = pairs [1..4];

  # [[0,1], [1,2], [2,3], [3,4]]

=cut

$test->for('example', 1, 'pairs', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [[0,1], [1,2], [2,3], [3,4]];

  $result
});

=example-2 pairs

  package main;

  use Venus 'pairs';

  my $pairs = pairs {'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4};

  # [['a',1], ['b',2], ['c',3], ['d',4]]

=cut

$test->for('example', 2, 'pairs', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [['a',1], ['b',2], ['c',3], ['d',4]];

  $result
});

=example-3 pairs

  package main;

  use Venus 'pairs';

  my @pairs = pairs [1..4];

  # ([0,1], [1,2], [2,3], [3,4])

=cut

$test->for('example', 3, 'pairs', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], [[0,1], [1,2], [2,3], [3,4]];

  @result
});

=example-4 pairs

  package main;

  use Venus 'pairs';

  my @pairs = pairs {'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4};

  # (['a',1], ['b',2], ['c',3], ['d',4])

=cut

$test->for('example', 4, 'pairs', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], [['a',1], ['b',2], ['c',3], ['d',4]];

  @result
});

=function path

The path function builds and returns a L<Venus::Path> object, or dispatches
to the coderef or method provided.

=signature path

  path(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata path

{
  since => '2.55',
}

=cut

=example-1 path

  package main;

  use Venus 'path';

  my $path = path 't/data/planets';

  # bless({...}, 'Venus::Path')

=cut

$test->for('example', 1, 'path', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Path';
  ok $result->get =~ m{t${fsds}data${fsds}planets};

  $result
});

=example-2 path

  package main;

  use Venus 'path';

  my $path = path 't/data/planets', 'absolute';

  # bless({...}, 'Venus::Path')

=cut

$test->for('example', 2, 'path', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Path';
  ok $result->get =~ m{t${fsds}data${fsds}planets};

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

=example-3 perl

  package main;

  use Venus 'perl';

  my $perl = perl;

  # bless({...}, 'Venus::Dump')

=cut

$test->for('example', 3, 'perl', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Dump';

  $result
});

=example-4 perl

  package main;

  use Venus 'perl';

  my $perl = perl 'class', {data => "..."};

  # Exception! (isa Venus::Fault)

=cut

$test->for('example', 4, 'perl', sub {
  my ($tryable) = @_;
  my $result = $tryable->catch('Venus::Fault')->result;
  isa_ok $result, 'Venus::Fault';
  like $result, qr/Invalid "perl" action "class"/;

  $result
});

=function process

The process function builds and returns a L<Venus::Process> object, or
dispatches to the coderef or method provided.

=signature process

  process(Str | CodeRef $code, Any @args) (Any)

=metadata process

{
  since => '2.55',
}

=cut

=example-1 process

  package main;

  use Venus 'process';

  my $process = process;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'process', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Process";

  $result
});

=example-2 process

  package main;

  use Venus 'process';

  my $process = process 'do', 'alarm', 10;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'process', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Process";
  is $result->alarm, 10;

  $result
});

=function proto

The proto function builds and returns a L<Venus::Prototype> object, or
dispatches to the coderef or method provided.

=signature proto

  proto(HashRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata proto

{
  since => '2.55',
}

=cut

=example-1 proto

  package main;

  use Venus 'proto';

  my $proto = proto {
    '$counter' => 0,
  };

  # bless({...}, 'Venus::Prototype')

=cut

$test->for('example', 1, 'proto', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Prototype';
  is $result->counter, 0;

  $result
});

=example-2 proto

  package main;

  use Venus 'proto';

  my $proto = proto { '$counter' => 0 }, 'apply', {
    '&decrement' => sub { $_[0]->counter($_[0]->counter - 1) },
    '&increment' => sub { $_[0]->counter($_[0]->counter + 1) },
  };

  # bless({...}, 'Venus::Prototype')

=cut

$test->for('example', 2, 'proto', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Prototype';
  is $result->counter, 0;
  is $result->increment, 1;
  is $result->decrement, 0;

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

=function random

The random function builds and returns a L<Venus::Random> object, or dispatches
to the coderef or method provided.

=signature random

  random(Str | CodeRef $code, Any @args) (Any)

=metadata random

{
  since => '2.55',
}

=cut

=example-1 random

  package main;

  use Venus 'random';

  my $random = random;

  # bless({...}, 'Venus::Random')

=cut

$test->for('example', 1, 'random', sub {
  if (require Venus::Random && Venus::Random->new(42)->range(1, 50) != 38) {
    plan skip_all => "OS ($^O) rand function is undeterministic";
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Random";

  $result
});

=example-2 random

  package main;

  use Venus 'random';

  my $random = random 'collect', 10, 'letter';

  # "ryKUPbJHYT"

=cut

$test->for('example', 2, 'random', sub {
  if (require Venus::Random && Venus::Random->new(42)->range(1, 50) != 38) {
    plan skip_all => "OS ($^O) rand function is undeterministic";
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result;

  $result
});

=function regexp

The regexp function builds and returns a L<Venus::Regexp> object, or dispatches
to the coderef or method provided.

=signature regexp

  regexp(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata regexp

{
  since => '2.55',
}

=cut

=example-1 regexp

  package main;

  use Venus 'regexp';

  my $regexp = regexp '[0-9]';

  # bless({...}, 'Venus::Regexp')

=cut

$test->for('example', 1, 'regexp', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Regexp";

  $result
});

=example-2 regexp

  package main;

  use Venus 'regexp';

  my $replace = regexp '[0-9]', 'replace', 'ID 12345', '0', 'g';

  # bless({...}, 'Venus::Replace')

  # $replace->get;

  # "ID 00000"

=cut

$test->for('example', 2, 'regexp', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Replace";
  is $result->get, "ID 00000";

  $result
});

=function render

The render function accepts a string as a template and renders it using
L<Venus::Template>, and returns the result.

=signature render

  render(Str $data, HashRef $args) (Str)

=metadata render

{
  since => '3.04',
}

=cut

=example-1 render

  package main;

  use Venus 'render';

  my $render = render 'hello {{name}}', {
    name => 'user',
  };

  # "hello user"

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "hello user";

  $result
});

=function replace

The replace function builds and returns a L<Venus::Replace> object, or
dispatches to the coderef or method provided.

=signature replace

  replace(ArrayRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata replace

{
  since => '2.55',
}

=cut

=example-1 replace

  package main;

  use Venus 'replace';

  my $replace = replace ['hello world', 'world', 'universe'];

  # bless({...}, 'Venus::Replace')

=cut

$test->for('example', 1, 'replace', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Replace";
  is $result->string, 'hello world';
  is $result->regexp, 'world';
  is $result->substr, 'universe';

  $result
});

=example-2 replace

  package main;

  use Venus 'replace';

  my $replace = replace ['hello world', 'world', 'universe'], 'get';

  # "hello universe"

=cut

$test->for('example', 2, 'replace', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "hello universe";

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

=function search

The search function builds and returns a L<Venus::Search> object, or dispatches
to the coderef or method provided.

=signature search

  search(ArrayRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata search

{
  since => '2.55',
}

=cut

=example-1 search

  package main;

  use Venus 'search';

  my $search = search ['hello world', 'world'];

  # bless({...}, 'Venus::Search')

=cut

$test->for('example', 1, 'search', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Search";
  is $result->string, 'hello world';
  is $result->regexp, 'world';

  $result
});

=example-2 search

  package main;

  use Venus 'search';

  my $search = search ['hello world', 'world'], 'count';

  # 1

=cut

$test->for('example', 2, 'search', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
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

=function schema

The schema function builds and returns a L<Venus::Schema> object, or dispatches
to the coderef or method provided.

=signature schema

  schema(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata schema

{
  since => '2.55',
}

=cut

=example-1 schema

  package main;

  use Venus 'schema';

  my $schema = schema { name => 'string' };

  # bless({...}, "Venus::Schema")

=cut

$test->for('example', 1, 'schema', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Schema';
  is_deeply $result->definition, { name => 'string' };

  $result
});

=example-2 schema

  package main;

  use Venus 'schema';

  my $result = schema { name => 'string' }, 'validate', { name => 'example' };

  # { name => 'example' }

=cut

$test->for('example', 2, 'schema', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, { name => 'example' };

  $result
});

=function string

The string function builds and returns a L<Venus::String> object, or dispatches
to the coderef or method provided.

=signature string

  string(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata string

{
  since => '2.55',
}

=cut

=example-1 string

  package main;

  use Venus 'string';

  my $string = string 'hello world';

  # bless({...}, 'Venus::String')

=cut

$test->for('example', 1, 'string', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::String';
  is $result->get, 'hello world';

  $result
});

=example-2 string

  package main;

  use Venus 'string';

  my $string = string 'hello world', 'camelcase';

  # "helloWorld"

=cut

$test->for('example', 2, 'string', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'helloWorld';

  $result
});

=function syscall

The syscall function perlforms system call, i.e. a L<perlfunc/qx> operation,
and returns C<true> if the command succeeds, otherwise returns C<false>. In
list context, returns the output of the operation and the exit code.

=signature syscall

  syscall(Int | Str @args) (Any)

=metadata syscall

{
  since => '3.04',
}

=cut

=example-1 syscall

  package main;

  use Venus 'syscall';

  my $syscall = syscall 'perl', '-v';

  # true

=cut

$test->for('example', 1, 'syscall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_QX_DATA = 'perl';
  local $TEST_VENUS_QX_EXIT = 0;
  local $TEST_VENUS_QX_CODE = 0;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 syscall

  package main;

  use Venus 'syscall';

  my $syscall = syscall 'perl', '-z';

  # false

=cut

$test->for('example', 2, 'syscall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_QX_DATA = 'perl';
  local $TEST_VENUS_QX_EXIT = 7424;
  local $TEST_VENUS_QX_CODE = 29;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-3 syscall

  package main;

  use Venus 'syscall';

  my ($data, $code) = syscall 'sun', '--heat-death';

  # ('done', 0)

=cut

$test->for('example', 3, 'syscall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_QX_DATA = 'done';
  local $TEST_VENUS_QX_EXIT = 0;
  local $TEST_VENUS_QX_CODE = 0;
  my @result = $tryable->result;
  is_deeply [@result], ['done', 0];

  @result
});

=example-4 syscall

  package main;

  use Venus 'syscall';

  my ($data, $code) = syscall 'earth', '--melt-icecaps';

  # ('', 127)

=cut

$test->for('example', 4, 'syscall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_QX_DATA = '';
  local $TEST_VENUS_QX_EXIT = -1;
  local $TEST_VENUS_QX_CODE = 127;
  my @result = $tryable->result;
  is_deeply [@result], ['', 127];

  @result
});

=function template

The template function builds and returns a L<Venus::Template> object, or
dispatches to the coderef or method provided.

=signature template

  template(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata template

{
  since => '2.55',
}

=cut

=example-1 template

  package main;

  use Venus 'template';

  my $template = template 'Hi {{name}}';

  # bless({...}, 'Venus::Template')

=cut

$test->for('example', 1, 'template', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Template';
  is $result->get, 'Hi {{name}}';

  $result
});

=example-2 template

  package main;

  use Venus 'template';

  my $template = template 'Hi {{name}}', 'render', undef, {
    name => 'stranger',
  };

  # "Hi stranger"

=cut

$test->for('example', 2, 'template', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'Hi stranger';

  $result
});

=function test

The test function builds and returns a L<Venus::Test> object, or dispatches to
the coderef or method provided.

=signature test

  test(Str $value, Str | CodeRef $code, Any @args) (Any)

=metadata test

{
  since => '2.55',
}

=cut

=example-1 test

  package main;

  use Venus 'test';

  my $test = test 't/Venus.t';

  # bless({...}, 'Venus::Test')

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Test";
  is $result->file, 't/Venus.t';

  $result
});

=example-2 test

  package main;

  use Venus 'test';

  my $test = test 't/Venus.t', 'for', 'synopsis';

  # bless({...}, 'Venus::Test')

=cut

$test->for('example', 2, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Test";
  is $result->file, 't/Venus.t';

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

=function throw

The throw function builds and returns a L<Venus::Throw> object, or dispatches
to the coderef or method provided.

=signature throw

  throw(Str | HashRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata throw

{
  since => '2.55',
}

=cut

=example-1 throw

  package main;

  use Venus 'throw';

  my $throw = throw 'Example::Error';

  # bless({...}, 'Venus::Throw')

=cut

$test->for('example', 1, 'throw', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Throw";
  is $result->package, 'Example::Error';

  $result
});

=example-2 throw

  package main;

  use Venus 'throw';

  my $throw = throw 'Example::Error', 'catch', 'error';

  # bless({...}, 'Example::Error')

=cut

$test->for('example', 2, 'throw', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Example::Error';

  $result
});

=example-3 throw

  package main;

  use Venus 'throw';

  my $throw = throw {
    name => 'on.execute',
    package => 'Example::Error',
    capture => ['...'],
    stash => {
      time => time,
    },
  };

  # bless({...}, 'Venus::Throw')

=cut

$test->for('example', 3, 'throw', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Throw';
  ok $result->package eq 'Example::Error';
  is $result->name, 'on.execute';
  ok $result->stash('captured');
  ok $result->stash('time');

  $result
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

=function try

The try function builds and returns a L<Venus::Try> object, or dispatches to
the coderef or method provided.

=signature try

  try(Any $data, Str | CodeRef $code, Any @args) (Any)

=metadata try

{
  since => '2.55',
}

=cut

=example-1 try

  package main;

  use Venus 'try';

  my $try = try sub {};

  # bless({...}, 'Venus::Try')

  # my $result = $try->result;

  # ()

=cut

$test->for('example', 1, 'try', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Try";

  $result
});

=example-2 try

  package main;

  use Venus 'try';

  my $try = try sub { die };

  # bless({...}, 'Venus::Try')

  # my $result = $try->result;

  # Exception! (isa Venus::Error)

=cut

$test->for('example', 2, 'try', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Try";

  $result
});

=example-3 try

  package main;

  use Venus 'try';

  my $try = try sub { die }, 'maybe';

  # bless({...}, 'Venus::Try')

  # my $result = $try->result;

  # undef

=cut

$test->for('example', 3, 'try', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Try';
  ok !defined $result->result;

  $result
});

=function type

The type function builds and returns a L<Venus::Type> object, or dispatches to
the coderef or method provided.

=signature type

  type(Any $data, Str | CodeRef $code, Any @args) (Any)

=metadata type

{
  since => '2.55',
}

=cut

=example-1 type

  package main;

  use Venus 'type';

  my $type = type [1..4];

  # bless({...}, 'Venus::Type')

  # $type->deduce;

  # bless({...}, 'Venus::Array')

=cut

$test->for('example', 1, 'type', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Type";
  my $returned = $result->deduce;
  isa_ok $returned, "Venus::Array";

  $result
});

=example-2 type

  package main;

  use Venus 'type';

  my $type = type [1..4], 'deduce';

  # bless({...}, 'Venus::Array')

=cut

$test->for('example', 2, 'type', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, "Venus::Array";

  $result
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

=function vars

The vars function builds and returns a L<Venus::Vars> object, or dispatches to
the coderef or method provided.

=signature vars

  vars(HashRef $value, Str | CodeRef $code, Any @args) (Any)

=metadata vars

{
  since => '2.55',
}

=cut

=example-1 vars

  package main;

  use Venus 'vars';

  my $vars = vars {};

  # bless({...}, 'Venus::Vars')

=cut

$test->for('example', 1, 'vars', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Vars';

  $result
});

=example-2 vars

  package main;

  use Venus 'vars';

  my $path = vars {}, 'exists', 'path';

  # "..."

=cut

$test->for('example', 2, 'vars', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result;

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

=example-3 yaml

  package main;

  use Venus 'yaml';

  my $yaml = yaml;

  # bless({...}, 'Venus::Yaml')

=cut

$test->for('example', 3, 'yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Yaml';

  $result
});

=example-4 yaml

  package main;

  use Venus 'yaml';

  my $yaml = yaml 'class', {data => "..."};

  # Exception! (isa Venus::Fault)

=cut

$test->for('example', 4, 'yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  my $result = $tryable->catch('Venus::Fault')->result;
  isa_ok $result, 'Venus::Fault';
  like $result, qr/Invalid "yaml" action "class"/;

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

=feature venus-run

This library contains a L<Venus::Run> class which provides a base class for
providing a command execution system for creating CLIs (command-line
interfaces).

=cut

$test->for('feature', 'venus-run');

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

=feature venus-task

This library contains a L<Venus::Task> class which provides a base class for
creating CLIs (command-line interfaces).

=cut

$test->for('feature', 'venus-task');

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
