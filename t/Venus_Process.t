package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Config;
use Venus::Process;

if ($Config{d_pseudofork}) {
  diag 'Fork emulation not supported';
  goto SKIP;
}

our $TEST_VENUS_PROCESS_ALARM = 0;
our $TEST_VENUS_PROCESS_CHDIR = 1;
our $TEST_VENUS_PROCESS_EXIT = 0;
our $TEST_VENUS_PROCESS_EXITCODE = 0;
our $TEST_VENUS_PROCESS_FORK = undef;
our $TEST_VENUS_PROCESS_FORKABLE = 1;
our $TEST_VENUS_PROCESS_KILL = 0;
our $TEST_VENUS_PROCESS_OPEN = 1;
our $TEST_VENUS_PROCESS_PID = 12345;
our $TEST_VENUS_PROCESS_SETSID = 1;
our $TEST_VENUS_PROCESS_WAITPID = undef;

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
      return $TEST_VENUS_PROCESS_PID++;
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

# _pid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_pid"} = sub {
    $TEST_VENUS_PROCESS_PID
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

# _waitpid
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Process::_waitpid"} = sub {
    if (defined $TEST_VENUS_PROCESS_WAITPID) {
      return $TEST_VENUS_PROCESS_WAITPID;
    }
    else {
      return --$TEST_VENUS_PROCESS_PID;
    }
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

method: chdir
method: check
method: count
method: daemon
method: disengage
method: engage
method: exit
method: fork
method: forks
method: kill
method: killall
method: pid
method: pids
method: ping
method: prune
method: restart
method: setsid
method: started
method: status
method: stderr
method: stdin
method: stdout
method: stopped
method: trap
method: wait
method: waitall
method: watch
method: watchlist
method: work
method: works
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
  local $TEST_VENUS_PROCESS_WAITPID = $TEST_VENUS_PROCESS_PID + 1;
  local $TEST_VENUS_PROCESS_EXITCODE = local $TEST_VENUS_PROCESS_EXIT = 1;
  ok my @result = $tryable->result;
  is_deeply \@result, [$TEST_VENUS_PROCESS_PID, 1];

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
  is_deeply $result, [12345];

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

  # given: synopsis

  package main;

  $parent->watch(1001);

  my $status = $parent->status(sub {
    my ($pid, $check, $exit) = @_;

    # assuming process 1001 is still running (not terminated)

    return [$pid, $check, $exit];
  });

  # [[1001, 0, -1]]

=cut

$test->for('example', 1, 'status', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 1001;
  local $TEST_VENUS_PROCESS_WAITPID = 0;
  local $TEST_VENUS_PROCESS_EXITCODE = -1;
  my $result = $tryable->result;
  is_deeply $result, [[1001, 0, -1]];

  $result
});

=example-2 status

  # given: synopsis

  package main;

  $parent->watch(1001);

  my $status = $parent->status(sub {
    my ($pid, $check, $exit) = @_;

    # assuming process 1001 terminated with exit code 255

    return [$pid, $check, $exit];
  });

  # [[1001, 1001, 255]]

=cut

$test->for('example', 2, 'status', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 1001;
  local $TEST_VENUS_PROCESS_WAITPID = 1001;
  local $TEST_VENUS_PROCESS_EXITCODE = 255;
  my $result = $tryable->result;
  is_deeply $result, [[1001, 1001, 255]];

  $result
});

=example-3 status

  # given: synopsis

  package main;

  $parent->watch(1001);

  my @status = $parent->status(sub {
    my ($pid, $check, $exit) = @_;

    # assuming process 1001 terminated with exit code 255

    return [$pid, $check, $exit];
  });

  # ([1001, 1001, 255])

=cut

$test->for('example', 3, 'status', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_PID = 1001;
  local $TEST_VENUS_PROCESS_WAITPID = 1001;
  local $TEST_VENUS_PROCESS_EXITCODE = 255;
  my @result = $tryable->result;
  is_deeply [@result], [[1001, 1001, 255]];

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
  is_deeply $result, [12345];

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
  local $TEST_VENUS_PROCESS_WAITPID = $TEST_VENUS_PROCESS_PID + 1;
  local $TEST_VENUS_PROCESS_EXITCODE = local $TEST_VENUS_PROCESS_EXIT = 1;
  ok my @result = $tryable->result;
  is_deeply \@result, [$TEST_VENUS_PROCESS_PID, 1];

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

  my @args = ('/nowhere', 123);

  my $error = $parent->throw('error_on_chdir', @args)->catch('error');

  # my $name = $error->name;

  # "on_chdir"

  # my $message = $error->message;

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
  my $message = $result->message;
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

  my @args = (123);

  my $error = $parent->throw('error_on_fork_process', @args)->catch('error');

  # my $name = $error->name;

  # "on_fork_process"

  # my $message = $error->message;

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
  my $message = $result->message;
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

  my @args = (123);

  my $error = $parent->throw('error_on_fork_support', @args)->catch('error');

  # my $name = $error->name;

  # "on_fork_support"

  # my $message = $error->message;

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
  my $message = $result->message;
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

  my @args = (123);

  my $error = $parent->throw('error_on_setid', @args)->catch('error');

  # my $name = $error->name;

  # "on_setid"

  # my $message = $error->message;

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
  my $message = $result->message;
  is $message, "Can't start a new session: $!";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=error error_on_stdin

This package may raise an error_on_stdin exception.

=cut

$test->for('error', 'error_on_stdin');

=example-1 error_on_stderr

  # given: synopsis;

  my @args = ('/nowhere', 123);

  my $error = $parent->throw('error_on_stderr', @args)->catch('error');

  # my $name = $error->name;

  # "on_stderr"

  # my $message = $error->message;

  # "Can't redirect STDERR to \"$path\": $!"

  # my $path = $error->stash('path');

  # "/nowhere"

=cut

$test->for('example', 1, 'error_on_stderr', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_stderr";
  my $message = $result->message;
  is $message, "Can't redirect STDERR to \"/nowhere\": $!";
  my $path = $result->stash('path');
  is $path, "/nowhere";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=example-1 error_on_stdin

  # given: synopsis;

  my @args = ('/nowhere', 123);

  my $error = $parent->throw('error_on_stdin', @args)->catch('error');

  # my $name = $error->name;

  # "on_stdin"

  # my $message = $error->message;

  # "Can't redirect STDIN to \"$path\": $!"

  # my $path = $error->stash('path');

  # "/nowhere"

=cut

$test->for('example', 1, 'error_on_stdin', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_stdin";
  my $message = $result->message;
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

  my @args = ( '/nowhere', 123);

  my $error = $parent->throw('error_on_stdout', @args)->catch('error');

  # my $name = $error->name;

  # "on_stdout"

  # my $message = $error->message;

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
  my $message = $result->message;
  is $message, "Can't redirect STDOUT to \"/nowhere\": $!";
  my $path = $result->stash('path');
  is $path, "/nowhere";
  my $pid = $result->stash('pid');
  is $pid, 123;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Process.pod') if $ENV{RENDER};

SKIP:
ok 1 and done_testing;
