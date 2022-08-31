package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Error

=cut

$test->for('name');

=tagline

Error Class

=cut

$test->for('tagline');

=abstract

Error Class for Perl 5

=cut

$test->for('abstract');

=includes

method: as
method: explain
method: frame
method: frames
method: is
method: of
method: throw
method: trace

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Error;

  my $error = Venus::Error->new;

  # $error->throw;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package represents a context-aware error (exception object).

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Explainable
Venus::Role::Stashable

=cut

$test->for('integrates');

=attributes

name: rw, opt, Str
context: rw, opt, Str, C<'(None)'>
message: rw, opt, Str, C<'Exception!'>
verbose: rw, opt, Int, C<1>

=cut

$test->for('attributes');

=method as

The as method returns an error object using the return value(s) of the "as"
method specified, which should be defined as C<"as_${name}">, which will be
called automatically by this method. If no C<"as_${name}"> method exists, this
method will set the L</name> attribute to the value provided.

=signature as

  as(Str $name) (Error)

=metadata as

{
  since => '1.02',
}

=example-1 as

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('message', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('message', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->message eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->message eq 'role_error';
  }

  package main;

  my $error = System::Error->new->as('auth_error');

  $error->throw;

  # Exception! (isa Venus::Error)

=cut

$test->for('example', 1, 'as', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('System::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'auth_error';

  $result
});

=example-2 as

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('message', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('message', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->message eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->message eq 'role_error';
  }

  package main;

  my $error = System::Error->new->as('role_error');

  $error->throw;

  # Exception! (isa Venus::Error)

=cut

$test->for('example', 2, 'as', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('System::Error');
  ok $error->isa('Venus::Error');
  ok $error->message eq 'role_error';

  $result
});

=example-3 as

  package Virtual::Error;

  use Venus::Class;

  base 'Venus::Error';

  package main;

  my $error = Virtual::Error->new->as('on_save_error');

  $error->throw;

  # name is "on_save_error"

  # Exception! (isa Venus::Error)

=cut

$test->for('example', 3, 'as', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Virtual::Error');
  ok $error->isa('Venus::Error');
  ok $error->name eq 'on_save_error';

  $result
});

=example-4 as

  package Virtual::Error;

  use Venus::Class;

  base 'Venus::Error';

  package main;

  my $error = Virtual::Error->new->as('on.SAVE.error');

  $error->throw;

  # name is "on_save_error"

  # Exception! (isa Venus::Error)

=cut

$test->for('example', 4, 'as', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Virtual::Error');
  ok $error->isa('Venus::Error');
  ok $error->name eq 'on_save_error';

  $result
});

=method explain

The explain method returns the error message and is used in stringification
operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $error->explain;

  # "Exception! in ...

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ /^Exception! /;

  $result
});

=method frame

The frame method returns the data from C<caller> on the frames captured, and
returns a hashref where the keys map to the keys described by
L<perlfunc/caller>.

=signature frame

  frame(Int $index) (HashRef)

=metadata frame

{
  since => '1.11',
}

=example-1 frame

  # given: synopsis;

  my $frame = $error->frame;

  # {
  #   'bitmask' => '...',
  #   'evaltext' => '...',
  #   'filename' => '...',
  #   'hasargs' => '...',
  #   'hinthash' => '...',
  #   'hints' => '...',
  #   'is_require' => '...',
  #   'line' => '...',
  #   'package' => '...',
  #   'subroutine' => '...',
  #   'wantarray' => '...',
  # }

=cut

$test->for('example', 1, 'frame', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok exists $result->{bitmask};
  ok exists $result->{evaltext};
  ok exists $result->{filename};
  ok exists $result->{hasargs};
  ok exists $result->{hinthash};
  ok exists $result->{hints};
  ok exists $result->{is_require};
  ok exists $result->{line};
  ok exists $result->{package};
  ok exists $result->{subroutine};
  ok exists $result->{wantarray};

  $result
});

=example-2 frame

  # given: synopsis;

  my $frame = $error->frame(1);

  # {
  #   'bitmask' => '...',
  #   'evaltext' => '...',
  #   'filename' => '...',
  #   'hasargs' => '...',
  #   'hinthash' => '...',
  #   'hints' => '...',
  #   'is_require' => '...',
  #   'line' => '...',
  #   'package' => '...',
  #   'subroutine' => '...',
  #   'wantarray' => '...',
  # }

=cut

$test->for('example', 2, 'frame', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok exists $result->{bitmask};
  ok exists $result->{evaltext};
  ok exists $result->{filename};
  ok exists $result->{hasargs};
  ok exists $result->{hinthash};
  ok exists $result->{hints};
  ok exists $result->{is_require};
  ok exists $result->{line};
  ok exists $result->{package};
  ok exists $result->{subroutine};
  ok exists $result->{wantarray};

  $result
});

=method frames

The frames method returns the compiled and stashed stack trace data.

=signature frames

  frames() (ArrayRef)

=metadata frames

{
  since => '0.01',
}

=example-1 frames

  # given: synopsis;

  my $frames = $error->frames;

  # [
  #   ...
  #   [
  #     "main",
  #     "t/Venus_Error.t",
  #     ...
  #   ],
  # ]

=cut

$test->for('example', 1, 'frames', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  my $last_frame = $result->[-1];
  ok $last_frame->[0] eq 'main';
  ok $last_frame->[1] =~ m{t/Venus_Error.t$};

  $result
});

=method is

The is method returns truthy or falsy based on the return value(s) of the "is"
method specified, which should be defined as C<"is_${name}">, which will be
called automatically by this method. If no C<"is_${name}"> method exists, this
method will check if the L</name> attribute is equal to the value provided.

=signature is

  is(Str $name) (Bool)

=metadata is

{
  since => '1.02',
}

=example-1 is

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('message', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('message', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->message eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->message eq 'role_error';
  }

  package main;

  my $is = System::Error->new->as('auth_error')->is('auth_error');

  # 1

=cut

$test->for('example', 1, 'is', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 is

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('message', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('message', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->message eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->message eq 'role_error';
  }

  package main;

  my $is = System::Error->as('auth_error')->is('auth_error');

  # 1

=cut

$test->for('example', 2, 'is', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-3 is

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('message', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('message', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->message eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->message eq 'role_error';
  }

  package main;

  my $is = System::Error->as('auth_error')->is('role_error');

  # 0

=cut

$test->for('example', 3, 'is', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-4 is

  package Virtual::Error;

  use Venus::Class;

  base 'Venus::Error';

  package main;

  my $is = Virtual::Error->new->as('on_save_error')->is('on_save_error');

  # 1

=cut

$test->for('example', 4, 'is', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-5 is

  package Virtual::Error;

  use Venus::Class;

  base 'Venus::Error';

  package main;

  my $is = Virtual::Error->new->as('on.SAVE.error')->is('on_save_error');

  # 1

=cut

$test->for('example', 5, 'is', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method of

The of method returns truthy or falsy based on the return value(s) of the "of"
method specified, which should be defined as C<"of_${name}">, which will be
called automatically by this method. If no C<"of_${name}"> method exists, this
method will check if the L</name> attribute contains the value provided.

=signature of

  of(Str $name) (Bool)

=metadata of

{
  since => '1.11',
}

=example-1 of

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('name', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('name', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->name eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->name eq 'role_error';
  }

  package main;

  my $of = System::Error->as('auth_error')->of('role');

  # 0

=cut

$test->for('example', 1, 'of', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-2 of

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('name', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('name', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->name eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->name eq 'role_error';
  }

  package main;

  my $of = System::Error->as('auth_error')->of('auth');

  # 1

=cut

$test->for('example', 2, 'of', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-3 of

  package System::Error;

  use Venus::Class;

  base 'Venus::Error';

  sub as_auth_error {
    my ($self) = @_;

    return $self->do('name', 'auth_error');
  }

  sub as_role_error {
    my ($self) = @_;

    return $self->do('name', 'role_error');
  }

  sub is_auth_error {
    my ($self) = @_;

    return $self->name eq 'auth_error';
  }

  sub is_role_error {
    my ($self) = @_;

    return $self->name eq 'role_error';
  }

  package main;

  my $of = System::Error->as('auth_error')->of('role_error');

  # 0

=cut

$test->for('example', 3, 'of', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-4 of

  package Virtual::Error;

  use Venus::Class;

  base 'Venus::Error';

  package main;

  my $of = Virtual::Error->new->as('on_save_error')->of('on.save');

  # 1

=cut

$test->for('example', 4, 'of', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-5 of

  package Virtual::Error;

  use Venus::Class;

  base 'Venus::Error';

  package main;

  my $of = Virtual::Error->new->as('on.SAVE.error')->of('on.save');

  # 1

=cut

$test->for('example', 5, 'of', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method throw

The throw method throws an error if the invocant is an object, or creates an
error object using the arguments provided and throws the created object.

=signature throw

  throw(Any @data) (Error)

=metadata throw

{
  since => '0.01',
}

=example-1 throw

  # given: synopsis;

  my $throw = $error->throw;

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 1, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Error');

  $result
});

=method trace

The trace method compiles a stack trace and returns the object. By default it
skips the first frame.

=signature trace

  trace(Int $offset, Int $limit) (Error)

=metadata trace

{
  since => '0.01',
}

=example-1 trace

  # given: synopsis;

  my $trace = $error->trace;

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 1, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok @{$result->frames} > 0;

  $result
});

=example-2 trace

  # given: synopsis;

  my $trace = $error->trace(0, 1);

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 2, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok @{$result->frames} == 1;

  $result
});

=example-3 trace

  # given: synopsis;

  my $trace = $error->trace(0, 2);

  # bless({ ... }, 'Venus::Error')

=cut

$test->for('example', 3, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Error');
  ok @{$result->frames} == 2;

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $error eq 'Exception!';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $error ne 'exception!';

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $test = 'Exception!' =~ qr/$error/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$error";

  # "Exception!"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ 'Exception!';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $error ~~ 'Exception!';

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

# END

$test->render('lib/Venus/Error.pod') if $ENV{RENDER};

ok 1 and done_testing;