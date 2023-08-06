package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Unacceptable

=cut

$test->for('name');

=tagline

Unacceptable Role

=cut

$test->for('tagline');

=abstract

Unacceptable Role for Perl 5

=cut

$test->for('abstract');

=synopsis

  package ExampleAccept;

  use Venus::Class 'attr';

  attr 'name';

  package ExampleDeny;

  use Venus::Class 'attr', 'with';

  with 'Venus::Role::Unacceptable';

  attr 'name';

  package main;

  my $example = ExampleDeny->new(name => 'example', test => 12345);

  # Exception! (isa Venus::Role::Unacceptable::Error)

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Role::Unacceptable::Error');
  ok $error->isa('Venus::Error');
  ok $error->is('on.build');
  is_deeply $error->stash('unknowns'), ['test'];
  ok $error->message =~ /ExampleDeny was passed unknown attribute/;
  my $example = ExampleAccept->new(name => 'example', test => 12345);
  ok $example->isa('ExampleAccept');
  ok !$example->does('Venus::Role::Unacceptable');
  is $example->{name}, 'example';
  is $example->{test}, 12345;

  $result
});

=description

This package provides a mechanism for raising an exception when unexpected
constructor arguments are encountered.

=cut

$test->for('description');

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Unacceptable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
