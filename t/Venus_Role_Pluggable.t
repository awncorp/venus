package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Role::Pluggable

=cut

$test->for('name');

=tagline

Pluggable Role

=cut

$test->for('tagline');

=abstract

Pluggable Role for Perl 5

=cut

$test->for('abstract');

=synopsis

  package Example::Plugin::Password;

  use Venus::Class;

  use Digest::SHA ();

  sub execute {
    my ($self, $example) = @_;

    return Digest::SHA::sha1_hex($example->secret);
  }

  package Example;

  use Venus::Class;

  with 'Venus::Role::Pluggable';

  has 'secret';

  package main;

  my $example = Example->new(secret => rand);

  # $example->password;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Pluggable');

  $result
});

=description

This package provides a mechanism for dispatching to plugin classes.

=cut

$test->for('description');

=integrates

Venus::Role::Proxyable

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

$test->render('lib/Venus/Role/Pluggable.pod') if $ENV{RENDER};

ok 1 and done_testing;