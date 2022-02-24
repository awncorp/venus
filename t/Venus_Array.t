package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Array

=cut

$test->for('name');

=tagline

Array Class

=cut

$test->for('tagline');

=abstract

Array Class for Perl 5

=cut

$test->for('abstract');

=includes

method: all
method: any
method: count
method: default
method: delete
method: each
method: empty
method: exists
method: find
method: first
method: grep
method: iterator
method: join
method: keyed
method: keys
method: last
method: list
method: map
method: none
method: numified
method: one
method: pairs
method: path
method: part
method: pop
method: push
method: random
method: reverse
method: rotate
method: rsort
method: shift
method: size
method: slice
method: sort
method: unique
method: unshift

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([1..9]);

  # $array->random;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Array');

  $result
});

=description

This package provides methods for manipulating array data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=integrates

Venus::Role::Mappable

=cut

$test->for('integrates');

=method all

The all method returns true if the callback returns true for all of the
elements.

=signature all

  all(CodeRef $code) (Bool)

=metadata all

{
  since => '0.01',
}

=example-1 all

  # given: synopsis;

  my $all = $array->all(sub {
    $_ > 0;
  });

  # 1

=cut

$test->for('example', 1, 'all', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 all

  # given: synopsis;

  my $all = $array->all(sub {
    my ($key, $value) = @_;

    $value > 0;
  });

  # 1

=cut

$test->for('example', 2, 'all', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method any

The any method returns true if the callback returns true for any of the
elements.

=signature any

  any(CodeRef $code) (Bool)

=metadata any

{
  since => '0.01',
}

=example-1 any

  # given: synopsis;

  my $any = $array->any(sub {
    $_ > 4;
  });

=cut

$test->for('example', 1, 'any', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 any

  # given: synopsis;

  my $any = $array->any(sub {
    my ($key, $value) = @_;

    $value > 4;
  });

=cut

$test->for('example', 2, 'any', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method count

The count method returns the number of elements within the array.

=signature count

  count() (Int)

=metadata count

{
  since => '0.01',
}

=example-1 count

  # given: synopsis;

  my $count = $array->count;

  # 9

=cut

$test->for('example', 1, 'count', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 9;

  $result
});

=method default

The default method returns the default value, i.e. C<[]>.

=signature default

  default() (ArrayRef)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $array->default;

  # []

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=method delete

The delete method returns the value of the element at the index specified after
removing it from the array.

=signature delete

  delete(Int $index) (Any)

=metadata delete

{
  since => '0.01',
}

=example-1 delete

  # given: synopsis;

  my $delete = $array->delete(2);

  # 3

=cut

$test->for('example', 1, 'delete', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 3;

  $result
});

=method each

The each method executes a callback for each element in the array passing the
index and value as arguments. This method can return a list of values in
list-context.

=signature each

  each(CodeRef $code) (ArrayRef)

=metadata each

{
  since => '0.01',
}

=example-1 each

  # given: synopsis;

  my $each = $array->each(sub {
    [$_]
  });

  # [[1], [2], [3], [4], [5], [6], [7], [8], [9]]

=cut

$test->for('example', 1, 'each', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [[1], [2], [3], [4], [5], [6], [7], [8], [9]];

  $result
});

=example-2 each

  # given: synopsis;

  my $each = $array->each(sub {
    my ($key, $value) = @_;

    [$key, $value]
  });

  # [
  #   [0, 1],
  #   [1, 2],
  #   [2, 3],
  #   [3, 4],
  #   [4, 5],
  #   [5, 6],
  #   [6, 7],
  #   [7, 8],
  #   [8, 9],
  # ]

=cut

$test->for('example', 2, 'each', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
    [4, 5],
    [5, 6],
    [6, 7],
    [7, 8],
    [8, 9],
  ];

  $result
});

=method empty

The empty method drops all elements from the array.

=signature empty

  empty() (Array)

=metadata empty

{
  since => '0.01',
}

=example-1 empty

  # given: synopsis;

  my $empty = $array->empty;

  # bless({ value => [] }, "Venus::Array")

=cut

$test->for('example', 1, 'empty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Array');
  is_deeply $result->value, [];

  $result
});

=method exists

The exists method returns true if the element at the index specified exists,
otherwise it returns false.

=signature exists

  exists(Int $index) (Bool)

=metadata exists

{
  since => '0.01',
}

=example-1 exists

  # given: synopsis;

  my $exists = $array->exists(0);

  # 1

=cut

$test->for('example', 1, 'exists', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method find

The find method traverses the data structure using the keys and indices
provided, returning the value found or undef. In list-context, this method
returns a tuple, i.e. the value found and boolean representing whether the
match was successful.

=signature find

  find(Str @keys) (Any)

=metadata find

{
  since => '0.01',
}

=example-1 find

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my $find = $array->find(0, 'foo');

  # { bar => "baz" }

=cut

$test->for('example', 1, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { bar => "baz" };

  $result
});

=example-2 find

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my $find = $array->find(0, 'foo', 'bar');

  # "baz"

=cut

$test->for('example', 2, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'baz';

  $result
});

=example-3 find

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my $find = $array->find(2, 0);

  # "baz"

=cut

$test->for('example', 3, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'baz';

  $result
});

=method first

The first method returns the value of the first element.

=signature first

  first() (Any)

=metadata first

{
  since => '0.01',
}

=example-1 first

  # given: synopsis;

  my $first = $array->first;

  # 1

=cut

$test->for('example', 1, 'first', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method grep

The grep method executes a callback for each element in the array passing the
value as an argument, returning a new array reference containing the elements
for which the returned true. This method can return a list of values in
list-context.

=signature grep

  grep(CodeRef $code) (ArrayRef)

=metadata grep

{
  since => '0.01',
}

=example-1 grep

  # given: synopsis;

  my $grep = $array->grep(sub {
    $_ > 3
  });

  # [4..9]

=cut

$test->for('example', 1, 'grep', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [4..9];

  $result
});

=example-2 grep

  # given: synopsis;

  my $grep = $array->grep(sub {
    my ($key, $value) = @_;

    $value > 3
  });

  # [4..9]

=cut

$test->for('example', 2, 'grep', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [4..9];

  $result
});

=method iterator

The iterator method returns a code reference which can be used to iterate over
the array. Each time the iterator is executed it will return the next element
in the array until all elements have been seen, at which point the iterator
will return an undefined value. This method can return a tuple with the key and
value in list-context.

=signature iterator

  iterator() (CodeRef)

=metadata iterator

{
  since => '0.01',
}

=example-1 iterator

  # given: synopsis;

  my $iterator = $array->iterator;

  # sub { ... }

  # while (my $value = $iterator->()) {
  #   say $value; # 1
  # }

=cut

$test->for('example', 1, 'iterator', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  while (my $value = $result->()) {
    ok $value =~ m{\d};
  }

  $result
});

=example-2 iterator

  # given: synopsis;

  my $iterator = $array->iterator;

  # sub { ... }

  # while (grep defined, my ($key, $value) = $iterator->()) {
  #   say $value; # 1
  # }

=cut

$test->for('example', 2, 'iterator', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  while (grep defined, my ($key, $value) = $result->()) {
    ok $key =~ m{\d};
    ok $value =~ m{\d};
  }

  $result
});

=method join

The join method returns a string consisting of all the elements in the array
joined by the join-string specified by the argument. Note: If the argument is
omitted, an empty string will be used as the join-string.

=signature join

  join(Str $seperator) (Str)

=metadata join

{
  since => '0.01',
}

=example-1 join

  # given: synopsis;

  my $join = $array->join;

  # 123456789

=cut

$test->for('example', 1, 'join', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456789;

  $result
});

=example-2 join

  # given: synopsis;

  my $join = $array->join(', ');

  # "1, 2, 3, 4, 5, 6, 7, 8, 9"

=cut

$test->for('example', 2, 'join', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "1, 2, 3, 4, 5, 6, 7, 8, 9";

  $result
});

=method keyed

The keyed method returns a hash reference where the arguments become the keys,
and the elements of the array become the values.

=signature keyed

  keyed(Str @keys) (HashRef)

=metadata keyed

{
  since => '0.01',
}

=example-1 keyed

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([1..4]);

  my $keyed = $array->keyed('a'..'d');

  # { a => 1, b => 2, c => 3, d => 4 }

=cut

$test->for('example', 1, 'keyed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { a => 1, b => 2, c => 3, d => 4 };

  $result
});

=method keys

The keys method returns an array reference consisting of the indicies of the
array.

=signature keys

  keys() (ArrayRef)

=metadata keys

{
  since => '0.01',
}

=example-1 keys

  # given: synopsis;

  my $keys = $array->keys;

  # [0..8]

=cut

$test->for('example', 1, 'keys', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [0..8];

  $result
});

=method last

The last method returns the value of the last element in the array.

=signature last

  last() (Any)

=metadata last

{
  since => '0.01',
}

=example-1 last

  # given: synopsis;

  my $last = $array->last;

  # 9

=cut

$test->for('example', 1, 'last', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 9;

  $result
});

=method list

The list method returns a shallow copy of the underlying array reference as an
array reference.

=signature list

  list() (Any)

=metadata list

{
  since => '0.01',
}

=example-1 list

  # given: synopsis;

  my $list = $array->list;

  # 9

=cut

$test->for('example', 1, 'list', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 9;

  $result
});

=example-2 list

  # given: synopsis;

  my @list = $array->list;

  # (1..9)

=cut

$test->for('example', 2, 'list', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  is_deeply [@result], [1..9];

  @result
});

=method map

The map method iterates over each element in the array, executing the code
reference supplied in the argument, passing the routine the value at the
current position in the loop and returning a new array reference containing the
elements for which the argument returns a value or non-empty list. This method
can return a list of values in list-context.

=signature map

  map(CodeRef $code) (ArrayRef)

=metadata map

{
  since => '0.01',
}

=example-1 map

  # given: synopsis;

  my $map = $array->map(sub {
    $_ * 2
  });

  # [2, 4, 6, 8, 10, 12, 14, 16, 18]

=cut

$test->for('example', 1, 'map', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result,[2, 4, 6, 8, 10, 12, 14, 16, 18];

  $result
});

=example-2 map

  # given: synopsis;

  my $map = $array->map(sub {
    my ($key, $value) = @_;

    [$key, ($value * 2)]
  });

  # [
  #   [0, 2],
  #   [1, 4],
  #   [2, 6],
  #   [3, 8],
  #   [4, 10],
  #   [5, 12],
  #   [6, 14],
  #   [7, 16],
  #   [8, 18],
  # ]

=cut

$test->for('example', 2, 'map', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    [0, 2],
    [1, 4],
    [2, 6],
    [3, 8],
    [4, 10],
    [5, 12],
    [6, 14],
    [7, 16],
    [8, 18],
  ];

  $result
});

=method none

The none method returns true if none of the elements in the array meet the
criteria set by the operand and rvalue.

=signature none

  none(CodeRef $code) (Bool)

=metadata none

{
  since => '0.01',
}

=example-1 none

  # given: synopsis;

  my $none = $array->none(sub {
    $_ < 1
  });

  # 1

=cut

$test->for('example', 1, 'none', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 none

  # given: synopsis;

  my $none = $array->none(sub {
    my ($key, $value) = @_;

    $value < 1
  });

  # 1

=cut

$test->for('example', 2, 'none', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method numified

The numified method returns the numerical representation of the object. For
array objects this method returns the count (i.e. the number of elements in the
array).

=signature numified

  numified() (Int)

=metadata numified

{
  since => '0.08',
}

=example-1 numified

  # given: synopsis;

  my $numified = $array->numified;

  # 9

=cut

$test->for('example', 1, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 9;

  $result
});

=example-2 numified

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([1..3]);

  my $numified = $array->numified;

  # 3

=cut

$test->for('example', 2, 'numified', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 3;

  $result
});

=method one

The one method returns true if only one of the elements in the array meet the
criteria set by the operand and rvalue.

=signature one

  one(CodeRef $code) (Bool)

=metadata one

{
  since => '0.01',
}

=example-1 one

  # given: synopsis;

  my $one = $array->one(sub {
    $_ == 1
  });

  # 1

=cut

$test->for('example', 1, 'one', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 one

  # given: synopsis;

  my $one = $array->one(sub {
    my ($key, $value) = @_;

    $value == 1
  });

  # 1

=cut

$test->for('example', 2, 'one', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method pairs

The pairs method is an alias to the pairs_array method. This method can return
a list of values in list-context.

=signature pairs

  pairs() (ArrayRef)

=metadata pairs

{
  since => '0.01',
}

=example-1 pairs

  # given: synopsis;

  my $pairs = $array->pairs;

  # [
  #   [0, 1],
  #   [1, 2],
  #   [2, 3],
  #   [3, 4],
  #   [4, 5],
  #   [5, 6],
  #   [6, 7],
  #   [7, 8],
  #   [8, 9],
  # ]

=cut

$test->for('example', 1, 'pairs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
    [4, 5],
    [5, 6],
    [6, 7],
    [7, 8],
    [8, 9],
  ];

  $result
});

=method path

The path method traverses the data structure using the path expr provided,
returning the value found or undef. In list-context, this method returns a
tuple, i.e. the value found and boolean representing whether the match was
successful.

=signature path

  path(Str $expr) (Any)

=metadata path

{
  since => '0.01',
}

=example-1 path

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my $path = $array->path('/0/foo');

  # { bar => "baz" }

=cut

$test->for('example', 1, 'path', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { bar => "baz" };

  $result
});

=example-2 path

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my $path = $array->path('/0/foo/bar');

  # "baz"

=cut

$test->for('example', 2, 'path', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'baz';

  $result
});

=example-3 path

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my $path = $array->path('/2/0');

  # "baz"

=cut

$test->for('example', 3, 'path', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'baz';

  $result
});

=example-4 path

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([{'foo' => {'bar' => 'baz'}}, 'bar', ['baz']]);

  my @path = $array->path('/3/0');

  # (undef, 0)

=cut

$test->for('example', 4, 'path', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  ok @result == 2;
  ok !defined $result[0];
  ok $result[1] == 0;

  @result
});

=method part

The part method iterates over each element in the array, executing the code
reference supplied in the argument, using the result of the code reference to
partition to array into two distinct array references. This method can return a
list of values in list-context.

=signature part

  part(CodeRef $code) (Tuple[ArrayRef, ArrayRef])

=metadata part

{
  since => '0.01',
}

=example-1 part

  # given: synopsis;

  my $part = $array->part(sub {
    $_ > 5
  });

  # [[6..9], [1..5]]

=cut

$test->for('example', 1, 'part', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [[6..9], [1..5]];

  $result
});

=example-2 part

  # given: synopsis;

  my $part = $array->part(sub {
    my ($key, $value) = @_;

    $value < 5
  });

  # [[1..4], [5..9]]

=cut

$test->for('example', 2, 'part', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [[1..4], [5..9]];

  $result
});

=method pop

The pop method returns the last element of the array shortening it by one.
Note, this method modifies the array.

=signature pop

  pop() (Any)

=metadata pop

{
  since => '0.01',
}

=example-1 pop

  # given: synopsis;

  my $pop = $array->pop;

  # 9

=cut

$test->for('example', 1, 'pop', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 9;

  $result
});

=method push

The push method appends the array by pushing the agruments onto it and returns
itself.

=signature push

  push(Any @data) (ArrayRef)

=metadata push

{
  since => '0.01',
}

=example-1 push

  # given: synopsis;

  my $push = $array->push(10);

  # [1..10]

=cut

$test->for('example', 1, 'push', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1..10];

  $result
});

=method random

The random method returns a random element from the array.

=signature random

  random() (Any)

=metadata random

{
  since => '0.01',
}

=example-1 random

  # given: synopsis;

  my $random = $array->random;

  # 2

  # my $random = $array->random;

  # 1

=cut

$test->for('example', 1, 'random', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=method reverse

The reverse method returns an array reference containing the elements in the
array in reverse order.

=signature reverse

  reverse() (ArrayRef)

=metadata reverse

{
  since => '0.01',
}

=example-1 reverse

  # given: synopsis;

  my $reverse = $array->reverse;

  # [9, 8, 7, 6, 5, 4, 3, 2, 1]

=cut

$test->for('example', 1, 'reverse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [9, 8, 7, 6, 5, 4, 3, 2, 1];

  $result
});

=method rotate

The rotate method rotates the elements in the array such that first elements
becomes the last element and the second element becomes the first element each
time this method is called.

=signature rotate

  rotate() (ArrayRef)

=metadata rotate

{
  since => '0.01',
}

=example-1 rotate

  # given: synopsis;

  my $rotate = $array->rotate;

  # [2..9, 1]

=cut

$test->for('example', 1, 'rotate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [2..9, 1];

  $result
});

=method rsort

The rsort method returns an array reference containing the values in the array
sorted alphanumerically in reverse.

=signature rsort

  rsort() (ArrayRef)

=metadata rsort

{
  since => '0.01',
}

=example-1 rsort

  # given: synopsis;

  my $rsort = $array->rsort;

  # [9, 8, 7, 6, 5, 4, 3, 2, 1]

=cut

$test->for('example', 1, 'rsort', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [9, 8, 7, 6, 5, 4, 3, 2, 1];

  $result
});

=method shift

The shift method returns the first element of the array shortening it by one.

=signature shift

  shift() (Any)

=metadata shift

{
  since => '0.01',
}

=example-1 shift

  # given: synopsis;

  my $shift = $array->shift;

  # 1

=cut

$test->for('example', 1, 'shift', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method size

The size method returns the number of elements within the array, and is an
alias for the L</count> method.

=signature size

  size() (Int)

=metadata size

{
  since => '0.08',
}

=example-1 size

  # given: synopsis;

  my $size = $array->size;

  # 9

=cut

$test->for('example', 1, 'size', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 9;

  $result
});

=method slice

The slice method returns a hash reference containing the elements in the array
at the index(es) specified in the arguments.

=signature slice

  slice(Str @keys) (ArrayRef)

=metadata slice

{
  since => '0.01',
}

=example-1 slice

  # given: synopsis;

  my $slice = $array->slice(2, 4);

  # [3, 5]

=cut

$test->for('example', 1, 'slice', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [3, 5];

  $result
});

=method sort

The sort method returns an array reference containing the values in the array
sorted alphanumerically.

=signature sort

  sort() (ArrayRef)

=metadata sort

{
  since => '0.01',
}

=example-1 sort

  package main;

  use Venus::Array;

  my $array = Venus::Array->new(['d','c','b','a']);

  my $sort = $array->sort;

  # ["a".."d"]

=cut

$test->for('example', 1, 'sort', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["a".."d"];

  $result
});

=method unique

The unique method returns an array reference consisting of the unique elements
in the array.

=signature unique

  unique() (ArrayRef)

=metadata unique

{
  since => '0.01',
}

=example-1 unique

  package main;

  use Venus::Array;

  my $array = Venus::Array->new([1,1,1,1,2,3,1]);

  my $unique = $array->unique;

  # [1, 2, 3]

=cut

$test->for('example', 1, 'unique', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1, 2, 3];

  $result
});

=method unshift

The unshift method prepends the array by pushing the agruments onto it and
returns itself.

=signature unshift

  unshift(Any @data) (ArrayRef)

=metadata unshift

{
  since => '0.01',
}

=example-1 unshift

  # given: synopsis;

  my $unshift = $array->unshift(-2,-1,0);

  # [-2..9]

=cut

$test->for('example', 1, 'unshift', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [-2..9];

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

$test->render('lib/Venus/Array.pod') if $ENV{RENDER};

ok 1 and done_testing;