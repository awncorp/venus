package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus::Log;
use Venus::Space;
use Venus::Task;

our $TEST_VENUS_TASK_EXIT = 0;
our $TEST_VENUS_TASK_LOGS = [];
our $TEST_VENUS_TASK_PRINT = [];
our $TEST_VENUS_TASK_LOG_LEVEL = 'trace';
our $TEST_VENUS_TASK_SYSTEM = 0;

# _exit
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Task::_exit"} = sub {
    $TEST_VENUS_TASK_EXIT = $_[0]
  };
}

# _print
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Task::_print"} = sub {
    push @{$TEST_VENUS_TASK_PRINT}, [@_]
  };
}

# _system
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Task::_system"} = sub {
    $TEST_VENUS_TASK_SYSTEM
  };
}

# log_level
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Task::log_level"} = sub {
    $TEST_VENUS_TASK_LOG_LEVEL
  };
}

my $test = test(__FILE__);

=name

Venus::Task

=cut

$test->for('name');

=tagline

Task Class

=cut

$test->for('tagline');

=abstract

Task Class for Perl 5

=cut

$test->for('abstract');

=includes

method: args
method: cmds
method: description
method: execute
method: exit
method: fail
method: footer
method: handler
method: header
method: help
method: log_debug
method: log_error
method: log_fatal
method: log_info
method: log_level
method: log_trace
method: log_warn
method: name
method: okay
method: opts
method: output
method: prepare
method: pass
method: run
method: startup
method: shutdown
method: system
method: test
method: usage

=cut

$test->for('includes');

=synopsis

  package Example;

  use base 'Venus::Task';

  package main;

  my $task = Example->new(['--help']);

  # bless({...}, 'Example')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Task');
  is_deeply $result->data, ['--help'];

  $result
});

=description

This package provides a superclass, methods, and a simple framework for
creating CLIs (command-line interfaces).

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

=attribute data

The data attribute is read-write, accepts C<(ArrayRef)> values, and is
optional.

=signature data

  data(ArrayRef $data) (ArrayRef)

=metadata data

{
  since => '2.91',
}

=cut

=example-1 data

  # given: synopsis

  package main;

  my $set_data = $task->data([1..4]);

  # [1..4]

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1..4];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 data

  # given: synopsis

  # given: example-1 data

  package main;

  my $get_data = $task->data;

  # [1..4]

=cut

$test->for('example', 2, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1..4];

  Venus::Space->new('Example')->unload;
  $result
});

=method args

The args method can be overridden and returns a hashref suitable to be passed
to the L<Venus::Cli/set> method as type C<"arg">. An C<"arg"> is a CLI
positional argument.

=signature args

  args() (HashRef)

=metadata args

{
  since => '2.91',
}

=cut

=example-1 args

  # given: synopsis

  package main;

  my $args = $task->args;

  # {}

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {};

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 args

  package Example;

  use base 'Venus::Task';

  sub args {

    return {
      name => {
        help => 'Name of user',
      },
    }
  }

  package main;

  my $task = Example->new;

  my $args = $task->args;

  # {
  #   name => {
  #     help => 'Name of user',
  #   },
  # }

=cut

$test->for('example', 2, 'args', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    name => {
      help => 'Name of user',
    },
  };

  Venus::Space->new('Example')->unload;
  $result
});

=method cli

The cli method can be overridden and returns a L<Venus::Cli> object. The
L<Venus::Cli> object is configured automatically when L</prepare> is executed.

=signature cli

  cli() (Cli)

=metadata cli

{
  since => '2.91',
}

=cut

=example-1 cli

  # given: synopsis

  package main;

  my $cli = $task->cli;

  # bless({...}, 'Venus::Cli')

=cut

$test->for('example', 1, 'cli', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Cli';

  Venus::Space->new('Example')->unload;
  $result
});

=method cmds

The cmds method can be overridden and returns a hashref suitable to be passed
to the L<Venus::Cli/set> method as type C<"cmd">. A C<"cmd"> is a CLI command
which maps to an positional argument declare by L</args>.

=signature cmds

  cmds() (HashRef)

=metadata cmds

{
  since => '2.91',
}

=cut

=example-1 cmds

  # given: synopsis

  package main;

  my $cmds = $task->cmds;

  # {}

=cut

$test->for('example', 1, 'cmds', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {};

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 cmds

  package Example;

  use base 'Venus::Task';

  sub args {

    return {
      op => {
        help => 'Name of operation',
      },
    }
  }

  sub cmds {

    return {
      init => {
        help => 'Initialize the system',
        arg => 'op',
      },
    }
  }

  package main;

  my $task = Example->new;

  my $cmds = $task->cmds;

  # {
  #   init => {
  #     help => 'Initialize the system',
  #     arg => 'op',
  #   },
  # }

=cut

$test->for('example', 2, 'cmds', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    init => {
      help => 'Initialize the system',
      arg => 'op',
    },
  };

  Venus::Space->new('Example')->unload;
  $result
});

=method description

The description method doesn't exist on the L<Venus::Task> superclass but if
defined returns a string that will be used as the CLI "description" (before the
arguments, options, and commands text).

=signature description

  description() (Task)

=metadata description

{
  since => '2.91',
}

=cut

=example-1 description

  package Example;

  use base 'Venus::Task';

  sub description {

    "This text used in the description area of the usage text"
  }

  package main;

  my $task = Example->new;

  my $description = $task->description;

  # "..."

=cut

$test->for('example', 1, 'description', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "This text used in the description area of the usage text";
  $result = Example->new->prepare;
  isa_ok $result, 'Venus::Task';
  is_deeply $result->cli->get('str'), {
    name => {
      value => $0
    },
    description => {
      value => "This text used in the description area of the usage text"
    },
  };
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method execute

The execute method can be overridden and returns the invocant. This method
prepares the L<Venus::Cli> via L</prepare>, and runs the L</startup>,
L</handler>, and L</shutdown> sequences, passing L<Venus::Cli/parsed> to each
method.

=signature execute

  execute() (Task)

=metadata execute

{
  since => '2.91',
}

=cut

=example-1 execute

  # given: synopsis

  package main;

  my $execute = $task->execute;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'execute', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 execute

  package Example;

  use base 'Venus::Task';

  sub args {

    return {
      name => {
        help => 'Name of user',
      },
    }
  }

  sub opts {

    return {
      sudo => {
        help => 'Elevate user privileges',
        alias => ['s'],
      },
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  sub startup {
    my ($self) = @_;

    $self->{startup} = time;

    return $self;
  }

  sub handler {
    my ($self, $data) = @_;

    $self->{handler} = time;
    $self->{parsed} = $data;

    return $self;
  }

  sub shutdown {
    my ($self) = @_;

    $self->{shutdown} = time;

    return $self;
  }

  package main;

  my $task = Example->new(['admin', '-s']);

  my $execute = $task->execute;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 2, 'execute', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [];
  ok my $startup = $result->{startup};
  ok my $handler = $result->{handler};
  ok my $parsed = $result->{parsed};
  ok my $shutdown = $result->{shutdown};
  ok (($startup <= $handler) && ($handler <= $shutdown));
  is_deeply $parsed, {name => 'admin', 'sudo' => 1, help => undef};

  Venus::Space->new('Example')->unload;
  $result
});

=example-3 execute

  package Example;

  use base 'Venus::Task';

  sub args {

    return {
      name => {
        help => 'Name of user',
      },
    }
  }

  sub opts {

    return {
      sudo => {
        help => 'Elevate user privileges',
        alias => ['s'],
      },
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  sub handler {
    my ($self, $data) = @_;

    $self->{handler} = time;
    $self->{parsed} = $data;

    return $self;
  }

  package main;

  my $task = Example->new(['-s']);

  my $execute = $task->execute;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 3, 'execute', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [];
  ok my $handler = $result->{handler};
  ok my $parsed = $result->{parsed};
  is_deeply $parsed, {name => undef, 'sudo' => 1, help => undef};

  Venus::Space->new('Example')->unload;
  $result
});

=method exit

The exit method exits the program using the exit code provided. The exit code
defaults to C<0>. Optionally, you can dispatch before exiting by providing a
method name or coderef, and arguments. If an exit code of C<undef> is provided,
the exit code will be determined by the result of the dispatching.

=signature exit

  exit(Int $code, Str|CodeRef $code, Any @args) (Any)

=metadata exit

{
  since => '2.91',
}

=example-1 exit

  # given: synopsis

  package main;

  my $exit = $task->exit;

  # ()

=cut

$test->for('example', 1, 'exit', sub {
  local $TEST_VENUS_TASK_EXIT = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 0;

  Venus::Space->new('Example')->unload;
  !$result
});

=example-2 exit

  # given: synopsis

  package main;

  my $exit = $task->exit(0);

  # ()

=cut

$test->for('example', 2, 'exit', sub {
  local $TEST_VENUS_TASK_EXIT = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 0;

  Venus::Space->new('Example')->unload;
  !$result
});

=example-3 exit

  # given: synopsis

  package main;

  my $exit = $task->exit(1);

  # ()

=cut

$test->for('example', 3, 'exit', sub {
  local $TEST_VENUS_TASK_EXIT = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 1;

  Venus::Space->new('Example')->unload;
  $result
});

=example-4 exit

  # given: synopsis

  package main;

  my $exit = $task->exit(1, 'log_error', 'oh no');

  # ()

=cut

$test->for('example', 4, 'exit', sub {
  local $TEST_VENUS_TASK_EXIT = 0;
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 1;
  is_deeply $TEST_VENUS_TASK_PRINT, [['oh no', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method fail

The fail method exits the program with the exit code C<1>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature fail

  fail(Str|CodeRef $code, Any @args) (Any)

=metadata fail

{
  since => '2.91',
}

=example-1 fail

  # given: synopsis

  package main;

  my $fail = $task->fail;

  # ()

=cut

$test->for('example', 1, 'fail', sub {
  local $TEST_VENUS_TASK_EXIT = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 1;

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 fail

  # given: synopsis

  package main;

  my $fail = $task->fail('log_error', 'oh no');

  # ()

=cut

$test->for('example', 2, 'fail', sub {
  local $TEST_VENUS_TASK_EXIT = 0;
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 1;
  is_deeply $TEST_VENUS_TASK_PRINT, [['oh no', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method footer

The footer method doesn't exist on the L<Venus::Task> superclass but if defined
returns a string that will be used as the CLI "footer" (after the arguments,
options, and commands text).

=signature footer

  footer() (Task)

=metadata footer

{
  since => '2.91',
}

=cut

=example-1 footer

  package Example;

  use base 'Venus::Task';

  sub footer {

    "This text used in the footer area of the usage text"
  }

  package main;

  my $task = Example->new;

  my $footer = $task->footer;

  # "..."

=cut

$test->for('example', 1, 'footer', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "This text used in the footer area of the usage text";
  $result = Example->new->prepare;
  isa_ok $result, 'Venus::Task';
  is_deeply $result->cli->get('str'), {
    name => {
      value => $0
    },
    footer => {
      value => "This text used in the footer area of the usage text"
    },
  };
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method handler

The handler method can and should be overridden and returns the invocant. This
method is where the central task operations are meant to happen. By default, if
not overriden this method calls L</usage> if a "help" flag is detected.

=signature handler

  handler(HashRef $data) (Task)

=metadata handler

{
  since => '2.91',
}

=cut

=example-1 handler

  # given: synopsis

  package main;

  my $handler = $task->handler({});

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'handler', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 handler

  # given: synopsis

  package main;

  my $handler = $task->handler({help => 1});

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 2, 'handler', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [['Usage: application', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=example-3 handler

  package Example;

  use base 'Venus::Task';

  sub handler {
    my ($self, $data) = @_;

    $self->{handler} = time;
    $self->{parsed} = $data;

    return $self;
  }

  package main;

  my $task = Example->new;

  my $handler = $task->handler({});

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 3, 'handler', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  ok $result->{handler};
  is_deeply $result->{parsed}, {};
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method header

The header method doesn't exist on the L<Venus::Task> superclass but if defined
returns a string that will be used as the CLI "header" (after the title, before
the arguments, options, and commands text).

=signature header

  header() (Task)

=metadata header

{
  since => '2.91',
}

=cut

=example-1 header

  package Example;

  use base 'Venus::Task';

  sub header {

    "This text used in the header area of the usage text"
  }

  package main;

  my $task = Example->new;

  my $header = $task->header;

  # "..."

=cut

$test->for('example', 1, 'header', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "This text used in the header area of the usage text";
  $result = Example->new->prepare;
  isa_ok $result, 'Venus::Task';
  is_deeply $result->cli->get('str'), {
    name => {
      value => $0
    },
    header => {
      value => "This text used in the header area of the usage text"
    },
  };
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method help

The help method can be overridden and returns a string representing "help" text
for the CLI. By default this method returns the result of L<Venus::Cli/help>,
based on the L</cli> object.

=signature help

  help() (Str)

=metadata help

{
  since => '2.91',
}

=cut

=example-1 help

  # given: synopsis

  package main;

  my $help = $task->help;

  # "Usage: application"

=cut

$test->for('example', 1, 'help', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'Usage: application';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 help

  package Example;

  use base 'Venus::Task';

  sub name {

    return 'eg';
  }

  package main;

  my $task = Example->new;

  $task->prepare;

  my $help = $task->help;

  # "Usage: application"

=cut

$test->for('example', 2, 'help', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'Usage: eg';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method log

The log method can be overridden and returns a L<Venus::Log> object. The
L<Venus::Log> object is configured automatically when L</prepare> is executed.

=signature log

  log(Log $data) (Log)

=metadata log

{
  since => '2.91',
}

=cut

=example-1 log

  # given: synopsis

  package main;

  my $log = $task->log;

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';

  Venus::Space->new('Example')->unload;
  $result
});

=method log_debug

The log_debug method dispatches to the L<Venus::Log/debug> method and returns the
result.

=signature log_debug

  log_debug(Any @log_debug) (Log)

=metadata log_debug

{
  since => '2.91',
}

=cut

=example-1 log_debug

  # given: synopsis

  package main;

  my $log_debug = $task->log_debug('something' ,'happened');

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log_debug', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method log_error

The log_error method dispatches to the L<Venus::Log/error> method and returns the
result.

=signature log_error

  log_error(Any @log_error) (Log)

=metadata log_error

{
  since => '2.91',
}

=cut

=example-1 log_error

  # given: synopsis

  package main;

  my $log_error = $task->log_error('something' ,'happened');

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log_error', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method log_fatal

The log_fatal method dispatches to the L<Venus::Log/fatal> method and returns the
result.

=signature log_fatal

  log_fatal(Any @log_fatal) (Log)

=metadata log_fatal

{
  since => '2.91',
}

=cut

=example-1 log_fatal

  # given: synopsis

  package main;

  my $log_fatal = $task->log_fatal('something' ,'happened');

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log_fatal', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method log_info

The log_info method dispatches to the L<Venus::Log/info> method and returns the
result.

=signature log_info

  log_info(Any @log_info) (Log)

=metadata log_info

{
  since => '2.91',
}

=cut

=example-1 log_info

  # given: synopsis

  package main;

  my $log_info = $task->log_info('something' ,'happened');

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log_info', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method log_level

The log_level method can be overridden and returns a valid L<Venus::Log/level>
value. This method defaults to returning L<info>.

=signature log_level

  log_level() (Str)

=metadata log_level

{
  since => '2.91',
}

=cut

=example-1 log_level

  # given: synopsis

  package main;

  my $log_level = $task->log_level;

  # "info"

=cut

$test->for('example', 1, 'log_level', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_TASK_LOG_LEVEL = 'info';
  my $result = $tryable->result;
  is $result, "info";

  $result
});

=method log_trace

The log_trace method dispatches to the L<Venus::Log/trace> method and returns the
result.

=signature log_trace

  log_trace(Any @log_trace) (Log)

=metadata log_trace

{
  since => '2.91',
}

=cut

=example-1 log_trace

  # given: synopsis

  package main;

  my $log_trace = $task->log_trace('something' ,'happened');

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log_trace', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method log_warn

The log_warn method dispatches to the L<Venus::Log/warn> method and returns the
result.

=signature log_warn

  log_warn(Any @log_warn) (Log)

=metadata log_warn

{
  since => '2.91',
}

=cut

=example-1 log_warn

  # given: synopsis

  package main;

  my $log_warn = $task->log_warn('something' ,'happened');

  # bless({...}, 'Venus::Log')

=cut

$test->for('example', 1, 'log_warn', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Log';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method name

The name method can be overridden and returns the name of the task (and
application). This method defaults to C<$0> if not overridden.

=signature name

  name() (Task)

=metadata name

{
  since => '2.91',
}

=cut

=example-1 name

  # given: synopsis

  package main;

  my $name = $task->name;

  # "/path/to/application"

=cut

$test->for('example', 1, 'name', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, $0;
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 name

  package Example;

  use base 'Venus::Task';

  sub name {

    return 'eg';
  }

  package main;

  my $task = Example->new;

  my $name = $task->name;

  # "eg"

=cut

$test->for('example', 2, 'name', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'eg';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method okay

The okay method exits the program with the exit code C<0>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature okay

  okay(Str|CodeRef $code, Any @args) (Any)

=metadata okay

{
  since => '2.91',
}

=example-1 okay

  # given: synopsis

  package main;

  my $okay = $task->okay;

  # ()

=cut

$test->for('example', 1, 'okay', sub {
  local $TEST_VENUS_TASK_EXIT = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 0;

  Venus::Space->new('Example')->unload;
  !$result
});

=example-2 okay

  # given: synopsis

  package main;

  my $okay = $task->okay('log_info', 'yatta');

  # ()

=cut

$test->for('example', 2, 'okay', sub {
  local $TEST_VENUS_TASK_EXIT = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 0;

  Venus::Space->new('Example')->unload;
  !$result
});

=method opts

The opts method can be overridden and returns a hashref suitable to be passed
to the L<Venus::Cli/set> method as type C<"opt">. An C<"opt"> is a CLI option
(or flag).

=signature opts

  opts() (HashRef)

=metadata opts

{
  since => '2.91',
}

=cut

=example-1 opts

  # given: synopsis

  package main;

  my $opts = $task->opts;

  # {}

=cut

$test->for('example', 1, 'opts', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {};

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 opts

  package Example;

  use base 'Venus::Task';

  sub opts {

    return {
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  package main;

  my $task = Example->new;

  my $opts = $task->opts;

  # {
  #   help => {
  #     help => 'Display help',
  #     alias => ['h'],
  #   },
  # }

=cut

$test->for('example', 2, 'opts', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    help => {
      help => 'Display help',
      alias => ['h'],
    },
  };

  Venus::Space->new('Example')->unload;
  $result
});

=method output

The output method is configured as the L<Venus::Log/handler> by L</prepare>,
can be overridden and returns the invocant.

=signature output

  output(Str $level, Str @messages) (Task)

=metadata output

{
  since => '2.91',
}

=cut

=example-1 output

  # given: synopsis

  package main;

  $task->prepare;

  $task = $task->output('info', 'something happened');

  # bless({...}, 'Example')

=cut

$test->for('example', 1, 'output', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Example';
  is_deeply $TEST_VENUS_TASK_PRINT, [['something happened', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=method prepare

The prepare method can be overridden, but typically shouldn't, is responsible
for configuring the L</cli> and L</log> objects, parsing the arguments, and
after returns the invocant.

=signature prepare

  prepare() (Task)

=metadata prepare

{
  since => '2.91',
}

=cut

=example-1 prepare

  # given: synopsis

  package main;

  my $prepare = $task->prepare;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'prepare', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $result->cli->get('arg'), undef;
  is_deeply $result->cli->get('cmd'), undef;
  is_deeply $result->cli->get('opt'), undef;
  is_deeply $result->cli->get('str'), {
    name => { value => $0 },
  };
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 prepare

  package Example;

  use base 'Venus::Task';

  sub args {

    return {
      name => {
        help => 'Name of user',
      },
    }
  }

  sub opts {

    return {
      sudo => {
        help => 'Elevate user privileges',
        alias => ['s'],
      },
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  package main;

  my $task = Example->new;

  my $prepare = $task->prepare;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 2, 'prepare', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $result->cli->get('arg'), {
    name => {
      name => 'name',
      help => 'Name of user',
    }
  };
  is_deeply $result->cli->get('cmd'), undef;
  is_deeply $result->cli->get('opt'), {
    sudo => {
      name => 'sudo',
      help => 'Elevate user privileges',
      alias => ['s'],
    },
    help => {
      name => 'help',
      help => 'Display help',
      alias => ['h'],
    },
  };
  is_deeply $result->cli->get('str'), {
    name => { value => $0 },
  };
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-3 prepare

  package Example;

  use base 'Venus::Task';

  sub args {

    return {
      name => {
        help => 'Name of user',
      },
    }
  }

  sub cmds {

    return {
      admin => {
        help => 'Run as an admin',
        arg => 'name',
      },
      user => {
        help => 'Run as a user',
        arg => 'name',
      },
    }
  }

  sub opts {

    return {
      sudo => {
        help => 'Elevate user privileges',
        alias => ['s'],
      },
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  package main;

  my $task = Example->new(['admin', '-s']);

  my $prepare = $task->prepare;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 3, 'prepare', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $result->cli->get('arg'), {
    name => {
      name => 'name',
      help => 'Name of user',
    }
  };
  is_deeply $result->cli->get('cmd'), {
    admin => {
      name => 'admin',
      help => 'Run as an admin',
      arg => 'name',
    },
    user => {
      name => 'user',
      help => 'Run as a user',
      arg => 'name',
    },
  };
  is_deeply $result->cli->get('opt'), {
    sudo => {
      name => 'sudo',
      help => 'Elevate user privileges',
      alias => ['s'],
    },
    help => {
      name => 'help',
      help => 'Display help',
      alias => ['h'],
    },
  };
  is_deeply $result->cli->get('str'), {
    name => { value => $0 },
  };
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method pass

The pass method exits the program with the exit code C<0>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature pass

  pass(Str|CodeRef $code, Any @args) (Any)

=metadata pass

{
  since => '3.10',
}

=example-1 pass

  # given: synopsis

  package main;

  my $pass = $task->pass;

  # ()

=cut

$test->for('example', 1, 'pass', sub {
  local $TEST_VENUS_TASK_EXIT = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 0;

  Venus::Space->new('Example')->unload;
  !$result
});

=example-2 pass

  # given: synopsis

  package main;

  my $pass = $task->pass('log_info', 'yatta');

  # ()

=cut

$test->for('example', 2, 'pass', sub {
  local $TEST_VENUS_TASK_EXIT = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $TEST_VENUS_TASK_EXIT, 0;

  Venus::Space->new('Example')->unload;
  !$result
});

=method run

The run class method will automatically execute the task class by instansiating
the class and calling the L</execute> method and returns the invocant. This
method is meant to be used directly in package scope outside of any routine,
and will only auto-execute under the conditions that the caller is the "main"
package space and the C<VENUS_TASK_AUTO> environment variable is truthy.

=signature run

  run(Any @args) (Task)

=metadata run

{
  since => '2.91',
}

=cut

=example-1 run

  package Example;

  use base 'Venus::Task';

  sub opts {

    return {
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  package main;

  my $task = Example->new(['--help']);

  my $run = $task->run;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'run', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  local $ENV{VENUS_TASK_AUTO} = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  # will not run in eval context
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 run

  package Example;

  use base 'Venus::Task';

  sub opts {

    return {
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  run Example;

  # 'Example'

=cut

$test->for('example', 2, 'run', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  local $ENV{VENUS_TASK_AUTO} = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  # will not run in eval context
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method startup

The startup method can be overridden and returns the invocant. This method is
called by L</execute> automatically after L</prepare> and before L</handler>,
and is passed the result of L<Venus::Cli/parsed>.

=signature startup

  startup(HashRef $data) (Task)

=metadata startup

{
  since => '2.91',
}

=cut

=example-1 startup

  # given: synopsis

  package main;

  my $startup = $task->startup({});

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'startup', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method shutdown

The shutdown method can be overridden and returns the invocant. This method is
called by L</execute> automatically after L</handler> and is passed the result
of L<Venus::Cli/parsed>.

=signature shutdown

  shutdown(HashRef $data) (Task)

=metadata shutdown

{
  since => '2.91',
}

=cut

=example-1 shutdown

  # given: synopsis

  package main;

  my $shutdown = $task->shutdown({});

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'shutdown', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [];

  Venus::Space->new('Example')->unload;
  $result
});

=method system

The system method attempts to make a L<perlfunc/system> call and returns the
invocant. If the system call is unsuccessful an error is thrown.

=signature system

  system(Str @args) (Task)

=metadata system

{
  since => '2.91',
}

=cut

=example-1 system

  # given: synopsis

  package main;

  my $system = $task->system($^X, '-V');

  # bless({...},  'Example')

=cut

$test->for('example', 1, 'system', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Example';

  $result
});

=example-2 system

  # given: synopsis

  package main;

  my $system = $task->system('/path/to/nowhere');

  # Exception! (isa Example::Error) (see error_on_system_call)

=cut

$test->for('example', 2, 'system', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_TASK_SYSTEM = 1;
  my $result = $tryable->error->result;
  isa_ok $result, 'Example::Error';
  is $result->name, 'on_system_call';

  $result
});

=method test

The test method validates the values for the C<arg> or C<opt> specified and
returns the value(s) associated. This method dispatches to L<Venus::Cli/test>.

=signature test

  test(Str $type, Str $name) (Any)

=metadata test

{
  since => '3.10',
}

=cut

=example-1 test

  package Example;

  use base 'Venus::Task';

  sub opts {

    return {
      help => {
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  package main;

  my $task = Example->new(['--help']);

  my ($help) = $task->prepare->test('opt', 'help');

  # true

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  Venus::Space->new('Example')->unload;
  $result
});

=example-2 test

  package Example;

  use base 'Venus::Task';

  sub opts {

    return {
      help => {
        type => 'string',
        help => 'Display help',
        alias => ['h'],
      },
    }
  }

  package main;

  my $task = Example->new(['--help']);

  my ($help) = $task->prepare->test('opt', 'help');

  # Exception! (isa Venus::Cli::Error) (see error_on_arg_validation)

  # Invalid option: help: received (undef), expected (string)

=cut

$test->for('example', 2, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Cli::Error';
  ok $result->is('on.opt.validation');
  like $result->render, qr/Invalid option: help/;

  Venus::Space->new('Example')->unload;
  $result
});

=method usage

The usage method exits the program with the exit code C<1> after calling
L</log_info> with the result of L</help>. This method makes it easy to output
the default help text and end the program if some condition isn't met.

=signature usage

  usage() (Task)

=metadata usage

{
  since => '2.91',
}

=cut

=example-1 usage

  # given: synopsis

  package main;

  my $usage = $task->usage;

  # bless({...}, 'Venus::Task')

=cut

$test->for('example', 1, 'usage', sub {
  local $TEST_VENUS_TASK_PRINT = [];
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Task';
  is_deeply $TEST_VENUS_TASK_PRINT, [['Usage: application', "\n"]];

  Venus::Space->new('Example')->unload;
  $result
});

=error error_on_system_call

This package may raise an error_on_system_call exception.

=cut

$test->for('error', 'error_on_system_call');

=example-1 error_on_system_call

  # given: synopsis;

  my $input = {
    throw => 'error_on_system_call',
    args => ['/path/to/nowhere', 'arg1', 'arg2'],
    error => $?,
  };

  my $error = $task->catch('error', $input);

  # my $name = $error->name;

  # "on_system_call"

  # my $message = $error->render;

  # "Can't make system call \"/path/to/nowhere arg1 arg2\": $?"

  # my $args = $error->stash('args');

  # []

=cut

$test->for('example', 1, 'error_on_system_call', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_system_call";
  my $message = $result->render;
  is $message, "Can't make system call \"/path/to/nowhere arg1 arg2\": $?";
  my $args = $result->stash('args');
  is_deeply $args, ['/path/to/nowhere', 'arg1', 'arg2'];

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Task.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
