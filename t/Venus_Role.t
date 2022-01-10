package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role

=cut

$test->for('name');

=tagline

Role Builder

=cut

$test->for('tagline');

=abstract

Role Builder for Perl 5

=cut

$test->for('abstract');

=synopsis

  package Exemplar;

  use Venus::Role;

  sub handshake {
    return true;
  }

  package Example;

  use Venus::Class;

  with 'Exemplar';

  package main;

  my $example = Example->new;

  # $example->handshake;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Exemplar');
  ok $result->handshake == 1;

  $result
});

=description

This package modifies the consuming package making it a modified L<Moo> role,
i.e. L<Moo::Role>. All functions in L<Venus> are automatically imported unless
routines of the same name already exist.

=cut

$test->for('description');

=integrates

Moo::Role

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

$test->render('lib/Venus/Role.pod') if $ENV{RENDER};

ok 1 and done_testing;