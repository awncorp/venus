package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

our $PACKAGE = "Venus::Cli";

use_ok $PACKAGE;

our $CLI_EXIT_RETVAL = 0;
$PACKAGE->mock('_exit', sub {
  sub {$CLI_EXIT_RETVAL = $_[0]}
});

our $CLI_PRINT_INPUT = [];
our $CLI_PRINT_RETVAL = undef;
$PACKAGE->mock('_print', sub {
  sub {$CLI_PRINT_INPUT = [@_] if @_; $CLI_PRINT_RETVAL}
});

our $CLI_PROMPT_RETVAL = undef;
$PACKAGE->mock('_prompt', sub {
  sub {$CLI_PROMPT_RETVAL}
});

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
method: cmd
method: exit
method: fail
method: help
method: get
method: okay
method: opt
method: parsed
method: parser
method: pass
method: set
method: str
method: test

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--help']);

  $cli->set('opt', 'help', {
    help => 'Show help information',
  });

  # $cli->opt('help');

  # [1]

  # $cli->parsed;

  # {help => 1}

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Cli');
  is_deeply [$result->opt('help')], [1];
  is_deeply $result->data, ['--help'];
  is_deeply $result->parsed, {help => 1};

  $result
});

=description

This package provides a superclass and methods for creating simple yet robust
command-line interfaces.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Stashable

=cut

$test->for('integrates');

=attribute data

The data attribute holds an arrayref of command-line arguments and defaults to
C<@ARGV>.

=signature data

  data(ArrayRef $data) (ArrayRef)

=metadata data

{
  since => '2.55',
}

=example-1 data

  # given: synopsis

  package main;

  my $data = $cli->data([]);

  # []

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=method arg

The arg method returns the value passed to the CLI that corresponds to the
registered argument using the name provided.

=signature arg

  arg(Str $name) (Any)

=metadata arg

{
  since => '2.55',
}

=example-1 arg

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  my $name = $cli->arg('name');

  # undef

=cut

$test->for('example', 1, 'arg', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 arg

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  $cli->set('arg', 'name', {
    range => '0',
  });

  my $name = $cli->arg('name');

  # ["example"]

=cut

$test->for('example', 2, 'arg', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ["example"];

  $result
});

=example-3 arg

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  $cli->set('arg', 'name', {
    range => '0',
  });

  my ($name) = $cli->arg('name');

  # "example"

=cut

$test->for('example', 3, 'arg', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "example";

  $result
});

=example-4 arg

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--help']);

  $cli->set('arg', 'name', {
    prompt => 'Enter a name',
    range => '0',
  });

  my ($name) = $cli->arg('name');

  # prompts for name, e.g.

  # > name: Enter a name
  # > example

  # "example"

=cut

$test->for('example', 4, 'arg', sub {
  local $CLI_PRINT_INPUT;
  local $CLI_PROMPT_RETVAL = "example";
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $CLI_PRINT_INPUT, ['name: Enter a name'];
  is $result, "example";

  $result
});

=example-5 arg

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--help']);

  $cli->set('arg', 'name', {
    default => 'example',
    range => '0',
  });

  my ($name) = $cli->arg('name');

  # "example"

=cut

$test->for('example', 5, 'arg', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "example";

  $result
});

=example-6 arg

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  $cli->set('arg', 'name', {
    type => 'string',
    range => '0',
  });

  my ($name) = $cli->arg('name');

  # "example"

=cut

$test->for('example', 6, 'arg', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "example";

  $result
});

=method cmd

The cmd method returns truthy or falsy if the value passed to the CLI that
corresponds to the argument registered and associated with the registered
command using the name provided.

=signature cmd

  cmd(Str $name) (Any)

=metadata cmd

{
  since => '2.55',
}

=example-1 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', 'execute']);

  my $name = $cli->cmd('name');

  # undef

=cut

$test->for('example', 1, 'cmd', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', 'execute']);

  $cli->set('arg', 'action', {
    range => '1',
  });

  $cli->set('cmd', 'execute', {
    arg => 'action',
  });

  my $is_execute = $cli->cmd('execute');

  # 1

=cut

$test->for('example', 2, 'cmd', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', 'execute']);

  $cli->set('arg', 'action', {
    range => '1',
  });

  $cli->set('cmd', 'execute', {
    arg => 'action',
  });

  my ($is_execute) = $cli->cmd('execute');

  # 1

=cut

$test->for('example', 3, 'cmd', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example']);

  $cli->set('arg', 'action', {
    prompt => 'Enter the desired action',
    range => '1',
  });

  $cli->set('cmd', 'execute', {
    arg => 'action',
  });

  my ($is_execute) = $cli->cmd('execute');

  # prompts for action, e.g.

  # > name: Enter the desired action
  # > execute

  # 1

=cut

$test->for('example', 4, 'cmd', sub {
  local $CLI_PRINT_INPUT;
  local $CLI_PROMPT_RETVAL = "execute";
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $CLI_PRINT_INPUT, ['action: Enter the desired action'];
  is $result, 1;

  $result
});

=example-5 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example']);

  $cli->set('arg', 'action', {
    default => 'execute',
    range => '1',
  });

  $cli->set('cmd', 'execute', {
    arg => 'action',
  });

  my ($is_execute) = $cli->cmd('execute');

  # 1

=cut

$test->for('example', 5, 'cmd', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-6 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', 'execute']);

  $cli->set('arg', 'action', {
    type => 'string',
    range => '1',
  });

  $cli->set('cmd', 'execute', {
    arg => 'action',
  });

  my ($is_execute) = $cli->cmd('execute');

  # 1

=cut

$test->for('example', 6, 'cmd', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-7 cmd

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example']);

  $cli->set('arg', 'action', {
    type => 'string',
    range => '1',
  });

  $cli->set('cmd', 'execute', {
    arg => 'action',
  });

  my ($is_execute) = $cli->cmd('execute');

  # 0

=cut

$test->for('example', 7, 'cmd', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=method exit

The exit method exits the program using the exit code provided. The exit code
defaults to C<0>. Optionally, you can dispatch before exiting by providing a
method name or coderef, and arguments.

=signature exit

  exit(Int $code, Str|CodeRef $code, Any @args) (Any)

=metadata exit

{
  since => '2.55',
}

=example-1 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit;

  # ()

=cut

$test->for('example', 1, 'exit', sub {
  local $CLI_EXIT_RETVAL = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 0;

  !$result
});

=example-2 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit(0);

  # ()

=cut

$test->for('example', 2, 'exit', sub {
  local $CLI_EXIT_RETVAL = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 0;

  !$result
});

=example-3 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit(1);

  # ()

=cut

$test->for('example', 3, 'exit', sub {
  local $CLI_EXIT_RETVAL = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 1;

  $result
});

=example-4 exit

  # given: synopsis

  package main;

  my $exit = $cli->exit(1, 'stash', 'executed', 1);

  # ()

=cut

$test->for('example', 4, 'exit', sub {
  local $CLI_EXIT_RETVAL = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 1;

  $result
});

=method fail

The fail method exits the program with the exit code C<1>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature fail

  fail(Str|CodeRef $code, Any @args) (Any)

=metadata fail

{
  since => '2.55',
}

=example-1 fail

  # given: synopsis

  package main;

  my $fail = $cli->fail;

  # ()

=cut

$test->for('example', 1, 'fail', sub {
  local $CLI_EXIT_RETVAL = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 1;

  $result
});

=example-2 fail

  # given: synopsis

  package main;

  my $fail = $cli->fail('stash', 'executed', 1);

  # ()

=cut

$test->for('example', 2, 'fail', sub {
  local $CLI_EXIT_RETVAL = 0;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 1;

  $result
});

=method get

The get method returns C<arg>, C<opt>, C<cmd>, or C<str> configuration values
from the configuration database.

=signature get

  get(Str $type, Str $name) (Any)

=metadata get

{
  since => '2.55',
}

=cut

=example-1 get

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $get = $cli->get;

  # undef

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 get

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $get = $cli->get('opt', 'help');

  # undef

=cut

$test->for('example', 2, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-3 get

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {
    alias => 'h',
  });

  my $get = $cli->get('opt', 'help');

  # {name => 'help', alias => 'h'}

=cut

$test->for('example', 3, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {name => 'help', alias => 'h'};

  $result
});

=example-4 get

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {
    alias => 'h',
  });

  my $get = $cli->get('opt');

  # {help => {name => 'help', alias => 'h'}}

=cut

$test->for('example', 4, 'get', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {help => {name => 'help', alias => 'h'}};

  $result
});

=method help

The help method returns a string representing I<"usage"> information based on
the configuration of the CLI.

=signature help

  help() (Str)

=metadata help

{
  since => '2.55',
}

=example-1 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $help = $cli->help;

  # "Usage: application"

=cut

$test->for('example', 1, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Usage: application";

  $result
});

=example-2 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  my $help = $cli->help;

  # "Usage: program"

=cut

$test->for('example', 2, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Usage: program";

  $result
});

=example-3 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  $cli->set('arg', 'command', {
    help => 'Command to execute',
  });

  my $help = $cli->help;

  # "Usage: program [<argument>]
  #
  # Arguments:
  #
  #   command
  #     Command to execute
  #     (optional)"

=cut

$test->for('example', 3, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $expected = <<"EOF";
Usage: program [<argument>]

Arguments:

  command
    Command to execute
    (optional)
EOF

  chomp $expected;

  is $result, $expected;

  $result
});

=example-4 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  $cli->set('arg', 'command', {
    help => 'Command to execute',
    required => 1
  });

  my $help = $cli->help;

  # "Usage: program <argument>
  #
  # Arguments:
  #
  #   command
  #     Command to execute
  #     (required)"

=cut

$test->for('example', 4, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $expected = <<"EOF";
Usage: program <argument>

Arguments:

  command
    Command to execute
    (required)
EOF

  chomp $expected;

  is $result, $expected;

  $result
});

=example-5 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  $cli->set('arg', 'command', {
    help => 'Command to execute',
    type => 'string',
    required => 1,
  });

  my $help = $cli->help;

  # "Usage: program <argument>
  #
  # Arguments:
  #
  #   command
  #     Command to execute
  #     (required)
  #     (string)"

=cut

$test->for('example', 5, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $expected = <<"EOF";
Usage: program <argument>

Arguments:

  command
    Command to execute
    (required)
    (string)
EOF

  chomp $expected;

  is $result, $expected;

  $result
});

=example-6 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  $cli->set('arg', 'command', {
    help => 'Command to execute',
    required => 1,
  });

  $cli->set('cmd', 'create', {
    help => 'Create new resource',
    arg => 'command',
  });

  my $help = $cli->help;

  # "Usage: program <argument>
  #
  # Arguments:
  #
  #   command
  #     Command to execute
  #     (required)
  #
  # Commands:
  #
  #   create
  #     Create new resource
  #     (ccommand)"

=cut

$test->for('example', 6, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $expected = <<"EOF";
Usage: program <argument>

Arguments:

  command
    Command to execute
    (required)

Commands:

  create
    Create new resource
    (command)
EOF

  chomp $expected;

  is $result, $expected;

  $result
});

=example-7 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  $cli->set('arg', 'command', {
    help => 'Command to execute',
    required => 1,
  });

  $cli->set('opt', 'help', {
    help => 'Show help information',
    alias => ['?', 'h'],
  });

  $cli->set('cmd', 'create', {
    help => 'Create new resource',
    arg => 'command',
  });

  my $help = $cli->help;

  # "Usage: program <argument> [<option>]
  #
  # Arguments:
  #
  #   command
  #     Command to execute
  #     (required)
  #
  # Options:
  #
  #   -?, -h, --help
  #     Show help information
  #     (optional)
  #
  # Commands:
  #
  #   create
  #     Create new resource
  #     (command)"

=cut

$test->for('example', 7, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $expected = <<"EOF";
Usage: program <argument> [<option>]

Arguments:

  command
    Command to execute
    (required)

Options:

  -?, -h, --help
    Show help information
    (optional)

Commands:

  create
    Create new resource
    (command)
EOF

  chomp $expected;

  is $result, $expected;

  $result
});

=example-8 help

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  $cli->set('arg', 'files', {
    help => 'File paths',
    required => 1,
    range => '0:',
  });

  $cli->set('opt', 'verbose', {
    help => 'Show details during processing',
    alias => ['v'],
  });

  my $help = $cli->help;

  # "Usage: program <argument>, ... [<option>]
  #
  # Arguments:
  #
  #   files, ...
  #     File paths
  #     (required)
  #
  # Options:
  #
  #   -v, --verbose
  #     Show details during processing
  #     (optional)"

=cut

$test->for('example', 8, 'help', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $expected = <<"EOF";
Usage: program <argument>, ... [<option>]

Arguments:

  files, ...
    File paths
    (required)

Options:

  -v, --verbose
    Show details during processing
    (optional)
EOF

  chomp $expected;

  is $result, $expected;

  $result
});

=method okay

The okay method exits the program with the exit code C<0>. Optionally, you can
dispatch before exiting by providing a method name or coderef, and arguments.

=signature okay

  okay(Str|CodeRef $code, Any @args) (Any)

=metadata okay

{
  since => '2.55',
}

=example-1 okay

  # given: synopsis

  package main;

  my $okay = $cli->okay;

  # ()

=cut

$test->for('example', 1, 'okay', sub {
  local $CLI_EXIT_RETVAL = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 0;

  !$result
});

=example-2 okay

  # given: synopsis

  package main;

  my $okay = $cli->okay('stash', 'executed', 1);

  # ()

=cut

$test->for('example', 2, 'okay', sub {
  local $CLI_EXIT_RETVAL = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 0;

  !$result
});

=method opt

The opt method returns the value passed to the CLI that corresponds to the
registered option using the name provided.

=signature opt

  opt(Str $name) (Any)

=metadata opt

{
  since => '2.55',
}

=example-1 opt

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  my $name = $cli->opt('help');

  # undef

=cut

$test->for('example', 1, 'opt', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 opt

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  $cli->set('opt', 'help', {});

  my $name = $cli->opt('help');

  # [1]

=cut

$test->for('example', 2, 'opt', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [1];

  $result
});

=example-3 opt

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  $cli->set('opt', 'help', {});

  my ($name) = $cli->opt('help');

  # 1

=cut

$test->for('example', 3, 'opt', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 opt

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new([]);

  $cli->set('opt', 'name', {
    prompt => 'Enter a name',
    type => 'string',
    multi => 0,
  });

  my ($name) = $cli->opt('name');

  # prompts for name, e.g.

  # > name: Enter a name
  # > example

  # "example"

=cut

$test->for('example', 4, 'opt', sub {
  local $CLI_PRINT_INPUT;
  local $CLI_PROMPT_RETVAL = "example";
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $CLI_PRINT_INPUT, ['name: Enter a name'];
  is $result, "example";

  $result
});

=example-5 opt

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--name', 'example']);

  $cli->set('opt', 'name', {
    prompt => 'Enter a name',
    type => 'string',
    multi => 0,
  });

  my ($name) = $cli->opt('name');

  # Does not prompt

  # "example"

=cut

$test->for('example', 5, 'opt', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "example";

  $result
});

=example-6 opt

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--name', 'example', '--name', 'example']);

  $cli->set('opt', 'name', {
    type => 'string',
    multi => 1,
  });

  my (@name) = $cli->opt('name');

  # ("example", "example")

=cut

$test->for('example', 6, 'opt', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], ["example", "example"];

  (@result)
});

=method parsed

The parsed method returns the values provided to the CLI for all registered
arguments and options as a hashref.

=signature parsed

  parsed() (HashRef)

=metadata parsed

{
  since => '2.55',
}

=cut

=example-1 parsed

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--help']);

  $cli->set('arg', 'name', {
    range => '0',
  });

  $cli->set('opt', 'help', {
    alias => 'h',
  });

  my $parsed = $cli->parsed;

  # {name => "example", help => 1}

=cut

$test->for('example', 1, 'parsed', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {name => "example", help => 1};

  $result
});

=method parser

The parser method returns a L<Venus::Opts> object using the L</spec> returned
based on the CLI configuration.

=signature parser

  parser() (Opts)

=metadata parser

{
  since => '2.55',
}

=cut

=example-1 parser

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {
    help => 'Show help information',
    alias => 'h',
  });

  my $parser = $cli->parser;

  # bless({...}, 'Venus::Opts')

=cut

$test->for('example', 1, 'parser', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Opts';
  is_deeply $result->specs, ['help|h'];

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

  my $pass = $cli->pass;

  # ()

=cut

$test->for('example', 1, 'pass', sub {
  local $CLI_EXIT_RETVAL = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 0;

  !$result
});

=example-2 pass

  # given: synopsis

  package main;

  my $pass = $cli->pass('stash', 'executed', 1);

  # ()

=cut

$test->for('example', 2, 'pass', sub {
  local $CLI_EXIT_RETVAL = 1;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $CLI_EXIT_RETVAL, 0;

  !$result
});

=method set

The set method stores configuration values for C<arg>, C<opt>, C<cmd>, or
C<str> data in the configuration database, and returns the invocant.

The following are configurable C<arg> properties:

+=over 4

+=item *

The C<default> property specifies the "default" value to be used if none is
provided.

+=item *

The C<help> property specifies the help text to output in usage instructions.

+=item *

The C<label> property specifies the label text to output in usage instructions.

+=item *

The C<name> property specifies the name of the argument.

+=item *

The C<prompt> property specifies the text to be used in a prompt for input if
no value is provided.

+=item *

The C<range> property specifies the zero-indexed position where the CLI
arguments can be found, using range notation.

+=item *

The C<required> property specifies whether the argument is required and throws
an exception is missing when fetched.

+=item *

The C<type> property specifies the data type of the argument. Valid types are
C<number> parsed as a L<Getopt::Long> integer, C<string> parsed as a
L<Getopt::Long> string, C<float> parsed as a L<Getopt::Long> float, C<boolean>
parsed as a L<Getopt::Long> flag, or C<yesno> parsed as a L<Getopt::Long>
string. Otherwise, the type will default to C<boolean>.

+=back

The following are configurable C<cmd> properties:

+=over 4

+=item *

The C<arg> property specifies the CLI argument where the command can be found.

+=item *

The C<help> property specifies the help text to output in usage instructions.

+=item *

The C<label> property specifies the label text to output in usage instructions.

+=item *

The C<name> property specifies the name of the command.

+=back

The following are configurable C<opt> properties:

+=over 4

+=item *

The C<alias> property specifies the alternate identifiers that can be provided.

+=item *

The C<default> property specifies the "default" value to be used if none is
provided.

+=item *

The C<help> property specifies the help text to output in usage instructions.

+=item *

The C<label> property specifies the label text to output in usage instructions.

+=item *

The C<multi> property denotes whether the CLI will accept multiple occurrences
of the option.

+=item *

The C<name> property specifies the name of the option.

+=item *

The C<prompt> property specifies the text to be used in a prompt for input if
no value is provided.

+=item *

The C<required> property specifies whether the option is required and throws an
exception is missing when fetched.

+=item *

The C<type> property specifies the data type of the option. Valid types are
C<number> parsed as a L<Getopt::Long> integer, C<string> parsed as a
L<Getopt::Long> string, C<float> parsed as a L<Getopt::Long> float, C<boolean>
parsed as a L<Getopt::Long> flag, or C<yesno> parsed as a L<Getopt::Long>
string. Otherwise, the type will default to C<boolean>.

+=back

=signature set

  set(Str $type, Str $name, Str|HashRef $data) (Any)

=metadata set

{
  since => '2.55',
}

=cut

=example-1 set

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $set = $cli->set;

  # undef

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 set

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $set = $cli->set('opt', 'help');

  # bless({...}, 'Venus::Cli')

=cut

$test->for('example', 2, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Cli';
  is_deeply $result->store('opt', 'help'), {name => 'help'};

  $result
});

=example-3 set

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $set = $cli->set('opt', 'help', {
    alias => 'h',
  });

  # bless({...}, 'Venus::Cli')

=cut

$test->for('example', 3, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Cli';
  is_deeply $result->store('opt', 'help'), {name => 'help', alias => 'h'};

  $result
});

=example-4 set

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  my $set = $cli->set('opt', 'help', {
    alias => ['?', 'h'],
  });

  # bless({...}, 'Venus::Cli')

=cut

$test->for('example', 4, 'set', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Cli';
  is_deeply $result->store('opt', 'help'), {name => 'help', alias => ['?', 'h']};

  $result
});

=method spec

The spec method returns parser L<specifications|Getopt::Long/"Summary of Option
Specifications"> for use with L<Getopt::Long>.

=signature spec

  spec() (ArrayRef)

=metadata spec

{
  since => '2.55',
}

=cut

=example-1 spec

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {});

  my $spec = $cli->spec;

  # ['help']

=cut

$test->for('example', 1, 'spec', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ['help'];

  $result
});

=example-2 spec

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {alias => 'h'});

  my $spec = $cli->spec;

  # ['help|h']

=cut

$test->for('example', 2, 'spec', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ['help|h'];

  $result
});

=example-3 spec

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {alias => ['?', 'h']});

  my $spec = $cli->spec;

  # ['help|?|h']

=cut

$test->for('example', 3, 'spec', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ['help|?|h'];

  $result
});

=example-4 spec

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('opt', 'help', {alias => ['?', 'h']});

  $cli->set('opt', 'verbose', {alias => ['v']});

  my $spec = $cli->spec;

  # ['help|?|h', 'verbose|v']

=cut

$test->for('example', 4, 'spec', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, ['help|?|h', 'verbose|v'];

  $result
});

=method str

The str method gets or sets configuration strings used in CLI help text based
on the arguments provided. The L</help> method uses C<"name">,
C<"description">, C<"header">, and C<"footer"> strings.

=signature str

  str(Str $name) (Any)

=metadata str

{
  since => '2.55',
}

=cut

=example-1 str

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new;

  $cli->set('str', 'name', 'program');

  my $str = $cli->str('name');

  # "program"

=cut

$test->for('example', 1, 'str', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 'program';

  $result
});

=method test

The test method validates the values for the C<arg> or C<opt> specified and
returns the value(s) associated. If validation failed an exception is thrown.

=signature test

  test(Str $type, Str $name) (Any)

=metadata test

{
  since => '3.10',
}

=cut

=example-1 test

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['help']);

  $cli->set('arg', 'name', {
    type => 'string',
    range => '0',
  });

  my ($name) = $cli->test('arg', 'name');

  # "help"

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "help";

  $result
});

=example-2 test

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['--help']);

  $cli->set('arg', 'name', {
    type => 'string',
    range => '0',
  });

  my ($name) = $cli->test('arg', 'name');

  # Exception! (isa Venus::Cli::Error) (see error_on_arg_validation)

  # Invalid argument: name: received (undef), expected (string)

=cut

$test->for('example', 2, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Cli::Error';
  ok $result->is('on.arg.validation');
  like $result->message, qr/Invalid argument: name/;

  $result
});

=example-3 test

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--name', 'example']);

  $cli->set('opt', 'name', {
    type => 'string',
    multi => 1,
  });

  my ($name) = $cli->test('opt', 'name');

  # "example"

=cut

$test->for('example', 3, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "example";

  $result
});

=example-4 test

  package main;

  use Venus::Cli;

  my $cli = Venus::Cli->new(['example', '--name', 'example']);

  $cli->set('opt', 'name', {
    type => 'number',
    multi => 1,
  });

  my ($name) = $cli->test('opt', 'name');

  # Exception! (isa Venus::Cli::Error) (see error_on_opt_validation)

  # Invalid option: name: received (undef), expected (number)

=cut

$test->for('example', 4, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  isa_ok $result, 'Venus::Cli::Error';
  ok $result->is('on.opt.validation');
  like $result->message, qr/Invalid option: name/;

  $result
});

=error error_on_arg_validation

This package may raise an error_on_arg_validation exception.

=cut

$test->for('error', 'error_on_arg_validation');

=example-1 error_on_arg_validation

  # given: synopsis;

  my @args = ("...", "example", "string");

  my $error = $cli->throw('error_on_arg_validation', @args)->catch('error');

  # my $name = $error->name;

  # "on_arg_validation"

  # my $message = $error->message;

  # "Invalid argument: example: ..."

  # my $name = $error->stash('name');

  # "example"

  # my $type = $error->stash('type');

  # "string"

=cut

$test->for('example', 1, 'error_on_arg_validation', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_arg_validation";
  my $message = $result->message;
  is $message, "Invalid argument: example: ...";
  $name = $result->stash('name');
  is $name, "example";
  my $type = $result->stash('type');
  is $type, "string";

  $result
});

=error error_on_opt_validation

This package may raise an error_on_opt_validation exception.

=cut

$test->for('error', 'error_on_opt_validation');

=example-1 error_on_opt_validation

  # given: synopsis;

  my @args = ("...", "example", "string");

  my $error = $cli->throw('error_on_opt_validation', @args)->catch('error');

  # my $name = $error->name;

  # "on_opt_validation"

  # my $message = $error->message;

  # "Invalid option: example: ..."

  # my $name = $error->stash('name');

  # "example"

  # my $type = $error->stash('type');

  # "string"

=cut

$test->for('example', 1, 'error_on_opt_validation', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_opt_validation";
  my $message = $result->message;
  is $message, "Invalid option: example: ...";
  $name = $result->stash('name');
  is $name, "example";
  my $type = $result->stash('type');
  is $type, "string";

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Cli.pod') if $ENV{RENDER};

ok 1 and done_testing;
