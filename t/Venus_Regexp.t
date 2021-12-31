package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Regexp

=cut

$test->for('name');

=tagline

Regexp Class

=cut

$test->for('tagline');

=abstract

Regexp Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default
method: replace
method: search

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<greet>\w+) (?<username>\w+)/,
  );

  # $regexp->search;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating regexp data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method default

The default method returns the default value, i.e. C<qr//>.

=signature default

  default() (Regexp)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $regexp->default;

  # qr/(?^u:)/

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq qr//;

  $result
});

=method replace

The replace method performs a regular expression substitution on the given
string. The first argument is the string to match against. The second argument
is the replacement string. The optional third argument might be a string
representing flags to append to the s///x operator, such as 'g' or 'e'.  This
method will always return a L<Venus::Replace> object which can be used to
introspect the result of the operation.

=signature replace

  replace(Str $string, Str $substr, Str $flags) (Replace)

=metadata replace

{
  since => '0.01',
}

=example-1 replace

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<username>\w+)$/,
  );

  my $replace = $regexp->replace('Hey, unknown', 'cpanery');

  # bless({ ... }, 'Venus::Replace')

=cut

$test->for('example', 1, 'replace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Replace');

  $result
});

=method search

The search method performs a regular expression match against the given string,
this method will always return a L<Venus::Search> object which can be used to
introspect the result of the operation.

=signature search

  search(Str $string) (Search)

=metadata search

{
  since => '0.01',
}

=example-1 search

  package main;

  use Venus::Regexp;

  my $regexp = Venus::Regexp->new(
    qr/(?<greet>\w+), (?<username>\w+)/,
  );

  my $search = $regexp->search('hey, cpanery');

  # bless({ ... }, 'Venus::Search')

=cut

$test->for('example', 1, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Search');

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $regexp eq '(?^u:(?<greet>\\w+) (?<username>\\w+))';

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

  my $result = $regexp ne '(?<greet>\w+) (?<username>\w+)';

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

  my $result = 'Hello Friend' =~  $regexp;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

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

$test->render('lib/Venus/Regexp.pod') if $ENV{RENDER};

ok 1 and done_testing;