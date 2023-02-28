package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Role::Serializable

=cut

$test->for('name');

=tagline

Serializable Role

=cut

$test->for('tagline');

=abstract

Serializable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: serialize

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Serializable';

  attr 'test';

  package main;

  my $example = Example->new(test => 123);

  # $example->serialize;

  # {test => 123}

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Serializable');
  ok $result->can('serialize');
  is_deeply $result->serialize, {
    test => 123,
  };

  $result
});

=description

This package provides a mechanism for serializing objects or the return value
of a dispatched method call.

=cut

$test->for('description');

=method serialize

The serialize method serializes the invocant or the return value of a
dispatched method call, and returns the result.

=signature serialize

  serialize(Str | CodeRef $code, Any @args) (Any)

=metadata serialize

{
  since => '1.75',
}

=example-1 serialize

  package Example1;

  use Venus::Class 'with';

  with 'Venus::Role::Serializable';

  sub ARGS {
    (@_[1..$#_])
  }

  sub DATA {
    [@_[1..$#_]]
  }

  package main;

  my $example1 = Example1->new(1..4);

  # bless([1..4], 'Example1')

  # my $result = $example1->serialize;

  # [1..4]

=cut

$test->for('example', 1, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example1');
  ok $result->does('Venus::Role::Serializable');
  is_deeply $result->serialize, [1..4];

  $result
});

=example-2 serialize

  package Example2;

  use Venus::Class 'with';

  with 'Venus::Role::Serializable';

  sub ARGS {
    (@_[1..$#_])
  }

  sub DATA {
    sub{[@_[1..$#_]]}
  }

  package main;

  my $example2 = Example2->new(1..4);

  # bless(sub{[1..4]}, 'Example2')

  # my $result = $example2->serialize;

  # sub{...}

=cut

$test->for('example', 2, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example2');
  ok $result->does('Venus::Role::Serializable');
  my $returned = $result->serialize;
  ok ref $returned eq 'CODE';
  is_deeply $returned->(0..4), [1..4];

  $result
});

=example-3 serialize

  package Example3;

  use Venus::Class 'with';

  with 'Venus::Role::Serializable';

  sub ARGS {
    (@_[1..$#_])
  }

  sub DATA {
    qr{@{[join '', @_[1..$#_]]}};
  }

  package main;

  my $example3 = Example3->new(1..4);

  # bless(qr/1234/, 'Example3')

  # my $result = $example3->serialize;

  # qr/1234/u

=cut

$test->for('example', 3, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example3');
  ok $result->does('Venus::Role::Serializable');
  is $result->serialize, qr/1234/;

  $result
});

=example-4 serialize

  package Example4;

  use Venus::Class 'with';

  with 'Venus::Role::Serializable';

  sub ARGS {
    (@_[1..$#_])
  }

  sub DATA {
    \join '', @_[1..$#_]
  }

  package main;

  my $example4 = Example4->new(1..4);

  # bless(\'1234', 'Example4')

  # my $result = $example4->serialize;

  # "1234"

=cut

$test->for('example', 4, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example4');
  ok $result->does('Venus::Role::Serializable');
  is $result->serialize, "1234";

  $result
});

=example-5 serialize

  package Example5;

  use Venus::Class 'with';

  with 'Venus::Role::Serializable';

  sub ARGS {
    (@_[1..$#_])
  }

  sub DATA {
    \(my $ref = \join '', @_[1..$#_])
  }

  package main;

  my $example5 = Example5->new(1..4);

  # bless(do{\(my $ref = \'1234')}, 'Example5')

  # my $result = $example5->serialize;

  # "1234"

=cut

$test->for('example', 5, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example5');
  ok $result->does('Venus::Role::Serializable');
  is $result->serialize, "1234";

  $result
});

=example-6 serialize

  package Example6;

  use Venus::Class 'base';

  base 'Venus::Array';

  package main;

  my $example6 = Example6->new([1..4]);

  # bless(..., 'Example6')

  # my $result = $example6->serialize;

  # [1..4]

=cut

$test->for('example', 6, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example6');
  ok $result->does('Venus::Role::Serializable');
  is_deeply $result->serialize, [1..4];

  $result
});

=example-7 serialize

  package Example7;

  use Venus::Class 'base';

  base 'Venus::Path';

  package main;

  my $example7 = Example7->new('/path/to/somewhere');

  # bless(..., 'Example7')

  # my $result = $example7->serialize;

  # "/path/to/somewhere"

=cut

$test->for('example', 7, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example7');
  ok $result->does('Venus::Role::Serializable');
  is $result->serialize, "/path/to/somewhere";

  $result
});

=example-8 serialize

  package Example8;

  use Venus::Class 'with';

  with 'Venus::Role::Serializable';
  with 'Venus::Role::Valuable';

  package main;

  my $example8 = Example8->new(value => 123);

  # bless(..., 'Example8')

  # my $result = $example8->serialize;

  # 123

=cut

$test->for('example', 8, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example8');
  ok $result->does('Venus::Role::Serializable');
  is $result->serialize, 123;

  $result
});

=example-9 serialize

  package Example9;

  use Venus::Class 'base', 'with';

  base 'IO::Handle';

  with 'Venus::Role::Serializable';

  package main;

  my $example9 = Example9->new;

  # bless(..., 'Example9')

  # my $result = $example9->serialize;

  # Exception! (isa Venus::Error) is "on.serialize"

=cut

$test->for('example', 9, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example9');
  ok $result->does('Venus::Role::Serializable');
  my $error = catch { $result->serialize };
  ok $error->isa('Example9::Error');
  ok $error->isa('Venus::Error');
  ok $error->is('on.serialize');

  $result
});

=example-10 serialize

  package Example10;

  use Venus::Class 'attr', 'with';

  with 'Venus::Role::Serializable';

  attr 'test';

  package main;

  use IO::Handle;

  my $example10 = Example10->new(test => IO::Handle->new);

  # bless(..., 'Example10')

  # my $result = $example10->serialize;

  # Exception! (isa Venus::Error) is "on.serialize.deconstruct"

=cut

$test->for('example', 10, 'serialize', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example10');
  ok $result->does('Venus::Role::Serializable');
  my $error = catch { $result->serialize };
  ok $error->isa('Example10::Error');
  ok $error->isa('Venus::Error');
  ok $error->is('on.serialize.deconstruct');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Serializable.pod') if $ENV{RENDER};

ok 1 and done_testing;
