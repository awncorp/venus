package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;
use File::Temp;

my $test = test(__FILE__);
my $path = File::Temp::tempdir(CLEANUP => 1);

=name

Venus::Space

=cut

$test->for('name');

=tagline

Space Class

=cut

$test->for('tagline');

=abstract

Space Class for Perl 5

=cut

$test->for('abstract');

=includes

method: all
method: append
method: array
method: arrays
method: authority
method: basename
method: blessed
method: build
method: call
method: chain
method: child
method: children
method: cop
method: data
method: destroy
method: eval
method: explain
method: hash
method: hashes
method: id
method: init
method: inherits
method: included
method: inject
method: load
method: loaded
method: locate
method: name
method: parent
method: parse
method: parts
method: prepend
method: rebase
method: reload
method: require
method: root
method: routine
method: routines
method: scalar
method: scalars
method: sibling
method: siblings
method: tryload
method: use
method: used
method: variables
method: version

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/bar');

  # $space->package; # Foo::Bar

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for parsing and manipulating package namespaces.

=cut

$test->for('description');

=inherits

Venus::Name

=cut

$test->for('inherits');

=method all

The all method executes any available method on the instance and all instances
representing packages inherited by the package represented by the invocant.

=signature all

  all(Str $method, Any @args) (ArrayRef[Tuple[Str, Any]])

=metadata all

{
  since => '0.01',
}

=example-1 all

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus');

  my $all = $space->all('id');

  # [["Venus", "Venus"]]

=cut

$test->for('example', 1, 'all', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [["Venus", "Venus"]];

  $result
});

=example-2 all

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus/Space');

  my $all = $space->all('inherits');

  # [
  #   [
  #     "Venus::Space", ["Venus::Name"]
  #   ],
  #   [
  #     "Venus::Name", ["Venus::Kind::Utility"]
  #   ],
  # ]

=cut

$test->for('example', 2, 'all', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    ["Venus::Space", ["Venus::Name"]],
    ["Venus::Name", ["Venus::Kind::Utility"]]
  ];

  $result
});

=example-3 all

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus/Space');

  my $all = $space->all('locate');

  # [
  #   [
  #     "Venus::Space",
  #     "/path/to/lib/Venus/Space.pm",
  #   ],
  #   [
  #     "Venus::Name",
  #     "/path/to/lib/Venus/Name.pm",
  #   ],
  # ]

=cut

 $test->for('example', 3, 'all', sub {
   my ($tryable) = @_;
   ok my $result = $tryable->result;
   ok @$result == 2;
   ok @{$result->[0]} == 2;
   ok $result->[0][0] eq 'Venus::Space';
   ok $result->[0][1] =~ 'Venus/Space';
   ok @{$result->[1]} == 2;
   ok $result->[1][0] eq 'Venus::Name';
   ok $result->[1][1] =~ 'Venus/Name';

   $result
 });

=method append

The append method modifies the object by appending to the package namespace
parts.

=signature append

  append(Str @path) (Space)

=metadata append

{
  since => '0.01',
}

=example-1 append

  # given: synopsis;

  my $append = $space->append('baz');

  # bless({ value => "Foo/Bar/Baz" }, "Venus::Space")

=cut

$test->for('example', 1, 'append', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok $result =~ m{Foo::Bar::Baz};

  $result
});

=example-2 append

  # given: synopsis;

  my $append = $space->append('baz', 'bax');

  # bless({ value => "Foo/Bar/Baz/Bax" }, "Venus::Space")

=cut

$test->for('example', 2, 'append', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok $result =~ m{Foo::Bar::Baz::Bax};

  $result
});

=method array

The array method returns the value for the given package array variable name.

=signature array

  array(Str $name) (ArrayRef)

=metadata array

{
  since => '0.01',
}

=example-1 array

  # given: synopsis;

  package Foo::Bar;

  our @handler = 'start';

  package main;

  my $array = $space->array('handler');

  # ["start"]

=cut

$test->for('example', 1, 'array', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['start'];

  $result
});

=method arrays

The arrays method searches the package namespace for arrays and returns their
names.

=signature arrays

  arrays() (ArrayRef)

=metadata arrays

{
  since => '0.01',
}

=example-1 arrays

  # given: synopsis;

  package Foo::Bar;

  our @handler = 'start';
  our @initial = ('next', 'prev');

  package main;

  my $arrays = $space->arrays;

  # ["handler", "initial"]

=cut

$test->for('example', 1, 'arrays', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["handler", "initial"];

  $result
});

=method authority

The authority method returns the C<AUTHORITY> declared on the target package,
if any.

=signature authority

  authority() (Maybe[Str])

=metadata authority

{
  since => '0.01',
}

=example-1 authority

  package Foo::Boo;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $authority = $space->authority;

  # undef

=cut

$test->for('example', 1, 'authority', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 authority

  package Foo::Boo;

  our $AUTHORITY = 'cpan:CPANERY';

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $authority = $space->authority;

  # "cpan:CPANERY"

=cut

$test->for('example', 2, 'authority', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'cpan:CPANERY';

  $result
});

=method basename

The basename method returns the last segment of the package namespace parts.

=signature basename

  basename() (Str)

=metadata basename

{
  since => '0.01',
}

=example-1 basename

  # given: synopsis;

  my $basename = $space->basename;

  # "Bar"

=cut

$test->for('example', 1, 'basename', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Bar';

  $result
});

=method blessed

The blessed method blesses the given value into the package namespace and
returns an object. If no value is given, an empty hashref is used.

=signature blessed

  blessed(Ref $data) (Object)

=metadata blessed

{
  since => '0.01',
}

=example-1 blessed

  # given: synopsis;

  package Foo::Bar;

  sub import;

  package main;

  my $blessed = $space->blessed;

  # bless({}, "Foo::Bar")

=cut

$test->for('example', 1, 'blessed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Foo::Bar');

  $result
});

=example-2 blessed

  # given: synopsis;

  package Foo::Bar;

  sub import;

  package main;

  my $blessed = $space->blessed({okay => 1});

  # bless({ okay => 1 }, "Foo::Bar")

=cut

$test->for('example', 2, 'blessed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Foo::Bar');
  ok exists $result->{okay};
  ok $result->{okay} == 1;

  $result
});

=method build

The build method attempts to call C<new> on the package namespace and if
successful returns the resulting object.

=signature build

  build(Any @args) (Object)

=metadata build

{
  since => '0.01',
}

=example-1 build

  # given: synopsis;

  package Foo::Bar::Baz;

  sub new {
    bless {}, $_[0];
  }

  package main;

  my $build = $space->child('baz')->build;

  # bless({}, "Foo::Bar::Baz")

=cut

$test->for('example', 1, 'build', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Foo::Bar::Baz');

  $result
});

=example-2 build

  # given: synopsis;

  package Foo::Bar::Bax;

  sub new {
    bless $_[1], $_[0];
  }

  package main;

  my $build = $space->child('bax')->build({okay => 1});

  # bless({ okay => 1 }, "Foo::Bar::Bax")

=cut

$test->for('example', 2, 'build', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Foo::Bar::Bax');
  ok exists $result->{okay};
  ok $result->{okay} == 1;

  $result
});

=example-3 build

  # given: synopsis;

  package Foo::Bar::Bay;

  sub new {
    bless $_[1], $_[0];
  }

  package main;

  my $build = $space->child('bay')->build([okay => 1]);

  # bless(["okay", 1], "Foo::Bar::Bay")

=cut

$test->for('example', 3, 'build', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Foo::Bar::Bay');
  ok $#$result == 1;
  ok $result->[0] eq 'okay';
  ok $result->[1] == 1;

  $result
});

=method call

The call method attempts to call the given subroutine on the package namespace
and if successful returns the resulting value.

=signature call

  call(Any @args) (Any)

=metadata call

{
  since => '0.01',
}

=example-1 call

  package Foo;

  sub import;

  sub start {
    'started'
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $result = $space->call('start');

  # "started"

=cut

$test->for('example', 1, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'started';

  $result
});

=example-2 call

  package Zoo;

  sub import;

  sub AUTOLOAD {
    bless {};
  }

  sub DESTROY {
    ; # noop
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('zoo');

  my $result = $space->call('start');

  # bless({}, "Zoo")

=cut

$test->for('example', 2, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Zoo');

  $result
});

=method chain

The chain method chains one or more method calls and returns the result.

=signature chain

  chain(Str | Tuple[Str, Any] @steps) (Any)

=metadata chain

{
  since => '0.01',
}

=example-1 chain

  package Chu::Chu0;

  sub import;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Chu::Chu0');

  my $result = $space->chain('blessed');

  # bless({}, "Chu::Chu0")

=cut

$test->for('example', 1, 'chain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Chu::Chu0');

  $result
});

=example-2 chain

  package Chu::Chu1;

  sub new {
    bless pop;
  }

  sub frame {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Chu::Chu1');

  my $result = $space->chain(['blessed', {1..4}], 'frame');

  # [bless({ 1 => 2, 3 => 4 }, "Chu::Chu1")]

=cut

$test->for('example', 2, 'chain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 1;
  ok $result->[0]->isa('Chu::Chu1');
  ok exists $result->[0]{1};
  ok $result->[0]{1} == 2;
  ok exists $result->[0]{3};
  ok $result->[0]{3} == 4;

  $result
});

=example-3 chain

  package Chu::Chu2;

  sub new {
    bless pop;
  }

  sub frame {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Chu::Chu2');

  my $chain = $space->chain('blessed', ['frame', {1..4}]);

  # [bless({}, "Chu::Chu2"), { 1 => 2, 3 => 4 }]

=cut

$test->for('example', 3, 'chain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;
  ok $result->[0]->isa('Chu::Chu2');
  ok exists $result->[1]{1};
  ok $result->[1]{1} == 2;
  ok exists $result->[1]{3};
  ok $result->[1]{3} == 4;

  $result
});

=method child

The child method returns a new L<Venus::Space> object for the child
package namespace.

=signature child

  child(Str @path) (Space)

=metadata child

{
  since => '0.01',
}

=example-1 child

  # given: synopsis;

  my $child = $space->child('baz');

  # bless({ value => "Foo/Bar/Baz" }, "Venus::Space")

=cut

$test->for('example', 1, 'child', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok $result =~ 'Foo::Bar::Baz';

  $result
});

=method children

The children method searches C<%INC> and C<@INC> and retuns a list of
L<Venus::Space> objects for each child namespace found (one level deep).

=signature children

  children() (ArrayRef[Object])

=metadata children

{
  since => '0.01',
}

=example-1 children

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  my $children = $space->children;

  # [
  #   bless({ value => "CPAN/Author" }, "Venus::Space"),
  #   bless({ value => "CPAN/Bundle" }, "Venus::Space"),
  #   bless({ value => "CPAN/CacheMgr" }, "Venus::Space"),
  #   ...
  # ]

=cut

$test->for('example', 1, 'children', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result > 0;
  ok $_->isa('Venus::Space') for @$result;

  $result
});

=method cop

The cop method attempts to curry the given subroutine on the package namespace
and if successful returns a closure.

=signature cop

  cop(Str $method, Any @args) (CodeRef)

=metadata cop

{
  since => '0.01',
}

=example-1 cop

  package Foo::Bar;

  sub import;

  sub handler {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/bar');

  my $code = $space->cop('handler', $space->blessed);

  # sub { Foo::Bar::handler(..., @_) }

=cut

$test->for('example', 1, 'cop', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref($result) eq 'CODE';
  my $returns = $result->(1..4);
  ok ref($returns) eq 'ARRAY';
  ok ref($returns->[0]) eq 'Foo::Bar';
  ok $returns->[1] == 1;
  ok $returns->[2] == 2;
  ok $returns->[3] == 3;
  ok $returns->[4] == 4;

  $result
});

=method data

The data method attempts to read and return any content stored in the C<DATA>
section of the package namespace.

=signature data

  data() (Str)

=metadata data

{
  since => '0.01',
}

=example-1 data

  # given: synopsis;

  my $data = $space->data;

  # ""

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method destroy

The destroy method attempts to wipe out a namespace and also remove it and its
children from C<%INC>. B<NOTE:> This can cause catastrophic failures if used
incorrectly.

=signature destroy

  destroy() (Object)

=metadata destroy

{
  since => '0.01',
}

=example-1 destroy

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('data/dumper');

  $space->load; # Data/Dumper

  my $destroy = $space->destroy;

  # bless({ value => "data/dumper" }, "Venus::Space")

=cut

$test->for('example', 1, 'destroy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok $result =~ m{Data::Dumper};

  $result
});

=method eval

The eval method takes a list of strings and evaluates them under the namespace
represented by the instance.

=signature eval

  eval(Str @data) (Any)

=metadata eval

{
  since => '0.01',
}

=example-1 eval

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $eval = $space->eval('our $VERSION = 0.01');

  # 0.01

=cut

$test->for('example', 1, 'eval', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 0.01;
  is "Foo"->VERSION, 0.01;

  $result
});

=method explain

The explain method returns the package name and is used in stringification
operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $space->explain;

  # "Foo::Bar"

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo::Bar';

  $result
});

=method hash

The hash method returns the value for the given package hash variable name.

=signature hash

  hash(Str $name) (HashRef)

=metadata hash

{
  since => '0.01',
}

=example-1 hash

  # given: synopsis;

  package Foo::Bar;

  our %settings = (
    active => 1
  );

  package main;

  my $hash = $space->hash('settings');

  # { active => 1 }

=cut

$test->for('example', 1, 'hash', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { active => 1 };

  $result
});

=method hashes

The hashes method searches the package namespace for hashes and returns their
names.

=signature hashes

  hashes() (ArrayRef)

=metadata hashes

{
  since => '0.01',
}

=example-1 hashes

  # given: synopsis;

  package Foo::Bar;

  our %defaults = (
    active => 0
  );

  our %settings = (
    active => 1
  );

  package main;

  my $hashes = $space->hashes;

  # ["defaults", "settings"]

=cut

$test->for('example', 1, 'hashes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["defaults", "settings"];

  $result
});

=method id

The id method returns the fully-qualified package name as a label.

=signature id

  id() (Str)

=metadata id

{
  since => '0.01',
}

=example-1 id

  # given: synopsis;

  my $id = $space->id;

  # "Foo_Bar"

=cut

$test->for('example', 1, 'id', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo_Bar';

  $result
});

=method init

The init method ensures that the package namespace is loaded and, whether
created in-memory or on-disk, is flagged as being loaded and loadable.

=signature init

  init() (Str)

=metadata init

{
  since => '0.01',
}

=example-1 init

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('kit');

  my $init = $space->init;

  # "Kit"

=cut

$test->for('example', 1, 'init', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Kit';

  $result
});

=method inherits

The inherits method returns the list of superclasses the target package is
derived from.

=signature inherits

  inherits() (ArrayRef)

=metadata inherits

{
  since => '0.01',
}

=example-1 inherits

  package Bar;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('bar');

  my $inherits = $space->inherits;

  # []

=cut

$test->for('example', 1, 'inherits', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 inherits

  package Foo;

  sub import;

  package Bar;

  use base 'Foo';

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('bar');

  my $inherits = $space->inherits;

  # ["Foo"]

=cut

$test->for('example', 2, 'inherits', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['Foo'];

  $result
});

=method included

The included method returns the path of the namespace if it exists in C<%INC>.

=signature included

  included() (Str | Undef)

=metadata included

{
  since => '0.01',
}

=example-1 included

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Venus/Space');

  my $included = $space->included;

  # "/path/to/lib/Venus/Space.pm"

=cut

$test->for('example', 1, 'included', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{lib/Venus/Space.pm$};

  $result
});

=method inject

The inject method monkey-patches the package namespace, installing a named
subroutine into the package which can then be called normally, returning the
fully-qualified subroutine name.

=signature inject

  inject(Str $name, Maybe[CodeRef] $coderef) (Any)

=metadata inject

{
  since => '0.01',
}

=example-1 inject

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('kit');

  my $inject = $space->inject('build', sub { 'finished' });

  # *Kit::build

=cut

$test->for('example', 1, 'inject', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '*Kit::build';

  my $package = 'Kit';
  is $package->build, 'finished';

  $result
});

=method load

The load method checks whether the package namespace is already loaded and if
not attempts to load the package. If the package is not loaded and is not
loadable, this method will throw an exception using confess. If the package is
loadable, this method returns truthy with the package name. As a workaround for
packages that only exist in-memory, if the package contains a C<new>, C<with>,
C<meta>, or C<import> routine it will be recognized as having been loaded.

=signature load

  load() (Str)

=metadata load

{
  since => '0.01',
}

=example-1 load

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  my $load = $space->load;

  # "CPAN"

=cut

$test->for('example', 1, 'load', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'CPAN';

  $result
});

=method loaded

The loaded method checks whether the package namespace is already loaded
returns truthy or falsy.

=signature loaded

  loaded() (Int)

=metadata loaded

{
  since => '0.01',
}

=example-1 loaded

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('data/dumper');

  $space->destroy;

  my $loaded = $space->loaded;

  # 0

=cut

$test->for('example', 1, 'loaded', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 loaded

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('data/dumper');

  $space->load;

  my $loaded = $space->loaded;

  # 1

=cut

$test->for('example', 2, 'loaded', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method locate

The locate method checks whether the package namespace is available in
C<@INC>, i.e. on disk. This method returns the file if found or an empty
string.

=signature locate

  locate() (Str)

=metadata locate

{
  since => '0.01',
}

=example-1 locate

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('xyz');

  my $locate = $space->locate;

  # ""

=cut

$test->for('example', 1, 'locate', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 locate

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('data/dumper');

  $space->load;

  my $locate = $space->locate;

  # "/path/to/lib/Data/Dumper.pm"

=cut

$test->for('example', 2, 'locate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{Data/Dumper.pm$};

  $result
});

=method name

The name method returns the fully-qualified package name.

=signature name

  name() (Str)

=metadata name

{
  since => '0.01',
}

=example-1 name

  # given: synopsis;

  my $name = $space->name;

  # "Foo::Bar"

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo::Bar';

  $result
});

=method parent

The parent method returns a new L<Venus::Space> object for the parent package
namespace.

=signature parent

  parent() (Space)

=metadata parent

{
  since => '0.01',
}

=example-1 parent

  # given: synopsis;

  my $parent = $space->parent;

  # bless({ value => "Foo" }, "Venus::Space")

=cut

$test->for('example', 1, 'parent', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok $result eq 'Foo';

  $result
});

=method parse

The parse method parses the string argument and returns an arrayref of package
namespace segments (parts).

=signature parse

  parse() (ArrayRef)

=metadata parse

{
  since => '0.01',
}

=example-1 parse

  # given: synopsis;

  my $parse = $space->parse;

  # ["Foo", "Bar"]

=cut

$test->for('example', 1, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["Foo", "Bar"];

  $result
});

=example-2 parse

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo/Bar');

  my $parse = $space->parse;

  # ["Foo", "Bar"]

=cut

$test->for('example', 2, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["Foo", "Bar"];

  $result
});

=example-3 parse

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo\Bar');

  my $parse = $space->parse;

  # ["Foo", "Bar"]

=cut

$test->for('example', 3, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["Foo", "Bar"];

  $result
});

=example-4 parse

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo-Bar');

  my $parse = $space->parse;

  # ["FooBar"]

=cut

$test->for('example', 4, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["FooBar"];

  $result
});

=example-5 parse

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo_Bar');

  my $parse = $space->parse;

  # ["FooBar"]

=cut

$test->for('example', 5, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["FooBar"];

  $result
});

=method parts

The parts method returns an arrayref of package namespace segments (parts).

=signature parts

  parts() (ArrayRef)

=metadata parts

{
  since => '0.01',
}

=example-1 parts

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo');

  my $parts = $space->parts;

  # ["Foo"]

=cut

$test->for('example', 1, 'parts', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["Foo"];

  $result
});

=example-2 parts

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo/Bar');

  my $parts = $space->parts;

  # ["Foo", "Bar"]

=cut

$test->for('example', 2, 'parts', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["Foo", "Bar"];

  $result
});

=example-3 parts

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('Foo_Bar');

  my $parts = $space->parts;

  # ["FooBar"]

=cut

$test->for('example', 3, 'parts', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["FooBar"];

  $result
});

=method prepend

The prepend method modifies the object by prepending to the package namespace
parts.

=signature prepend

  prepend(Str @path) (Space)

=metadata prepend

{
  since => '0.01',
}

=example-1 prepend

  # given: synopsis;

  my $prepend = $space->prepend('etc');

  # bless({ value => "Etc/Foo/Bar" }, "Venus::Space")

=cut

$test->for('example', 1, 'prepend', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok "$result" eq 'Etc::Foo::Bar';

  $result
});

=example-2 prepend

  # given: synopsis;

  my $prepend = $space->prepend('etc', 'tmp');

  # bless({ value => "Etc/Tmp/Foo/Bar" }, "Venus::Space")

=cut

$test->for('example', 2, 'prepend', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok "$result" eq 'Etc::Tmp::Foo::Bar';

  $result
});

=method rebase

The rebase method returns an object by prepending the package namespace
specified to the base of the current object's namespace.

=signature rebase

  rebase(Str @path) (Space)

=metadata rebase

{
  since => '0.01',
}

=example-1 rebase

  # given: synopsis;

  my $rebase = $space->rebase('zoo');

  # bless({ value => "Zoo/Bar" }, "Venus::Space")

=cut

$test->for('example', 1, 'rebase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok "$result" eq 'Zoo::Bar';

  $result
});

=method reload

The reload method attempts to delete and reload the package namespace using the
L</load> method. B<Note:> Reloading is additive and will overwrite existing
symbols but does not remove symbols.

=signature reload

  reload() (Str)

=metadata reload

{
  since => '0.01',
}

=example-1 reload

  package main;

  use Venus::Space;

  # Foo::Gen is generate with $VERSION as 0.01

  my $space = Venus::Space->new('Foo/Gen');

  my $reload = $space->reload;

  # Foo::Gen
  # Foo::Gen->VERSION is 0.01

=cut

$test->for('example', 1, 'reload', sub {
  require File::Spec::Functions;
  mkdir File::Spec::Functions::catdir($path, 'Foo');
  my $file = File::Spec::Functions::catfile($path, 'Foo', 'Gen.pm');
  open my $fh, '>', $file or die "File error: $!";
  my @subs = map "sub $_ {1}", 'a'..'d';
  print $fh join ";\n\n", 'package Foo::Gen', 'our $VERSION = 0.01', @subs, 1;
  close $fh;
  push @INC, $path;

  my ($tryable) = @_;
  ok(my $result = $tryable->result);
  is($result, 'Foo::Gen');
  is($Foo::Gen::VERSION, 0.01);
  is(Foo::Gen->VERSION, 0.01);
  ok(Foo::Gen->can($_)) for 'a'..'d';

  $result
});

=example-2 reload

  package main;

  use Venus::Space;

  # Foo::Gen is generate with $VERSION as 0.02

  my $space = Venus::Space->new('Foo/Gen');

  my $reload = $space->reload;

  # Foo::Gen
  # Foo::Gen->VERSION is 0.02

=cut

$test->for('example', 2, 'reload', sub {
  require File::Spec::Functions;
  mkdir File::Spec::Functions::catdir($path, 'Foo');
  my $file = File::Spec::Functions::catfile($path, 'Foo', 'Gen.pm');
  open my $fh, '>', $file or die "File error: $!";
  my @subs = map "sub $_ {1}", 'a'..'d';
  print $fh join ";\n\n", 'package Foo::Gen', 'our $VERSION = 0.02', @subs, 1;
  close $fh;
  push @INC, $path;

  my ($tryable) = @_;
  ok(my $result = $tryable->result);
  is($result, 'Foo::Gen');
  is($Foo::Gen::VERSION, 0.02);
  is(Foo::Gen->VERSION, 0.02);
  ok(Foo::Gen->can($_)) for 'a'..'d';

  $result
});

=method require

The require method executes a C<require> statement within the package namespace
specified.

=signature require

  require(Str $target) (Any)

=metadata require

{
  since => '0.01',
}

=example-1 require

  # given: synopsis;

  my $require = $space->require('Moo');

  # 1

=cut

$test->for('example', 1, 'require', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method root

The root method returns the root package namespace segments (parts). Sometimes
separating the C<root> from the C<parts> helps identify how subsequent child
objects were derived.

=signature root

  root() (Str)

=metadata root

{
  since => '0.01',
}

=example-1 root

  # given: synopsis;

  my $root = $space->root;

  # "Foo"

=cut

$test->for('example', 1, 'root', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo';

  $result
});

=method routine

The routine method returns the subroutine reference for the given subroutine
name.

=signature routine

  routine(Str $name) (CodeRef)

=metadata routine

{
  since => '0.01',
}

=example-1 routine

  package Foo;

  sub cont {
    [@_]
  }

  sub abort {
    [@_]
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo');

  my $routine = $space->routine('cont');

  # sub { ... }

=cut

$test->for('example', 1, 'routine', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result->('begin'), ['begin'];

  $result
});

=method routines

The routines method searches the package namespace for routines and returns
their names.

=signature routines

  routines() (ArrayRef)

=metadata routines

{
  since => '0.01',
}

=example-1 routines

  package Foo::Subs;

  sub start {
    1
  }

  sub abort {
    1
  }

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/subs');

  my $routines = $space->routines;

  # ["abort", "start"]

=cut

$test->for('example', 1, 'routines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["abort", "start"];

  $result
});

=method scalar

The scalar method returns the value for the given package scalar variable name.

=signature scalar

  scalar(Str $name) (Any)

=metadata scalar

{
  since => '0.01',
}

=example-1 scalar

  # given: synopsis;

  package Foo::Bar;

  our $root = '/path/to/file';

  package main;

  my $scalar = $space->scalar('root');

  # "/path/to/file"

=cut

$test->for('example', 1, 'scalar', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "/path/to/file";

  $result
});

=method scalars

The scalars method searches the package namespace for scalars and returns their
names.

=signature scalars

  scalars() (ArrayRef)

=metadata scalars

{
  since => '0.01',
}

=example-1 scalars

  # given: synopsis;

  package Foo::Bar;

  our $root = 'root';
  our $base = 'path/to';
  our $file = 'file';

  package main;

  my $scalars = $space->scalars;

  # ["base", "file", "root"]

=cut

$test->for('example', 1, 'scalars', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["base", "file", "root"];

  $result
});

=method sibling

The sibling method returns a new L<Venus::Space> object for the sibling package
namespace.

=signature sibling

  sibling(Str $path) (Space)

=metadata sibling

{
  since => '0.01',
}

=example-1 sibling

  # given: synopsis;

  my $sibling = $space->sibling('baz');

  # bless({ value => "Foo/Baz" }, "Venus::Space")

=cut

$test->for('example', 1, 'sibling', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok "$result" eq "Foo::Baz";

  $result
});

=method siblings

The siblings method searches C<%INC> and C<@INC> and retuns a list of
L<Venus::Space> objects for each sibling namespace found (one level deep).

=signature siblings

  siblings() (ArrayRef[Object])

=metadata siblings

{
  since => '0.01',
}

=example-1 siblings

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('encode/m_i_m_e');

  my $siblings = $space->siblings;

  # [
  #   bless({ value => "Encode/MIME/Header" }, "Venus::Space"),
  #   bless({ value => "Encode/MIME/Name" }, "Venus::Space"),
  #   ...
  # ]

=cut

$test->for('example', 1, 'siblings', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result > 0;

  ok $result->[0]->isa('Venus::Space');
  ok $result->[1]->isa('Venus::Space');

  $result
});

=method tryload

The tryload method attempt to C<load> the represented package using the
L</load> method and returns truthy/falsy based on whether the package was
loaded.

=signature tryload

  tryload() (Bool)

=metadata tryload

{
  since => '0.01',
}

=example-1 tryload

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  my $tryload = $space->tryload;

  # 1

=cut

$test->for('example', 1, 'tryload', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 tryload

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('n_a_p_c');

  my $tryload = $space->tryload;

  # 0

=cut

$test->for('example', 2, 'tryload', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method use

The use method executes a C<use> statement within the package namespace
specified.

=signature use

  use(Str | Tuple[Str, Str] $target, Any @params) (Space)

=metadata use

{
  since => '0.01',
}

=example-1 use

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/goo');

  my $use = $space->use('Moo');

  # bless({ value => "foo/goo" }, "Venus::Space")

=cut

$test->for('example', 1, 'use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok "$result" eq 'Foo::Goo';
  ok 'Foo::Goo'->isa('Moo::Object');
  is $result->package, 'Foo::Goo';
  ok $result->package->can('after');
  ok $result->package->can('before');
  ok $result->package->can('extends');
  ok $result->package->can('has');
  ok $result->package->can('with');

  $result
});

=example-2 use

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/hoo');

  my $use = $space->use('Moo', 'has');

  # bless({ value => "foo/hoo" }, "Venus::Space")

=cut

$test->for('example', 2, 'use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Space');
  ok "$result" eq 'Foo::Hoo';
  ok 'Foo::Hoo'->isa('Moo::Object');
  is $result->package, 'Foo::Hoo';
  ok $result->package->can('after');
  ok $result->package->can('before');
  ok $result->package->can('extends');
  ok $result->package->can('has');
  ok $result->package->can('with');

  $result
});

=example-3 use

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/foo');

  my $use = $space->use(['Moo', 9.99], 'has');

=cut

$test->for('example', 3, 'use', sub {
  my $failed = 0;
  my ($tryable) = @_;
  $tryable->default(sub {
    my ($error) = @_;
    $failed++;
    Venus::Space->new('foo/foo');
  });
  ok my $result = $tryable->result;
  is $result->package, 'Foo::Foo';
  ok $failed;
  ok !$result->package->can('after');
  ok !$result->package->can('before');
  ok !$result->package->can('extends');
  ok !$result->package->can('has');
  ok !$result->package->can('with');

  $result
});

=method used

The used method searches C<%INC> for the package namespace and if found returns
the filepath and complete filepath for the loaded package, otherwise returns
falsy with an empty string.

=signature used

  used() (Str)

=metadata used

{
  since => '0.01',
}

=example-1 used

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/oof');

  my $used = $space->used;

  # ""

=cut

$test->for('example', 1, 'used', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 used

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('c_p_a_n');

  $space->load;

  my $used = $space->used;

  # "CPAN"

=cut

$test->for('example', 2, 'used', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'CPAN';

  $result
});

=example-3 used

  package Foo::Bar;

  sub import;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/bar');

  $space->load;

  my $used = $space->used;

  # "Foo/Bar"

=cut

$test->for('example', 3, 'used', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo/Bar';

  $result
});

=method variables

The variables method searches the package namespace for variables and returns
their names.

=signature variables

  variables() (ArrayRef[Tuple[Str, ArrayRef]])

=metadata variables

{
  since => '0.01',
}

=example-1 variables

  package Etc;

  our $init = 0;
  our $func = 1;

  our @does = (1..4);
  our %sets = (1..4);

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('etc');

  my $variables = $space->variables;

  # [
  #   ["arrays", ["does"]],
  #   ["hashes", ["sets"]],
  #   ["scalars", ["func", "init"]],
  # ]

=cut

$test->for('example', 1, 'variables', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  my $arrays = ['arrays', ['does']];
  my $hashes = ['hashes', ['sets']];
  my $scalars = ['scalars', ['func', 'init']];
  is_deeply $result, [$arrays, $hashes, $scalars];

  $result
});

=method version

The version method returns the C<VERSION> declared on the target package, if
any.

=signature version

  version() (Maybe[Str])

=metadata version

{
  since => '0.01',
}

=example-1 version

  package Foo::Boo;

  sub import;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $version = $space->version;

  # undef

=cut

$test->for('example', 1, 'version', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 version

  package Foo::Boo;

  our $VERSION = 0.01;

  package main;

  use Venus::Space;

  my $space = Venus::Space->new('foo/boo');

  my $version = $space->version;

  # 0.01

=cut

$test->for('example', 2, 'version', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '0.01';

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

$test->render('lib/Venus/Space.pod') if $ENV{RENDER};

ok 1 and done_testing;