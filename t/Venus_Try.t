package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Try

=cut

$test->for('name');

=tagline

Try Class

=cut

$test->for('tagline');

=abstract

Try Class for Perl 5

=cut

$test->for('abstract');

=includes

method: any
method: call
method: callback
method: catch
method: default
method: error
method: execute
method: finally
method: maybe
method: no_catch
method: no_default
method: no_finally
method: no_try
method: result

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    # try something

    return time;
  });

  $try->catch('Example::Error', sub {
    my ($caught) = @_;

    # caught an error (exception)

    return;
  });

  $try->default(sub {
    my ($caught) = @_;

    # catch the uncaught

    return;
  });

  $try->finally(sub {
    my (@args) = @_;

    # always run after try/catch

    return;
  });

  my @args;

  my $result = $try->result(@args);

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides an object-oriented interface for performing complex
try/catch operations.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=attributes

invocant: ro, opt, Object
arguments: ro, opt, ArrayRef
on_try: rw, opt, CodeRef
on_catch: rw, opt, ArrayRef[CodeRef], C<[]>
on_default: rw, opt, CodeRef
on_finally: rw, opt, CodeRef

=cut

$test->for('attributes');

=method any

The any method registers a default C<catch> condition that returns whatever
value was encoutered on error and returns it as a result.

=signature any

  any() (Venus::Try)

=metadata any

{
  since => '2.32',
}

=example-1 any

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    die 'Oops!';
  });

  my $any = $try->any;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'any', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $returned = scalar $result->result;
  like $returned, qr/Oops!/;

  $result
});

=example-2 any

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    die $try;
  });

  my $any = $try->any;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 2, 'any', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $returned = scalar $result->result;
  ok $returned->isa('Venus::Try');

  $result
});

=method call

The call method takes a method name or coderef, registers it as the tryable
routine, and returns the object. When invoked, the callback will received an
C<invocant> if one was provided to the constructor, the default C<arguments> if
any were provided to the constructor, and whatever arguments were provided by
the invocant.


=signature call

  call(string | coderef $method) (Venus::Try)

=metadata call

{
  since => '0.01',
}

=example-1 call

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  my $call = $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'call', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  is_deeply $result->result(1..4), [1..4];

  $result
});

=method callback

The callback method takes a method name or coderef, and returns a coderef for
registration. If a coderef is provided this method is mostly a passthrough.

=signature callback

  callback(string | coderef $method) (coderef)

=metadata callback

{
  since => '0.01',
}

=example-1 callback

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  my $callback = $try->callback(sub {
    my (@args) = @_;

    return [@args];
  });

  # sub { ... }

=cut

$test->for('example', 1, 'callback', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref $result, 'CODE';
  is_deeply $result->(1..4), [1..4];

  $result
});

=example-2 callback

  package Example1;

  sub new {
    bless {};
  }

  sub test {
    my (@args) = @_;

    return [@args];
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example1->new,
  );

  my $callback = $try->callback('test');

  # sub { ... }

=cut

$test->for('example', 2, 'callback', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is ref $result, 'CODE';
  is_deeply $result->(1..4), [1..4];

  $result
});

=example-3 callback

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  my $callback = $try->callback('missing_method');

  # Exception! (isa Venus::Try::Error) (see error_on_callback)

=cut

$test->for('example', 3, 'callback', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Try::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method catch

The catch method takes a package or ref name, and when triggered checks whether
the captured exception is of the type specified and if so executes the given
callback. If no callback is provided the exception is captured in a L</default>
operation and returned as a result.

=signature catch

  catch(string $isa, string | coderef $method) (Venus::Try)

=metadata catch

{
  since => '0.01',
}

=example-1 catch

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $catch = $try->catch('Venus::Try', sub {
    my (@args) = @_;

    return [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  is_deeply $result->result, [$result];

  $result
});

=example-2 catch

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    $try->throw->error;
  });

  my $catch = $try->catch('Venus::Try::Error', sub {

    return (@_);
  });

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 2, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  ok $result->result->isa('Venus::Try::Error');

  $result
});

=example-3 catch

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {

    $try->throw->error;
  });

  my $catch = $try->catch('Venus::Try::Error');

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 3, 'catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  ok $result->result->isa('Venus::Try::Error');

  $result
});

=method default

The default method takes a method name or coderef and is triggered if no
C<catch> conditions match the exception thrown.

=signature default

  default(string | coderef $method) (Venus::Try)

=metadata default

{
  since => '0.01',
}

=example-1 default

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $default = $try->default(sub {
    my (@args) = @_;

    return [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  is_deeply $result->result, [$result];

  $result
});

=method error

The error method takes a scalar reference and assigns any uncaught exceptions
to it during execution. If no variable is provided a L</catch> operation will
be registered to capture all L<Venus::Error> exceptions.

=signature error

  error(Ref $variable) (Venus::Try)

=metadata error

{
  since => '0.01',
}

=example-1 error

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $error = $try->error(\my $object);

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');

  $result
});

=example-2 error

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    $try->throw->error;
  });

  my $error = $try->error;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $returned = $result->result;
  ok $returned->isa('Venus::Try::Error');

  $result
});

=method execute

The execute method takes a coderef and executes it with any given arguments.
When invoked, the callback will received an C<invocant> if one was provided to
the constructor, the default C<arguments> if any were provided to the
constructor, and whatever arguments were passed directly to this method. This
method can return a list of values in list-context.

=signature execute

  execute(coderef $code, any @args) (any)

=metadata execute

{
  since => '0.01',
}

=example-1 execute

  package Example2;

  sub new {
    bless {};
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example2->new,
    arguments => [1,2,3],
  );

  my $execute = $try->execute(sub {
    my (@args) = @_;

    return [@args];
  });

  # [bless({}, "Example2"), 1, 2, 3]

=cut

$test->for('example', 1, 'execute', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result(4,5);
  ok $result->[0]->isa('Example2');
  is $result->[1], 1;
  is $result->[2], 2;
  is $result->[3], 3;

  $result
});

=method finally

The finally method takes a package or ref name and always executes the callback
after a try/catch operation. The return value is ignored. When invoked, the
callback will received an C<invocant> if one was provided to the constructor,
the default C<arguments> if any were provided to the constructor, and whatever
arguments were provided by the invocant.

=signature finally

  finally(string | coderef $method) (Venus::Try)

=metadata finally

{
  since => '0.01',
}

=example-1 finally

  package Example3;

  sub new {
    bless {};
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example3->new,
    arguments => [1,2,3],
  );

  $try->call(sub {
    my (@args) = @_;

    return $try;
  });

  my $finally = $try->finally(sub {
    my (@args) = @_;

    $try->{args} = [@args];
  });

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'finally', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $returned = $result->result(4,5);
  ok $returned->isa('Venus::Try');
  my $finally = $returned->{args};
  ok $finally->[0]->isa('Example3');
  is $finally->[1], 1;
  is $finally->[2], 2;
  is $finally->[3], 3;

  $result
});

=method maybe

The maybe method registers a default C<catch> condition that returns falsy,
i.e. an undefined value, if an exception is encountered.

=signature maybe

  maybe() (Venus::Try)

=metadata maybe

{
  since => '0.01',
}

=example-1 maybe

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $maybe = $try->maybe;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'maybe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  is scalar $result->result, undef;

  $result
});

=method no_catch

The no_catch method removes any configured catch conditions and returns the
object.

=signature no_catch

  no_catch() (Venus::Try)

=metadata no_catch

{
  since => '0.01',
}

=example-1 no_catch

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  $try->catch('Venus::Try', sub {
    my (@args) = @_;

    return [@args];
  });


  my $no_catch = $try->no_catch;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'no_catch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $error = do { eval { $result->result }; $@ };
  ok $error->isa('Venus::Try');

  $result
});

=method no_default

The no_default method removes any configured default condition and returns the
object.

=signature no_default

  no_default() (Venus::Try)

=metadata no_default

{
  since => '0.01',
}

=example-1 no_default

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    die $try;
  });

  my $default = $try->default(sub {
    my (@args) = @_;

    return [@args];
  });

  my $no_default = $try->no_default;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'no_default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $error = do { eval { $result->result }; $@ };
  ok $error->isa('Venus::Try');
  ok $result = $tryable->result;

  $result
});

=method no_finally

The no_finally method removes any configured finally condition and returns the
object.

=signature no_finally

  no_finally() (Venus::Try)

=metadata no_finally

{
  since => '0.01',
}

=example-1 no_finally

  package Example4;

  sub new {
    bless {};
  }

  package main;

  use Venus::Try;

  my $try = Venus::Try->new(
    invocant => Example4->new,
    arguments => [1,2,3],
  );

  $try->call(sub {
    my (@args) = @_;

    return $try;
  });

  $try->finally(sub {
    my (@args) = @_;

    $try->{args} = [@args];
  });

  my $no_finally = $try->no_finally;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'no_finally', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  my $returned = $result->result;
  ok $returned->isa('Venus::Try');
  ok not exists $returned->{args};

  $result
});

=method no_try

The no_try method removes any configured C<try> operation and returns the
object.

=signature no_try

  no_try() (Venus::Try)

=metadata no_try

{
  since => '0.01',
}

=example-1 no_try

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  my $no_try = $try->no_try;

  # bless({ on_catch => ... }, "Venus::Try")

=cut

$test->for('example', 1, 'no_try', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Try');
  ok not defined $result->on_try;

  $result
});

=method result

The result method executes the try/catch/default/finally logic and returns
either 1) the return value from the successfully tried operation 2) the return
value from the successfully matched catch condition if an exception was thrown
3) the return value from the default catch condition if an exception was thrown
and no catch condition matched. When invoked, the C<try> and C<finally>
callbacks will received an C<invocant> if one was provided to the constructor,
the default C<arguments> if any were provided to the constructor, and whatever
arguments were passed directly to this method. This method can return a list of
values in list-context.

=signature result

  result(any @args) (any)

=metadata result

{
  since => '0.01',
}

=example-1 result

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  my $result = $try->result;

  # []

=cut

$test->for('example', 1, 'result', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 result

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {
    my (@args) = @_;

    return [@args];
  });

  my $result = $try->result(1..5);

  # [1..5]

=cut

$test->for('example', 2, 'result', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1..5];

  $result
});

=example-3 result

  package main;

  use Venus::Try;

  my $try = Venus::Try->new;

  $try->call(sub {die});

  my $result = $try->result;

  # Exception! Venus::Error

=cut

$test->for('example', 3, 'result', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok !$result->isa('Venus::Try::Error');
  ok $result->isa('Venus::Error');

  $result
});

=error error_on_callback

This package may raise an error_on_callback exception.

=cut

$test->for('error', 'error_on_callback');

=example-1 error_on_callback

  # given: synopsis;

  my $input = {
    invocant => 'Example',
    callback => 'execute',
  };

  my $error = $try->throw('error_on_callback', $input)->catch('error');

  # my $name = $error->name;

  # "on_callback"

  # my $message = $error->render;

  # "Can't locate object method \"execute\" on package \"Example\""

=cut

$test->for('example', 1, 'error_on_callback', sub {
  my ($tryable) = @_;
  my $result = $tryable->error(\my $error)->result;
  isa_ok $error, 'Venus::Error';
  my $name = $error->name;
  is $name, "on_callback";
  my $message = $error->render;
  is $message, "Can't locate object method \"execute\" on package \"Example\"";

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Try.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;