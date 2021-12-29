package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Mappable

=cut

$test->for('name');

=tagline

Mappable Role

=cut

$test->for('tagline');

=abstract

Mappable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: all
method: any
method: count
method: delete
method: each
method: empty
method: exists
method: grep
method: iterator
method: keys
method: map
method: none
method: one
method: pairs
method: random
method: reverse
method: slice

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Mappable';

  sub all;
  sub any;
  sub count;
  sub delete;
  sub each;
  sub empty;
  sub exists;
  sub grep;
  sub iterator;
  sub keys;
  sub map;
  sub none;
  sub one;
  sub pairs;
  sub random;
  sub reverse;
  sub slice;

  package main;

  my $example = Example->new;

  # $example->random;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Mappable');

  $result
});

=description

This package provides a specification for the consuming package to implement
methods that makes the object mappable. See L<Venus::Array> and L<Venus::Hash>
as other examples of mappable classes.

=cut

$test->for('description');

=method all

The all method should return true if the callback returns true for all of the
elements provided.

=signature all

  all(CodeRef $code) (Bool)

=metadata all

{
  since => '0.01',
}

=example-1 all

  # given: synopsis;

  my $all = $example->all(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'all', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method any

The any method should return true if the callback returns true for any of the
elements provided.


=signature any

  any(CodeRef $code) (Bool)

=metadata any

{
  since => '0.01',
}

=example-1 any

  # given: synopsis;

  my $any = $example->any(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'any', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method count

The count method should return the number of top-level element in the data
structure.


=signature count

  count() (Num)

=metadata count

{
  since => '0.01',
}

=example-1 count

  # given: synopsis;

  my $count = $example->count;

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'count', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method delete

The delete method returns should remove the item in the data structure based on
the key provided, returning the item.


=signature delete

  delete(Str $key) (Any)

=metadata delete

{
  since => '0.01',
}

=example-1 delete

  # given: synopsis;

  my $delete = $example->delete(...);

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'delete', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method each

The each method should execute the callback for each item in the data structure
passing the key and value as arguments.


=signature each

  each(CodeRef $code) (ArrayRef)

=metadata each

{
  since => '0.01',
}

=example-1 each

  # given: synopsis;

  my $results = $example->each(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'each', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method empty

The empty method should drop all items from the data structure.


=signature empty

  empty() (Value)

=metadata empty

{
  since => '0.01',
}

=example-1 empty

  # given: synopsis;

  my $empty = $example->empty;

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'empty', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method exists

The exists method should return true if the item at the key specified exists,
otherwise it returns false.


=signature exists

  exists(Str $key) (Bool)

=metadata exists

{
  since => '0.01',
}

=example-1 exists

  # given: synopsis;

  my $exists = $example->exists(...);

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'exists', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method grep

The grep method should execute a callback for each item in the array, passing
the value as an argument, returning a value containing the items for which the
returned true.


=signature grep

  grep(CodeRef $code) (ArrayRef)

=metadata grep

{
  since => '0.01',
}

=example-1 grep

  # given: synopsis;

  my $results = $example->grep(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'grep', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method iterator

The iterator method should return a code reference which can be used to iterate
over the data structure. Each time the iterator is executed it will return the
next item in the data structure until all items have been seen, at which point
the iterator will return an undefined value.


=signature iterator

  iterator() (CodeRef)

=metadata iterator

{
  since => '0.01',
}

=example-1 iterator

  # given: synopsis;

  my $iterator = $example->iterator;

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'iterator', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method keys

The keys method should return an array reference consisting of the keys of the
data structure.


=signature keys

  keys() (ArrayRef)

=metadata keys

{
  since => '0.01',
}

=example-1 keys

  # given: synopsis;

  my $keys = $example->keys;

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'keys', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method map

The map method should iterate over each item in the data structure, executing
the code reference supplied in the argument, passing the routine the value at
the current position in the loop and returning an array reference containing
the items for which the argument returns a value or non-empty list.


=signature map

  map(CodeRef $code) (ArrayRef)

=metadata map

{
  since => '0.01',
}

=example-1 map

  # given: synopsis;

  my $results = $example->map(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'map', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method none

The none method should return true if none of the items in the data structure
meet the criteria set by the operand and rvalue.


=signature none

  none(CodeRef $code) (Bool)

=metadata none

{
  since => '0.01',
}

=example-1 none

  # given: synopsis;

  my $none = $example->none(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'none', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method one

The one method should return true if only one of the items in the data
structure meet the criteria set by the operand and rvalue.


=signature one

  one(CodeRef $code) (Bool)

=metadata one

{
  since => '0.01',
}

=example-1 one

  # given: synopsis;

  my $one = $example->one(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'one', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method pairs

The pairs method should return an array reference of tuples where each tuple is
an array reference having two items corresponding to the key and value for each
item in the data structure.


=signature pairs

  pairs(CodeRef $code) (Tuple[ArrayRef, ArrayRef])

=metadata pairs

{
  since => '0.01',
}

=example-1 pairs

  # given: synopsis;

  my $pairs = $example->pairs(sub {
    # ...
  });

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'pairs', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method random

The random method should return a random item from the data structure.


=signature random

  random() (Any)

=metadata random

{
  since => '0.01',
}

=example-1 random

  # given: synopsis;

  my $random = $example->random;

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'random', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method reverse

The reverse method should returns an array reference containing the items in
the data structure in reverse order if the items in the data structure are
ordered.


=signature reverse

  reverse() (ArrayRef)

=metadata reverse

{
  since => '0.01',
}

=example-1 reverse

  # given: synopsis;

  my $reverse = $example->reverse;

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'reverse', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=method slice

The slice method should return a new data structure containing the elements in
the invocant at the key(s) specified in the arguments.


=signature slice

  slice(Str @keys) (ArrayRef)

=metadata slice

{
  since => '0.01',
}

=example-1 slice

  # given: synopsis;

  my $slice = $example->slice(...);

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONLY
# $test->for('example', 1, 'slice', sub {
#   my ($tryable) = @_;
#   ok my $result = $tryable->result;
#
#   $result
# });

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Role/Mappable.pod') if $ENV{RENDER};

ok 1 and done_testing;