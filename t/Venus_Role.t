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

=feature has

This package supports the C<has> keyword function and all of its
configurations. See the L<Moo> documentation for more details.

=example-1 has

  package Example::Has;

  use Venus::Role;

  has 'data' => (
    is => 'ro',
    isa => sub { die }
  );

  package Example::HasData;

  use Venus::Class;

  with 'Example::Has';

  has '+data' => (
    is => 'ro',
    isa => sub { 1 }
  );

  package main;

  my $example = Example::HasData->new(data => time);

=cut

$test->for('example', 1, 'has', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});

=feature has-is

This package supports the C<is> directive, used to denote whether the attribute
is read-only or read-write. See the L<Moo> documentation for more details.

=example-1 has-is

  package Example::HasIs;

  use Venus::Class;

  has data => (
    is => 'ro'
  );

  package main;

  my $example = Example::HasIs->new(data => time);

=cut

$test->for('example', 1, 'has-is', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});

=feature has-isa

This package supports the C<isa> directive, used to define the type constraint
to validate the attribute against. See the L<Moo> documentation for more
details.

=example-1 has-isa

  package Example::HasIsa;

  use registry;

  use Venus::Class;

  has data => (
    is => 'ro',
    isa => 'Str' # e.g. Types::Standard::Str
  );

  package main;

  my $example = Example::HasIsa->new(data => time);

=cut

SKIP: {
if (not(do{eval "require registry; 1"})) {
  diag 'cannot find registry pragma';
  skip '=example-1 has-isa';
}
$test->for('example', 1, 'has-isa', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});
}

=feature has-req

This package supports the C<req> and C<required> directives, used to denote if
an attribute is required or optional. See the L<Moo> documentation for more
details.

=example-1 has-req

  package Example::HasReq;

  use Venus::Class;

  has data => (
    is => 'ro',
    req => 1 # required
  );

  package main;

  my $example = Example::HasReq->new(data => time);

=cut

$test->for('example', 1, 'has-req', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});

=feature has-opt

This package supports the C<opt> and C<optional> directives, used to denote if
an attribute is optional or required. See the L<Moo> documentation for more
details.

=example-1 has-opt

  package Example::HasOpt;

  use Venus::Class;

  has data => (
    is => 'ro',
    opt => 1
  );

  package main;

  my $example = Example::HasOpt->new(data => time);

=cut

$test->for('example', 1, 'has-opt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});

=feature has-bld

This package supports the C<bld> and C<builder> directives, expects a C<1>, a
method name, or coderef and builds the attribute value if it wasn't provided to
the constructor. See the L<Moo> documentation for more details.

=example-1 has-bld

  package Example::HasBld;

  use Venus::Class;

  has data => (
    is => 'ro',
    bld => 1
  );

  sub _build_data {
    return rand;
  }

  package main;

  my $example = Example::HasBld->new;

=cut

$test->for('example', 1, 'has-bld', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});

=feature has-clr

This package supports the C<clr> and C<clearer> directives expects a C<1> or a
method name of the clearer method. See the L<Moo> documentation for more
details.

=example-1 has-clr

  package Example::HasClr;

  use Venus::Class;

  has data => (
    is => 'ro',
    clr => 1
  );

  package main;

  my $example = Example::HasClr->new(data => time);

  # $example->clear_data;

=cut

$test->for('example', 1, 'has-clr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;
  ok $result->clear_data;
  ok !$result->data;

  $result
});

=feature has-crc

This package supports the C<crc> and C<coerce> directives denotes whether an
attribute's value should be automatically coerced. See the L<Moo> documentation
for more details.

=example-1 has-crc

  package Example::HasCrc;

  use Venus::Class;

  has data => (
    is => 'ro',
    crc => sub {'0'}
  );

  package main;

  my $example = Example::HasCrc->new(data => time);

=cut

$test->for('example', 1, 'has-crc', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !$result->data;
  is $result->data, '0';

  $result
});

=feature has-def

This package supports the C<def> and C<default> directives expects a
non-reference or a coderef to be used to build a default value if one is not
provided to the constructor. See the L<Moo> documentation for more details.

=example-1 has-def

  package Example::HasDef;

  use Venus::Class;

  has data => (
    is => 'ro',
    def => '0'
  );

  package main;

  my $example = Example::HasDef->new;

=cut

$test->for('example', 1, 'has-def', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !$result->data;
  is $result->data, '0';

  $result
});

=feature has-mod

This package supports the C<mod> and C<modify> directives denotes whether a
pre-existing attribute's definition is being modified. This ability is not
supported by the L<Moo> object superclass.

=example-1 has-mod

  package Example::HasNomod;

  use Venus::Role;

  has data => (
    is => 'rw',
    opt => 1
  );

  package Example::HasMod;

  use Venus::Class;

  with 'Example::HasNomod';

  has data => (
    is => 'ro',
    req => 1,
    mod => 1
  );

  package main;

  my $example = Example::HasMod->new;

=cut

$test->for('example', 1, 'has-mod', sub {
  my ($tryable) = @_;
  $tryable->default(sub {
    my ($error) = @_;
    "$error" =~ /required/i ? 'errored' : 'unknown';
  });
  ok my $result = $tryable->result;
  is $result, 'errored';

  $result
});

=feature has-hnd

This package supports the C<hnd> and C<handles> directives denotes the methods
created on the object which dispatch to methods available on the attribute's
object. See the L<Moo> documentation for more details.

=example-1 has-hnd

  package Example::Time;

  use Venus::Class;

  sub maketime {
    return time;
  }

  package Example::HasHnd;

  use Venus::Class;

  has data => (
    is => 'ro',
    hnd => ['maketime']
  );

  package main;

  my $example = Example::HasHnd->new(data => Example::Time->new);

=cut

$test->for('example', 1, 'has-hnd', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok my $object = $result->data;
  ok $object->can('maketime');
  ok $result->maketime;

  $result
});

=feature has-lzy

This package supports the C<lzy> and C<lazy> directives denotes whether the
attribute will be constructed on-demand, or on-construction. See the L<Moo>
documentation for more details.

=example-1 has-lzy

  package Example::HasLzy;

  use Venus::Class;

  has data => (
    is => 'ro',
    def => sub {time},
    lzy => 1
  );

  package main;

  my $example = Example::HasLzy->new;

=cut

$test->for('example', 1, 'has-lzy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok !$result->{data};
  ok $result->data;
  ok $result->{data};

  $result
});

=feature has-new

This package supports the C<new> directive, if truthy, denotes that the
attribute will be constructed on-demand, i.e. is lazy, with a builder named
new_{attribute}. This ability is not supported by the L<Moo> object superclass.

=example-1 has-new

  package Example::HasNew;

  use Venus::Class;

  has data => (
    is => 'ro',
    new => 1
  );

  sub new_data {
    return time;
  }

  package main;

  my $example = Example::HasNew->new(data => time);

=cut

$test->for('example', 1, 'has-new', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;

  $result
});

=feature has-pre

This package supports the C<pre> and C<predicate> directives expects a C<1> or
a method name and generates a method for checking the existance of the
attribute. See the L<Moo> documentation for more details.

=example-1 has-pre

  package Example::HasPre;

  use Venus::Class;

  has data => (
    is => 'ro',
    pre => 1
  );

  package main;

  my $example = Example::HasPre->new(data => time);

=cut

$test->for('example', 1, 'has-pre', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->has_data;

  $result
});

=feature has-rdr

This package supports the C<rdr> and C<reader> directives denotes the name of
the method to be used to "read" and return the attribute's value. See the
L<Moo> documentation for more details.

=example-1 has-rdr

  package Example::HasRdr;

  use Venus::Class;

  has data => (
    is => 'ro',
    rdr => 'get_data'
  );

  package main;

  my $example = Example::HasRdr->new(data => time);

=cut

$test->for('example', 1, 'has-rdr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->get_data;

  $result
});

=feature has-tgr

This package supports the C<tgr> and C<trigger> directives expects a C<1> or a
coderef and is executed whenever the attribute's value is changed. See the
L<Moo> documentation for more details.

=example-1 has-tgr

  package Example::HasTgr;

  use Venus::Class;

  has data => (
    is => 'ro',
    tgr => 1
  );

  sub _trigger_data {
    my ($self) = @_;

    $self->{triggered} = 1;

    return $self;
  }

  package main;

  my $example = Example::HasTgr->new(data => time);

=cut

$test->for('example', 1, 'has-tgr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;
  is $result->{triggered}, 1;

  $result
});

=feature has-use

This package supports the C<use> directive denotes that the attribute will be
constructed on-demand, i.e. is lazy, using a custom builder meant to perform
service construction. This directive exists to provide a simple dependency
injection mechanism for class attributes. This ability is not supported by the
L<Moo> object superclass.

=example-1 has-use

  package Example::HasUse;

  use Venus::Class;

  has data => (
    is => 'ro',
    use => ['service', 'time']
  );

  sub service {
    my ($self, $type, @args) = @_;

    $self->{serviced} = 1;

    return time if $type eq 'time';
  }

  package main;

  my $example = Example::HasUse->new;

=cut

$test->for('example', 1, 'has-use', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->data;
  is $result->{serviced}, 1;

  $result
});

=feature has-wkr

This package supports the C<wkr> and C<weak_ref> directives is used to denote if
the attribute's value should be weakened. See the L<Moo> documentation for more
details.

=example-1 has-wkr

  package Example::HasWkr;

  use Venus::Class;

  has data => (
    is => 'ro',
    wkr => 1
  );

  package main;

  my $data = do {
    my ($a, $b);

    $a = { time => time };
    $b = { time => $a };

    $a->{time} = $b;
    $a
  };

  my $example = Example::HasWkr->new(data => $data);

=cut

$test->for('example', 1, 'has-wkr', sub {
  my ($tryable) = @_;
  require Scalar::Util;

  ok my $result = $tryable->result;
  ok $result->data;
  ok Scalar::Util::isweak($result->{data});

  $result
});

=feature has-wrt

This package supports the C<wrt> and C<writer> directives denotes the name of
the method to be used to "write" and return the attribute's value. See the
L<Moo> documentation for more details.

=example-1 has-wrt

  package Example::HasWrt;

  use Venus::Class;

  has data => (
    is => 'ro',
    wrt => 'set_data'
  );

  package main;

  my $example = Example::HasWrt->new;

=cut

$test->for('example', 1, 'has-wrt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->set_data(time);
  ok $result->data;

  $result
});

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