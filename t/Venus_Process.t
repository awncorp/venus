package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

use Config;
use Venus::Process;

if ($Config{d_pseudofork}) {
  diag 'Fork emulation not supported';
  goto SKIP;
}

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
method: daemon
method: disengage
method: engage
method: exit
method: fork
method: forks
method: kill
method: setsid
method: stderr
method: stdin
method: stdout
method: trap
method: wait
method: work
method: untrap

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
Venus::Role::Explainable

=cut

$test->for('inherits');

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

  # Exception! Venus::Process::Error (isa Venus::Error)

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

  # Exception! Venus::Process:Error (isa Venus::Error)

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

  my $kill = $parent->kill('term', int$process);

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

  # Exception! Venus::Process::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'setsid', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_SETSID = -1;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');

  $result
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

  # Exception! Venus::Process:Error (isa Venus::Error)

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

  # Exception! Venus::Process::Error (isa Venus::Error)

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

  # Exception! Venus::Process::Error (isa Venus::Process)

=cut

$test->for('example', 2, 'stdout', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_PROCESS_OPEN = 0;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Process::Error');
  ok $error->isa('Venus::Error');

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

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Process.pod') if $ENV{RENDER};

SKIP:
ok 1 and done_testing;
