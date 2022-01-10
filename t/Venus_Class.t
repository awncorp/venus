package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Class

=cut

$test->for('name');

=tagline

Class Builder

=cut

$test->for('tagline');

=abstract

Class Builder for Perl 5

=cut

$test->for('abstract');

=synopsis

  package Example;

  use Venus::Class;

  sub handshake {
    return true;
  }

  package main;

  my $example = Example->new;

  # $example->handshake;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->handshake == 1;

  $result
});

=description

This package modifies the consuming package making it a modified L<Moo> class.
All functions in L<Venus> are automatically imported unless routines of the
same name already exist.

=cut

$test->for('description');

=integrates

Moo

=cut

# SKIP TEST, USED FOR DOCUMENTATION ONY
# $test->for('integrates');

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Class.pod') if $ENV{RENDER};

ok 1 and done_testing;