package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Log

=cut

$test->for('name');

=tagline

Log Class

=cut

$test->for('tagline');

=abstract

Log Class for Perl 5

=cut

$test->for('abstract');

=includes

method: debug
method: error
method: fatal
method: info
method: input
method: output
method: string
method: trace
method: warn
method: write

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Log;

  my $log = Venus::Log->new;

  # $log->trace(time, 'Something failed!');

  # "0000000000 Something failed!"

  # $log->error(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->trace(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];
  ok $result->error(2, 'Something failed!');
  is_deeply $logs, [['1 Something failed!'], ['2 Something failed!']];

  $result
});

=description

This package provides methods for logging information using various log levels.

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

=attribute handler

The handler attribute holds the callback that handles logging.

=signature handler

  handler(CodeRef $code) (CodeRef)

=metadata handler

{
  since => '1.68',
}

=example-1 handler

  # given: synopsis

  package main;

  my $handler = $log->handler;

  my $events = [];

  $handler = $log->handler(sub{push @$events, [@_]});

=cut

$test->for('example', 1, 'handler', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref $result, 'CODE';

  $result
});

=attribute level

The level attribute holds the current log level.

=signature level

  level(Str $name) (Str)

=metadata level

{
  since => '1.68',
}

=example-1 level

  # given: synopsis

  package main;

  my $level = $log->level;

  # "trace"

  $level = $log->level('fatal');

  # "fatal"

=cut

$test->for('example', 1, 'level', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'fatal';

  $result
});

=attribute separator

The separator attribute holds the value used to join multiple log message arguments.

=signature separator

  separator(Any $data) (Any)

=metadata separator

{
  since => '1.68',
}

=example-1 separator

  # given: synopsis

  package main;

  my $separator = $log->separator;

  # ""

  $separator = $log->separator("\n");

  # "\n"

=cut

$test->for('example', 1, 'separator', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "\n";

  $result
});

=method debug

The debug method logs C<debug> information and returns the invocant.

=signature debug

  debug(Str @data) (Log)

=metadata debug

{
  since => '1.68',
}

=example-1 debug

  # given: synopsis

  package main;

  # $log = $log->debug(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'debug', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->debug(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=example-2 debug

  # given: synopsis

  package main;

  # $log->level('info');

  # $log = $log->debug(time, 'Something failed!');

  # noop

=cut

$test->for('example', 2, 'debug', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  ok $result->level('info');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->debug(1, 'Something failed!');
  is_deeply $logs, [];

  $result
});

=method error

The error method logs C<error> information and returns the invocant.

=signature error

  error(Str @data) (Log)

=metadata error

{
  since => '1.68',
}

=example-1 error

  # given: synopsis

  package main;

  # $log = $log->error(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->error(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=example-2 error

  # given: synopsis

  package main;

  # $log->level('fatal');

  # $log = $log->error(time, 'Something failed!');

  # noop

=cut

$test->for('example', 2, 'error', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  ok $result->level('fatal');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->error(1, 'Something failed!');
  is_deeply $logs, [];

  $result
});

=method fatal

The fatal method logs C<fatal> information and returns the invocant.

=signature fatal

  fatal(Str @data) (Log)

=metadata fatal

{
  since => '1.68',
}

=example-1 fatal

  # given: synopsis

  package main;

  # $log = $log->fatal(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'fatal', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->fatal(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=example-2 fatal

  # given: synopsis

  package main;

  # $log->level('unknown');

  # $log = $log->fatal(time, 'Something failed!');

  # noop

=cut

$test->for('example', 2, 'fatal', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  ok $result->level('unknown');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->fatal(1, 'Something failed!');
  is_deeply $logs, [];

  $result
});

=method info

The info method logs C<info> information and returns the invocant.

=signature info

  info(Str @data) (Log)

=metadata info

{
  since => '1.68',
}

=example-1 info

  # given: synopsis

  package main;

  # $log = $log->info(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'info', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->info(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=example-2 info

  # given: synopsis

  package main;

  # $log->level('warn');

  # $log = $log->info(time, 'Something failed!');

  # noop

=cut

$test->for('example', 2, 'info', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  ok $result->level('warn');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->info(1, 'Something failed!');
  is_deeply $logs, [];

  $result
});

=method input

The input method returns the arguments provided to the log level methods, to
the L</output>, and can be overridden by subclasses.

=signature input

  input(Str @data) (Str)

=metadata input

{
  since => '1.68',
}

=example-1 input

  # given: synopsis

  package main;

  my @input = $log->input(1, 'Something failed!');

  # (1, 'Something failed!')

=cut

$test->for('example', 1, 'input', sub {
  my ($tryable) = @_;
  ok my $result = [$tryable->result];
  is_deeply $result, [1, 'Something failed!'];

  $result
});

=method new

The new method returns a new instance of this package.

=signature new

  new(Str $level | Any %args | HashRef $args) (Log)

=metadata new

{
  since => '1.68',
}

=example-1 new

  package main;

  use Venus::Log;

  my $log = Venus::Log->new;

  # bless(..., "Venus::Log")

  # $log->level;

  # "trace"

=cut

$test->for('example', 1, 'new', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  is $result->level, 'trace';

  $result
});

=example-2 new

  package main;

  use Venus::Log;

  my $log = Venus::Log->new('error');

  # bless(..., "Venus::Log")

  # $log->level;

  # "error"

=cut

$test->for('example', 2, 'new', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  is $result->level, 'error';

  $result
});

=example-3 new

  package main;

  use Venus::Log;

  my $log = Venus::Log->new(5);

  # bless(..., "Venus::Log")

  # $log->level;

  # "error"

=cut

$test->for('example', 3, 'new', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  is $result->level, 'error';

  $result
});

=method output

The output method returns the arguments returned by the L</input> method, to
the log handler, and can be overridden by subclasses.

=signature output

  output(Str @data) (Str)

=metadata output

{
  since => '1.68',
}

=example-1 output

  # given: synopsis

  package main;

  my $output = $log->output(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'output', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  like $result, qr/\d+ Something failed!/;

  $result
});

=method string

The string method returns a stringified representation of any argument provided
and is used by the L</output> method.

=signature string

  string(Any $data) (Str)

=metadata string

{
  since => '1.68',
}

=example-1 string

  # given: synopsis

  package main;

  my $string = $log->string;

  # ""

=cut

$test->for('example', 1, 'string', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, '';

  !$result
});

=example-2 string

  # given: synopsis

  package main;

  my $string = $log->string('Something failed!');

  # "Something failed!"

=cut

$test->for('example', 2, 'string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "Something failed!";

  $result
});

=example-3 string

  # given: synopsis

  package main;

  my $string = $log->string([1,2,3]);

  # [1,2,3]

=cut

$test->for('example', 3, 'string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "[1,2,3]";

  $result
});

=example-4 string

  # given: synopsis

  package main;

  my $string = $log->string(bless({}));

  # "bless({}, 'main')"

=cut

$test->for('example', 4, 'string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  $result =~ s/\s//g;
  is $result, "bless({},'main')";

  $result
});

=method trace

The trace method logs C<trace> information and returns the invocant.

=signature trace

  trace(Str @data) (Log)

=metadata trace

{
  since => '1.68',
}

=example-1 trace

  # given: synopsis

  package main;

  # $log = $log->trace(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->trace(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=example-2 trace

  # given: synopsis

  package main;

  # $log->level('debug');

  # $log = $log->trace(time, 'Something failed!');

  # noop

=cut

$test->for('example', 2, 'trace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  ok $result->level('debug');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->trace(1, 'Something failed!');
  is_deeply $logs, [];

  $result
});

=method warn

The warn method logs C<warn> information and returns the invocant.

=signature warn

  warn(Str @data) (Log)

=metadata warn

{
  since => '1.68',
}

=example-1 warn

  # given: synopsis

  package main;

  # $log = $log->warn(time, 'Something failed!');

  # "0000000000 Something failed!"

=cut

$test->for('example', 1, 'warn', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->warn(1, 'Something failed!');
  is_deeply $logs, [['1 Something failed!']];

  $result
});

=example-2 warn

  # given: synopsis

  package main;

  # $log->level('error');

  # $log = $log->warn(time, 'Something failed!');

  # noop

=cut

$test->for('example', 2, 'warn', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  ok $result->level('error');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->warn(1, 'Something failed!');
  is_deeply $logs, [];

  $result
});

=method write

The write method invokes the log handler, i.e. L</handler>, and returns the invocant.

=signature write

  write(Any @data) (Log)

=metadata write

{
  since => '1.68',
}

=example-1 write

  # given: synopsis

  package main;

  # $log = $log->write(time, 'Something failed!');

  # bless(..., "Venus::Log")

=cut

$test->for('example', 1, 'write', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Log');
  my $logs = [];
  $result->handler(sub{push @$logs, [@_]});
  ok !@$logs;
  ok $result->write(1, 'Something failed!');
  is_deeply $logs, [[1, 'Something failed!']];
  ok $result->write(2, 'Something failed!');
  is_deeply $logs, [[1, 'Something failed!'], [2, 'Something failed!']];

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Log.pod') if $ENV{RENDER};

ok 1 and done_testing;
