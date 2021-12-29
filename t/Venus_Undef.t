package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Undef

=cut

$test->for('name');

=tagline

Undef Class

=cut

$test->for('tagline');

=abstract

Undef Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Undef;

  my $undef = Venus::Undef->new;

  # $undef->defined;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=description

This package provides methods for manipulating undef data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method default

The default method returns the default value, i.e. C<undef>.

=signature default

  default() (Undef)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $undef->default;

  # undef

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Undef.pod') if $ENV{RENDER};

ok 1 and done_testing;