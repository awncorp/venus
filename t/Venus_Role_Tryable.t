package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Tryable

=cut

$test->for('name');

=tagline

Tryable Role

=cut

$test->for('tagline');

=abstract

Tryable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: try

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class 'with';
  use Venus 'raise';

  with 'Venus::Role::Tryable';

  sub test {
    raise 'Example::Error';
  }

  package main;

  my $example = Example->new;

  # $example->try('test');

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Tryable');

  $result
});

=description

This package modifies the consuming package and provides a mechanism for
handling potentially volatile routines.

=cut

$test->for('description');

=method try

The try method returns a L<Venus::Try> object having the invocant, callback,
arguments pre-configured. This method supports dispatching, i.e. providing a
method name and arguments whose return value will be acted on by this method.

=signature try

  try(Str | CodeRef $method, Any @args) (Try)

=metadata try

{
  since => '0.01',
}

=example-1 try

  package main;

  my $example = Example->new;

  my $try = $example->try('test');

  # my $value = $try->result;

=cut

$test->for('example', 1, 'try', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  $result->error(\my $error)->result;
  ok $error;
  ok $error->isa('Example::Error');
  ok $error->isa('Venus::Error');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Tryable.pod') if $ENV{RENDER};

ok 1 and done_testing;