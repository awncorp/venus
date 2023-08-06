package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Coercible

=cut

$test->for('name');

=tagline

Coercible Role

=cut

$test->for('tagline');

=abstract

Coercible Role for Perl 5

=cut

$test->for('abstract');

=includes

method: coerce_args
method: coerce_attr
method: coerce_into
method: coerce_onto
method: coercers
method: coercion

=cut

$test->for('includes');

=synopsis

  package Person;

  use Venus::Class;

  with 'Venus::Role::Coercible';

  attr 'name';
  attr 'father';
  attr 'mother';
  attr 'siblings';

  sub coercers {
    {
      father => 'Person',
      mother => 'Person',
      name => 'Venus/String',
      siblings => 'Person',
    }
  }

  sub coerce_name {
    my ($self, $code, @args) = @_;

    return $self->$code(@args);
  }

  sub coerce_siblings {
    my ($self, $code, $class, $value) = @_;

    return [map $self->$code($class, $_), @$value];
  }

  package main;

  my $person = Person->new(
    name => 'me',
    father => {name => 'father'},
    mother => {name => 'mother'},
    siblings => [{name => 'brother'}, {name => 'sister'}],
  );

  # $person
  # bless({...}, 'Person')

  # $person->name
  # bless({...}, 'Venus::String')

  # $person->father
  # bless({...}, 'Person')

  # $person->mother
  # bless({...}, 'Person')

  # $person->siblings
  # [bless({...}, 'Person'), bless({...}, 'Person'), ...]

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  # $person
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Coercible');

  # $person->name
  ok $result->name->isa('Venus::String');

  # $person->father
  ok $result->father->isa('Person');
  ok $result->father->does('Venus::Role::Coercible');
  ok $result->father->name('Venus::String');

  # $person->mother
  ok $result->mother->isa('Person');
  ok $result->mother->does('Venus::Role::Coercible');
  ok $result->mother->name('Venus::String');

  # $person->siblings
  ok ref($result->siblings) eq 'ARRAY';
  ok $result->siblings->[0]->isa('Person');
  ok $result->siblings->[0]->does('Venus::Role::Coercible');
  ok $result->siblings->[0]->name('Venus::String');
  ok $result->siblings->[1]->isa('Person');
  ok $result->siblings->[1]->does('Venus::Role::Coercible');
  ok $result->siblings->[1]->name('Venus::String');

  $result
});

=description

This package modifies the consuming package and provides methods for hooking
into object construction and coercing arguments into objects and values.

=cut

$test->for('description');

=method coerce_args

The coerce_args method replaces values in the data provided with objects
corresponding to the specification provided. The specification should contains
key/value pairs where the keys map to class attributes (or input parameters)
and the values are L<Venus::Space> compatible package names.

=signature coerce_args

  coerce_args(HashRef $data, HashRef $spec) (HashRef)

=metadata coerce_args

{
  since => '0.07',
}

=example-1 coerce_args

  package main;

  my $person = Person->new;

  my $data = $person->coerce_args(
    {
      father => { name => 'father' }
    },
    {
      father => 'Person',
    },
  );

  # {
  #   father   => bless({...}, 'Person'),
  # }

=cut

$test->for('example', 1, 'coerce_args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref($result), 'HASH';
  ok $result->{father};
  ok $result->{father}->isa('Person');

  $result
});

=method coerce_attr

The coerce_attr method is a surrogate accessor and gets and/or sets an instance
attribute based on the coercion rules, returning the coerced value.

=signature coerce_attr

  coerce_attr(Str $name, Any $value) (Any)

=metadata coerce_attr

{
  since => '1.23',
}

=example-1 coerce_attr

  # given: synopsis

  package main;

  $person = Person->new(
    name => 'me',
  );

  my $coerce_name = $person->coerce_attr('name');

  # bless({value => "me"}, "Venus::String")

=cut

$test->for('example', 1, 'coerce_attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->get eq "me";

  $result
});

=example-2 coerce_attr

  # given: synopsis

  package main;

  $person = Person->new(
    name => 'me',
  );

  my $coerce_name = $person->coerce_attr('name', 'myself');

  # bless({value => "myself"}, "Venus::String")

=cut

$test->for('example', 2, 'coerce_attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->get eq "myself";

  $result
});

=method coerce_into

The coerce_into method attempts to build and return an object based on the
class name and value provided, unless the value provided is already an object
derived from the specified class.

=signature coerce_into

  coerce_into(Str $class, Any $value) (Object)

=metadata coerce_into

{
  since => '0.07',
}

=example-1 coerce_into

  package main;

  my $person = Person->new;

  my $friend = $person->coerce_into('Person', {
    name => 'friend',
  });

  # bless({...}, 'Person')

=cut

$test->for('example', 1, 'coerce_into', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->name->isa('Venus::String');
  is $result->name->value, 'friend';

  $result
});

=method coerce_onto

The coerce_onto method attempts to build and assign an object based on the
class name and value provided, as the value corresponding to the name
specified, in the data provided. If the C<$value> is omitted, the value
corresponding to the name in the C<$data> will be used.

=signature coerce_onto

  coerce_onto(HashRef $data, Str $name, Str $class, Any $value) (Object)

=metadata coerce_onto

{
  since => '0.07',
}

=example-1 coerce_onto

  package main;

  my $person = Person->new;

  my $data = { friend => { name => 'friend' } };

  my $friend = $person->coerce_onto($data, 'friend', 'Person');

  # bless({...}, 'Person'),

  # $data was updated
  #
  # {
  #   friend => bless({...}, 'Person'),
  # }

=cut

$test->for('example', 1, 'coerce_onto', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->name->isa('Venus::String');
  is $result->name->value, 'friend';

  $result
});

=example-2 coerce_onto

  package Player;

  use Venus::Class;

  with 'Venus::Role::Coercible';

  attr 'name';
  attr 'teammates';

  sub coercers {
    {
      teammates => 'Person',
    }
  }

  sub coerce_into_person {
    my ($self, $class, $value) = @_;

    return $class->new($value);
  }

  sub coerce_into_venus_string {
    my ($self, $class, $value) = @_;

    return $class->new($value);
  }

  sub coerce_teammates {
    my ($self, $code, $class, $value) = @_;

    return [map $self->$code($class, $_), @$value];
  }

  package main;

  my $player = Player->new;

  my $data = { teammates => [{ name => 'player2' }, { name => 'player3' }] };

  my $teammates = $player->coerce_onto($data, 'teammates', 'Person');

  # [bless({...}, 'Person'), bless({...}, 'Person')]

  # $data was updated
  #
  # {
  #   teammates => [bless({...}, 'Person'), bless({...}, 'Person')],
  # }

=cut

$test->for('example', 2, 'coerce_onto', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Person');
  is $result->[0]->name, 'player2';
  ok $result->[1]->isa('Person');
  is $result->[1]->name, 'player3';

  $result
});

=method coercers

The coercers method, if defined, is called during object construction, or by the
L</coercion> method, and returns key/value pairs where the keys map to class
attributes (or input parameters) and the values are L<Venus::Space> compatible
package names.

=signature coercers

  coercers() (HashRef)

=metadata coercers

{
  since => '0.02',
}

=example-1 coercers

  package main;

  my $person = Person->new(
    name => 'me',
  );

  my $coercers = $person->coercers;

  # {
  #   father   => "Person",
  #   mother   => "Person",
  #   name     => "Venus/String",
  #   siblings => "Person",
  # }

=cut

$test->for('example', 1, 'coercers', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {
    father   => "Person",
    mother   => "Person",
    name     => "Venus/String",
    siblings => "Person",
  };

  $result
});

=method coercion

The coercion method is called automatically during object construction but can
be called manually as well, and is passed a hashref to coerce and return.

=signature coercion

  coercion(HashRef $data) (HashRef)

=metadata coercion

{
  since => '0.02',
}

=example-1 coercion

  package main;

  my $person = Person->new;

  my $coercion = $person->coercion({
    name => 'me',
  });

  # $coercion
  # {...}

  # $coercion->{name}
  # bless({...}, 'Venus::String')

  # $coercion->{father}
  # undef

  # $coercion->{mother}
  # undef

  # $coercion->{siblings}
  # undef

=cut

$test->for('example', 1, 'coercion', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  # $result
  ok ref($result) eq 'HASH';

  # $result->{name}
  ok $result->{name}->isa('Venus::String');

  # $result->{father}
  ok !defined $result->{father};

  # $result->{mother}
  ok !defined $result->{mother};

  # $result->{siblings}
  ok !defined $result->{siblings};

  $result
});

=example-2 coercion

  package main;

  my $person = Person->new;

  my $coercion = $person->coercion({
    name => 'me',
    mother => {name => 'mother'},
    siblings => [{name => 'brother'}, {name => 'sister'}],
  });

  # $coercion
  # {...}

  # $coercion->{name}
  # bless({...}, 'Venus::String')

  # $coercion->{father}
  # undef

  # $coercion->{mother}
  # bless({...}, 'Person')

  # $coercion->{siblings}
  # [bless({...}, 'Person'), bless({...}, 'Person'), ...]

=cut

$test->for('example', 2, 'coercion', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  # $result
  ok ref($result) eq 'HASH';

  # $result->{name}
  ok $result->{name}->isa('Venus::String');

  # $result->{father}
  ok !defined $result->{father};

  # $result->{mother}
  ok $result->{mother}->isa('Person');
  ok $result->{mother}->does('Venus::Role::Coercible');
  ok $result->{mother}->name('Venus::String');

  # $result->siblings
  ok ref($result->{siblings}) eq 'ARRAY';
  ok $result->{siblings}->[0]->isa('Person');
  ok $result->{siblings}->[0]->does('Venus::Role::Coercible');
  ok $result->{siblings}->[0]->name('Venus::String');
  ok $result->{siblings}->[1]->isa('Person');
  ok $result->{siblings}->[1]->does('Venus::Role::Coercible');
  ok $result->{siblings}->[1]->name('Venus::String');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Coercible.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
