package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Kind::Utility

=cut

$test->for('name');

=tagline

Utility Base Class

=cut

$test->for('tagline');

=abstract

Utility Base Class for Perl 5

=cut

$test->for('abstract');

=synopsis

  package Example;

  use Venus::Class;

  base 'Venus::Kind::Utility';

  package main;

  my $example = Example->new;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');

  $result
});

=description

This package provides identity and methods common across all L<Venus> utility
classes.

=cut

$test->for('description');

=inherits

Venus::Kind

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable

=cut

$test->for('integrates');

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Kind/Utility.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;