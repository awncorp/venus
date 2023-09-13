package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Patchable

=cut

$test->for('name');

=tagline

Patchable Role

=cut

$test->for('tagline');

=abstract

Patchable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: patch

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Patchable';

  package main;

  my $example = Example->new;

  # my $patch = $example->patch;

  # bless(.., "Venus::Space")

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Patchable');

  require Venus::Space;
  Venus::Space->new('Example')->unload;

  $result
});

=description

This package modifies the consuming package and provides methods for patching
(or monkey-patching) routines in the calling package using
L<Venus::Space/patch>.

=cut

$test->for('description');

=method patch

The patch method overwrites the named subroutine in the calling package using
L<Venus::Space/patch> returning a L<Venus::Space> object that can be used to
restore the original subroutine when L<Venus::Space/unpatch> is called.

=signature patch

  patch(string $name, coderef $code) (Venus::Space)

=metadata patch

{
  since => '3.55',
}

=example-1 patch

  package Example;

  use Venus::Class;

  with 'Venus::Role::Patchable';

  sub test {
    my ($self, @args) = @_;

    return [$self, @args];
  }

  package main;

  my $example = Example->new;

  my $patch = $example->patch('test', sub {
    my ($next, @args) = @_;

    return ['patched', @{$next->(@args)}];
  });

  # bless(.., "Venus::Space")

=cut

$test->for('example', 1, 'patch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Space';
  ok $result->patched;
  my $example = $result->package->new;
  my $returned = $example->test(1..4);
  is $returned->[0], 'patched';
  isa_ok $returned->[1], $result;
  is $returned->[2], 1;
  is $returned->[3], 2;
  is $returned->[4], 3;
  is $returned->[5], 4;
  $result->unpatch;
  $returned = $example->test(1..4);
  isa_ok $returned->[0], $result;
  is $returned->[1], 1;
  is $returned->[2], 2;
  is $returned->[3], 3;
  is $returned->[4], 4;

  require Venus::Space;
  Venus::Space->new('Example')->unload;

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Patchable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
