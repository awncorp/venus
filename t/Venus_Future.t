package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;
use Venus;

my $test = test(__FILE__);

=name

Venus::Future

=cut

$test->for('name');

=tagline

Future Class

=cut

$test->for('tagline');

=abstract

Future Class for Perl 5

=cut

$test->for('abstract');

=includes

method: catch
method: finally
method: fulfill
method: is
method: is_fulfilled
method: is_pending
method: is_promised
method: is_rejected
method: issue
method: new
method: promise
method: reject
method: resolve
method: status
method: then
method: value
method: wait

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Future;

  my $future = Venus::Future->new;

  # bless({...}, 'Venus::Future')

  # $future->promise(sub{
  #   my ($resolve, $reject) = @_;
  #   $resolve->result(1);
  # });

  # bless({...}, 'Venus::Future')

  # $future->fulfill;

  # true

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Future');
  ok $result->is_pending;

  $result
});

=description

This package provides a framework-agnostic "Future" and implementation of the
"Promise/A+" pattern for asynchronous programming. The futures are non-blocking
and support "suspend" and "resume" allowing them to be used in any asynchronous
operating environment.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable

=cut

$test->for('integrates');

=method catch

The catch method registers a rejection handler and returns the future that
invokes the handlers.

=signature catch

  catch(coderef $on_reject) (Venus::Future)

=metadata catch

{
  since => '3.55',
}

=cut

=example-1 catch

  # given: synopsis

  package main;

  my $catch = $future->catch(sub{
    my ($issue) = @_;

    return $issue;
  });

  # bless(..., "Venus::Future")

  # $catch->then(sub{...});

  # bless(..., "Venus::Future")

=cut

$test->for('example', 1, 'catch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;

  $result
});

=example-2 catch

  # given: synopsis

  package main;

  my $catch = $future->catch(sub{
    my ($issue) = @_;

    return $issue;
  });

  # bless(..., "Venus::Future")

  $future = $future;

  # bless(..., "Venus::Future")

  # $future->reject('Oops!');

  # bless(..., "Venus::Future")

=cut

$test->for('example', 2, 'catch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;
  $result->reject('Oops!');
  ok $result->is_rejected;
  is $result->issue, 'Oops!';

  $result
});

=method finally

The finally method registers a finally handler and returns the future that
invokes the handlers.

=signature finally

  finally(coderef $on_finally) (Venus::Future)

=metadata finally

{
  since => '3.55',
}

=cut

=example-1 finally

  # given: synopsis

  package main;

  my $finally = $future->finally(sub{
    my ($data) = @_;

    return $data;
  });

  # bless(..., "Venus::Future")

  # $finally->then(sub{...});

  # bless(..., "Venus::Future")

=cut

$test->for('example', 1, 'finally', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;

  $result
});

=example-2 finally

  # given: synopsis

  package main;

  $future->then(sub{
    $_
  });

  my $finally = $future->finally(sub{
    my ($data) = @_;

    $future->{stash} = $data;

    return $data;
  });

  # bless(..., "Venus::Future")

  $future = $future;

  # bless(..., "Venus::Future")

  # $future->resolve('Hello.');

  # bless(..., "Venus::Future")

=cut

$test->for('example', 2, 'finally', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;
  $result->resolve('Hello.');
  ok $result->is_fulfilled;
  is $result->value, 'Hello.';
  is $result->value, $result->{stash};

  $result
});

=example-3 finally

  # given: synopsis

  package main;

  $future->then(sub{
    $_
  });

  my $finally = $future->finally(sub{
    my ($data) = @_;

    $future->{stash} = $data;

    return $data;
  });

  # bless(..., "Venus::Future")

  $future = $future;

  # bless(..., "Venus::Future")

  # $future->reject('Oops!');

  # bless(..., "Venus::Future")

=cut

$test->for('example', 3, 'finally', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;
  $result->reject('Oops!');
  ok $result->is_rejected;
  is $result->issue, 'Oops!';
  is $result->issue, $result->{stash};

  $result
});

=method fulfill

The fulfill method attempts to fulfill the L<promise|/promise> by actuating it,
or resuming a previously actuated promise, and returns true if the future has
been resolved, i.e. the future is either L<is_fulfilled> or L<is_rejected>, and
otherwise returns false.

=signature fulfill

  fulfill() (Venus::Future)

=metadata fulfill

{
  since => '3.55',
}

=cut

=example-1 fulfill

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[0]->result;
  });

  my $fulfilled = $future->fulfill;

  # true

=cut

$test->for('example', 1, 'fulfill', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 fulfill

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[0]->result;
  });

  $future->fulfill;

  my $result = $future;

  # bless(..., "Venus::Future")

  # $result->is_fulfilled;

  # true

  # $result->value;

  # undef

=cut

$test->for('example', 2, 'fulfill', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_fulfilled, true;
  is $result->value, undef;

  $result
});

=example-3 fulfill

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[1]->result;
  });

  my $fulfilled = $future->fulfill;

  # true

=cut

$test->for('example', 3, 'fulfill', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-4 fulfill

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[1]->result;
  });

  $future->fulfill;

  my $result = $future;

  # bless(..., "Venus::Future")

  # $result->is_rejected;

  # true

  # $result->issue;

  # undef

=cut

$test->for('example', 4, 'fulfill', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_rejected, true;
  is $result->issue, undef;

  $result
});

=example-5 fulfill

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[0]->result(1);
  })->then(sub{
    return $future->{stash} = $_ * 2; # 2
  })->then(sub{
    return $future->{stash} = $_ * 2; # 4
  })->then(sub{
    return $future->{stash} = $_ * 2; # 8
  });

  $future->fulfill;

  my $result = $future;

  # bless(..., "Venus::Future")

  # $result->is_fulfilled;

  # true

  # $result->value;

  # 1

=cut

$test->for('example', 5, 'fulfill', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_fulfilled, true;
  is $result->value, 1;
  is $result->{stash}, 8;

  $result
});

=example-6 fulfill

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[0]->result(1);
  });

  $future->then(sub{
    return $future->{stash} = $_ * 2; # 2
  });

  $future->then(sub{
    return $future->{stash} = $_ * 2; # 2
  });

  $future->then(sub{
    return $future->{stash} = $_ * 2; # 2
  });

  $future->fulfill;

  my $result = $future;

  # bless(..., "Venus::Future")

  # $result->is_fulfilled;

  # true

  # $result->value;

  # 1

=cut

$test->for('example', 6, 'fulfill', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_fulfilled, true;
  is $result->value, 1;
  is $result->{stash}, 2;

  $result
});

=example-7 fulfill

  # given: synopsis

  package main;

  my $pending_future = Venus::Future->new;

  $future->promise(sub{
    # resolve
    $_[0]->result(1);
  })->then(sub{
    return $_
  })->then(sub{
    return $pending_future;
  })->then(sub{
    return $_
  });

  $future->fulfill;

  my @results = ($future, $pending_future);

  # my $result = $future;

  # bless(..., "Venus::Future")

  # $result->is_fulfilled;

  # false

  # $result->is_pending;

  # true

  # $result->value;

  # undef

  # $pending_future->resolve(0);

  # bless(..., "Venus::Future")

  # $pending_future->is_fulfilled;

  # true

  # $result->fulfill;

  # true

  # $result->is_fulfilled;

  # true

=cut

$test->for('example', 7, 'fulfill', sub {
  my ($tryable) = @_;
  my @results = $tryable->result;
  my $result = shift @results;
  my $pending = shift @results;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_fulfilled, false;
  is $result->is_pending, true;
  ok defined $pending;
  isa_ok $pending, "Venus::Future";
  is $pending->is_fulfilled, false;
  is $pending->is_pending, true;
  is $result->value, undef;
  is $pending, $pending->resolve(0);
  is $pending->is_fulfilled, true;
  is $result->is_pending, true;
  is $result->fulfill, true;
  is $result->is_fulfilled, true;

  $result
});

=example-8 fulfill

  # given: synopsis

  package Thenable;

  use Venus::Class;

  sub then {
    my ($self, $resolve, $reject) = @_;

    $resolve->(100);
  }

  package main;

  my $thenable_object = Thenable->new;

  $future->promise(sub{
    # resolve
    $_[0]->result(1);
  })->then(sub{
    return $_
  })->then(sub{
    return $thenable_object;
  })->then(sub{
    return $future->{stash} = $_
  });

  $future->fulfill;

  my @results = ($future, $thenable_object);

  # my $result = $future;

  # bless(..., "Venus::Future")

  # $result->is_fulfilled;

  # true

  # $result->value;

  # 1

=cut

$test->for('example', 8, 'fulfill', sub {
  my ($tryable) = @_;
  my @results = $tryable->result;
  my $result = shift @results;
  my $thenable = shift @results;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_fulfilled, true;
  ok defined $thenable;
  isa_ok $thenable, "Thenable";
  is $result->value, 1;
  is $result->{stash}, 100;

  require Venus::Space;
  Venus::Space->new('Thenable')->unload;

  $result
});

=method is

The is method take a name and dispatches to the corresponding C<is_$name>
method and returns the result.

=signature is

  is(string $name) (boolean)

=metadata is

{
  since => '3.55',
}

=cut

=example-1 is

  # given: synopsis

  package main;

  $future->resolve;

  my $is_fulfilled = $future->is('fulfilled');

  # true

=cut

$test->for('example', 1, 'is', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 is

  # given: synopsis

  package main;

  my $is_pending = $future->is('pending');

  # true

=cut

$test->for('example', 2, 'is', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-3 is

  # given: synopsis

  package main;

  $future->reject;

  my $is_rejected = $future->is('rejected');

  # true

=cut

$test->for('example', 3, 'is', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method is_fulfilled

The is_fulfilled method returns true if the future has been fulfilled,
otherwise returns false.

=signature is_fulfilled

  is_fulfilled() (boolean)

=metadata is_fulfilled

{
  since => '3.55',
}

=cut

=example-1 is_fulfilled

  # given: synopsis

  package main;

  my $is_fulfilled = $future->is_fulfilled;

  # false

=cut

$test->for('example', 1, 'is_fulfilled', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=example-2 is_fulfilled

  # given: synopsis

  package main;

  $future->resolve;

  my $is_fulfilled = $future->is_fulfilled;

  # true

=cut

$test->for('example', 2, 'is_fulfilled', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-3 is_fulfilled

  # given: synopsis

  package main;

  $future->reject;

  my $is_fulfilled = $future->is_fulfilled;

  # false

=cut

$test->for('example', 3, 'is_fulfilled', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=method is_pending

The is_pending method returns true if the future has remained pending,
otherwise returns false.

=signature is_pending

  is_pending() (boolean)

=metadata is_pending

{
  since => '3.55',
}

=cut

=example-1 is_pending

  # given: synopsis

  package main;

  my $is_pending = $future->is_pending;

  # true

=cut

$test->for('example', 1, 'is_pending', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 is_pending

  # given: synopsis

  package main;

  $future->resolve;

  my $is_pending = $future->is_pending;

  # false

=cut

$test->for('example', 2, 'is_pending', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=example-3 is_pending

  # given: synopsis

  package main;

  $future->reject;

  my $is_pending = $future->is_pending;

  # false

=cut

$test->for('example', 3, 'is_pending', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=method is_promised

The is_promised method returns true if the future a registered promise,
otherwise returns false.

=signature is_promised

  is_promised() (boolean)

=metadata is_promised

{
  since => '3.55',
}

=cut

=example-1 is_promised

  # given: synopsis

  package main;

  my $is_promised = $future->is_promised;

  # false

=cut

$test->for('example', 1, 'is_promised', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=example-2 is_promised

  # given: synopsis

  package main;

  $future->promise;

  my $is_promised = $future->is_promised;

  # false

=cut

$test->for('example', 2, 'is_promised', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=example-3 is_promised

  # given: synopsis

  package main;

  $future->promise(sub{$_[0]->result});

  my $is_promised = $future->is_promised;

  # true

=cut

$test->for('example', 3, 'is_promised', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method is_rejected

The is_rejected method returns true if the future has been rejected, otherwise
returns false.

=signature is_rejected

  is_rejected() (boolean)

=metadata is_rejected

{
  since => '3.55',
}

=cut

=example-1 is_rejected

  # given: synopsis

  package main;

  my $is_rejected = $future->is_rejected;

  # false

=cut

$test->for('example', 1, 'is_rejected', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=example-2 is_rejected

  # given: synopsis

  package main;

  $future->resolve;

  my $is_rejected = $future->is_rejected;

  # false

=cut

$test->for('example', 2, 'is_rejected', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, false;

  !$result
});

=example-3 is_rejected

  # given: synopsis

  package main;

  $future->reject;

  my $is_rejected = $future->is_rejected;

  # true

=cut

$test->for('example', 3, 'is_rejected', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method issue

The issue method returns the result of the L</reject> operation once the future
has been rejected.

=signature issue

  issue() (any)

=metadata issue

{
  since => '3.55',
}

=cut

=example-1 issue

  # given: synopsis

  package main;

  my $issue = $future->issue;

  # undef

  # $future->is_pending

  # true

=cut

$test->for('example', 1, 'issue', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=example-2 issue

  # given: synopsis

  package main;

  $future->reject(0);

  my $issue = $future->issue;

  # 0

  # $future->is_rejected

  # true

=cut

$test->for('example', 2, 'issue', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-3 issue

  # given: synopsis

  package main;

  $future->reject({fail => 1});

  my $issue = $future->issue;

  # {fail => 1}

  # $future->is_rejected

  # true

=cut

$test->for('example', 3, 'issue', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, {fail => 1};

  $result
});

=method new

The new method instantiates this package and returns a new instance.

=signature new

  new(any @args) (Venus::Future)

=metadata new

{
  since => '3.55',
}

=cut

=example-1 new

  package main;

  my $future = Venus::Future->new;

  # bless(..., "Venus::Future")

=cut

$test->for('example', 1, 'new', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Future';
  ok $result->is_pending;

  $result
});

=example-2 new

  package main;

  my $future = Venus::Future->new(sub{
    my ($resolve, $reject) = @_;
    $resolve->result('okay');
  });

  # bless(..., "Venus::Future")

  # $future->is('fulfilled');

  # true

  # $future->value;

  # 'okay'

=cut

$test->for('example', 2, 'new', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Future';
  ok $result->is_fulfilled;
  is $result->value, 'okay';

  $result
});

=example-3 new

  package main;

  my $future = Venus::Future->new(promise => sub{
    my ($resolve, $reject) = @_;
    $reject->result('boom');
  });

  # bless(..., "Venus::Future")

  # $future->is('rejected');

  # true

  # $future->issue;

  # 'boom'

=cut

$test->for('example', 3, 'new', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Future';
  ok $result->is_rejected;
  is $result->issue, 'boom';

  $result
});

=method promise

The promise method registers a callback executed by the L</fulfill> method,
which is provided two arguments; the first argument being a L<Venus::Try>
instance representing a C<resolve> operaiton; the second argument being a
L<Venus::Try> instance representing a C<reject> operaiton; and returns the
invocant.

=signature promise

  promise(coderef $code) (Venus::Future)

=metadata promise

{
  since => '3.55',
}

=cut

=example-1 promise

  # given: synopsis

  package main;

  $future = $future->promise(sub{
    my ($resolve, $reject) = @_;

    $resolve->result('pass');
  });

  # bless(..., "Venus::Future")

  # $future->fulfill;

  # true

=cut

$test->for('example', 1, 'promise', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;
  ok $result->fulfill;
  ok $result->is_fulfilled;
  is $result->value, 'pass';

  $result
});

=example-2 promise

  # given: synopsis

  package main;

  $future = $future->promise(sub{
    my ($resolve, $reject) = @_;

    $reject->result('fail');
  });

  # bless(..., "Venus::Future")

  # $future->fulfill;

  # true

=cut

$test->for('example', 2, 'promise', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_pending;
  ok $result->fulfill;
  ok $result->is_rejected;
  is $result->issue, 'fail';

  $result
});

=method reject

The reject method cascades a rejection operation causes the future to be
rejected, and returns the invocant.

=signature reject

  reject(any $issue) (Venus::Future)

=metadata reject

{
  since => '3.55',
}

=cut

=example-1 reject

  # given: synopsis

  package main;

  my $rejected = $future->reject;

  # bless(..., "Venus::Future")

  # $rejected->status

  # "rejected"

  # $rejected->issue

  # undef

=cut

$test->for('example', 1, 'reject', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->status, "rejected";
  is $result->issue, undef;

  $result
});

=example-2 reject

  # given: synopsis

  package main;

  my $rejected = $future->reject('Oops!');

  # bless(..., "Venus::Future")

  # $rejected->status

  # "rejected"

  # $rejected->issue

  # "Oops!"

=cut

$test->for('example', 2, 'reject', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->status, "rejected";
  is $result->issue, "Oops!";

  $result
});

=method resolve

The resolve method cascades a rejection operation causes the future to be
rejected, and returns the invocant.

=signature resolve

  resolve(any $value) (Venus::Future)

=metadata resolve

{
  since => '3.55',
}

=cut

=example-1 resolve

  # given: synopsis

  package main;

  my $fulfilled = $future->resolve;

  # bless(..., "Venus::Future")

  # $fulfilled->status

  # "fulfilled"

  # $fulfilled->value

  # undef

=cut

$test->for('example', 1, 'resolve', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->status, "fulfilled";
  is $result->value, undef;

  $result
});

=example-2 resolve

  # given: synopsis

  package main;

  my $fulfilled = $future->resolve('Great!');

  # bless(..., "Venus::Future")

  # $fulfilled->status

  # "fulfilled"

  # $fulfilled->value

  # "Great!"

=cut

$test->for('example', 2, 'resolve', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->status, "fulfilled";
  is $result->value, "Great!";

  $result
});

=method status

The status method returns the status of the future. Valid statuses are
C<fulfilled>, C<pending>, and C<rejected>.

=signature status

  status() (any)

=metadata status

{
  since => '3.55',
}

=cut

=example-1 status

  # given: synopsis

  package main;

  my $status = $future->status;

  # "pending"

=cut

$test->for('example', 1, 'status', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "pending";

  $result
});

=example-2 status

  # given: synopsis

  package main;

  $future->resolve(0);

  my $status = $future->status;

  # "fulfilled"

=cut

$test->for('example', 2, 'status', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "fulfilled";

  $result
});

=example-3 status

  # given: synopsis

  package main;

  $future->reject(0);

  my $status = $future->status;

  # "rejected"

=cut

$test->for('example', 3, 'status', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "rejected";

  $result
});

=method then

The then method registers fulfillment and rejection handlers and returns the
future that invokes the handlers.

=signature then

  then(coderef $fulfill, coderef $reject) (Venus::Future)

=metadata then

{
  since => '3.55',
}

=cut

=example-1 then

  # given: synopsis

  package main;

  my $new_future = $future->then(sub{
    # fulfillment handler
    $_
  });

  # "Venus::Future"

  # $new_future->is_pending;

  # true

=cut

$test->for('example', 1, 'then', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_pending, true;

  $result
});

=example-2 then

  # given: synopsis

  package main;

  my $new_future = $future->then(sub{
    # fulfillment handler
    $_
  },
  sub{
    # rejection handler
    $_
  });

  # "Venus::Future"

  # $new_future->is_pending;

  # true

=cut

$test->for('example', 2, 'then', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_pending, true;

  $result
});

=example-3 then

  # given: synopsis

  package main;

  my $new_future = $future->then(undef, sub{
    # rejection handler
    $_
  });

  # "Venus::Future"

  # $new_future->is_pending;

  # true

=cut

$test->for('example', 3, 'then', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_pending, true;

  $result
});

=example-4 then

  # given: synopsis

  package main;

  my $new_future = $future->then(sub{
    # fulfillment handler
    $_
  });

  # "Venus::Future"

  # $new_future->is_pending;

  # true

  $future = $future;

  # "Venus::Future"

  # $new_future->is_pending;

  # true

=cut

$test->for('example', 4, 'then', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_pending, true;

  $result
});

=example-5 then

  # given: synopsis

  package main;

  my $new_future = $future->then(sub{
    # fulfillment handler
    $_
  },
  sub{
    # rejection handler
    $_
  });

  # "Venus::Future"

  # $new_future->is_pending;

  # true

  $future = $future;

  # "Venus::Future"

  # $new_future->is_pending;

  # true

=cut

$test->for('example', 5, 'then', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_pending, true;

  $result
});

=example-6 then

  # given: synopsis

  package main;

  my $new_future = $future->then(undef, sub{
    # rejection handler
    $_
  });

  # "Venus::Future"

  # $new_future->is_pending;

  # true

  $future = $future;

  # "Venus::Future"

  # $new_future->is_pending;

  # true

=cut

$test->for('example', 6, 'then', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  is $result->is_pending, true;

  $result
});

=method value

The value method returns the result of the L</resolve> operation once the
future has been fulfilled.

=signature value

  value() (any)

=metadata value

{
  since => '3.55',
}

=cut

=example-1 value

  # given: synopsis

  package main;

  my $value = $future->value;

  # undef

  # $future->is_pending

  # true

=cut

$test->for('example', 1, 'value', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=example-2 value

  # given: synopsis

  package main;

  $future->resolve(1);

  my $value = $future->value;

  # 1

  # $future->is_fulfilled

  # true

=cut

$test->for('example', 2, 'value', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-3 value

  # given: synopsis

  package main;

  $future->resolve({pass => 1});

  my $value = $future->value;

  # {pass => 1}

  # $future->is_fulfilled

  # true

=cut

$test->for('example', 3, 'value', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, {pass => 1};

  $result
});

=method wait

The wait method blocks the execution of the current process until a value is
received. If a timeout is provided, execution will be blocked until a value is
received or the wait time expires. If a timeout of C<0> is provided, execution
will not be blocked. If no timeout is provided at all, execution will block
indefinitely.

=signature wait

  wait(number $timeout) (Venus::Future)

=metadata wait

{
  since => '3.55',
}

=cut

=example-1 wait

  # given: synopsis

  package main;

  $future->promise(sub{
    # resolve
    $_[0]->result;
  });

  $future = $future->wait(0);

  # bless(..., "Venus::Future")

  # $future->is_fulfilled;

  # true

=cut

$test->for('example', 1, 'wait', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Future";
  ok $result->is_fulfilled;

  $result
});

=example-2 wait

  # given: synopsis

  package main;

  $future->promise(sub{
    # never fulfilled
  });

  $future->wait(1);

  # Exception! (isa Venus::Future::Error) (see error_on_timeout)

=cut

$test->for('example', 2, 'wait', sub {
  my ($tryable) = @_;
  my $_time_patch = Venus::Future->patch('_time', sub {0});
  my $result = $tryable->error->result;
  ok defined $result;
  isa_ok $result, "Venus::Future::Error";
  is $result->name, 'on_timeout';

  $result
});

=error error_on_timeout

This package may raise an error_on_timeout exception.

=cut

$test->for('error', 'error_on_timeout');

=example-1 error_on_timeout

  # given: synopsis;

  my $input = {
    throw => 'error_on_timeout',
    timeout => 10,
  };

  my $error = $future->try('error', $input)->error->result;

  # my $name = $error->name;

  # "on_timeout"

  # my $message = $error->render;

  # "Future timed-out after 10 seconds"

  # my $timeout = $error->stash('timeout');

  # 10

=cut

$test->for('example', 1, 'error_on_timeout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_timeout";
  my $message = $result->render;
  is $message, "Future timed-out after 10 seconds";
  my $timeout = $result->stash('timeout');
  is $timeout, 10;

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Future.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
