package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

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

  with 'Venus::Role::Proxyable';
  with 'Venus::Role::Pluggable';

  attr 'secret';

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

# END

$test->render('lib/Venus/Role/Pluggable.pod') if $ENV{RENDER};

ok 1 and done_testing;