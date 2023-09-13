package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Box

=cut

$test->for('name');

=tagline

Box Class

=cut

$test->for('tagline');

=abstract

Box Class for Perl 5

=cut

$test->for('abstract');

=includes

method: unbox

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Box;

  my $box = Venus::Box->new(
    value => {},
  );

  # $box->keys->count->unbox;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->{value}->isa('Venus::Hash');

  $result
});

=description

This package provides a pure Perl boxing mechanism for wrapping objects and
values, and chaining method calls across all objects.

=cut

$test->for('description');

=integrates

Venus::Role::Buildable
Venus::Role::Proxyable

=cut

$test->for('integrates');

=method unbox

The unbox method returns the un-boxed underlying object. This is a virtual
method that dispatches to C<__handle__unbox>. This method supports dispatching,
i.e. providing a method name and arguments whose return value will be acted on
by this method.

=signature unbox

  unbox(string $method, any @args) (any)

=metadata unbox

{
  since => '0.01',
}

=example-1 unbox

  # given: synopsis;

  my $unbox = $box->unbox;

  # bless({ value => {} }, "Venus::Hash")

=cut

$test->for('example', 1, 'unbox', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Hash');

  $result
});

=example-2 unbox

  # given: synopsis;

  my $unbox = $box->unbox('count');

  # 0

=cut

$test->for('example', 2, 'unbox', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Box.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;