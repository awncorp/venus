package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Sealed

=cut

$test->for('name');

=tagline

Sealed Class

=cut

$test->for('tagline');

=abstract

Sealed Class for Perl 5

=cut

$test->for('abstract');

=includes

method: get
method: set

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Sealed;

  my $sealed = Venus::Sealed->new('012345');

  # $sealed->get;

  # '012345'

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Sealed');

  $result
});

=description

This package provides a mechanism for sealing object and restricting and/or
preventing access to the underlying data structures. This package can be used
directly but is meant to be subclassed.

=cut

$test->for('description');

=integrates

Venus::Role::Buildable
Venus::Role::Catchable
Venus::Role::Proxyable
Venus::Role::Throwable
Venus::Role::Tryable

=cut

$test->for('integrates');

=method get

The get method can be used directly to get the sealed value set during
instantiation, but is meant to be overridden in a subclass to further control
access to the underlying data.

=signature get

  get(any @args) (any)

=metadata get

{
  since => '3.55',
}

=cut

=example-1 get

  # given: synopsis

  package main;

  my $get = $sealed->get;

  # "012345"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "012345";

  $result
});

=example-2 get

  package Example;

  use Venus::Class;

  base 'Venus::Sealed';

  sub __get {
    my ($self, $init, $data) = @_;

    return $data->{value};
  }

  sub __set {
    my ($self, $init, $data, $value) = @_;

    return $data->{value} = $value;
  }

  package main;

  my $sealed = Example->new("012345");

  my $get = $sealed->get;

  # "012345"

=cut

$test->for('example', 2, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "012345";

  require Venus::Space;
  Venus::Space->new('Example')->unload;

  $result
});

=method set

The set method can be used directly to set the sealed value set during
instantiation, but is meant to be overridden in a subclass to further control
access to the underlying data.

=signature set

  set(any @args) (any)

=metadata set

{
  since => '3.55',
}

=cut

=example-1 set

  # given: synopsis

  package main;

  my $set = $sealed->set("098765");

  # "098765"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "098765";

  $result
});

=example-2 set

  package Example;

  use Venus::Class;

  base 'Venus::Sealed';

  sub __get {
    my ($self, $init, $data) = @_;

    return $data->{value};
  }

  sub __set {
    my ($self, $init, $data, $value) = @_;

    return $data->{value} = $value;
  }

  package main;

  my $sealed = Example->new("012345");

  my $set = $sealed->set("098765");

  # "098765"

=cut

$test->for('example', 2, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "098765";

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

$test->render('lib/Venus/Sealed.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
