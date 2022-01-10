package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Float

=cut

$test->for('name');

=tagline

Float Class

=cut

$test->for('tagline');

=abstract

Float Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Float;

  my $float = Venus::Float->new(1.23);

  # $float->int;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->get eq '1.23';

  $result
});

=description

This package provides methods for manipulating float data.

=cut

$test->for('description');

=inherits

Venus::Number

=cut

$test->for('inherits');

=method default

The default method returns the default value, i.e. C<0.0>.

=signature default

  default() (Str)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $float->default;

  # "0.0"

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "0.0";

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

$test->render('lib/Venus/Float.pod') if $ENV{RENDER};

ok 1 and done_testing;