package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Data

=cut

$test->for('name');

=tagline

Data Class

=cut

$test->for('tagline');

=abstract

Data Class for Perl 5

=cut

$test->for('abstract');

=includes

method: count
method: data
method: docs
method: find
method: search
method: text

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Data;

  my $data = Venus::Data->new('t/data/sections');

  # $data->find(undef, 'name');

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Data');

  $result
});

=description

This package provides methods for extracting C<DATA> sections and POD blocks
from any file or package. The package can be configured to parse either POD or
DATA blocks, and it defaults to being configured for POD blocks.

+=head2 DATA syntax

  __DATA__

  # data syntax

  @@ name

  Example Name

  @@ end

  @@ titles #1

  Example Title #1

  @@ end

  @@ titles #2

  Example Title #2

  @@ end

+=cut

+=head2 DATA syntax (nested)

  __DATA__

  # data syntax (nested)

  @@ nested

  Example Nested

  +@@ demo

  blah blah blah

  +@@ end

  @@ end

+=cut

+=head2 POD syntax

  # pod syntax

  =head1 NAME

  Example #1

  =cut

  =head1 NAME

  Example #2

  =cut

  # pod-ish syntax

  =name

  Example #1

  =cut

  =name

  Example #2

  =cut

+=cut

+=head2 POD syntax (nested)

  # pod syntax (nested)

  =nested

  Example #1

  +=head1 WHY?

  blah blah blah

  +=cut

  More information on the same topic as was previously mentioned in the
  previous section demonstrating the topic, obviously from said section.

  =cut

+=cut

=cut

$test->for('description');

=inherits

Venus::Path

=cut

$test->for('inherits');

=method count

The count method uses the criteria provided to L</search> for and return the
number of blocks found.

=signature count

  count(HashRef $criteria) (Int)

=metadata count

{
  since => '0.01',
}

=example-1 count

  # given: synopsis;

  my $count = $data->docs->count;

  # 6

=cut

$test->for('example', 1, 'count', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 6;

  $result
});

=example-2 count

  # given: synopsis;

  my $count = $data->text->count;

  # 3

=cut

$test->for('example', 2, 'count', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 3;

  $result
});

=method data

The data method returns the text between the C<DATA> and C<END> sections of a
Perl package or file.

=signature data

  data() (Str)

=metadata data

{
  since => '0.01',
}

=example-1 data

  # given: synopsis;

  $data = $data->data;

  # ...

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=method docs

The docs method configures the instance for parsing POD blocks.

=signature docs

  docs() (Data)

=metadata docs

{
  since => '0.01',
}

=example-1 docs

  # given: synopsis;

  my $docs = $data->docs;

  # bless({ etag => "=cut", from => "read", stag => "=", ... }, "Venus::Data")

=cut

$test->for('example', 1, 'docs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Data');
  ok $result->stag eq '=';
  ok $result->etag eq '=cut';
  ok $result->from eq 'read';

  $result
});

=method find

The find method is a wrapper around L</search> as shorthand for searching by
C<list> and C<name>.

=signature find

  find(Maybe[Str] $list, Maybe[Str] $name) (ArrayRef)

=metadata find

{
  since => '0.01',
}

=example-1 find

  # given: synopsis;

  my $find = $data->docs->find(undef, 'name');

  # [
  #   { data => ["Example #1"], index => 4, list => undef, name => "name" },
  #   { data => ["Example #2"], index => 5, list => undef, name => "name" },
  # ]

=cut

$test->for('example', 1, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example #1"], index => 4, list => undef, name => "name" },
    { data => ["Example #2"], index => 5, list => undef, name => "name" },
  ];

  $result
});

=example-2 find

  # given: synopsis;

  my $find = $data->docs->find('head1', 'NAME');

  # [
  #   { data => ["Example #1"], index => 1, list => "head1", name => "NAME" },
  #   { data => ["Example #2"], index => 2, list => "head1", name => "NAME" },
  # ]

=cut

$test->for('example', 2, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example #1"], index => 1, list => "head1", name => "NAME" },
    { data => ["Example #2"], index => 2, list => "head1", name => "NAME" },
  ];

  $result
});

=example-3 find

  # given: synopsis;

  my $find = $data->text->find(undef, 'name');

  # [
  #   { data => ["Example Name"], index => 1, list => undef, name => "name" },
  # ]

=cut

$test->for('example', 3, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example Name"], index => 1, list => undef, name => "name" },
  ];

  $result
});

=example-4 find

  # given: synopsis;

  my $find = $data->text->find('titles', '#1');

  # [
  #   { data => ["Example Title #1"], index => 2, list => "titles", name => "#1" },
  # ]

=cut

$test->for('example', 4, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example Title #1"], index => 2, list => "titles", name => "#1" },
  ];

  $result
});

=method search

The search method returns the set of blocks matching the criteria provided.
This method can return a list of values in list-context.

=signature find

  find(HashRef $criteria) (ArrayRef)

=metadata find

{
  since => '0.01',
}

=example-1 search

  # given: synopsis;

  my $search = $data->docs->search({list => undef, name => 'name'});

  # [
  #   { data => ["Example #1"], index => 4, list => undef, name => "name" },
  #   { data => ["Example #2"], index => 5, list => undef, name => "name" },
  # ]

=cut

$test->for('example', 1, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example #1"], index => 4, list => undef, name => "name" },
    { data => ["Example #2"], index => 5, list => undef, name => "name" },
  ];

  $result
});

=example-2 search

  # given: synopsis;

  my $search = $data->docs->search({list => 'head1', name => 'NAME'});

  # [
  #   { data => ["Example #1"], index => 1, list => "head1", name => "NAME" },
  #   { data => ["Example #2"], index => 2, list => "head1", name => "NAME" },
  # ]

=cut

$test->for('example', 2, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example #1"], index => 1, list => "head1", name => "NAME" },
    { data => ["Example #2"], index => 2, list => "head1", name => "NAME" },
  ];

  $result
});

=example-3 search

  # given: synopsis;

  my $find = $data->text->search({list => undef, name => 'name'});

  # [
  #   { data => ["Example Name"], index => 1, list => undef, name => "name" },
  # ]

=cut

$test->for('example', 3, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example Name"], index => 1, list => undef, name => "name" },
  ];

  $result
});

=example-4 search

  # given: synopsis;

  my $search = $data->text->search({list => 'titles', name => '#1'});

  # [
  #   { data => ["Example Title #1"], index => 2, list => "titles", name => "#1" },
  # ]

=cut

$test->for('example', 4, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [
    { data => ["Example Title #1"], index => 2, list => "titles", name => "#1" },
  ];

  $result
});

=method text

The text method configures the instance for parsing DATA blocks.

=signature text

  text() (Data)

=metadata text

{
  since => '0.01',
}

=example-1 text

  # given: synopsis;

  my $text = $data->text;

  # bless({ etag  => '@@ end', from  => 'data', stag  => '@@ ', ... }, "Venus::Data")

=cut

$test->for('example', 1, 'text', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Data');
  ok $result->stag eq '@@ ';
  ok $result->etag eq '@@ end';
  ok $result->from eq 'data';

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

$test->render('lib/Venus/Data.pod') if $ENV{RENDER};

ok 1 and done_testing;