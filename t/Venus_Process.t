package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Config;
use Venus::Process;
use Venus::Path;

if ($Config{d_pseudofork}) {
  diag 'Fork emulation not supported' if $ENV{VENUS_DEBUG};
  goto SKIP;
}

our @TEST_VENUS_PROCESS_PIDS;
our $TEST_VENUS_PROCESS_ALARM = 0;
our $TEST_VENUS_PROCESS_CHDIR = 1;
our $TEST_VENUS_PROCESS_EXIT = 0;
our $TEST_VENUS_PROCESS_EXITCODE = 0;
our $TEST_VENUS_PROCESS_FORK = undef;
our $TEST_VENUS_PROCESS_FORKABLE = 1;
our $TEST_VENUS_PROCESS_SERVE = 0;
our $TEST_VENUS_PROCESS_KILL = 0;
our $TEST_VENUS_PROCESS_OPEN = 1;
our $TEST_VENUS_PROCESS_PID = 12345;
our $TEST_VENUS_PROCESS_PPID = undef;
our $TEST_VENUS_PROCESS_PING = 1;
our $TEST_VENUS_PROCESS_SETSID = 1;
our $TEST_VENUS_PROCESS_TIME = 0;
our $TEST_VENUS_PROCESS_WAITPID = undef;

$Venus::Process::PATH = Venus::Path->mktemp_dir;
$Venus::Process::PID = $TEST_VENUS_PROCESS_PID;

# _alarm
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_alarm"} = sub {
    $TEST_VENUS_PROCESS_ALARM = $_[0]
  };
}

# _chdir
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_chdir"} = sub {
    $TEST_VENUS_PROCESS_CHDIR
  };
}

# _exit
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_exit"} = sub {
    $TEST_VENUS_PROCESS_EXIT
  };
}

# _exitcode
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_exitcode"} = sub {
    $TEST_VENUS_PROCESS_EXITCODE
  };
}

# _fork
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_fork"} = sub {
    if (defined $TEST_VENUS_PROCESS_FORK) {
      return $TEST_VENUS_PROCESS_FORK;
    }
    else {
      push @TEST_VENUS_PROCESS_PIDS,
        $TEST_VENUS_PROCESS_PID+@TEST_VENUS_PROCESS_PIDS;
      return $TEST_VENUS_PROCESS_PIDS[-1];
    }
  };
}

# _forkable
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_forkable"} = sub {
    return $TEST_VENUS_PROCESS_FORKABLE;
  };
}

# _serve
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_serve"} = sub {
    return $TEST_VENUS_PROCESS_SERVE;
  };
}

# _kill
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_kill"} = sub {
    $TEST_VENUS_PROCESS_KILL;
  };
}

# _open
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_open"} = sub {
    $TEST_VENUS_PROCESS_OPEN
  };
}

# _ping
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_ping"} = sub {
    $TEST_VENUS_PROCESS_PING
  };
}

# _setsid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_setsid"} = sub {
    $TEST_VENUS_PROCESS_SETSID
  };
}

# _time
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_time"} = sub {
    $TEST_VENUS_PROCESS_TIME || time
  };
}

# _waitpid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_waitpid"} = sub {
    if (defined $TEST_VENUS_PROCESS_WAITPID) {
      return $TEST_VENUS_PROCESS_WAITPID;
    }
    else {
      return pop @TEST_VENUS_PROCESS_PIDS;
    }
  };
}

# default
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::default"} = sub {
    $TEST_VENUS_PROCESS_PID
  };
}

my $test = test(__FILE__);

=name

Venus::Process

=cut

$test->for('name');

=tagline

Process Class

=cut

$test->for('tagline');

=abstract

Process Class for Perl 5

=cut

$test->for('abstract');

=includes

method: async
method: await
method: chdir
method: check
method: count
method: daemon
method: data
method: decode
method: disengage
method: encode
method: engage
method: exchange
method: exit
method: followers
method: fork
method: forks
method: is_follower
method: is_leader
method: is_registered
method: is_unregistered
method: join
method: kill
method: killall
method: leader
method: leave
method: limit
method: others
method: others_active
method: others_inactive
method: poll
method: pool
method: pid
method: pids
method: ping
method: ppid
method: prune
method: recall
method: recallall
method: recv
method: recvall
method: register
method: registrants
method: restart
method: send
method: sendall
method: serve
method: setsid
method: started
method: status
method: stderr
method: stdin
method: stdout
method: stopped
method: sync
method: trap
method: wait
method: waitall
method: watch
method: watchlist
method: work
method: works
method: unregister
method: untrap
method: unwatch

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $process = $parent->fork;

  if ($process) {
    # do something in child process ...
    $process->exit;
  }
  else {
    # do something in parent process ...
    $parent->wait(-1);
  }

  # $parent->exit;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, $TEST_VENUS_PROCESS_PID;

  $result
});

=description

This package provides methods for handling and forking processes.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Explainable
Venus::Role::Valuable

=cut

$test->for('inherits');

=attribute alarm

The alarm attribute is used in calls to L<alarm> when the process is forked,
installing an alarm in the forked process if set.

=signature alarm

  alarm(Int $seconds) (Int)

=metadata alarm

{
  since => '2.40',
}

=example-1 alarm

  # given: synopsis

  package main;

  my $alarm = $parent->alarm;

  # undef

=cut

$test->for('example', 1, 'alarm', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 alarm

  # given: synopsis

  package main;

  my $alarm = $parent->alarm(10);

  # 10

=cut

$test->for('example', 2, 'alarm', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, 10;

  $result
});

=method async

The async method creates a new L<Venus::Process> object and asynchronously runs
the callback provided via the L</work> method. Both process objects are
configured to be are dyadic, i.e. representing an exclusing bi-directoral
relationship. Additionally, the callback return value will be automatically
made available via the L</await> method unless it's undefined. This method
returns the newly created L<"dyadic"|/is_dyadic> process object.

=signature async

  async(CodeRef $code, Any @args) (Process)

=metadata async

{
  since => '3.40',
}

=cut

=example-1 async

  # given: synopsis;

  my $async = $parent->async(sub{
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'async', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  ok $result->{directory};

  $result
});

=method await

The await method expects to operate on a L<"dyadic"|/is_dyadic> process object
and blocks the execution of the current process until a value is received from
its couterpart. If a timeout is provided, execution will be blocked until a
value is received or the wait time expires. If a timeout of C<0> is provided,
execution will not be blocked. If no timeout is provided at all, execution will
block indefinitely.

=signature await

  await(Int $timeout) (Any)

=metadata await

{
  since => '3.40',
}

=cut

=example-1 await

  # given: synopsis;

  my $async = $parent->async(sub{
    ($process) = @_;
    # in forked process ...
    return 'done';
  });

  my $await = $async->await;

  # ['done']

=cut

$test->for('example', 1, 'await', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  ok my $result = $tryable->result;
  is_deeply $result, ['done'];

  $result
});

=example-2 await

  # given: synopsis;

  my $async = $parent->async(sub{
    ($process) = @_;
    # in forked process ...
    return {status => 'done'};
  });

  my $await = $async->await;

  # [{status => 'done'}]

=cut

$test->for('example', 2, 'await', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  ok my $result = $tryable->result;
  is_deeply $result, [{status => 'done'}];

  $result
});

=example-3 await

  # given: synopsis;

  my $async = $parent->async(sub{
    ($process) = @_;
    # in forked process ...
    return 'done';
  });

  my ($await) = $async->await;

  # 'done'

=cut

$test->for('example', 3, 'await', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  ok my $result = $tryable->result;
  is $result, 'done';

  $result
});

=example-4 await

  # given: synopsis;

  my $async = $parent->async(sub{
    ($process) = @_;
    # in forked process ...
    return {status => 'done'};
  });

  my ($await) = $async->await;

  # {status => 'done'}

=cut

$test->for('example', 4, 'await', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  ok my $result = $tryable->result;
  is_deeply $result, {status => 'done'};

  $result
});

=example-5 await

  # given: synopsis;

  my $async = $parent->async(sub{
    ($process) = @_;
    # in forked process ...
    $process->sendall('send 1');
    $process->sendall('send 2');
    $process->sendall('send 3');
    return;
  });

  my $await;

  my $results = [];

  push @$results, $async->await;

  # 'send 1'

  push @$results, $async->await;

  # 'send 2'

  push @$results, $async->await;

  # 'send 3'

  $results;

  # ['send 1', 'send 2', 'send 3']

=cut

$test->for('example', 5, 'await', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  ok my $result = $tryable->result;
  is_deeply $result, ['send 1', 'send 2', 'send 3'];

  $result
});

=method chdir

The chdir method changes the working directory the current process is operating
within.

=signature chdir

  chdir(Str $path) (Process)

=metadata chdir

{
  since => '0.06',
}

=example-1 chdir

  # given: synopsis;

  $parent = $parent->chdir;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'chdir', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-2 chdir

  # given: synopsis;

  $parent = $parent->chdir('/tmp');

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'chdir', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-3 chdir

  # given: synopsis;

  $parent = $parent->chdir('/xyz');

  # Exception! (isa Venus::Process::Error) (see error_on_chdir)

=cut

$test->for('example', 3, 'chdir', sub {
  my ($tryable) = @_;
  my $error;
  local $TEST_VENUS_PROCESS_CHDIR = 0;
  ok my $result = $tryable->error(\$error)->result;
  ok $error;
  ok $error->isa('Venus::Process::Error');
  is $error->stash('path'), '/xyz';
  is $error->stash('pid'), $TEST_VENUS_PROCESS_PID;

  $result
});

=method check

The check method does a non-blocking L<perlfunc/waitpid> operation and returns
the wait status. In list context, returns the specified process' exit code (if
terminated).

=signature check

  check(Int $pid) (Int, Int)

=metadata check

{
  since => '0.06',
}

=example-1 check

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my $check = $parent->check($pid);

  # 0

=cut

$test->for('example', 1, 'check', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = 0;
  ok !(my $result = $tryable->result);
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 check

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($check, $status) = $parent->check('00000');

  # (-1, -1)

=cut

$test->for('example', 2, 'check', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  local $TEST_VENUS_PROCESS_EXITCODE = -1;
  ok my @result = $tryable->result;
  is_deeply \@result, [-1, -1];

  $result[0]
});

=example-3 check

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork(sub{ $_->exit(1) });

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($check, $status) = $parent->check($pid);

  # ($pid, 1)

=cut

$test->for('example', 3, 'check', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = $TEST_VENUS_PROCESS_PIDS[-1];
  local $TEST_VENUS_PROCESS_EXITCODE = local $TEST_VENUS_PROCESS_EXIT = 1;
  ok my @result = $tryable->result;
  is_deeply \@result, [$TEST_VENUS_PROCESS_WAITPID, 1];

  $result[0]
});

=method count

The count method dispatches to the method specified (or the L</watchlist> if
not specified) and returns a count of the items returned from the dispatched
call.

=signature count

  count(Str | CodeRef $code, Any @args) (Int)

=metadata count

{
  since => '2.40',
}

=cut

=example-1 count

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $count = $parent->count;

  # 0

=cut

$test->for('example', 1, 'count', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 count

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($pid) = $parent->watch(1001);

  my $count = $parent->count;

  # 1

=cut

$test->for('example', 2, 'count', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 count

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($pid) = $parent->watch(1001);

  my $count = $parent->count('watchlist');

  # 1

=cut

$test->for('example', 3, 'count', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method daemon

The daemon method detaches the process from controlling terminal and runs it in
the background as system daemon. This method internally calls L</disengage> and
L</setsid> and attempts to change the working directory to the root directory.

=signature daemon

  daemon() (Process)

=metadata daemon

{
  since => '0.06',
}

=example-1 daemon

  # given: synopsis;

  my $daemon = $parent->daemon; # exits parent immediately

  # in forked process ...

  # $daemon->exit;

=cut

$test->for('example', 1, 'daemon', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  $Venus::Process::PPID = undef;

  $result
});

=method data

The data method returns the number of messages sent to the current process,
from the PID or PIDs provided (if any). If no PID list is provided, the count
returned is based on the PIDs returned from L</watchlist>.

=signature data

  data(Int @pids) (Int)

=metadata data

{
  since => '2.91',
}

=cut

=example-1 data

  # given: synopsis

  package main;

  my $data = $parent->data;

  # 0

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 data

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->join('procs');

  # in process 2

  my $process_2 = Venus::Process->new(12346)->join('procs');

  # in process 3

  my $process_3 = Venus::Process->new(12347)->join('procs');

  # in process 1

  $process_1->pool(2)->sendall({
    from => $process_1->pid, said => 'hello',
  });

  # in process 2

  $process_2->pool(2)->sendall({
    from => $process_2->pid, said => 'hello',
  });

  # $process_2->data;

  # 2

  # in process 3

  $process_3->pool(2)->sendall({
    from => $process_3->pid, said => 'hello',
  });

  # $process_3->data;

  # 2

  # in process 1

  my $data = $process_1->data;

  # 2

=cut

$test->for('example', 2, 'data', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  is $result, 2;
  if (my $proc = Venus::Process->new(12345)->join('procs')) {
    local $TEST_VENUS_PROCESS_TIME = time + 1;
    $proc->pool(2);
    is $proc->data, 2;
    $proc->recvall;
  }
  if (my $proc = Venus::Process->new(12346)->join('procs')) {
    local $TEST_VENUS_PROCESS_TIME = time + 1;
    $proc->pool(2);
    is $proc->data, 2;
    $proc->recvall;
  }
  if (my $proc = Venus::Process->new(12347)->join('procs')) {
    local $TEST_VENUS_PROCESS_TIME = time + 1;
    $proc->pool(2);
    is $proc->data, 2;
    $proc->recvall;
  }
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=example-3 data

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->join('procs');

  # in process 2

  my $process_2 = Venus::Process->new(12346)->join('procs');

  # in process 3

  my $process_3 = Venus::Process->new(12347)->join('procs');

  # in process 1

  $process_1->pool(2)->sendall({
    from => $process_1->pid, said => 'hello',
  });

  # in process 2

  $process_2->pool(2)->sendall({
    from => $process_2->pid, said => 'hello',
  });

  # $process_2->data;

  # 2

  # in process 3

  $process_3->pool(2)->sendall({
    from => $process_3->pid, said => 'hello',
  });

  # $process_3->data;

  # 2

  # in process 1

  $process_1->recvall;

  my $data = $process_1->data;

  # 0

=cut

$test->for('example', 3, 'data', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  is $result, 0;
  if (my $proc = Venus::Process->new(12345)->join('procs')) {
    local $TEST_VENUS_PROCESS_TIME = time + 1;
    $proc->pool(2);
    is $proc->data, 0;
    $proc->recvall;
  }
  if (my $proc = Venus::Process->new(12346)->join('procs')) {
    local $TEST_VENUS_PROCESS_TIME = time + 1;
    $proc->pool(2);
    is $proc->data, 2;
    $proc->recvall;
  }
  if (my $proc = Venus::Process->new(12347)->join('procs')) {
    local $TEST_VENUS_PROCESS_TIME = time + 1;
    $proc->pool(2);
    is $proc->data, 2;
    $proc->recvall;
  }
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  !$result
});

=method decode

The decode method accepts a string representation of a Perl value and returns
the Perl value.

=signature decode

  decode(Str $data) (Any)

=metadata decode

{
  since => '2.91',
}

=cut

=example-1 decode

  # given: synopsis

  package main;

  my $decode = $parent->decode("{ok=>1}");

  # { ok => 1 }

=cut

$test->for('example', 1, 'decode', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, { ok => 1 };

  $result
});

=method disengage

The disengage method limits the interactivity of the process by changing the
working directory to the root directory and redirecting its standard file
descriptors from and to C</dev/null>, or the OS' equivalent. These state
changes can be undone by calling the L</engage> method.

=signature disengage

  disengage() (Process)

=metadata disengage

{
  since => '0.06',
}

=example-1 disengage

  # given: synopsis;

  $parent = $parent->disengage;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'disengage', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=method encode

The encode method accepts a Perl value and returns a string representation of
that Perl value.

=signature encode

  encode(Any $data) (Str)

=metadata encode

{
  since => '2.91',
}

=cut

=example-1 encode

  # given: synopsis

  package main;

  my $encode = $parent->encode({ok=>1});

  # "{ok=>1}"

=cut

$test->for('example', 1, 'encode', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  like $result, qr/.*ok.*=>.*1.*/;

  $result
});

=method engage

The engage method ensures the interactivity of the process by changing the
working directory to the directory used to launch the process, and by
redirecting/returning its standard file descriptors from and to their defaults.
This method effectively does the opposite of the L</disengage> method.

=signature engage

  engage() (Process)

=metadata engage

{
  since => '0.06',
}

=example-1 engage

  # given: synopsis;

  $parent = $parent->engage;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'engage', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=method exchange

The exchange method gets and/or sets the name of the data exchange. The
exchange is the ontext in which processes can register and cooperate. Process
can cooperate in different exchanges (or contexts) and messages sent to a
process in one context are not available to be retrieved will operating in
another exchange (or context).

=signature exchange

  exchange(Str $name) (Any)

=metadata exchange

{
  since => '2.91',
}

=cut

=example-1 exchange

  # given: synopsis

  package main;

  my $exchange = $parent->exchange;

  # undef

=cut

$test->for('example', 1, 'exchange', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 exchange

  # given: synopsis

  package main;

  my $exchange = $parent->exchange('procs');

  # "procs"

=cut

$test->for('example', 2, 'exchange', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "procs";

  $result
});

=example-3 exchange

  # given: synopsis

  package main;

  my $exchange = $parent->exchange('procs');

  # "procs"

  $exchange = $parent->exchange;

  # "procs"

=cut

$test->for('example', 3, 'exchange', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "procs";

  $result
});

=method exit

The exit method exits the program immediately.

=signature exit

  exit(Int $status) (Int)

=metadata exit

{
  since => '0.06',
}

=example-1 exit

  # given: synopsis;

  my $exit = $parent->exit;

  # 0

=cut

$test->for('example', 1, 'exit', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 exit

  # given: synopsis;

  my $exit = $parent->exit(1);

  # 1

=cut

$test->for('example', 2, 'exit', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_EXIT = 1;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method followers

The followers method returns the list of PIDs registered under the current
L</exchange> who are not the L</leader>.

=signature followers

  followers() (ArrayRef)

=metadata followers

{
  since => '2.91',
}

=cut

=example-1 followers

  # given: synopsis

  package main;

  my $followers = $parent->followers;

  # []

=cut

$test->for('example', 1, 'followers', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 followers

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  my $followers = $process_1->followers;

  # [12346, 12347]

=cut

$test->for('example', 2, 'followers', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [12346, 12347];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method fork

The fork method calls the system L<perlfunc/fork> function and creates a new
process running the same program at the same point (or call site). This method
returns a new L<Venus::Process> object representing the child process (from
within the execution of the child process (or fork)), and returns C<undef> to
the parent (or originating) process. In list context, this method returns both
the process and I<PID> (or process ID) of the child process. If a callback or
argument is provided it will be executed in the child process.

=signature fork

  fork(Str | CodeRef $code, Any @args) (Process, Int)

=metadata fork

{
  since => '0.06',
}

=example-1 fork

  # given: synopsis;

  $process = $parent->fork;

  # if ($process) {
  #   # in forked process ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait(-1);
  # }

  # in child process

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'fork', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  $Venus::Process::PPID = undef;

  $result
});

=example-2 fork

  # given: synopsis;

  my $pid;

  ($process, $pid) = $parent->fork;

  # if ($process) {
  #   # in forked process ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait($pid);
  # }

  # in parent process

  # (undef, $pid)

=cut

$test->for('example', 2, 'fork', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my @result = $tryable->result;
  is $result[1], $TEST_VENUS_PROCESS_PID;
  $Venus::Process::PPID = undef;

  @result
});

=example-3 fork

  # given: synopsis;

  my $pid;

  ($process, $pid) = $parent->fork(sub{
    $$_{started} = time;
  });

  # if ($process) {
  #   # in forked process ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait($pid);
  # }

  # in parent process

  # (undef, $pid)

=cut

$test->for('example', 3, 'fork', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my @result = $tryable->result;
  is $result[1], $TEST_VENUS_PROCESS_PID;
  ok $result[0]->{started};
  $Venus::Process::PPID = undef;

  @result
});

=example-4 fork

  # given: synopsis;

  $process = $parent->fork(sub{});

  # simulate fork failure

  # no forking attempted if NOT supported

  # Exception! (isa Venus::Process:Error) (see error_on_fork_support)

=cut

$test->for('example', 4, 'fork', sub {
  my ($tryable) = @_;
  require Config;
  local $TEST_VENUS_PROCESS_FORKABLE = 0;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');
  $Venus::Process::PPID = undef;

  $result
});

=example-5 fork

  # given: synopsis

  $process = $parent->do('alarm', 10)->fork;

  # if ($process) {
  #   # in forked process with alarm installed ...
  #   $process->exit;
  # }
  # else {
  #   # in parent process ...
  #   $parent->wait(-1);
  # }

  # in child process

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 5, 'fork', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_ALARM = 0;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  is $TEST_VENUS_PROCESS_ALARM, 10;
  $Venus::Process::PPID = undef;

  $result
});

=method forks

The forks method creates multiple forks by calling the L</fork> method C<n>
times, based on the count specified. As with the L</fork> method, this method
returns a new L<Venus::Process> object representing the child process (from
within the execution of the child process (or fork)), and returns C<undef> to
the parent (or originating) process. In list context, this method returns both
the process and an arrayref of I<PID> values (or process IDs) for each of the
child processes created. If a callback or argument is provided it will be
executed in each child process.

=signature forks

  forks(Str | CodeRef $code, Any @args) (Process, ArrayRef[Int])

=metadata forks

{
  since => '0.06',
}

=example-1 forks

  # given: synopsis;

  $process = $parent->forks(5);

  # if ($process) {
  #   # do something in (each) forked process ...
  #   $process->exit;
  # }
  # else {
  #   # do something in parent process ...
  #   $parent->wait(-1);
  # }

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'forks', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  $Venus::Process::PPID = undef;

  $result
});

=example-2 forks

  # given: synopsis;

  my $pids;

  ($process, $pids) = $parent->forks(5);

  # if ($process) {
  #   # do something in (each) forked process ...
  #   $process->exit;
  # }
  # else {
  #   # do something in parent process ...
  #   $parent->wait($_) for @$pids;
  # }

  # in parent process

  # (undef, $pids)

=cut

$test->for('example', 2, 'forks', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  ok my @result = $tryable->result;
  ok !defined $result[0];
  is @{$result[1]}, 5;
  like($_, qr/^\d+$/) for @{$result[1]};
  $Venus::Process::PPID = undef;

  @result
});

=example-3 forks

  # given: synopsis;

  my $pids;

  ($process, $pids) = $parent->forks(5, sub{
    my ($fork, $pid, $iteration) = @_;
    # $iteration is the fork iteration index
    $fork->exit;
  });

  # if ($process) {
  #   # do something in (each) forked process ...
  #   $process->exit;
  # }
  # else {
  #   # do something in parent process ...
  #   $parent->wait($_) for @$pids;
  # }

  # in child process

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 3, 'forks', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  $Venus::Process::PPID = undef;

  $result
});

=method is_follower

The is_follower method returns true if the process is not the L</leader>, otherwise
returns false.

=signature is_follower

  is_follower() (Bool)

=metadata is_follower

{
  since => '2.91',
}

=cut

=example-1 is_follower

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  my $is_follower = $process->is_follower;

  # false

=cut

$test->for('example', 1, 'is_follower', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 is_follower

  package main;

  use Venus::Process;

  my $process_1 = Venus::Process->new(12345)->register;
  my $process_2 = Venus::Process->new(12346)->register;
  my $process_3 = Venus::Process->new(12347)->register;

  my $is_follower = $process_1->is_follower;

  # false

  # my $is_follower = $process_2->is_follower;

  # true

  # my $is_follower = $process_3->is_follower;

  # true

=cut

$test->for('example', 2, 'is_follower', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  !$result
});

=example-3 is_follower

  package main;

  use Venus::Process;

  my $process_1 = Venus::Process->new(12345)->register;
  my $process_2 = Venus::Process->new(12346)->register;
  my $process_3 = Venus::Process->new(12347)->register;

  # my $is_follower = $process_1->is_follower;

  # false

  my $is_follower = $process_2->is_follower;

  # true

  # my $is_follower = $process_3->is_follower;

  # true

=cut

$test->for('example', 3, 'is_follower', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method is_leader

The is_leader method returns true if the process is the L</leader>, otherwise
returns false.

=signature is_leader

  is_leader() (Bool)

=metadata is_leader

{
  since => '2.91',
}

=cut

=example-1 is_leader

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  my $is_leader = $process->is_leader;

  # true

=cut

$test->for('example', 1, 'is_leader', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 is_leader

  package main;

  use Venus::Process;

  my $process_1 = Venus::Process->new(12345)->register;
  my $process_2 = Venus::Process->new(12346)->register;
  my $process_3 = Venus::Process->new(12347)->register;

  my $is_leader = $process_1->is_leader;

  # true

  # my $is_leader = $process_2->is_leader;

  # false

  # my $is_leader = $process_3->is_leader;

  # false

=cut

$test->for('example', 2, 'is_leader', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=example-3 is_leader

  package main;

  use Venus::Process;

  my $process_1 = Venus::Process->new(12345)->register;
  my $process_2 = Venus::Process->new(12346)->register;
  my $process_3 = Venus::Process->new(12347)->register;

  # my $is_leader = $process_1->is_leader;

  # true

  my $is_leader = $process_2->is_leader;

  # false

  # my $is_leader = $process_3->is_leader;

  # false

=cut

$test->for('example', 3, 'is_leader', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  !$result
});

=method is_registered

The is_registered method returns true if the process has registered using the
L</register> method, otherwise returns false.

=signature is_registered

  is_registered() (Bool)

=metadata is_registered

{
  since => '2.91',
}

=cut

=example-1 is_registered

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  my $is_registered = $process->is_registered;

  # false

=cut

$test->for('example', 1, 'is_registered', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 is_registered

  package main;

  use Venus::Process;

  my $process = Venus::Process->new(12345)->register;

  my $is_registered = $process->is_registered;

  # true

=cut

$test->for('example', 2, 'is_registered', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;
  Venus::Process->new(12345)->unregister;

  $result
});

=method is_unregistered

The is_unregistered method returns true if the process has unregistered using
the L</unregister> method, or had never registered at all, otherwise returns
false.

=signature is_unregistered

  is_unregistered() (Bool)

=metadata is_unregistered

{
  since => '2.91',
}

=cut

=example-1 is_unregistered

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  my $is_unregistered = $process->is_unregistered;

  # true

=cut

$test->for('example', 1, 'is_unregistered', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=example-2 is_unregistered

  package main;

  use Venus::Process;

  my $process = Venus::Process->new(12345);

  my $is_unregistered = $process->is_unregistered;

  # true

=cut

$test->for('example', 2, 'is_unregistered', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;
  Venus::Process->new(12345)->unregister;

  $result
});

=example-3 is_unregistered

  package main;

  use Venus::Process;

  my $process = Venus::Process->new(12345)->register;

  my $is_unregistered = $process->is_unregistered;

  # false

=cut

$test->for('example', 3, 'is_unregistered', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;
  Venus::Process->new(12345)->unregister;

  !$result
});

=method join

The join method sets the L</exchange>, registers the process with the exchange
using L</register>, and clears the L</watchlist>, then returns the invocant.

=signature join

  join(Str $name) (Process)

=metadata join

{
  since => '2.91',
}

=cut

=example-1 join

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  $process = $process->join;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'join', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->exchange, undef;
  is_deeply [$result->watchlist], [];
  $result->unregister;

  $result
});

=example-2 join

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  $process = $process->join('procs');

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'join', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->exchange, 'procs';
  is_deeply [$result->watchlist], [];
  $result->unregister;

  $result
});

=method kill

The kill method calls the system L<perlfunc/kill> function which sends a signal
to a list of processes and returns truthy or falsy. B<Note:> A truthy result
doesn't necessarily mean all processes were successfully signalled.

=signature kill

  kill(Str $signal, Int @pids) (Int)

=metadata kill

{
  since => '0.06',
}

=example-1 kill

  # given: synopsis;

  if ($process = $parent->fork) {
    # in forked process ...
    $process->exit;
  }

  my $kill = $parent->kill('term', int $process);

  # 1

=cut

$test->for('example', 1, 'kill', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_KILL = 1;
  ok my $result = $tryable->result;
  is $result, 1;
  $Venus::Process::PPID = undef;

  $result
});

=method killall

The killall method accepts a list of PIDs (or uses the L</watchlist> if not
provided) and returns the result of calling the L</kill> method for each PID.
Returns a list in list context.

=signature killall

  killall(Str $name, Int @pids) (ArrayRef)

=metadata killall

{
  since => '2.40',
}

=cut

=example-1 killall

  # given: synopsis

  package main;

  if ($process = $parent->fork) {
    # in forked process ...
    $process->exit;
  }

  my $killall = $parent->killall('term');

  # [1]

=cut

$test->for('example', 1, 'killall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  local $TEST_VENUS_PROCESS_KILL = 1;
  my $result = $tryable->result;
  is_deeply $result, [1];
  $Venus::Process::PPID = undef;

  $result
});

=example-2 killall

  # given: synopsis

  package main;

  if ($process = $parent->fork) {
    # in forked process ...
    $process->exit;
  }

  my $killall = $parent->killall('term', 1001..1004);

  # [1, 1, 1, 1]

=cut

$test->for('example', 2, 'killall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  local $TEST_VENUS_PROCESS_KILL = 1;
  my $result = $tryable->result;
  is_deeply $result, [1, 1, 1, 1];
  $Venus::Process::PPID = undef;

  $result
});

=method leader

The leader method uses a simple leader election algorithm to determine the
process leader and returns the PID for that process. The leader is always the
lowest value active PID (i.e. that responds to L</ping>).

=signature leader

  leader() (Int)

=metadata leader

{
  since => '2.91',
}

=cut

=example-1 leader

  # given: synopsis

  package main;

  my $leader = $parent->leader;

  # 12345

=cut

$test->for('example', 1, 'leader', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 12345;

  $result
});

=example-2 leader

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  my $leader = $process_3->leader;

  # 12345

=cut

$test->for('example', 2, 'leader', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 12345;
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=example-3 leader

  # given: synopsis

  package main;

  my $leader = $parent->register->leader;

  # 12345

=cut

$test->for('example', 3, 'leader', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 12345;

  $result
});

=method leave

The leave method sets the L</exchange> to undefined, unregisters the process
using L</unregister>, and clears the L</watchlist>, then returns the invocant.

=signature leave

  leave(Str $name) (Process)

=metadata leave

{
  since => '2.91',
}

=cut

=example-1 leave

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  $process = $process->leave;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'leave', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->exchange, undef;
  is_deeply [$result->watchlist], [];
  ok $result->is_unregistered;

  $result
});

=example-2 leave

  package main;

  use Venus::Process;

  my $process = Venus::Process->new;

  $process = $process->leave('procs');

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'leave', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->exchange, undef;
  is_deeply [$result->watchlist], [];
  ok $result->is_unregistered;

  $result
});

=method limit

The limit method blocks the execution of the current process until the number
of processes in the L</watchlist> falls bellow the count specified. The method
returns true once execution continues if execution was blocked, and false if
the limit has yet to be reached.

=signature limit

  limit(Int $count) (Bool)

=metadata limit

{
  since => '3.40',
}

=cut

=example-1 limit

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->work(sub {
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  my $limit = $parent->limit(2);

  # false

=cut

$test->for('example', 1, 'limit', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 limit

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->works(2, sub {
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  my $limit = $parent->limit(2);

  # true

=cut

$test->for('example', 2, 'limit', sub {
  my ($tryable) = @_;
  local @TEST_VENUS_PROCESS_PIDS = ();
  local $TEST_VENUS_PROCESS_FORK = undef;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  ok defined $result;
  is $result, 1;

  $result
});

=method others

The others method returns all L</registrants> other than the current process,
i.e. all other registered process PIDs whether active or inactive.

=signature others

  others() (ArrayRef)

=metadata others

{
  since => '2.91',
}

=cut

=example-1 others

  # given: synopsis

  package main;

  my $others = $parent->others;

  # []

=cut

$test->for('example', 1, 'others', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 others

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  my $others = $process_1->others;

  # [12346, 12347]

=cut

$test->for('example', 2, 'others', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [12346, 12347];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method others_active

The others_active method returns all L</registrants> other than the current
process which are active, i.e. all other registered process PIDs that responds
to L</ping>.

=signature others_active

  others_active() (ArrayRef)

=metadata others_active

{
  since => '2.91',
}

=cut

=example-1 others_active

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  my $others_active = $process_1->others_active;

  # [12346, 12347]

=cut

$test->for('example', 1, 'others_active', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PING = 1;
  my $result = $tryable->result;
  is_deeply $result, [12346, 12347];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method others_inactive

The others_inactive method returns all L</registrants> other than the current
process which are inactive, i.e. all other registered process PIDs that do not
respond to L</ping>.

=signature others_inactive

  others_inactive() (ArrayRef)

=metadata others_inactive

{
  since => '2.91',
}

=cut

=example-1 others_inactive

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1 (assuming all processes exited)

  my $others_inactive = $process_1->others_inactive;

  # [12346, 12347]

=cut

$test->for('example', 1, 'others_inactive', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PING = 0;
  my $result = $tryable->result;
  is_deeply $result, [12346, 12347];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method poll

The poll method continuously calls the named method or coderef and returns the
result that's not undefined, or throws an exception on timeout. If no method
name is provided this method will default to calling L</recvall>.

=signature poll

  poll(Int $timeout, Str | CodeRef $code, Any @args) (ArrayRef)

=metadata poll

{
  since => '2.91',
}

=cut

=example-1 poll

  # given: synopsis

  package main;

  my $poll = $parent->poll(0, 'ping', $parent->pid);

  # [1]

=cut

$test->for('example', 1, 'poll', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1];

  $result
});

=example-2 poll

  # given: synopsis

  package main;

  my $poll = $parent->poll(5, 'ping', $parent->pid);

  # [1]

=cut

$test->for('example', 2, 'poll', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1];

  $result
});

=example-3 poll

  # given: synopsis

  package main;

  my $poll = $parent->poll(0, 'recv', $parent->pid);

  # Exception! (isa Venus::Process::Error) (see error_on_timeout_poll)

=cut

$test->for('example', 3, 'poll', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = (time - 6);
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Process::Error';
  is $result->name, 'on_timeout_poll';

  $result
});

=example-4 poll

  # given: synopsis

  package main;

  my $poll = $parent->poll(5, sub {
    int(rand(2)) ? "" : ()
  });

  # [""]

=cut

$test->for('example', 4, 'poll', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [""];

  $result
});

=method pool

The pool method blocks the execution of the current process until the number of
L</other> processes are registered and pingable. This method returns the
invocant when successful, or throws an exception if the operation timed out.

=signature pool

  pool(Int $count, Int $timeout) (Process)

=metadata pool

{
  since => '2.91',
}

=cut

=example-1 pool

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 1

  $process_1 = $process_1->pool;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'pool', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply [$result->watchlist], [12346];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;

  $result
});

=example-2 pool

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  $process_1 = $process_1->pool(2);

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'pool', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply [$result->watchlist], [12346, 12347];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=example-3 pool

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  $process_1 = $process_1->pool(3, 0);

  # Exception! (isa Venus::Process::Error) (see error_on_timeout_pool)

=cut

$test->for('example', 3, 'pool', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = (time - 1);
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Process::Error';
  is $result->name, 'on_timeout_pool';
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method pid

The pid method returns the PID of the current process.

=signature pid

  pid() (Int)

=metadata pid

{
  since => '2.40',
}

=cut

=example-1 pid

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $pid = $parent->pid;

  # 00000

=cut

$test->for('example', 1, 'pid', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 12345;

  $result
});

=method pids

The pids method returns the PID of the current process, and the PIDs of any
child processes.

=signature pids

  pids() (ArrayRef)

=metadata pids

{
  since => '2.40',
}

=cut

=example-1 pids

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $pids = $parent->pids;

  # [00000]

=cut

$test->for('example', 1, 'pids', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [12345];

  $result
});

=example-2 pids

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(1001..1004);

  my $pids = $parent->pids;

  # [00000, 1001..1004]

=cut

$test->for('example', 2, 'pids', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [12345, 1001..1004];

  $result
});

=method ping

The ping method returns truthy if the process of the PID provided is active. If
multiple PIDs are provided, this method will return the count of active PIDs.

=signature ping

  ping(Int @pids) (Int)

=metadata ping

{
  since => '2.01',
}

=example-1 ping

  # given: synopsis;

  if ($process = $parent->fork) {
    # in forked process ...
    $process->exit;
  }

  my $ping = $parent->ping(int $process);

  # 1

=cut

$test->for('example', 1, 'ping', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  local $TEST_VENUS_PROCESS_KILL = 1;
  ok my $result = $tryable->result;
  is $result, 1;
  $Venus::Process::PPID = undef;

  $result
});

=method ppid

The ppid method returns the PID of the parent process (i.e. the process which
forked the current process, if any).

=signature ppid

  ppid() (Int)

=metadata ppid

{
  since => '2.91',
}

=cut

=example-1 ppid

  # given: synopsis;

  my $ppid = $parent->ppid;

  # undef

=cut

$test->for('example', 1, 'ppid', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok not defined $result;

  !$result
});

=example-2 ppid

  # given: synopsis;

  $process = $parent->fork;

  # in child process

  my $ppid = $process->ppid;

  # 00000

=cut

$test->for('example', 2, 'ppid', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  is $result, $TEST_VENUS_PROCESS_PID;

  $result
});

=method prune

The prune method removes all stopped processes and returns the invocant.

=signature prune

  prune() (Process)

=metadata prune

{
  since => '2.40',
}

=cut

=example-1 prune

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(1001);

  $parent = $parent->prune;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'prune', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->{watchlist}, [];

  $result
});

=example-2 prune

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $process = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  $parent = $parent->prune;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'prune', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->{watchlist}, [];

  $result
});

=example-3 prune

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->work(sub {
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  $parent = $parent->prune;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 3, 'prune', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, 'Venus::Process';
  is_deeply $result->{watchlist}, [];

  $result
});

=method recall

The recall method returns the earliest message, sent by the current process to
the process specified by the PID provided, which is no longer active (i.e.
responding to L</ping>).

=signature recall

  recall(Int $pid) (Any)

=metadata recall

{
  since => '2.91',
}

=cut

=example-1 recall

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 1

  $process_1->send($process_2->pid, {from => $process_1->pid});

  # in process 1 (process 2)

  my $recall = $process_1->recall($process_2->pid);

  # {from => 12345}

=cut

$test->for('example', 1, 'recall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  my $result = $tryable->result;
  is_deeply $result, {from => 12345};
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;

  $result
});

=method recallall

The recallall method performs a L</recall> on the parent process (if any) via
L</ppid> and any process listed in the L</watchlist>, and returns the results.

=signature recallall

  recallall() (ArrayRef)

=metadata recallall

{
  since => '2.91',
}

=cut

=example-1 recallall

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  $process_1->send($process_2->pid, {from => $process_1->pid});

  $process_1->send($process_3->pid, {from => $process_1->pid});

  $process_1->watch($process_2->pid, $process_3->pid);

  # in process 1 (process 2 and 3 died)

  my $recallall = $process_1->recallall;

  # [{from => 12345}, {from => 12345}]

=cut

$test->for('example', 1, 'recallall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PING = 0;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  my $result = $tryable->result;
  is_deeply $result, [{from => 12345}, {from => 12345}];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method recv

The recv method returns the earliest message found from the process specified
by the PID provided.

=signature recv

  recv(Int $pid) (Any)

=metadata recv

{
  since => '2.91',
}

=cut

=example-1 recv

  # given: synopsis

  package main;

  my $recv = $parent->recv;

  # undef

=cut

$test->for('example', 1, 'recv', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 recv

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345);

  # in process 2

  my $process_2 = Venus::Process->new(12346);

  # in process 1

  my $recv = $process_1->recv($process_2->pid);

  # undef

  # in process 2

  $process_2->send($process_1->pid, {from => $process_2->pid, said => 'hello'});

  # in process 1

  $recv = $process_1->recv($process_2->pid);

  # {from => 12346, said => 'hello'}

=cut

$test->for('example', 2, 'recv', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {from => 12346, said => 'hello'};

  $result
});

=method recvall

The recvall method performs a L</recv> on the parent process (if any) via
L</ppid> and any process listed in the L</watchlist>, and returns the results.

=signature recvall

  recvall() (ArrayRef)

=metadata recvall

{
  since => '2.91',
}

=cut

=example-1 recvall

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  $process_2->send($process_1->pid, {from => $process_2->pid});

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  $process_3->send($process_1->pid, {from => $process_3->pid});

  # in process 1

  my $recvall = $process_1->pool(2)->recvall;

  # [{from => 12346}, {from => 12347}]

=cut

$test->for('example', 1, 'recvall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  is_deeply $result, [{from => 12346}, {from => 12347}];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=example-2 recvall

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  $process_2->send($process_1->pid, {from => $process_2->pid});

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  $process_3->send($process_1->pid, {from => $process_3->pid});

  # in process 1

  my $recvall = $process_1->pool(2)->recvall;

  # [{from => 12346}, {from => 12347}]

  # in process 2

  $process_2->send($process_1->pid, {from => $process_2->pid});

  # in process 1

  $recvall = $process_1->recvall;

  # [{from => 12346}]

=cut

$test->for('example', 2, 'recvall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  is_deeply $result, [{from => 12346}];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method register

The register method declares that the process is willing to cooperate with
others (e.g. L</send> nad L</recv> messages), in a way that's discoverable by
other processes, and returns the invocant.

=signature register

  register() (Process)

=metadata register

{
  since => '2.91',
}

=cut

=example-1 register

  # given: synopsis

  package main;

  my $register = $parent->register;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'register', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  ok $result->is_registered;

  $result
});

=method registrants

The registrants method returns the PIDs for all the processes that registered
using the L</register> method whether they're currently active or not.

=signature registrants

  registrants() (ArrayRef)

=metadata registrants

{
  since => '2.91',
}

=cut

=example-1 registrants

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  my $registrants = $process_1->registrants;

  # [12345, 12346, 12347]

=cut

$test->for('example', 1, 'registrants', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [12345, 12346, 12347];

  $result
});

=method restart

The restart method executes the callback provided for each PID returned by the
L</stopped> method, passing the pid and the results of L</check> to the
callback as arguments, and returns the result of each call as an arrayref. In
list context, this method returns a list.

=signature restart

  restart(CodeRef $callback) (ArrayRef)

=metadata restart

{
  since => '2.40',
}

=cut

=example-1 restart

  # given: synopsis

  package main;

  $parent->watch(1001);

  my $restart = $parent->restart(sub {
    my ($pid, $check, $exit) = @_;

    # redeploy stopped process

    return [$pid, $check, $exit];
  });

  # [[1001, 1001, 255]]

=cut

$test->for('example', 1, 'restart', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 1001;
  local $TEST_VENUS_PROCESS_WAITPID = 1001;
  local $TEST_VENUS_PROCESS_EXITCODE = 255;
  my $result = $tryable->result;
  is_deeply $result, [[1001, 1001, 255]];

  $result
});

=method send

The send method makes the data provided available to the process specified by
the PID provided.

=signature send

  send(Int $pid, Any $data) (Process)

=metadata send

{
  since => '2.91',
}

=cut

=example-1 send

  # given: synopsis

  package main;

  my $send = $parent->send;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'send', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';

  $result
});

=example-2 send

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345);

  # in process 2

  my $process_2 = Venus::Process->new(12346);

  # in process 1

  $process_1 = $process_1->send($process_2->pid, {
    from => $process_1->pid, said => 'hello',
  });

  # bless({...}, 'Venus::Process')

  # in process 2

  # $process_2->recv($process_1->pid);

  # {from => 12345, said => 'hello'}

=cut

$test->for('example', 2, 'send', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply [Venus::Process->new(12346)->recv(12345)],
    [{from => 12345, said => 'hello'}];

  $result
});

=method sendall

The sendall method performs a L</send> on the parent process (if any) via
L</ppid> and any process listed in the L</watchlist>, and returns the invocant.

=signature sendall

  sendall(Any $data) (Process)

=metadata sendall

{
  since => '2.91',
}

=cut

=example-1 sendall

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  # in process 1

  $process_1 = $process_1->pool(2)->sendall({
    from => $process_1->pid, said => 'hello',
  });

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'sendall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  local $Venus::Process::PPID = $TEST_VENUS_PROCESS_PPID = undef;
  my $result = $tryable->result;
  my $process_1 = Venus::Process->new(12345);
  is_deeply $process_1->recv(12345), undef;
  $process_1->unregister;
  my $process_2 = Venus::Process->new(12346);
  is_deeply $process_2->recv(12345), {from => 12345, said => 'hello'};
  $process_2->unregister;
  my $process_3 = Venus::Process->new(12347);
  is_deeply $process_3->recv(12345), {from => 12345, said => 'hello'};
  $process_3->unregister;

  $result
});

=method serve

The serve method executes the callback using L</work> until L</limit> blocks
the execution of the current process, indefinitely. It has the effect of
serving the callback and maintaining the desired number of forks until killed
or gracefully shutdown.

=signature serve

  serve(Int $count, CodeRef $callback) (Process)

=metadata serve

{
  since => '3.40',
}

=cut

=example-1 serve

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->serve(2, sub {
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  # ...

  # bless({...}, "Venus::Process")

=cut

$test->for('example', 1, 'serve', sub {
  my ($tryable) = @_;
  local @TEST_VENUS_PROCESS_PIDS = ();
  local $TEST_VENUS_PROCESS_FORK = undef;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  local $TEST_VENUS_PROCESS_SERVE = 0;
  my $result = $tryable->result;
  is scalar(@TEST_VENUS_PROCESS_PIDS), 2;

  $result
});

=example-2 serve

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->serve(10, sub {
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  # ...

  # bless({...}, "Venus::Process")

=cut

$test->for('example', 2, 'serve', sub {
  my ($tryable) = @_;
  local @TEST_VENUS_PROCESS_PIDS = ();
  local $TEST_VENUS_PROCESS_FORK = undef;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  local $TEST_VENUS_PROCESS_SERVE = 0;
  my $result = $tryable->result;
  is scalar(@TEST_VENUS_PROCESS_PIDS), 10;

  $result
});

=method setsid

The setsid method calls the L<POSIX/setsid> function and sets the process group
identifier of the current process.

=signature setsid

  setsid() (Int)

=metadata setsid

{
  since => '0.06',
}

=example-1 setsid

  # given: synopsis;

  my $setsid = $parent->setsid;

  # 1

=cut

$test->for('example', 1, 'setsid', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=example-2 setsid

  # given: synopsis;

  my $setsid = $parent->setsid;

  # Exception! (isa Venus::Process::Error) (see error_on_setid)

=cut

$test->for('example', 2, 'setsid', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_SETSID = -1;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method started

The started method returns a list of PIDs whose processes have been started and
which have not terminated. Returns a list in list context.

=signature started

  started() (ArrayRef)

=metadata started

{
  since => '2.40',
}

=cut

=example-1 started

  # given: synopsis

  package main;

  my $started = $parent->started;

  # child not terminated

  # [...]

=cut

$test->for('example', 1, 'started', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [12346];

  $result
});

=example-2 started

  # given: synopsis

  package main;

  my $started = $parent->started;

  # child terminated

  # []

=cut

$test->for('example', 2, 'started', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=method status

The status method executes the callback provided for each PID in the
L</watchlist>, passing the pid and the results of L</check> to the callback as
arguments, and returns the result of each call as an arrayref. In list context,
this method returns a list.

=signature status

  status(CodeRef $callback) (ArrayRef)

=metadata status

{
  since => '2.40',
}

=cut

=example-1 status

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(12346);

  my $status = $parent->status(sub {
    my ($pid, $check, $exit) = @_;

    # assuming PID 12346 is still running (not terminated)
    return [$pid, $check, $exit];
  });

  # [[12346, 0, -1]]

=cut

$test->for('example', 1, 'status', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 12346;
  local $TEST_VENUS_PROCESS_WAITPID = 0;
  local $TEST_VENUS_PROCESS_EXITCODE = -1;
  my $result = $tryable->result;
  is_deeply $result, [[12346, 0, -1]];

  $result
});

=example-2 status

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(12346);

  my $status = $parent->status(sub {
    my ($pid, $check, $exit) = @_;

    # assuming process 12346 terminated with exit code 255
    return [$pid, $check, $exit];
  });

  # [[12346, 12346, 255]]

=cut

$test->for('example', 2, 'status', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 12346;
  local $TEST_VENUS_PROCESS_WAITPID = 12346;
  local $TEST_VENUS_PROCESS_EXITCODE = 255;
  my $result = $tryable->result;
  is_deeply $result, [[12346, 12346, 255]];

  $result
});

=example-3 status

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(12346);

  my @status = $parent->status(sub {
    my ($pid, $check, $exit) = @_;

    # assuming process 12346 terminated with exit code 255
    return [$pid, $check, $exit];
  });

  # ([12346, 12346, 255])

=cut

$test->for('example', 3, 'status', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 12346;
  local $TEST_VENUS_PROCESS_WAITPID = 12346;
  local $TEST_VENUS_PROCESS_EXITCODE = 255;
  my @result = $tryable->result;
  is_deeply [@result], [[12346, 12346, 255]];

  [@result]
});

=method stderr

The stderr method redirects C<STDERR> to the path provided, typically
C</dev/null> or some equivalent. If called with no arguments C<STDERR> will be
restored to its default.

=signature stderr

  stderr(Str $path) (Process)

=metadata stderr

{
  since => '0.06',
}

=example-1 stderr

  # given: synopsis;

  $parent = $parent->stderr;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'stderr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');

  $result
});

=example-2 stderr

  # given: synopsis;

  $parent = $parent->stderr('/nowhere');

  # Exception! (isa Venus::Process:Error) (see error_on_stderr)

=cut

$test->for('example', 2, 'stderr', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_OPEN = 0;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method stdin

The stdin method redirects C<STDIN> to the path provided, typically
C</dev/null> or some equivalent. If called with no arguments C<STDIN> will be
restored to its default.

=signature stdin

  stdin(Str $path) (Process)

=metadata stdin

{
  since => '0.06',
}

=example-1 stdin

  # given: synopsis;

  $parent = $parent->stdin;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'stdin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');

  $result
});

=example-2 stdin

  # given: synopsis;

  $parent = $parent->stdin('/nowhere');

  # Exception! (isa Venus::Process::Error) (see error_on_stdin)

=cut

$test->for('example', 2, 'stdin', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_OPEN = 0;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method stdout

The stdout method redirects C<STDOUT> to the path provided, typically
C</dev/null> or some equivalent. If called with no arguments C<STDOUT> will be
restored to its default.

=signature stdout

  stdout(Str $path) (Process)

=metadata stdout

{
  since => '0.06',
}

=example-1 stdout

  # given: synopsis;

  $parent = $parent->stdout;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'stdout', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');

  $result
});

=example-2 stdout

  # given: synopsis;

  $parent = $parent->stdout('/nowhere');

  # Exception! Venus::Process::Error (error_on_stdout)

=cut

$test->for('example', 2, 'stdout', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_OPEN = 0;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method stopped

The stopped method returns a list of PIDs whose processes have terminated.
Returns a list in list context.

=signature stopped

  stopped() (ArrayRef)

=metadata stopped

{
  since => '2.40',
}

=cut

=example-1 stopped

  # given: synopsis

  package main;

  my $stopped = $parent->stopped;

  # child terminated

  # [...]

=cut

$test->for('example', 1, 'stopped', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  my $result = $tryable->result;
  is_deeply $result, [12346];

  $result
});

=example-2 stopped

  # given: synopsis

  package main;

  my $stopped = $parent->stopped;

  # child not terminated

  # []

=cut

$test->for('example', 2, 'stopped', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = 0;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=method sync

The sync method blocks the execution of the current process until the number of
L</other> processes are registered, pingable, and have each sent at-least one
message to the current process. This method returns the invocant when
successful, or throws an exception if the operation timed out.

=signature sync

  sync(Int $count, Int $timeout) (Process)

=metadata sync

{
  since => '2.91',
}

=cut

=example-1 sync

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  $process_2->send($process_1->pid, {from => $process_2->pid, said => "hello"});

  # in process 1

  $process_1 = $process_1->sync;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'sync', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply [$result->watchlist], [12346];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;

  $result
});

=example-2 sync

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  $process_2->send($process_1->pid, {from => $process_2->pid, said => "hello"});

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  $process_3->send($process_1->pid, {from => $process_3->pid, said => "hello"});

  # in process 1

  $process_1 = $process_1->sync(2);

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'sync', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = time + 1;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  is_deeply [$result->watchlist], [12346, 12347];
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=example-3 sync

  # given: synopsis

  package main;

  # in process 1

  my $process_1 = Venus::Process->new(12345)->register;

  # in process 2

  my $process_2 = Venus::Process->new(12346)->register;

  $process_2->send($process_1->pid, {from => $process_2->pid, said => "hello"});

  # in process 3

  my $process_3 = Venus::Process->new(12347)->register;

  $process_3->send($process_1->pid, {from => $process_3->pid, said => "hello"});

  # in process 1

  $process_1 = $process_1->sync(3, 0);

  # Exception! (isa Venus::Process::Error) (see error_on_timeout_sync)

=cut

$test->for('example', 3, 'sync', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_TIME = (time - 1);
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Process::Error';
  is $result->name, 'on_timeout_sync';
  Venus::Process->new(12345)->unregister;
  Venus::Process->new(12346)->unregister;
  Venus::Process->new(12347)->unregister;

  $result
});

=method trap

The trap method registers a process signal trap (or callback) which will be
invoked whenever the current process receives that matching signal. The signal
traps are globally installed and will overwrite any preexisting behavior.
Signal traps are inherited by child processes (or forks) but can be overwritten
using this method, or reverted to the default behavior by using the L</untrap>
method.

=signature trap

  trap(Str $name, Str | CodeRef $expr) (Process)

=metadata trap

{
  since => '0.06',
}

=example-1 trap

  # given: synopsis;

  $parent = $parent->trap(term => sub{
    die 'Something failed!';
  });

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'trap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  is ref($SIG{TERM}), 'CODE';

  $result
});

=method wait

The wait method does a blocking L<perlfunc/waitpid> operation and returns the
wait status. In list context, returns the specified process' exit code (if
terminated).

=signature wait

  wait(Int $pid) (Int, Int)

=metadata wait

{
  since => '0.06',
}

=example-1 wait

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my $wait = $parent->wait($pid);

  # 0

=cut

$test->for('example', 1, 'wait', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = 0;
  ok !(my $result = $tryable->result);
  ok defined $result;
  is $result, 0;

  !$result
});

=example-2 wait

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($wait, $status) = $parent->wait('00000');

  # (-1, -1)

=cut

$test->for('example', 2, 'wait', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = -1;
  local $TEST_VENUS_PROCESS_EXITCODE = -1;
  ok my @result = $tryable->result;
  is_deeply \@result, [-1, -1];

  $result[0]
});

=example-3 wait

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork(sub{ $_->exit(1) });

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my ($wait, $status) = $parent->wait($pid);

  # ($pid, 1)

=cut

$test->for('example', 3, 'wait', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_WAITPID = $TEST_VENUS_PROCESS_PIDS[-1];
  local $TEST_VENUS_PROCESS_EXITCODE = local $TEST_VENUS_PROCESS_EXIT = 1;
  ok my @result = $tryable->result;
  is_deeply \@result, [$TEST_VENUS_PROCESS_WAITPID, 1];

  $result[0]
});

=method waitall

The waitall method does a blocking L</wait> call for all processes based on the
PIDs provided (or the PIDs returned by L</watchlist> if not provided) and
returns an arrayref of results from calling L</wait> on each PID. Returns a
list in list context.

=signature waitall

  waitall(Int @pids) (ArrayRef)

=metadata waitall

{
  since => '2.40',
}

=cut

=example-1 waitall

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $waitall = $parent->waitall;

  # []

=cut

$test->for('example', 1, 'waitall', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 waitall

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $waitall = $parent->waitall(1001);

  # [[1001, 0]]

=cut

$test->for('example', 2, 'waitall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 1001;
  local $TEST_VENUS_PROCESS_WAITPID = 1001;
  my $result = $tryable->result;
  is_deeply $result, [[1001, 0]];

  $result
});

=example-3 waitall

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my ($process, $pid) = $parent->fork;

  if ($process) {
    # in forked process ...
    $process->exit;
  }

  my $waitall = $parent->waitall;

  # [[$pid, 0]]

=cut

$test->for('example', 3, 'waitall', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 1;
  local $TEST_VENUS_PROCESS_PID = 12345;
  local $TEST_VENUS_PROCESS_WAITPID = 12345;
  my $result = $tryable->result;
  is_deeply $result, [[12345, 0]];

  $result
});

=method watch

The watch method records PIDs to be watched, e.g. using the L</status> method
and returns all PIDs being watched. Returns a list in list context.

=signature watch

  watch(Int @pids) (ArrayRef)

=metadata watch

{
  since => '2.40',
}

=cut

=example-1 watch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $watch = $parent->watch;

  # []

=cut

$test->for('example', 1, 'watch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 watch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $watch = $parent->watch(1001..1004);

  # [1001..1004]

=cut

$test->for('example', 2, 'watch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1001..1004];

  $result
});

=example-3 watch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $watch = $parent->watch(1001..1004, 1001..1004);

  # [1001..1004]

=cut

$test->for('example', 3, 'watch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1001..1004];

  $result
});

=example-4 watch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(1001..1004);

  my $watch = $parent->watch;

  # [1001..1004]

=cut

$test->for('example', 4, 'watch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1001..1004];

  $result
});

=example-5 watch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my @watch = $parent->watch(1001..1004);

  # (1001..1004)

=cut

$test->for('example', 5, 'watch', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], [1001..1004];

  [@result]
});

=method watchlist

The watchlist method returns the recorded PIDs. Returns a list in list context.

=signature watchlist

  watchlist() (ArrayRef)

=metadata watchlist

{
  since => '2.40',
}

=cut

=example-1 watchlist

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $watchlist = $parent->watchlist;

  # []

=cut

$test->for('example', 1, 'watchlist', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 watchlist

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(1001..1004);

  my $watchlist = $parent->watchlist;

  # [1001..1004]

=cut

$test->for('example', 2, 'watchlist', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1001..1004];

  $result
});

=method work

The work method forks the current process, runs the callback provided in the
child process, and immediately exits after. This method returns the I<PID> of
the child process. It is recommended to install an L<perlfunc/alarm> in the
child process (i.e. callback) to avoid creating zombie processes in situations
where the parent process might exit before the child process is done working.

=signature work

  work(Str | CodeRef $code, Any @args) (Int)

=metadata work

{
  since => '0.06',
}

=example-1 work

  # given: synopsis;

  my $pid = $parent->work(sub{
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  # $pid

=cut

$test->for('example', 1, 'work', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  is $result, $TEST_VENUS_PROCESS_PID;

  $result
});

=method works

The works method creates multiple forks by calling the L</work> method C<n>
times, based on the count specified. The works method runs the callback
provided in the child process, and immediately exits after with an exit code of
C<0> by default. This method returns the I<PIDs> of the child processes. It is
recommended to install an L<perlfunc/alarm> in the child process (i.e.
callback) to avoid creating zombie processes in situations where the parent
process might exit before the child process is done working.

=signature works

  works(Int $count, CodeRef $callback, Any @args) (ArrayRef)

=metadata works

{
  since => '2.40',
}

=cut

=example-1 works

  # given: synopsis;

  my $pids = $parent->works(5, sub{
    my ($process) = @_;
    # in forked process ...
    $process->exit;
  });

  # $pids

=cut

$test->for('example', 1, 'works', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_FORK = 0;
  ok my $result = $tryable->result;
  is_deeply $result, [
    $TEST_VENUS_PROCESS_PID,
    $TEST_VENUS_PROCESS_PID,
    $TEST_VENUS_PROCESS_PID,
    $TEST_VENUS_PROCESS_PID,
    $TEST_VENUS_PROCESS_PID
  ];

  $result
});

=method unregister

The unregister method declares that the process is no longer willing to
cooperate with others (e.g. L</send> nad L</recv> messages), and will no longer
be discoverable by other processes, and returns the invocant.

=signature unregister

  unregister() (Process)

=metadata unregister

{
  since => '2.91',
}

=cut

=example-1 unregister

  # given: synopsis

  package main;

  my $unregister = $parent->unregister;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'unregister', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Process';
  ok !$result->is_registered;

  $result
});

=method untrap

The untrap method restores the process signal trap specified to its default
behavior. If called with no arguments, it restores all signal traps overwriting
any user-defined signal traps in the current process.

=signature untrap

  untrap(Str $name) (Process)

=metadata untrap

{
  since => '0.06',
}

=example-1 untrap

  # given: synopsis;

  $parent->trap(chld => 'ignore')->trap(term => sub{
    die 'Something failed!';
  });

  $parent = $parent->untrap('term');

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 1, 'untrap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  is $SIG{CHLD}, 'IGNORE';
  is $SIG{TERM}, undef;

  $result
});

=example-2 untrap

  # given: synopsis;

  $parent->trap(chld => 'ignore')->trap(term => sub{
    die 'Something failed!';
  });

  $parent = $parent->untrap;

  # bless({...}, 'Venus::Process')

=cut

$test->for('example', 2, 'untrap', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Process');
  is $SIG{CHLD}, undef;
  is $SIG{TERM}, undef;

  $result
});

=method unwatch

The unwatch method removes the PIDs provided from the watchlist and returns the
list of PIDs remaining to be watched. In list context returns a list.

=signature unwatch

  unwatch(Int @pids) (ArrayRef)

=metadata unwatch

{
  since => '2.40',
}

=cut

=example-1 unwatch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  my $unwatch = $parent->unwatch;

  # []

=cut

$test->for('example', 1, 'unwatch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=example-2 unwatch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(1001..1004);

  my $unwatch = $parent->unwatch(1001);

  # [1002..1004]

=cut

$test->for('example', 2, 'unwatch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1002..1004];

  $result
});

=example-3 unwatch

  package main;

  use Venus::Process;

  my $parent = Venus::Process->new;

  $parent->watch(1001..1004);

  my $unwatch = $parent->unwatch(1002, 1004);

  # [1001, 1003]

=cut

$test->for('example', 3, 'unwatch', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1001, 1003];

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$parent";

  # $pid

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $parent ~~ /^\d+$/;

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

=error error_on_chdir

This package may raise an error_on_chdir exception.

=cut

$test->for('error', 'error_on_chdir');

=example-1 error_on_chdir

  # given: synopsis;

  my $input = {
    throw => 'error_on_chdir',
    error => $!,
    path => '/nowhere',
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_chdir"

  # my $message = $error->render;

  # "Can't chdir \"$path\": $!"

  # my $path = $error->stash('path');

  # "/nowhere"

  # my $pid = $error->stash('pid');

  # 123

=cut

$test->for('example', 1, 'error_on_chdir', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_chdir";
  my $message = $result->render;
  is $message, "Can't chdir \"/nowhere\": $!";
  my $path = $result->stash('path');
  is $path, "/nowhere";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_fork_process

This package may raise an error_on_fork_process exception.

=cut

$test->for('error', 'error_on_fork_process');

=example-1 error_on_fork_process

  # given: synopsis;

  my $input = {
    throw => 'error_on_fork_process',
    error => $!,
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_fork_process"

  # my $message = $error->render;

  # "Can't fork process $pid: $!"

  # my $pid = $error->stash('pid');

  # "123"

=cut

$test->for('example', 1, 'error_on_fork_process', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_fork_process";
  my $message = $result->render;
  is $message, "Can't fork process 123: $!";
  my $pid = $result->stash('pid');
  is $pid, "123";

  $result
});

=error error_on_fork_support

This package may raise an error_on_fork_support exception.

=cut

$test->for('error', 'error_on_fork_support');

=example-1 error_on_fork_support

  # given: synopsis;

  my $input = {
    throw => 'error_on_fork_support',
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_fork_support"

  # my $message = $error->render;

  # "Can't fork process $pid: Fork emulation not supported"

  # my $pid = $error->stash('pid');

  # 123

=cut

$test->for('example', 1, 'error_on_fork_support', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_fork_support";
  my $message = $result->render;
  is $message, "Can't fork process 123: Fork emulation not supported";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_setid

This package may raise an error_on_setid exception.

=cut

$test->for('error', 'error_on_setid');

=example-1 error_on_setid

  # given: synopsis;

  my $input = {
    throw => 'error_on_setid',
    error => $!,
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_setid"

  # my $message = $error->render;

  # "Can't start a new session: $!"

  # my $pid = $error->stash('pid');

  # 123

=cut

$test->for('example', 1, 'error_on_setid', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_setid";
  my $message = $result->render;
  is $message, "Can't start a new session: $!";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_stderr

This package may raise an error_on_stderr exception.

=cut

$test->for('error', 'error_on_stderr');

=example-1 error_on_stderr

  # given: synopsis;

  my $input = {
    throw => 'error_on_stderr',
    error => $!,
    path => "/nowhere",
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_stderr"

  # my $message = $error->render;

  # "Can't redirect STDERR to \"/nowhere\": $!"

  # my $path = $error->stash('path');

  # "/nowhere"

  # my $pid = $error->stash('pid');

  # 123

=cut

$test->for('example', 1, 'error_on_stderr', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_stderr";
  my $message = $result->render;
  is $message, "Can't redirect STDERR to \"/nowhere\": $!";
  my $path = $result->stash('path');
  is $path, "/nowhere";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_stdin

This package may raise an error_on_stdin exception.

=cut

$test->for('error', 'error_on_stdin');

=example-1 error_on_stdin

  # given: synopsis;

  my $input = {
    throw => 'error_on_stdin',
    error => $!,
    path => "/nowhere",
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_stdin"

  # my $message = $error->render;

  # "Can't redirect STDIN to \"$path\": $!"

  # my $path = $error->stash('path');

  # "/nowhere"

  # my $pid = $error->stash('pid');

  # 123

=cut

$test->for('example', 1, 'error_on_stdin', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_stdin";
  my $message = $result->render;
  is $message, "Can't redirect STDIN to \"/nowhere\": $!";
  my $path = $result->stash('path');
  is $path, "/nowhere";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_stdout

This package may raise an error_on_stdout exception.

=cut

$test->for('error', 'error_on_stdout');

=example-1 error_on_stdout

  # given: synopsis;

  my $input = {
    throw => 'error_on_stdout',
    error => $!,
    path => "/nowhere",
    pid => 123,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_stdout"

  # my $message = $error->render;

  # "Can't redirect STDOUT to \"$path\": $!"

  # my $path = $error->stash('path');

  # "/nowhere"

  # my $pid = $error->stash('pid');

  # 123

=cut

$test->for('example', 1, 'error_on_stdout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_stdout";
  my $message = $result->render;
  is $message, "Can't redirect STDOUT to \"/nowhere\": $!";
  my $path = $result->stash('path');
  is $path, "/nowhere";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_timeout_poll

This package may raise an error_on_timeout_poll exception.

=cut

$test->for('error', 'error_on_timeout_poll');

=example-1 error_on_timeout_poll

  # given: synopsis;

  my $input = {
    throw => 'error_on_timeout_poll',
    code => sub{},
    timeout => 0,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_timeout_poll"

  # my $message = $error->render;

  # "Timed out after 0 seconds in process 12345 while polling __ANON__"

  # my $code = $error->stash('code');

  # sub{}

  # my $exchange = $error->stash('exchange');

  # undef

  # my $pid = $error->stash('pid');

  # 12345

  # my $timeout = $error->stash('timeout');

  # 0

=cut

$test->for('example', 1, 'error_on_timeout_poll', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_timeout_poll";
  my $message = $result->render;
  is $message, "Timed out after 0 seconds in process 12345 while polling __ANON__";
  my $code = $result->stash('code');
  ok ref $code, 'CODE';
  my $exchange = $result->stash('exchange');
  is $exchange, undef;
  my $pid = $result->stash('pid');
  is $pid, 12345;
  my $timeout = $result->stash('timeout');
  is $timeout, 0;

  $result
});

=error error_on_timeout_pool

This package may raise an error_on_timeout_pool exception.

=cut

$test->for('error', 'error_on_timeout_pool');

=example-1 error_on_timeout_pool

  # given: synopsis;

  my $input = {
    throw => 'error_on_timeout_pool',
    pool_size => 2,
    timeout => 0,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_timeout_pool"

  # my $message = $error->render;

  # "Timed out after 0 seconds in process 12345 while pooling"

  # my $exchange = $error->stash('exchange');

  # undef

  # my $pid = $error->stash('pid');

  # 12345

  # my $pool_size = $error->stash('pool_size');

  # 2

  # my $timeout = $error->stash('timeout');

  # 0

=cut

$test->for('example', 1, 'error_on_timeout_pool', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_timeout_pool";
  my $message = $result->render;
  is $message, "Timed out after 0 seconds in process 12345 while pooling";
  my $exchange = $result->stash('exchange');
  is $exchange, undef;
  my $pid = $result->stash('pid');
  is $pid, 12345;
  my $pool_size = $result->stash('pool_size');
  is $pool_size, 2;
  my $timeout = $result->stash('timeout');
  is $timeout, 0;

  $result
});

=error error_on_timeout_sync

This package may raise an error_on_timeout_sync exception.

=cut

$test->for('error', 'error_on_timeout_sync');

=example-1 error_on_timeout_sync

  # given: synopsis;

  my $input = {
    throw => 'error_on_timeout_sync',
    pool_size => 2,
    timeout => 0,
  };

  my $error = $parent->catch('error', $input);

  # my $name = $error->name;

  # "on_timeout_sync"

  # my $message = $error->render;

  # "Timed out after 0 seconds in process 12345 while syncing"

  # my $exchange = $error->stash('exchange');

  # undef

  # my $pid = $error->stash('pid');

  # 12345

  # my $pool_size = $error->stash('pool_size');

  # 2

  # my $timeout = $error->stash('timeout');

  # 0

=cut

$test->for('example', 1, 'error_on_timeout_sync', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_timeout_sync";
  my $message = $result->render;
  is $message, "Timed out after 0 seconds in process 12345 while syncing";
  my $exchange = $result->stash('exchange');
  is $exchange, undef;
  my $pid = $result->stash('pid');
  is $pid, 12345;
  my $pool_size = $result->stash('pool_size');
  is $pool_size, 2;
  my $timeout = $result->stash('timeout');
  is $timeout, 0;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

Venus::Path->new($Venus::Process::PATH)->rmdirs;

$test->render('lib/Venus/Process.pod') if $ENV{VENUS_RENDER};

SKIP:
ok 1 and done_testing;
