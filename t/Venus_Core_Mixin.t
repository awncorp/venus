package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Core::Mixin

=cut

$test->for('name');

=tagline

Mixin Base Class

=cut

$test->for('tagline');

=abstract

Mixin Base Class for Perl 5

=cut

$test->for('abstract');

=includes

method: import
method: does
method: meta
method: unimport

=cut

$test->for('includes');

=synopsis

  package Person;

  use base 'Venus::Core::Mixin';

  package User;

  use base 'Venus::Core::Class';

  package main;

  my $user = User->MIXIN('Person')->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'User')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('User');
  ok UNIVERSAL::isa($result, 'HASH');
  ok $result->{fname} eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok !$result->does('Person');

  $result
});

=description

This package provides a mixin base class with mixin building and object
construction lifecycle hooks.

=cut

$test->for('description');

=inherits

Venus::Core

=cut

$test->for('inherits');

=method import

The import method throws a fatal exception whenever the L<perlfunc/use>
declaration is used with mixins as they are meant to be consumed via the
C<mixin> keyword function.

=signature import

  import(any @args) (any)

=metadata import

{
  since => '2.91',
}

=example-1 import

  package main;

  use Person;

  # Exception! (isa Venus::Fault)

=cut

$test->for('example', 1, 'import', sub {
  1
});

=method does

The does method returns true if the object is composed of the role provided.

=signature does

  does(string $name) (boolean)

=metadata does

{
  since => '1.02',
}

=example-1 does

  package Employee;

  use base 'Venus::Core::Role';

  Employee->MIXIN('Person');

  package main;

  my $user = User->ROLE('Employee')->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  my $does = $user->does('Employee');

  # 1

=cut

$test->for('example', 1, 'does', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method meta

The meta method returns a L<Venus::Meta> objects which describes the package's
configuration.

=signature meta

  meta() (Venus::Meta)

=metadata meta

{
  since => '1.02',
}

=example-1 meta

  package main;

  my $user = User->ROLE('Person')->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  my $meta = Person->meta;

  # bless({...}, 'Venus::Meta')

=cut

$test->for('example', 1, 'meta', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Meta');

  $result
});

=method unimport

The unimport method invokes the C<UNIMPORT> lifecycle hook and is invoked
whenever the L<perlfunc/no> declaration is used.

=signature unimport

  unimport(any @args) (any)

=metadata unimport

{
  since => '2.91',
}

=cut

=example-1 unimport

  package main;

  no Person;

  # ()

=cut

$test->for('example', 1, 'unimport', sub {
  1
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Core/Mixin.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
