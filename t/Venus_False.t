package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::False

=cut

$test->for('name');

=tagline

False Class

=cut

$test->for('tagline');

=abstract

False Class for Perl 5

=cut

$test->for('abstract');

=includes

method: value

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::False;

  my $false = Venus::False->new;

  # $false->value;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result->isa('Venus::False');

  !$result
});

=description

This package provides the global C<false> value used in L<Venus::Boolean> and
the L<Venus/false> function.

=cut

$test->for('description');

=method value

The value method returns value representing the global C<false> value.

=signature value

  value() (Bool)

=metadata value

{
  since => '1.23',
}

=example-1 value

  # given: synopsis;

  my $value = $false->value;

  # 0

=cut

$test->for('example', 1, 'value', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/False.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
