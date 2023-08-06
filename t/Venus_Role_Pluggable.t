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

  package Example::Plugin::Username;

  use Venus::Class;

  use Digest::SHA ();

  sub execute {
    my ($self, $example) = @_;

    return Digest::SHA::sha1_hex($example->login);
  }

  package Example::Plugin::Password;

  use Venus::Class;

  use Digest::SHA ();

  attr 'value';

  sub construct {
    my ($class, $example) = @_;

    return $class->new(value => $example->secret);
  }

  sub execute {
    my ($self) = @_;

    return Digest::SHA::sha1_hex($self->value);
  }

  package Example;

  use Venus::Class;

  with 'Venus::Role::Proxyable';
  with 'Venus::Role::Pluggable';

  attr 'login';
  attr 'secret';

  package main;

  my $example = Example->new(login => 'admin', secret => 'p@ssw0rd');

  # $example->username;
  # $example->password;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Pluggable');
  is $result->username, 'd033e22ae348aeb5660fc2140aec35850c4da997';
  is $result->password, '57b2ad99044d337197c0c39fd3823568ff81e48a';

  $result
});

=description

This package provides a mechanism for dispatching to plugin classes.

=cut

$test->for('description');

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Pluggable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;