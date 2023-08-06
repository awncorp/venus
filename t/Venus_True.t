package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::True

=cut

$test->for('name');

=tagline

True Class

=cut

$test->for('tagline');

=abstract

True Class for Perl 5

=cut

$test->for('abstract');

=includes

method: value

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::True;

  my $true = Venus::True->new;

  # $true->value;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::True');

  $result
});

=description

This package provides the global C<true> value used in L<Venus::Boolean> and
the L<Venus/true> function.

=cut

$test->for('description');

=method value

The value method returns value representing the global C<true> value.

=signature value

  value() (Bool)

=metadata value

{
  since => '1.23',
}

=example-1 value

  # given: synopsis;

  my $value = $true->value;

  # 1

=cut

$test->for('example', 1, 'value', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/True.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
