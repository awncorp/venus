package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Space;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

my $pkgs = Venus::Space->new('Person');

=name

Venus::Role::Optional

=cut

$test->for('name');

=tagline

Optional Role

=cut

$test->for('tagline');

=abstract

Optional Role for Perl 5

=cut

$test->for('abstract');

=includes

method: clear
method: has
method: reset

=cut

$test->for('includes');

=synopsis

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');

  $result
});

=description

This package modifies the consuming package and provides methods for automating
object construction and attribute accessors.

=cut

$test->for('description');

=method clear

The clear method deletes an attribute and returns the removed value.

=signature clear

  clear(Str $name) (Any)

=metadata clear

{
  since => '1.55',
}

=example-1 clear

  # given: synopsis

  package main;

  my $fname = $person->clear('fname');

  # "Elliot"

=cut

$test->for('example', 1, 'clear', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Elliot";

  $result
});

=example-2 clear

  # given: synopsis

  package main;

  my $lname = $person->clear('lname');

  # "Alderson"

  my $object = $person;

  # bless({fname => "Elliot"}, "Person")

=cut

$test->for('example', 2, 'clear', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok exists $result->{fname};
  ok !exists $result->{lname};
  is_deeply $result, {fname => 'Elliot'};

  $result
});

=example-3 clear

  # given: synopsis

  package main;

  my $lname = $person->clear('lname');

  # "Alderson"

=cut

$test->for('example', 3, 'clear', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Alderson";

  $result
});

=method has

The has method returns truthy if the attribute specified exists, otherwise
returns falsy.

=signature has

  has(Str $name) (Boolean)

=metadata has

{
  since => '1.55',
}

=example-1 has

  # given: synopsis

  package main;

  my $has_fname = $person->has('fname');

  # true

=cut

$test->for('example', 1, 'has', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-2 has

  # given: synopsis

  package main;

  my $has_mname = $person->has('mname');

  # false

=cut

$test->for('example', 2, 'has', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method reset

The reset method rebuilds an attribute and returns the deleted value.

=signature reset

  reset(Str $name) (Any)

=metadata reset

{
  since => '1.55',
}

=example-1 reset

  # given: synopsis

  package main;

  my $fname = $person->reset('fname');

  # "Elliot"

=cut

$test->for('example', 1, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Elliot';

  $result
});

=example-2 reset

  # given: synopsis

  package main;

  my $lname = $person->reset('lname');

  # "Alderson"

  my $object = $person;

  # bless({fname => "Elliot"}, "Person")

=cut

$test->for('example', 2, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok exists $result->{fname};
  ok !exists $result->{lname};
  is_deeply $result, {fname => 'Elliot'};

  $result
});

=example-3 reset

  # given: synopsis

  package main;

  my $lname = $person->reset('lname', 'Smith');

  # "Alderson"

  my $object = $person;

  # bless({fname => "Elliot", lname => "Smith"}, "Person")

=cut

$test->for('example', 3, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok exists $result->{fname};
  ok exists $result->{lname};
  is_deeply $result, {fname => 'Elliot', lname => 'Smith'};

  $result
});

=feature asserting

This library provides a mechanism for automatically validating class attributes
using L<Venus::Assert> based on the return value of the attribute callback. The
callback should be in the form of C<assert_${name}>, and should return a
L<Venus::Assert> object or a "validation expression" (string) to be passed to
the L<Venus::Assert/expression> method.

=cut

$test->for('feature', 'asserting');

=example-1 asserting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub assert_fname {
    return 'string';
  }

  sub assert_lname {
    return 'string';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

=cut

$pkgs->unload;

$test->for('example', 1, 'asserting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->fname eq 'Elliot';
  ok $result->lname eq 'Alderson';
  ok !defined $result->email;

  $result
});

=example-2 asserting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub assert_fname {
    return 'string';
  }

  sub assert_lname {
    return 'string';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 1234567890,
  );

  # Exception! (isa Venus::Assert::Error)

=cut

$pkgs->unload;

$test->for('example', 2, 'asserting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->is('on.validate');
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ /Person\.lname/i;

  $result
});

=example-3 asserting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub assert_fname {
    return 'string';
  }

  sub assert_lname {
    return 'string';
  }

  package main;

  my $person = Person->new(
    fname => 1234567890,
    lname => 'Alderson',
  );

  # Exception! (isa Venus::Assert::Error)

=cut

$pkgs->unload;

$test->for('example', 3, 'asserting', sub {
  my ($tryable) = @_;
  my $error;
  ok my $result = $tryable->error(\$error)->result;
  ok $error->is('on.validate');
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ /Person\.fname/i;

  $result
});

=example-4 asserting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'progress';

  sub assert_progress {
    return 'number | float';
  }

  package main;

  my $person = Person->new(
    progress => 1,
  );

  # bless({progress => 1}, 'Person')

  # my $person = Person->new(
  #   progress => 7.89,
  # );

  # bless({progress => 7.89}, 'Person')

  # my $person = Person->new(
  #   progress => '1',
  # );

  # Exception! (isa Venus::Assert::Error)

=cut

$pkgs->unload;

$test->for('example', 4, 'asserting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('progress');
  ok $result->progress eq 1;
  my $person = Person->new(progress => 7.89);
  ok $person->isa('Person');
  ok $person->does('Venus::Role::Optional');
  ok $person->can('progress');
  ok $person->progress eq 7.89;
  my $error = catch { Person->new(progress => '1') };
  ok $error;
  ok $error->is('on.validate');
  ok $error->isa('Venus::Assert::Error');
  ok $error->message =~ /Person\.progress/i;
  ok $error->message =~ /received \(string\), expected \(number OR float\)/i;

  $result
});

=feature building

This library provides a mechanism for automatically building class attributes
on construction, and during getting and setting its value, after any default
values are processed, based on the return value of the attribute callback. The
callback should be in the form of C<build_${name}>, and is passed any arguments
provided.

=cut

$test->for('feature', 'building');

=example-1 building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub build_fname {
    my ($self, $value) = @_;
    return $value ? ucfirst $value : undef;
  }

  sub build_lname {
    my ($self, $value) = @_;
    return $value ? ucfirst $value : undef;
  }

  sub build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : undef;
  }

  package main;

  my $person = Person->new(
    fname => 'elliot',
    lname => 'alderson',
    email => 'E.ALDERSON@E-CORP.org',
  );

  # bless({fname => 'Elliot', lname => 'Alderson', ...}, 'Person')

  # $person->fname;

  # "Elliot"

  # $person->lname;

  # "Alderson"

  # $person->email;

  # "e.alderson@e-corp.org"

=cut

$pkgs->unload;

$test->for('example', 1, 'building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->{fname} eq 'Elliot';
  ok $result->{fname} = 'elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok $result->{lname} = 'alderson';
  ok $result->lname eq 'Alderson';
  ok $result->{email} eq 'e.alderson@e-corp.org';
  ok $result->{email} = 'E.ALDERSON@E-CORP.org';
  ok $result->email eq 'e.alderson@e-corp.org';

  $result
});

=example-2 building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub build_fname {
    my ($self, $value) = @_;
    return $value ? ucfirst $value : undef;
  }

  sub build_lname {
    my ($self, $value) = @_;
    return $value ? ucfirst $value : undef;
  }

  sub build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : undef;
  }

  package Person;

  sub build_email {
    my ($self, $value) = @_;
    return lc join '@', (join '.', substr($self->fname, 0, 1), $self->lname),
      'e-corp.org';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # $person->email;

  # "e.alderson@e-corp.org"

=cut

$pkgs->unload;

$test->for('example', 2, 'building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->fname eq 'Elliot';
  ok $result->lname eq 'Alderson';
  ok $result->email eq 'e.alderson@e-corp.org';

  $result
});

=example-3 building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';

  sub build_fname {
    my ($self, $value) = @_;
    return $value ? ucfirst $value : undef;
  }

  sub coerce_fname {
    return 'Venus::String';
  }

  sub build_lname {
    my ($self, $value) = @_;
    return $value ? ucfirst $value : undef;
  }

  sub coerce_lname {
    return 'Venus::String';
  }

  package main;

  my $person = Person->new(
    fname => 'elliot',
    lname => 'alderson',
  );

  # bless({
  #   fname => bless({value => 'Elliot'}, 'Venus::String'),
  #   lname => bless({value => 'Alderson'}, 'Venus::String')
  # }, 'Person')

=cut

$pkgs->unload;

$test->for('example', 3, 'building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->fname->isa('Venus::String');
  ok $result->fname eq 'Elliot';
  ok $result->lname->isa('Venus::String');
  ok $result->lname eq 'Alderson';

  $result
});

=example-4 building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : undef;
  }

  sub coerce_email {
    return 'Venus::String';
  }

  package main;

  my $person = Person->new(
    email => 'Elliot.Alderson@e-corp.org',
  );

  # bless({
  #   email => bless({value => 'elliot.alderson@e-corp.org'}, 'Venus::String'),
  # }, 'Person')

=cut

$pkgs->unload;

$test->for('example', 4, 'building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok $result->email->isa('Venus::String');
  ok $result->email eq 'elliot.alderson@e-corp.org';

  $result
});

=example-5 building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : undef;
  }

  sub default_email {
    return 'NO-REPLY@E-CORP.ORG';
  }

  package main;

  my $person = Person->new;

  # bless({email => 'no-reply@e-corp.org'}, 'Person')

=cut

$pkgs->unload;

$test->for('example', 5, 'building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok $result->email eq 'no-reply@e-corp.org';

  $result
});

=feature checking

This library provides a mechanism for automatically checking class attributes
after getting or setting its value. The callback should be in the form of
C<check_${name}>, and is passed any arguments provided.

=cut

$test->for('feature', 'checking');

=example-1 checking

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub check_fname {
    my ($self, $value) = @_;
    if ($value) {
      return true if lc($value) eq 'elliot';
    }
    return false;
  }

  sub check_lname {
    my ($self, $value) = @_;
    if ($value) {
      return true if lc($value) eq 'alderson';
    }
    return false;
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

=cut

$pkgs->unload;

$test->for('example', 1, 'checking', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->fname eq 'Elliot';
  ok $result->lname eq 'Alderson';

  $result
});

=example-2 checking

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub check_fname {
    my ($self, $value) = @_;
    if ($value) {
      return true if lc($value) eq 'elliot';
    }
    return false;
  }

  sub check_lname {
    my ($self, $value) = @_;
    if ($value) {
      return true if lc($value) eq 'alderson';
    }
    return false;
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # $person->lname('Alderson');

  # "Alderson"

  # $person->lname('');

  # Exception! (isa Person::Error)

=cut

$pkgs->unload;

$test->for('example', 2, 'checking', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->lname('Alderson') eq 'Alderson';
  my $error = catch { $result->lname('') };
  ok $error;
  ok $error->is('on.check');
  ok $error->isa('Person::Error');
  ok $error->message =~ /checking attribute value failed/i;

  $result
});

=feature coercing

This library provides a mechanism for automatically coercing class attributes
into class instances using L<Venus::Space> based on the return value of the
attribute callback. The callback should be in the form of C<coerce_${name}>,
and should return the name of the package to be constructed. That package will
be instantiated via the customary C<new> method, passing the data recevied as
its arguments.

=cut

$test->for('feature', 'coercing');

=example-1 coercing

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub coerce_fname {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  sub coerce_lname {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  sub coerce_email {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({
  #   'fname' => bless({'value' => 'Elliot'}, 'Venus::String'),
  #   'lname' => bless({'value' => 'Alderson'}, 'Venus::String')
  # }, 'Person')

=cut

 $pkgs->unload;

$test->for('example', 1, 'coercing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->fname->isa('Venus::String');
  ok $result->fname->get eq 'Elliot';
  ok $result->lname->isa('Venus::String');
  ok $result->lname->get eq 'Alderson';
  ok !$result->email;

  $result
});

=example-2 coercing

  package Person;

  use Venus::Class;
  use Venus::String;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub coerce_fname {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  sub coerce_lname {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  sub coerce_email {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  package main;

  my $person = Person->new(
    email => 'e.alderson@e-corp.org',
  );

  # bless({
  #   'email' => bless({'value' => 'e.alderson@e-corp.org'}, 'Venus::String'),
  # }, 'Person')

=cut

 $pkgs->unload;

$test->for('example', 2, 'coercing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok !$result->fname;
  ok !$result->lname;
  ok $result->email->isa('Venus::String');
  ok $result->email->get eq 'e.alderson@e-corp.org';

  $result
});

=example-3 coercing

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub coerce_email {
    my ($self, $value) = @_;

    return 'Venus::String';
  }

  sub default_email {
    my ($self, $value) = @_;

    return 'no-reply@e-corp.org';
  }

  package main;

  my $person = Person->new;

  # bless({
  #   'email' => bless({'value' => 'no-reply@e-corp.org'}, 'Venus::String'),
  # }, 'Person')

=cut

$pkgs->unload;

$test->for('example', 3, 'coercing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok $result->email->isa('Venus::String');
  ok $result->email->get eq 'no-reply@e-corp.org';
  ok $result->email eq 'no-reply@e-corp.org';

  $result
});

=feature defaulting

This library provides a mechanism for automatically defaulting class attributes
to predefined values, statically or dynamically based on the return value of
the attribute callback. The callback should be in the form of
C<default_${name}>, and should return the value to be used if no value exists
or has been provided to the constructor.

=cut

$test->for('feature', 'defaulting');

=example-1 defaulting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub default_lname {
    my ($self, $value) = @_;

    return 'Alderson';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # $person->lname('Johnston');

  # "Johnston"

  # $person->reset('lname');

  # "Johnston"

  # $person->lname;

  # "Alderson"

=cut

$pkgs->unload;

$test->for('example', 1, 'defaulting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->{fname} eq 'Elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok $result->lname eq 'Alderson';
  ok !exists $result->{email};
  ok !$result->email;
  ok $result->lname('Johnston') eq 'Johnston';
  ok $result->reset('lname') eq 'Johnston';
  ok $result->lname eq 'Alderson';

  $result
});

=feature initialing

This library provides a mechanism for automatically setting class attributes to
predefined values, statically or dynamically based on the return value of the
attribute callback. The callback should be in the form of C<initial_${name}>,
and should return the value to be used if no value has been provided to the
constructor. This behavior is similar to the I<"defaulting"> mechanism but is
only executed during object construction.

=cut

$test->for('feature', 'initialing');

=example-1 initialing

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub initial_lname {
    my ($self, $value) = @_;

    return 'Alderson';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # $person->lname('Johnston');

  # "Johnston"

  # $person->reset('lname');

  # "Johnston"

  # $person->lname;

  # undef

=cut

$pkgs->unload;

$test->for('example', 1, 'initialing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->{fname} eq 'Elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok $result->lname eq 'Alderson';
  ok !exists $result->{email};
  ok !$result->email;
  ok $result->lname('Johnston') eq 'Johnston';
  ok $result->reset('lname') eq 'Johnston';
  ok !exists $result->{lname};
  ok !defined $result->lname;

  $result
});

=feature lazy-building

This library provides a mechanism for automatically building class attributes
during getting and setting its value, after any default values are processed,
based on the return value of the attribute callback. The callback should be in
the form of C<lazy_build_${name}>, and is passed any arguments provided.

=cut

$test->for('feature', 'lazy-building');

=example-1 lazy-building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub lazy_build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : 'no-reply@e-corp.org';
  }

  package main;

  my $person = Person->new;

  # bless({}, 'Person')

  # $person->email;

  # "no-reply@e-corp.org"

=cut

$pkgs->unload;

$test->for('example', 1, 'lazy-building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok !exists $result->{email};
  ok $result->email eq 'no-reply@e-corp.org';
  ok $result->{email} eq 'no-reply@e-corp.org';

  $result
});

=example-2 lazy-building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub coerce_email {
    return 'Venus::String';
  }

  sub lazy_build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : 'no-reply@e-corp.org';
  }

  package main;

  my $person = Person->new;

  # bless({}, 'Person')

  # $person->email;

  # bless({value => 'no-reply@e-corp.org'}, 'Venus::String')

=cut

$pkgs->unload;

$test->for('example', 2, 'lazy-building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok !exists $result->{email};
  ok $result->email->isa('Venus::String');
  ok $result->email eq 'no-reply@e-corp.org';

  $result
});

=example-3 lazy-building

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub default_email {
    return 'NO-REPLY@E-CORP.ORG';
  }

  sub lazy_build_email {
    my ($self, $value) = @_;
    return $value ? lc $value : undef;
  }

  package main;

  my $person = Person->new;

  # bless({}, 'Person')

  # $person->email;

  # "no-reply@e-corp.org"

=cut

$pkgs->unload;

$test->for('example', 3, 'lazy-building', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok $result->email eq 'no-reply@e-corp.org';

  $result
});

=feature reading

This library provides a mechanism for hooking into the class attribute reader
(accessor) for reading values via the the attribute reader callback. The
callback should be in the form of C<read_${name}>, and should read and return
the value for the attribute specified.

=cut

$test->for('feature', 'reading');

=example-1 reading

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub read_fname {
    my ($self, $value) = @_;

    return ucfirst $self->{fname};
  }

  sub read_lname {
    my ($self, $value) = @_;

    return ucfirst $self->{lname};
  }

  package main;

  my $person = Person->new(
    fname => 'elliot',
    lname => 'alderson',
  );

  # bless({fname => 'elliot', lname => 'alderson'}, 'Person')

  # $person->fname;

  # "Elliot"

  # $person->lname;

  # "Alderson"

=cut

$pkgs->unload;

$test->for('example', 1, 'reading', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->{fname} eq 'elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'alderson';
  ok $result->lname eq 'Alderson';

  $result
});

=feature writing

This library provides a mechanism for hooking into the class attribute writer
(accessor) for writing values via the the attribute writer callback. The
callback should be in the form of C<write_${name}>, and should set and return
the value for the attribute specified.

=cut

$test->for('feature', 'writing');

=example-1 writing

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub write_fname {
    my ($self, $value) = @_;

    return $self->{fname} = ucfirst $value;
  }

  sub write_lname {
    my ($self, $value) = @_;

    return $self->{lname} = ucfirst $value;
  }

  package main;

  my $person = Person->new;

  # bless({}, 'Person')

  # $person->fname('elliot');

  # "Elliot"

  # $person->lname('alderson');

  # "Alderson"

=cut

$pkgs->unload;

$test->for('example', 1, 'writing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok !exists $result->{fname};
  ok !exists $result->{lname};
  ok !exists $result->{email};
  ok $result->fname('elliot') eq 'Elliot';
  ok $result->{fname} eq 'Elliot';
  ok $result->lname('alderson') eq 'Alderson';
  ok $result->{lname} eq 'Alderson';

  $result
});

=feature self-asserting

This library provides a mechanism for automatically validating class attributes
using the attribute callback provided. The author is resposible for validating
the state of the attribute and raising an exception when an attribute fails
validation. The callback should be in the form of C<self_assert_${name}>.

=cut

$test->for('feature', 'self-asserting');

=example-1 self-asserting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';

  sub self_assert_fname {
    my ($self, $value) = @_;
    die 'Bad fname' if $value && $value !~ '^[a-zA-Z]';
  }

  sub self_assert_lname {
    my ($self, $value) = @_;
    die 'Bad lname' if $value && $value !~ '^[a-zA-Z]';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # my $person = Person->new(fname => '@ElliotAlderson');

  # Exception! (isa Venus::Error)

=cut

$pkgs->unload;

$test->for('example', 1, 'self-asserting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->{fname} eq 'Elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok $result->lname eq 'Alderson';
  my $error = catch { Person->new(fname => '@ElliotAlderson') };
  ok $error;
  ok $error->isa('Venus::Error');
  ok $error->message =~ 'Bad fname';

  $result
});

=example-2 self-asserting

  package Person;

  use Venus::Class 'attr', 'raise', 'with';

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';

  sub self_assert_fname {
    my ($self, $value) = @_;
    raise 'Person::Error::BadFname' if $value && $value !~ '^[a-zA-Z]';
  }

  sub self_assert_lname {
    my ($self, $value) = @_;
    raise 'Person::Error::BadLname' if $value && $value !~ '^[a-zA-Z]';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # my $person = Person->new(lname => '@AldersonElliot');

  # Exception! (isa Person::Error::BadLname, isa Venus::Error)

=cut

$pkgs->unload;

$test->for('example', 2, 'self-asserting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->{fname} eq 'Elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok $result->lname eq 'Alderson';
  my $error = catch { Person->new(lname => '@AldersonElliot') };
  ok $error;
  ok $error->isa('Person::Error::BadLname');
  ok $error->isa('Venus::Error');
  ok $error->message =~ 'Exception!';

  $result
});

=example-3 self-asserting

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';

  sub self_assert_fname {
    my ($self, $value) = @_;
    die $self if $value && $value !~ '^[a-zA-Z]';
  }

  sub self_assert_lname {
    my ($self, $value) = @_;
    die $self if $value && $value !~ '^[a-zA-Z]';
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  # my $person = Person->new(fname => rand);

  # Exception! (isa Person)

=cut

$pkgs->unload;

$test->for('example', 3, 'self-asserting', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->{fname} eq 'Elliot';
  ok $result->fname eq 'Elliot';
  ok $result->{lname} eq 'Alderson';
  ok $result->lname eq 'Alderson';
  my $error = catch { Person->new(fname => rand) };
  ok $error;
  ok $error->isa('Person');
  ok !$error->isa('Venus::Error');

  $result
});

=feature self-coercing

This library provides a mechanism for automatically coercing class attributes
using the attribute callback provided. The author is resposible for any
transformations to the attribute and value. The callback should be in the form
of C<self_coerce_${name}>.

=cut

$test->for('feature', 'self-coercing');

=example-1 self-coercing

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';

  sub self_coerce_fname {
    my ($self, $value) = @_;

    require Venus::String;

    return Venus::String->new($value || '');
  }

  sub self_coerce_lname {
    my ($self, $value) = @_;

    require Venus::String;

    return Venus::String->new($value || '');
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({
  #   fname => bless({value => 'Elliot'}, 'Venus::String'),
  #   lname => bless({value => 'Alderson'}, 'Venus::String')
  # }, 'Person')

=cut

$pkgs->unload;

$test->for('example', 1, 'self-coercing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->fname->isa('Venus::String');
  ok $result->fname eq 'Elliot';
  ok $result->lname->isa('Venus::String');
  ok $result->lname eq 'Alderson';

  $result
});

=example-2 self-coercing

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'email';

  sub default_email {
    my ($self, $value) = @_;

    return 'no-reply@e-corp.org';
  }

  sub self_coerce_email {
    my ($self, $value) = @_;

    require Venus::String;

    return Venus::String->new($value || '');
  }

  package main;

  my $person = Person->new;

  # bless({
  #   'email' => bless({'value' => 'no-reply@e-corp.org'}, 'Venus::String'),
  # }, 'Person')

=cut

$pkgs->unload;

$test->for('example', 2, 'self-coercing', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('email');
  ok $result->email->isa('Venus::String');
  ok $result->email->get eq 'no-reply@e-corp.org';
  ok $result->email eq 'no-reply@e-corp.org';

  $result
});

=feature triggering

This library provides a mechanism for automatically triggering routines after
reading or writing class attributes via an attribute callback. The callback
should be in the form of C<trigger_${name}>, and will be invoked after the
related attribute is read or written.

=cut

$test->for('feature', 'triggering');

=example-1 triggering

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub trigger_fname {
    my ($self, $value) = @_;

    if ($value) {
      $self->{dirty}{fname} = $value;
    }
    return;
  }

  sub trigger_lname {
    my ($self, $value) = @_;

    if ($value) {
      $self->{dirty}{lname} = $value;
    }
    return;
  }

  package main;

  my $person = Person->new;

  # bless({}, 'Person')

  # $person->fname('Elliot');

  # "Elliot"

  # $person->lname('Alderson');

  # "Alderson"

  # my $object = $person;

  # bless({..., dirty => {fname => 'Elliot', lname => 'Alderson'}}, 'Person')

=cut

$pkgs->unload;

$test->for('example', 1, 'triggering', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok !exists $result->{fname};
  ok $result->fname('Elliot') eq 'Elliot';
  ok !exists $result->{lname};
  ok $result->lname('Alderson') eq 'Alderson';
  ok !exists $result->{email};
  is_deeply $result, {
    fname => 'Elliot',
    lname => 'Alderson',
    dirty => {
      fname => 'Elliot',
      lname => 'Alderson',
    },
  };

  $result
});

=feature readonly

This library provides a mechanism for marking class attributes as I<"readonly">
(or not) based on the return value of the attribute callback. The callback
should be in the form of C<readonly_${name}>, and should return truthy to
automatically throw an exception if a change is attempted.

=cut

$test->for('feature', 'readonly');

=example-1 readonly

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub readonly_fname {
    my ($self, $value) = @_;

    return true;
  }

  sub readonly_lname {
    my ($self, $value) = @_;

    return true;
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  $person->fname('Mister');

  # Exception! (isa Person::Error)

  # $person->lname('Johnston');

  # Exception! (isa Person::Error)

=cut

$pkgs->unload;

$test->for('example', 1, 'readonly', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->is('on.readonly');
  ok $error->isa('Person::Error');
  ok $error->isa('Venus::Error');
  ok $error->message =~ /setting read-only attribute/i;
  ok $error->stash('name') eq 'fname';

  $result
});

=feature readwrite

This library provides a mechanism for marking class attributes as I<"readwrite">
(or not) based on the return value of the attribute callback. The callback
should be in the form of C<readwrite_${name}>, and should return falsy to
automatically throw an exception if a change is attempted.

=cut

$test->for('feature', 'readwrite');

=example-1 readwrite

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub readwrite_fname {
    my ($self, $value) = @_;

    return false;
  }

  sub readwrite_lname {
    my ($self, $value) = @_;

    return false;
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

  $person->fname('Mister');

  # Exception! (isa Person::Error)

  # $person->lname('Johnston');

  # Exception! (isa Person::Error)

=cut

$pkgs->unload;

$test->for('example', 1, 'readwrite', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->is('on.readwrite');
  ok $error->isa('Person::Error');
  ok $error->isa('Venus::Error');
  ok $error->message =~ /setting read-only attribute/i;
  ok $error->stash('name') eq 'fname';

  $result
});

=feature requiring

This library provides a mechanism for marking class attributes as I<"required">
(i.e. to be provided to the constructor) based on the return value of the
attribute callback. The callback should be in the form of C<require_${name}>,
and should return truthy to automatically throw an exception if the related
attribute is missing.

=cut

$test->for('feature', 'requiring');

=example-1 requiring

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub require_fname {
    my ($self, $value) = @_;

    return true;
  }

  sub require_lname {
    my ($self, $value) = @_;

    return true;
  }

  sub require_email {
    my ($self, $value) = @_;

    return false;
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
    lname => 'Alderson',
  );

  # bless({fname => 'Elliot', lname => 'Alderson'}, 'Person')

=cut

$pkgs->unload;

$test->for('example', 1, 'requiring', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Person');
  ok $result->does('Venus::Role::Optional');
  ok $result->can('fname');
  ok $result->can('lname');
  ok $result->can('email');
  ok $result->fname eq 'Elliot';
  ok $result->lname eq 'Alderson';
  ok !$result->email;

  $result
});

=example-2 requiring

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub require_fname {
    my ($self, $value) = @_;

    return true;
  }

  sub require_lname {
    my ($self, $value) = @_;

    return true;
  }

  sub require_email {
    my ($self, $value) = @_;

    return false;
  }

  package main;

  my $person = Person->new(
    fname => 'Elliot',
  );

  # Exception! (isa Person::Error)

=cut

$pkgs->unload;

$test->for('example', 2, 'requiring', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->is('on.require');
  ok $error->isa('Person::Error');
  ok $error->isa('Venus::Error');
  ok $error->message =~ /missing required attribute/i;
  ok $error->stash('name') eq 'lname';

  $result
});

=example-3 requiring

  package Person;

  use Venus::Class;

  with 'Venus::Role::Optional';

  attr 'fname';
  attr 'lname';
  attr 'email';

  sub require_fname {
    my ($self, $value) = @_;

    return true;
  }

  sub require_lname {
    my ($self, $value) = @_;

    return true;
  }

  sub require_email {
    my ($self, $value) = @_;

    return false;
  }

  package main;

  my $person = Person->new(
    lname => 'Alderson',
  );

  # Exception! (isa Person::Error)

=cut

$pkgs->unload;

$test->for('example', 3, 'requiring', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->is('on.require');
  ok $error->isa('Person::Error');
  ok $error->isa('Venus::Error');
  ok $error->message =~ /missing required attribute/i;
  ok $error->stash('name') eq 'fname';

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Optional.pod') if $ENV{RENDER};

ok 1 and done_testing;
