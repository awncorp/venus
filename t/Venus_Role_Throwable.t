package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Throwable

=cut

$test->for('name');

=tagline

Throwable Role

=cut

$test->for('tagline');

=abstract

Throwable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: error
method: throw

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Throwable';

  package main;

  my $example = Example->new;

  # $example->throw;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Throwable');

  $result
});

=description

This package modifies the consuming package and provides a mechanism for
throwing context-aware errors (exceptions).

=cut

$test->for('description');

=method error

The error method dispatches to the L</throw> method, excepts a hashref of
options to be provided to the L</throw> method, and returns the result unless
an exception is raised automatically. If the C<throw> option is provided it is
excepted to be the name of a method used as a callback to provide arguments to
the thrower.

=signature error

  error(hashref $data) (any)

=metadata error

{
  since => '3.40',
}

=cut

=example-1 error

  package main;

  my $example = Example->new;

  my $throw = $example->error;

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';

  $result
});

=example-2 error

  package main;

  my $example = Example->new;

  my $throw = $example->error({package => 'Example::Error::Unknown'});

  # bless({ "package" => "Example::Error::Unknown", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error::Unknown';

  $result
});

=example-3 error

  package main;

  my $example = Example->new;

  my $throw = $example->error({
    name => 'on.example',
    capture => [$example],
    stash => {
      time => time,
    },
  });

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 3, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';
  is $result->name, 'on.example';
  ok $result->stash('captured');
  ok $result->stash('time');

  $result
});

=example-4 error

  # given: synopsis

  package Example;

  # ...

  sub error_on_example {
    my ($self) = @_;

    return {
      name => 'on.example',
      capture => [$example],
      stash => {
        time => time,
      },
    };
  }

  package main;

  my $throw = $example->error({throw => 'error_on_example'});

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 4, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';
  is $result->name, 'on.example';
  ok $result->stash('captured');
  ok $result->stash('time');

  $result
});

=example-5 error

  # given: synopsis

  package Example;

  # ...

  sub error_on_example {
    my ($self) = @_;

    return {
      name => 'on.example',
      capture => [$example],
      stash => {
        time => time,
      },
      raise => 1,
    };
  }

  package main;

  my $throw = $example->error({throw => 'error_on_example'});

  # Exception! (isa Example::Error)

=cut

$test->for('example', 5, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error->result;
  ok $result->isa('Example::Error');
  is $result->name, 'on_example';
  ok $result->stash('time');

  $result
});

=method throw

The throw method builds a L<Venus::Throw> object, which can raise errors
(exceptions). If passed a string representing a package name, the throw object
will be configured to throw an exception using that package name. If passed a
string representing a method name, the throw object will call that method
expecting a hashref to be returned which will be provided to L<Venus::Throw> as
arguments to configure the thrower. If passed a hashref, the keys and values
are expected to be method names and arguments which will be called to configure
the L<Venus::Throw> object returned. If passed additional arguments, assuming
they are preceeded by a string representing a method name, the additional
arguments will be supplied to the method when called. If the C<raise> argument
is provided (or returned from the callback), the thrower will automatically
throw the exception.

=signature throw

  throw(maybe[string | hashref] $data, any @args) (any)

=metadata throw

{
  since => '0.01',
}

=example-1 throw

  package main;

  my $example = Example->new;

  my $throw = $example->throw;

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 1, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';

  $result
});

=example-2 throw

  package main;

  my $example = Example->new;

  my $throw = $example->throw('Example::Error::Unknown');

  # bless({ "package" => "Example::Error::Unknown", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 2, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error::Unknown';

  $result
});

=example-3 throw

  package main;

  my $example = Example->new;

  my $throw = $example->throw({
    name => 'on.example',
    capture => [$example],
    stash => {
      time => time,
    },
  });

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 3, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';
  is $result->name, 'on.example';
  ok $result->stash('captured');
  ok $result->stash('time');

  $result
});

=example-4 throw

  # given: synopsis

  package Example;

  # ...

  sub error_on_example {
    my ($self) = @_;

    return {
      name => 'on.example',
      capture => [$example],
      stash => {
        time => time,
      },
    };
  }

  package main;

  my $throw = $example->throw('error_on_example');

  # bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

  # $throw->error;

=cut

$test->for('example', 4, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Throw');
  ok $result->package eq 'Example::Error';
  is $result->name, 'on.example';
  ok $result->stash('captured');
  ok $result->stash('time');

  $result
});

=example-5 throw

  # given: synopsis

  package Example;

  # ...

  sub error_on_example {
    my ($self) = @_;

    return {
      name => 'on.example',
      capture => [$example],
      stash => {
        time => time,
      },
      raise => 1,
    };
  }

  package main;

  my $throw = $example->throw('error_on_example');

  # Exception! (isa Example::Error)

=cut

$test->for('example', 5, 'throw', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error->result;
  ok $result->isa('Example::Error');
  is $result->name, 'on_example';
  ok $result->stash('time');

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Throwable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;