package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Makeable

=cut

$test->for('name');

=tagline

Makeable Role

=cut

$test->for('tagline');

=abstract

Makeable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: make_args
method: make_attr
method: make_into
method: make_onto
method: makers
method: making

=cut

$test->for('includes');

=synopsis

  package Person;

  use Venus::Class 'attr', 'error', 'with';

  with 'Venus::Role::Makeable';

  attr 'name';
  attr 'father';
  attr 'mother';
  attr 'siblings';

  sub make {
    my ($self, $value) = @_;

    error if !ref $value;

    return $self->new($value);
  }

  sub makers {
    {
      father => 'Person',
      mother => 'Person',
      name => 'Venus/String',
      siblings => 'Person',
    }
  }

  sub make_name {
    my ($self, $code, @args) = @_;

    return $self->$code(@args);
  }

  sub make_siblings {
    my ($self, $code, $class, $value) = @_;

    return [map $self->$code($class, $_), @$value];
  }

  package main;

  my $person = Person->make({
    name => 'me',
    father => {name => 'father'},
    mother => {name => 'mother'},
    siblings => [{name => 'brother'}, {name => 'sister'}],
  });

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
  ok $result->does('Venus::Role::Makeable');

  # $person->name
  ok $result->name->isa('Venus::String');

  # $person->father
  ok $result->father->isa('Person');
  ok $result->father->does('Venus::Role::Makeable');
  ok $result->father->name('Venus::String');

  # $person->mother
  ok $result->mother->isa('Person');
  ok $result->mother->does('Venus::Role::Makeable');
  ok $result->mother->name('Venus::String');

  # $person->siblings
  ok ref($result->siblings) eq 'ARRAY';
  ok $result->siblings->[0]->isa('Person');
  ok $result->siblings->[0]->does('Venus::Role::Makeable');
  ok $result->siblings->[0]->name('Venus::String');
  ok $result->siblings->[1]->isa('Person');
  ok $result->siblings->[1]->does('Venus::Role::Makeable');
  ok $result->siblings->[1]->name('Venus::String');

  $result
});

=description

This package modifies the consuming package and provides methods for hooking
into object construction and coercing arguments into objects and values using
the I<"make"> protocol, i.e. using the C<"make"> method (which performs fatal
type checking and coercions) instead of the typical C<"new"> method.

=cut

$test->for('description');

=method make_args

The make_args method replaces values in the data provided with objects
corresponding to the specification provided. The specification should contains
key/value pairs where the keys map to class attributes (or input parameters)
and the values are L<Venus::Space> compatible package names.

=signature make_args

  make_args(HashRef $data, HashRef $spec) (HashRef)

=metadata make_args

{
  since => '1.30',
}

=example-1 make_args

  package main;

  my $person = Person->new;

  my $data = $person->make_args(
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

$test->for('example', 1, 'make_args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref($result), 'HASH';
  ok $result->{father};
  ok $result->{father}->isa('Person');

  $result
});

=method make_attr

The make_attr method is a surrogate accessor and gets and/or sets an instance
attribute based on the C<makers> rules, returning the made value.

=signature make_attr

  make_attr(Str $name, Any $value) (Any)

=metadata make_attr

{
  since => '1.30',
}

=example-1 make_attr

  # given: synopsis

  package main;

  $person = Person->new(
    name => 'me',
  );

  my $make_name = $person->make_attr('name');

  # bless({value => "me"}, "Venus::String")

=cut

$test->for('example', 1, 'make_attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->get eq "me";

  $result
});

=example-2 make_attr

  # given: synopsis

  package main;

  $person = Person->new(
    name => 'me',
  );

  my $make_name = $person->make_attr('name', 'myself');

  # bless({value => "myself"}, "Venus::String")

=cut

$test->for('example', 2, 'make_attr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::String');
  ok $result->get eq "myself";

  $result
});

=method make_into

The make_into method attempts to build and return an object based on the
class name and value provided, unless the value provided is already an object
derived from the specified class.

=signature make_into

  make_into(Str $class, Any $value) (Object)

=metadata make_into

{
  since => '1.30',
}

=example-1 make_into

  package main;

  my $person = Person->new;

  my $friend = $person->make_into('Person', {
    name => 'friend',
  });

  # bless({...}, 'Person')

=cut

$test->for('example', 1, 'make_into', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->name->isa('Venus::String');
  is $result->name->value, 'friend';

  $result
});

=method make_onto

The make_onto method attempts to build and assign an object based on the
class name and value provided, as the value corresponding to the name
specified, in the data provided. If the C<$value> is omitted, the value
corresponding to the name in the C<$data> will be used.

=signature make_onto

  make_onto(HashRef $data, Str $name, Str $class, Any $value) (Object)

=metadata make_onto

{
  since => '1.30',
}

=example-1 make_onto

  package main;

  my $person = Person->new;

  my $data = { friend => { name => 'friend' } };

  my $friend = $person->make_onto($data, 'friend', 'Person');

  # bless({...}, 'Person'),

  # $data was updated
  #
  # {
  #   friend => bless({...}, 'Person'),
  # }

=cut

$test->for('example', 1, 'make_onto', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->name->isa('Venus::String');
  is $result->name->value, 'friend';

  $result
});

=example-2 make_onto

  package Player;

  use Venus::Class;

  with 'Venus::Role::Makeable';

  attr 'name';
  attr 'teammates';

  sub makers {
    {
      teammates => 'Person',
    }
  }

  sub make_into_person {
    my ($self, $class, $value) = @_;

    return $class->make($value);
  }

  sub make_into_venus_string {
    my ($self, $class, $value) = @_;

    return $class->make($value);
  }

  sub make_teammates {
    my ($self, $code, $class, $value) = @_;

    return [map $self->$code($class, $_), @$value];
  }

  package main;

  my $player = Player->new;

  my $data = { teammates => [{ name => 'player2' }, { name => 'player3' }] };

  my $teammates = $player->make_onto($data, 'teammates', 'Person');

  # [bless({...}, 'Person'), bless({...}, 'Person')]

  # $data was updated
  #
  # {
  #   teammates => [bless({...}, 'Person'), bless({...}, 'Person')],
  # }

=cut

$test->for('example', 2, 'make_onto', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->[0]->isa('Person');
  is $result->[0]->name, 'player2';
  ok $result->[1]->isa('Person');
  is $result->[1]->name, 'player3';

  $result
});

=method makers

The makers method, if defined, is called during object construction, or by the
L</making> method, and returns key/value pairs where the keys map to class
attributes (or input parameters) and the values are L<Venus::Space> compatible
package names.

=signature makers

  makers() (HashRef)

=metadata makers

{
  since => '1.30',
}

=example-1 makers

  package main;

  my $person = Person->new(
    name => 'me',
  );

  my $makers = $person->makers;

  # {
  #   father   => "Person",
  #   mother   => "Person",
  #   name     => "Venus/String",
  #   siblings => "Person",
  # }

=cut

$test->for('example', 1, 'makers', sub {
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

=method making

The making method is called automatically during object construction but can
be called manually as well, and is passed a hashref to make and return.

=signature making

  making(HashRef $data) (HashRef)

=metadata making

{
  since => '1.30',
}

=example-1 making

  package main;

  my $person = Person->new;

  my $making = $person->making({
    name => 'me',
  });

  # $making
  # {...}

  # $making->{name}
  # bless({...}, 'Venus::String')

  # $making->{father}
  # undef

  # $making->{mother}
  # undef

  # $making->{siblings}
  # undef

=cut

$test->for('example', 1, 'making', sub {
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

=example-2 making

  package main;

  my $person = Person->new;

  my $making = $person->making({
    name => 'me',
    mother => {name => 'mother'},
    siblings => [{name => 'brother'}, {name => 'sister'}],
  });

  # $making
  # {...}

  # $making->{name}
  # bless({...}, 'Venus::String')

  # $making->{father}
  # undef

  # $making->{mother}
  # bless({...}, 'Person')

  # $making->{siblings}
  # [bless({...}, 'Person'), bless({...}, 'Person'), ...]

=cut

$test->for('example', 2, 'making', sub {
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
  ok $result->{mother}->does('Venus::Role::Makeable');
  ok $result->{mother}->name('Venus::String');

  # $result->siblings
  ok ref($result->{siblings}) eq 'ARRAY';
  ok $result->{siblings}->[0]->isa('Person');
  ok $result->{siblings}->[0]->does('Venus::Role::Makeable');
  ok $result->{siblings}->[0]->name('Venus::String');
  ok $result->{siblings}->[1]->isa('Person');
  ok $result->{siblings}->[1]->does('Venus::Role::Makeable');
  ok $result->{siblings}->[1]->name('Venus::String');

  $result
});

# END

$test->render('lib/Venus/Role/Makeable.pod') if $ENV{RENDER};

ok 1 and done_testing;
