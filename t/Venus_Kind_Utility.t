package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

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

  extends 'Venus::Kind::Utility';

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

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Kind/Utility.pod') if $ENV{RENDER};

ok 1 and done_testing;