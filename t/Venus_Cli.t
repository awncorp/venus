package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

our $CLI_EXIT_CODE;

{
  no strict 'refs'; no warnings 'redefine';

  require Venus::Cli; *{"Venus::Cli::_exit"} = sub {$CLI_EXIT_CODE = $_[0]};
}

=name

Venus::Cli

=cut

$test->for('name');

=tagline

Cli Class

=cut

$test->for('tagline');

=abstract

Cli Class for Perl 5

=cut

$test->for('abstract');

=includes

method: arg
method: execute
method: exit
method: fail
method: help
method: log_debug
method: log_error
method: log_fatal
method: log_info
method: log_trace
method: log_warn
method: okay
method: opt
method: options

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  # $cli->program;

  # "/path/to/executable"

  # $cli->arg(0);

  # "example"

  # $cli->opt('help');

  # 1

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  is_deeply $result->init, ['example', '--help'];

  $result
});

=description

This package provides a superclass and methods for providing simple yet robust
command-line interfaces.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Optional

=cut

$test->for('integrates');

=attribute args

The args attribute holds a L<Venus::Args> object.

=signature args

  args(Args $data) (Args)

=metadata args

{
  since => '1.71',
}

=example-1 args

  # given: synopsis

  package main;

  my $args = $cli->args;

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Args');

  $result
});

=attribute data

The data attribute holds a L<Venus::Data> object.

=signature data

  data(Data $data) (Data)

=metadata data

{
  since => '1.71',
}

=example-1 data

  # given: synopsis

  package main;

  my $data = $cli->data;

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Data');

  $result
});

=attribute init

The init attribute holds the "initial" raw arguments provided to the CLI,
defaulting to C<[@ARGV]>, used by L</args> and L</opts>.

=signature init

  init(ArrayRef $data) (ArrayRef)

=metadata init

{
  since => '1.68',
}

=example-1 init

  # given: synopsis

  package main;

  my $init = $cli->init;

  # ["example", "--help"]

=cut

$test->for('example', 1, 'init', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['example', '--help'];

  $result
});

=attribute logs

The logs attribute holds a L<Venus::Logs> object.

=signature logs

  logs(Logs $logs) (Logs)

=metadata logs

{
  since => '1.71',
}

=example-1 logs

  # given: synopsis

  package main;

  my $logs = $cli->logs;

=cut

$test->for('example', 1, 'logs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');

  $result
});

=attribute opts

The opts attribute holds a L<Venus::Opts> object.

=signature opts

  opts(Opts $opts) (Opts)

=metadata opts

{
  since => '1.71',
}

=example-1 opts

  # given: synopsis

  package main;

  my $opts = $cli->opts;

=cut

$test->for('example', 1, 'opts', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Opts');

  $result
});

=attribute path

The path attribute holds a L<Venus::Path> object, meant to represent the path
of the file where the CLI executable and POD is.

=signature path

  path(Path $data) (Path)

=metadata path

{
  since => '1.71',
}

=example-1 path

  # given: synopsis

  package main;

  my $path = $cli->path;

=cut

$test->for('example', 1, 'path', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');

  $result
});

=attribute vars

The vars attribute holds a L<Venus::Vars> object.

=signature vars

  vars(Vars $vars) (Vars)

=metadata vars

{
  since => '1.71',
}

=example-1 vars

  # given: synopsis

  package main;

  my $vars = $cli->vars;

=cut

$test->for('example', 1, 'vars', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Vars');

  $result
});

=method arg

The arg method returns the element specified by the index in the unnamed
arguments list, i.e. arguments not parsed as options.

=signature arg

  arg(Str $pos) (Str)

=metadata arg

{
  since => '1.68',
}

=example-1 arg

  # given: synopsis

  package main;

  my $arg = $cli->arg;

  # undef

=cut

$test->for('example', 1, 'arg', sub {
  my ($tryable) = @_;
  ok !defined(my $result = $tryable->result);

  !$result
});

=example-2 arg

  # given: synopsis

  package main;

  my $arg = $cli->arg(0);

  # "example"

=cut

$test->for('example', 2, 'arg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "example";

  $result
});

=method execute

The execute method is the default entrypoint of the program and runs the
application.

=signature execute

  execute() (Any)

=metadata execute

{
  since => '1.68',
}

=example-1 execute

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new([]);

  # e.g.

  # sub execute {
  #   my ($self) = @_;
  #
  #   return $self->opt('help') ? $self->okay : $self->fail;
  # }

  # my $result = $cli->execute;

  # ...

=cut

$test->for('example', 1, 'execute', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  $result->execute;
  is $CLI_EXIT_CODE, 1;

  $result
});

=example-2 execute

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--help']);

  # e.g.

  # sub execute {
  #   my ($self) = @_;
  #
  #   return $self->opt('help') ? $self->okay : $self->fail;
  # }

  # my $result = $cli->execute;

  # ...

=cut

$test->for('example', 2, 'execute', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  $result->execute;
  is $CLI_EXIT_CODE, 0;

  $result
});

=method exit

The exit method exits the program using the exit code provided. The exit code
defaults to C<0>. Optionally, you can dispatch before exiting by providing a
method name or coderef, and arguments.

=signature exit

  exit(Int $code, Str|CodeRef $code, Any @args) (Any)

=metadata exit

{
  since => '1.68',
}

=example-1 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit;

  # ()

=cut

$test->for('example', 1, 'exit', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $CLI_EXIT_CODE, 0;

  !$result
});

=example-2 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit(0);

  # ()

=cut

$test->for('example', 2, 'exit', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $CLI_EXIT_CODE, 0;

  !$result
});

=example-3 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit(1);

  # ()

=cut

$test->for('example', 3, 'exit', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $CLI_EXIT_CODE, 1;

  $result
});

=example-4 exit

  # given: synopsis

  package main;

  # my $exit = $cli->exit(1, 'log_info', 'Something failed!');

  # ()

=cut

$test->for('example', 4, 'exit', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  $result->exit(1, 'log_info', 'Something failed!');
  is_deeply $logs, [['Something failed!']];

  $result
});

=method fail

The fail method exits the program with the exit code C<1>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature fail

  fail(Str|CodeRef $code, Any @args) (Any)

=metadata fail

{
  since => '1.68',
}

=example-1 fail

  # given: synopsis

  package main;

  my $fail = $cli->fail;

  # ()

=cut

$test->for('example', 1, 'fail', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $CLI_EXIT_CODE, 1;

  $result
});

=example-2 fail

  # given: synopsis

  package main;

  # my $fail = $cli->fail('log_info', 'Something failed!');

  # ()

=cut

$test->for('example', 2, 'fail', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  $result->fail('log_info', 'Something failed!');
  is_deeply $logs, [['Something failed!']];
  is $CLI_EXIT_CODE, 1;

  $result
});

=method help

The help method returns the POD found in the file specified by the L</podfile>
method, defaulting to the C<=head1 OPTIONS> section.

=signature help

  help(Str @data) (Str)

=metadata help

{
  since => '1.68',
}

=example-1 help

  # given: synopsis

  package main;

  my $help = $cli->help;

  # ""

=cut

$test->for('example', 1, 'help', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 help

  # given: synopsis

  package main;

  # my $help = $cli->help('head1', 'NAME');

  #  "Example"

=cut

$test->for('example', 2, 'help', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  $result->data->set('t/data/sections');
  ok my $help = $result->help('head1', 'NAME');
  is $help, "Example #1\nExample #2";

  $result
});

=method log_debug

The log_debug method logs C<debug> information.

=signature log_debug

  log_debug(Str @data) (Log)

=metadata log_debug

{
  since => '1.68',
}

=example-1 log_debug

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_debug(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'log_debug', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->log_debug(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=method log_error

The log_error method logs C<error> information.

=signature log_error

  log_error(Str @data) (Log)

=metadata log_error

{
  since => '1.68',
}

=example-1 log_error

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_error(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'log_error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->log_error(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=method log_fatal

The log_fatal method logs C<fatal> information.

=signature log_fatal

  log_fatal(Str @data) (Log)

=metadata log_fatal

{
  since => '1.68',
}

=example-1 log_fatal

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_fatal(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'log_fatal', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->log_fatal(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=method log_info

The log_info method logs C<info> information.

=signature log_info

  log_info(Str @data) (Log)

=metadata log_info

{
  since => '1.68',
}

=example-1 log_info

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_info(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'log_info', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->log_info(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=method log_trace

The log_trace method logs C<trace> information.

=signature log_trace

  log_trace(Str @data) (Log)

=metadata log_trace

{
  since => '1.68',
}

=example-1 log_trace

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_trace(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'log_trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->log_trace(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=method log_warn

The log_warn method logs C<warn> information.

=signature log_warn

  log_warn(Str @data) (Log)

=metadata log_warn

{
  since => '1.68',
}

=example-1 log_warn

  # given: synopsis

  package main;

  # $cli->logs->level('trace');

  # my $log = $cli->log_warn(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'log_warn', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->log_warn(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=method okay

The okay method exits the program with the exit code C<0>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature okay

  okay(Str|CodeRef $code, Any @args) (Any)

=metadata okay

{
  since => '1.68',
}

=example-1 okay

  # given: synopsis

  package main;

  my $okay = $cli->okay;

  # ()

=cut

$test->for('example', 1, 'okay', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $CLI_EXIT_CODE, 0;

  !$result
});

=example-2 okay

  # given: synopsis

  package main;

  # my $okay = $cli->okay('log_info', 'Something worked!');

  # ()

=cut

$test->for('example', 2, 'okay', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->logs->level('trace');
  my $logs = [];
  $result->logs->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  $result->okay('log_info', 'Something worked!');
  is_deeply $logs, [['Something worked!']];
  is $CLI_EXIT_CODE, 0;

  $result
});

=method opt

The opt method returns the named option specified by the L</options> method.

=signature opt

  opt(Str $name) (Str)

=metadata opt

{
  since => '1.68',
}

=example-1 opt

  # given: synopsis

  package main;

  my $opt = $cli->opt;

  # undef

=cut

$test->for('example', 1, 'opt', sub {
  my ($tryable) = @_;
  ok !defined(my $result = $tryable->result);

  !$result
});

=example-2 opt

  # given: synopsis

  package main;

  my $opt = $cli->opt('help');

  # 1

=cut

$test->for('example', 2, 'opt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 1;

  $result
});

=method options

The options method returns the list of L<Getopt::Long> definitions.

=signature options

  options() (ArrayRef)

=metadata options

{
  since => '1.68',
}

=example-1 options

  # given: synopsis

  package main;

  my $options = $cli->options;

  # ['help|h']

=cut

$test->for('example', 1, 'options', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['help|h'];

  $result
});

# END

$test->render('lib/Venus/Cli.pod') if $ENV{RENDER};

ok 1 and done_testing;
