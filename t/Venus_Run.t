package main;

use 5.018;

use strict;
use warnings;

BEGIN {
  $ENV{VENUS_TASK_RUN} = 0;
  undef $ENV{VENUS_RUN_NAME};
  undef $ENV{VENUS_FILE};
}

use Test::More;
use Venus::Test;

use_ok "Venus::Run";

my $test = test(__FILE__);

my $init = {
  data => {
    ECHO => 1,
  },
  exec => {
    brew => 'perlbrew',
    cpan => 'cpanm -llocal -qn',
    docs => 'perldoc',
    each => 'shim -nE',
    edit => '$EDITOR $VENUS_FILE',
    eval => 'shim -E',
    exec => '$PERL',
    info => '$PERL -V',
    lint => 'perlcritic',
    okay => '$PERL -c',
    repl => '$REPL',
    reup => 'cpanm -qn Venus',
    says => 'eval "map log(eval), @ARGV"',
    shim => '$PERL -MVenus=true,false,log',
    test => '$PROVE',
    tidy => 'perltidy',
  },
  libs => [
    '-Ilib',
    '-Ilocal/lib/perl5',
  ],
  path => [
    'bin',
    'dev',
    'local/bin',
  ],
  perl => {
    perl => 'perl',
    prove => 'prove',
  },
  vars => {
    PERL => 'perl',
    PROVE => 'prove',
    REPL => '$PERL -dE0',
  },
};

our $TEST_VENUS_RUN_EXIT;
our $TEST_VENUS_RUN_OUTPUT = [];
our $TEST_VENUS_RUN_SYSTEM = [];
our $TEST_VENUS_RUN_SYSTEM_LOG = [];
our $TEST_VENUS_RUN_PRINT = [];
our $TEST_VENUS_RUN_PROMPT = undef;

# _print
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Run::_print"} = sub {
    $TEST_VENUS_RUN_PRINT = [@_];
  };
}

# _prompt
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Run::_prompt"} = sub {
    $TEST_VENUS_RUN_PROMPT;
  };
}

# exit
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Run::exit"} = sub {
    my ($self, $code, $method, @args) = @_;
    $self->$method(@args) if $method;
    $TEST_VENUS_RUN_EXIT = $code ||= 0;
  };
}

# output
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Run::output"} = sub {
    $TEST_VENUS_RUN_OUTPUT = [@_];
  };
}

# system
{
  no strict 'refs';
  no warnings 'redefine';
  *{"Venus::Run::system"} = sub {
    push @{$TEST_VENUS_RUN_SYSTEM_LOG}, $TEST_VENUS_RUN_SYSTEM = [@_];
  };
}

=name

Venus::Run

=cut

$test->for('name');

=tagline

Runner Class

=cut

$test->for('tagline');

=abstract

Runner Class for Perl 5

=cut

$test->for('abstract');

=includes

method: args
method: cmds
method: conf
method: file
method: footer
method: handler
method: init
method: name
method: opts

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Run;

  my $run = Venus::Run->new;

  # bless({...}, 'Venus::Run')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Run');

  $result
});

=description

This package is a subclass of L<Venus::Task> which provides a command execution
system. This package loads the configuration file used for defining tasks (i.e.
command-line operations) which can recursively resolve, injects environment
variables, resets the C<PATH> and C<PERL5LIB> variables where appropriate, and
executes the tasks by name. See L<vns> for an executable file which loads this
package and provides the CLI. See L</FEATURES> for usage and configuration
information.

=cut

$test->for('description');

=inherits

Venus::Task

=cut

$test->for('inherits');

=method args

The args method returns the task argument declarations.

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

  my $args = $run->args;

  # {
  #   'command' => {
  #     help => 'Command to run',
  #     required => 1,
  #   }
  # }

=cut

$test->for('example', 1, 'args', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    'command' => {
      help => 'Command to run',
      required => 1,
    }
  };

  $result
});

=method cmds

The cmds method returns the task command declarations.

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

  my $cmds = $run->cmds;

  # {
  #   'help' => {
  #     help => 'Display help and usages',
  #     arg => 'command',
  #   },
  #   'init' => {
  #     help => 'Initialize the configuration file',
  #     arg => 'command',
  #   },
  # }

=cut

$test->for('example', 1, 'cmds', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    'help' => {
      help => 'Display help and usages',
      arg => 'command',
    },
    'init' => {
      help => 'Initialize the configuration file',
      arg => 'command',
    },
  };

  $result
});

=method conf

The conf method loads the configuration file returned by L</file>, then decodes
and returns the information as a hashref.

=signature conf

  conf() (HashRef)

=metadata conf

{
  since => '2.91',
}

=cut

=example-1 conf

  # given: synopsis

  package main;

  my $conf = $run->conf;

  # {}

=cut

$test->for('example', 1, 'conf', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=example-2 conf

  # given: synopsis

  package main;

  local $ENV{VENUS_FILE} = 't/conf/.vns.pl';

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 2, 'conf', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;

  $result
});

=example-3 conf

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.yaml file

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 3, 'conf', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my $file = '.vns.yaml';
  require Venus::Path;
  require Venus::Config;
  Venus::Config
    ->read_file('t/conf/.vns.pl')
    ->write_file($file);
  my $path = Venus::Path->new($file);

  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;
  $path->unlink;

  $result
});

=example-4 conf

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.yml file

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 4, 'conf', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my $file = '.vns.yml';
  require Venus::Path;
  require Venus::Config;
  Venus::Config
    ->read_file('t/conf/.vns.pl')
    ->write_file($file);
  my $path = Venus::Path->new($file);

  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;
  $path->unlink;

  $result
});

=example-5 conf

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.json file

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 5, 'conf', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my $file = '.vns.json';
  require Venus::Path;
  require Venus::Config;
  Venus::Config
    ->read_file('t/conf/.vns.pl')
    ->write_file($file);
  my $path = Venus::Path->new($file);

  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;
  $path->unlink;

  $result
});

=example-6 conf

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.js file

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 6, 'conf', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my $file = '.vns.js';
  require Venus::Path;
  require Venus::Config;
  Venus::Config
    ->read_file('t/conf/.vns.pl')
    ->write_file($file);
  my $path = Venus::Path->new($file);

  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;
  $path->unlink;

  $result
});

=example-7 conf

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.perl file

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 7, 'conf', sub {
  my $file = '.vns.perl';
  require Venus::Path;
  require Venus::Config;
  Venus::Config
    ->read_file('t/conf/.vns.pl')
    ->write_file($file);
  my $path = Venus::Path->new($file);

  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;
  $path->unlink;

  $result
});

=example-8 conf

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.pl file

  my $conf = $run->conf;

  # {...}

=cut

$test->for('example', 8, 'conf', sub {
  my $file = '.vns.pl';
  require Venus::Path;
  require Venus::Config;
  Venus::Config
    ->read_file('t/conf/.vns.pl')
    ->write_file($file);
  my $path = Venus::Path->new($file);

  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;
  $path->unlink;

  $result
});

=method file

The file method returns the configuration file specified in the C<VENUS_FILE>
environment variable, or the discovered configuration file in the current
directory. The default name for a configuration file is in the form of
C<.vns.*>. Configuration files will be decoded based on their file extensions.
Valid file extensions are C<yaml>, C<yml>, C<json>, C<js>, C<perl>, and C<pl>.

=signature file

  file() (Str)

=metadata file

{
  since => '2.91',
}

=cut

=example-1 file

  # given: synopsis

  package main;

  my $file = $run->file;

  # undef

=cut

$test->for('example', 1, 'file', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-2 file

  # given: synopsis

  package main;

  local $ENV{VENUS_FILE} = 't/conf/.vns.pl';

  my $file = $run->file;

  # "t/conf/.vns.pl"

=cut

$test->for('example', 2, 'file', sub {
  my ($tryable) = @_;
  my $value = $ENV{VENUS_FILE};
  my $result = $tryable->result;
  is $result, "t/conf/.vns.pl";
  $ENV{VENUS_FILE} = $value;

  $result
});

=example-3 file

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.yaml file

  my $file = $run->file;

  # ".vns.yaml"

=cut

$test->for('example', 3, 'file', sub {
  require Venus::Path;
  my $path = Venus::Path->new;
  my $file = $path->child('.vns.yaml')->mkfile;

  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, ".vns.yaml";
  $file->unlink;

  $result
});

=example-4 file

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.yml file

  my $file = $run->file;

  # ".vns.yml"

=cut

$test->for('example', 4, 'file', sub {
  require Venus::Path;
  require Venus::Config;
  my $path = Venus::Path->new;
  my $file = $path->child('.vns.yml')->mkfile;

  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, ".vns.yml";
  $file->unlink;

  $result
});

=example-5 file

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.json file

  my $file = $run->file;

  # ".vns.json"

=cut

$test->for('example', 5, 'file', sub {
  require Venus::Path;
  require Venus::Config;
  my $path = Venus::Path->new;
  my $file = $path->child('.vns.json')->mkfile;

  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, ".vns.json";
  $file->unlink;

  $result
});

=example-6 file

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.js file

  my $file = $run->file;

  # ".vns.js"

=cut

$test->for('example', 6, 'file', sub {
  require Venus::Path;
  require Venus::Config;
  my $path = Venus::Path->new;
  my $file = $path->child('.vns.js')->mkfile;

  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, ".vns.js";
  $file->unlink;

  $result
});

=example-7 file

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.perl file

  my $file = $run->file;

  # ".vns.perl"

=cut

$test->for('example', 7, 'file', sub {
  require Venus::Path;
  require Venus::Config;
  my $path = Venus::Path->new;
  my $file = $path->child('.vns.perl')->mkfile;

  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, ".vns.perl";
  $file->unlink;

  $result
});

=example-8 file

  # given: synopsis

  package main;

  # e.g. current directory has only a .vns.pl file

  my $file = $run->file;

  # ".vns.pl"

=cut

$test->for('example', 8, 'file', sub {
  require Venus::Path;
  require Venus::Config;
  my $path = Venus::Path->new;
  my $file = $path->child('.vns.pl')->mkfile;

  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, ".vns.pl";
  $file->unlink;

  $result
});

=method footer

The footer method returns examples and usage information used in usage text.

=signature footer

  footer() (Str)

=metadata footer

{
  since => '2.91',
}

=cut

=example-1 footer

  # given: synopsis

  package main;

  my $footer = $run->footer;

  # "..."

=cut

$test->for('example', 1, 'footer', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  like $result, qr|---|;
  like $result, qr|data:|;
  like $result, qr|ECHO: true|;
  like $result, qr|exec:|;
  like $result, qr|okay: \$PERL -c|;
  like $result, qr|cpan: cpanm -llocal -qn|;
  like $result, qr|deps: cpan --installdeps .|;
  like $result, qr|each: \$PERL -MVenus=log -nE|;
  like $result, qr|exec: \$PERL -MVenus=log -E|;
  like $result, qr|repl: \$PERL -dE0|;
  like $result, qr|says: exec "map log\(eval\), \@ARGV"|;
  like $result, qr|test: \$PROVE|;
  like $result, qr|libs:|;
  like $result, qr|- -Ilib|;
  like $result, qr|- -Ilocal/lib/perl5|;
  like $result, qr|path:|;
  like $result, qr|- bin|;
  like $result, qr|- dev|;
  like $result, qr|- local/bin|;
  like $result, qr|perl:|;
  like $result, qr|perl: perl|;
  like $result, qr|prove: prove|;
  like $result, qr|vars:|;
  like $result, qr|PERL: perl|;
  like $result, qr|PROVE: prove|;
  like $result, qr|vns init|;
  like $result, qr|vns cpan \$DIST|;
  like $result, qr|vns deps|;
  like $result, qr|vns okay \$FILE|;
  like $result, qr|vns repl|;
  like $result, qr|vns exec \.\.\.|;
  like $result, qr|vns test t|;
  like $result, qr|Copyright 2022-2023, Vesion \d\.\d+|;
  like $result, qr|The Venus "AUTHOR" and "CONTRIBUTORS"|;

  $result
});

=method handler

The handler method processes the data provided and executes the request then
returns the invocant unless the program is exited.

=signature handler

  handler(HashRef $data) (Any)

=metadata handler

{
  since => '2.91',
}

=cut

=example-1 handler

  package main;

  use Venus::Run;

  my $run = Venus::Run->new;

  $run->execute;

  # ()

=cut

$test->for('example', 1, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  is_deeply $TEST_VENUS_RUN_SYSTEM, [];
  is_deeply $TEST_VENUS_RUN_OUTPUT, [];
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-2 handler

  package main;

  use Venus::Run;

  my $run = Venus::Run->new(['help']);

  $run->execute;

  # ()

=cut

$test->for('example', 2, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 1;
  is_deeply $TEST_VENUS_RUN_SYSTEM, [];
  is $$TEST_VENUS_RUN_OUTPUT[1], 'info';
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Usage: Venus::Run \<argument\> \[\<option\>\]|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-3 handler

  package main;

  use Venus::Run;

  my $run = Venus::Run->new(['--help']);

  $run->execute;

  # ()

=cut

$test->for('example', 3, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 1;
  is_deeply $TEST_VENUS_RUN_SYSTEM, [];
  is $$TEST_VENUS_RUN_OUTPUT[1], 'info';
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Usage: Venus::Run \<argument\> \[\<option\>\]|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-4 handler

  package main;

  use Venus::Run;

  my $run = Venus::Run->new(['init']);

  $run->execute;

  # ()

=cut

$test->for('example', 4, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  unlink '.vns.pl';
  ok !-f '.vns.pl';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  is_deeply $TEST_VENUS_RUN_SYSTEM, [];
  is $$TEST_VENUS_RUN_OUTPUT[1], 'info';
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Initialized with generated file \.vns\.pl|;
  ok -f '.vns.pl';
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-5 handler

  package main;

  use Venus::Run;

  # on linux

  my $run = Venus::Run->new(['echo']);

  $run->execute;

  # ()

  # i.e. ['echo']

=cut

$test->for('example', 5, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|echo$|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*echo|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-6 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   cpan: cpanm -llocal -qn
  #
  # ...

  my $run = Venus::Run->new(['cpan', 'Venus']);

  $run->execute;

  # ()

  # i.e. cpanm '-llocal' '-qn' Venus

=cut

$test->for('example', 6, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|cpanm '-llocal' '-qn' Venus|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*cpanm|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-7 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   cpan: cpanm -llocal -qn
  #   deps: cpan --installdeps .
  #
  # ...

  my $run = Venus::Run->new(['cpan', '--installdeps', '.']);

  $run->execute;

  # ()

  # i.e. cpanm '-llocal' '-qn' '--installdeps' '.'

=cut

$test->for('example', 7, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|cpanm '-llocal' '-qn' '--installdeps' '.'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*cpanm|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-8 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   okay: $PERL -c
  #
  # ...
  #
  # libs:
  # - -Ilib
  # - -Ilocal/lib/perl5
  #
  # ...
  #
  # vars:
  #   PERL: perl
  #
  # ...

  my $run = Venus::Run->new(['okay', 'lib/Venus.pm']);

  $run->execute;

  # ()

  # i.e. perl '-Ilib' '-Ilocal/lib/perl5' '-c'

=cut

$test->for('example', 8, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|perl '-Ilib' '-Ilocal/lib/perl5' '-c'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*perl|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-9 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   repl: $REPL
  #
  # ...
  #
  # libs:
  # - -Ilib
  # - -Ilocal/lib/perl5
  #
  # ...
  #
  # vars:
  #   PERL: perl
  #   REPL: $PERL -dE0
  #
  # ...

  my $run = Venus::Run->new(['repl']);

  $run->execute;

  # ()

  # i.e. perl '-Ilib' '-Ilocal/lib/perl5' '-dE0'

=cut

$test->for('example', 9, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|perl '-Ilib' '-Ilocal/lib/perl5' '-dE0'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*perl|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-10 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   exec: $PERL
  #
  # ...
  #
  # libs:
  # - -Ilib
  # - -Ilocal/lib/perl5
  #
  # ...
  #
  # vars:
  #   PERL: perl
  #
  # ...

  my $run = Venus::Run->new(['exec', '-MVenus=date', 'say date']);

  $run->execute;

  # ()

  # i.e. perl '-Ilib' '-Ilocal/lib/perl5' '-MVenus=date' 'say date'

=cut

$test->for('example', 10, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1],
    qr|perl '-Ilib' '-Ilocal/lib/perl5' '-MVenus=date' 'say date'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*perl|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-11 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   test: $PROVE
  #
  # ...
  #
  # libs:
  # - -Ilib
  # - -Ilocal/lib/perl5
  #
  # ...
  #
  # vars:
  #   PROVE: prove
  #
  # ...

  my $run = Venus::Run->new(['test', 't']);

  $run->execute;

  # ()

  # i.e. prove '-Ilib' '-Ilocal/lib/perl5' t

=cut

$test->for('example', 11, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|prove '-Ilib' '-Ilocal/lib/perl5' t|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*prove|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-12 handler

  package main;

  use Venus::Run;

  # on linux

  my $run = Venus::Run->new(['echo', 1, '|', 'less']);

  $run->execute;

  # ()

  # i.e. echo 1 | less

=cut

$test->for('example', 12, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|echo 1 \| less|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*echo|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-13 handler

  package main;

  use Venus::Run;

  # on linux

  my $run = Venus::Run->new(['echo', 1, '&&', 'echo', 2]);

  $run->execute;

  # ()

  # i.e. echo 1 && echo 2

=cut

$test->for('example', 13, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|echo 1 \| echo 2|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*echo|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-14 handler

  package main;

  use Venus::Run;

  # on linux

  local $ENV{VENUS_FILE} = 't/conf/from.perl';

  # in config
  #
  # ---
  # from:
  # - /path/to/parent
  #
  # ...
  #
  # exec:
  #   mypan: cpan -M https://pkg.myapp.com

  # in config (/path/to/parent)
  #
  # ---
  # exec:
  #   cpan: cpanm -llocal -qn
  #
  # ...

  my $run = Venus::Run->new(['mypan']);

  $run->execute;

  # ()

  # i.e. cpanm '-llocal' '-qn' '-M' 'https://pkg.myapp.com'

=cut

$test->for('example', 14, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1],
    qr|cpanm '-llocal' '-qn' '-M' 'https://pkg.myapp.com'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*cpanm|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-15 handler

  package main;

  use Venus::Run;

  # on linux

  local $ENV{VENUS_FILE} = 't/conf/with.perl';

  # in config
  #
  # ---
  # with:
  #   psql: /path/to/other
  #
  # ...

  # in config (/path/to/other)
  #
  # ---
  # exec:
  #   backup: pg_backupcluster
  #   restore: pg_restorecluster
  #
  # ...

  my $run = Venus::Run->new(['psql', 'backup']);

  $run->execute;

  # ()

  # i.e. vns backup

=cut

$test->for('example', 15, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|vns backup|;
  is_deeply $TEST_VENUS_RUN_OUTPUT, [];
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-16 handler

  package main;

  use Venus::Run;

  # on linux

  local $ENV{VENUS_FILE} = 't/conf/with.perl';

  # in config
  #
  # ---
  # with:
  #   psql: /path/to/other
  #
  # ...

  # in config (/path/to/other)
  #
  # ---
  # exec:
  #   backup: pg_backupcluster
  #   restore: pg_restorecluster
  #
  # ...

  my $run = Venus::Run->new(['psql', 'backup']);

  $run->execute;

  # VENUS_FILE=t/conf/psql.perl vns backup

  local $ENV{VENUS_FILE} = 't/conf/psql.perl';

  $run = Venus::Run->new(['backup']);

  $run->execute;

  # ()

  # i.e. pg_backupcluster

=cut

$test->for('example', 16, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|pg_backupcluster|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*pg_backupcluster|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-17 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   cpan: cpanm -llocal -qn
  #
  # ...
  #
  # flow:
  #   setup-term:
  #   - cpan Term::ReadKey
  #   - cpan Term::ReadLine::Gnu
  #
  # ...

  local $ENV{VENUS_FILE} = 't/conf/flow.perl';

  my $run = Venus::Run->new(['setup-term']);

  $run->execute;

  # ()

  # i.e.
  # cpanm '-llocal' '-qn' 'Term::ReadKey'
  # cpanm '-llocal' '-qn' 'Term::ReadLine::Gnu'

=cut

$test->for('example', 17, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM_LOG[0][1],
    qr|.*cpanm '-llocal' '-qn' 'Term::ReadKey'|;
  like $$TEST_VENUS_RUN_SYSTEM_LOG[1][1],
    qr|.*cpanm '-llocal' '-qn' 'Term::ReadLine::Gnu'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*cpanm|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-17 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # exec:
  #   cpan: cpanm -llocal -qn
  #
  # ...
  #
  # flow:
  #   setup-term:
  #   - cpan Term::ReadKey
  #   - cpan Term::ReadLine::Gnu
  #
  # ...

  local $ENV{VENUS_FILE} = 't/conf/flow.perl';

  my $run = Venus::Run->new(['setup-term']);

  $run->execute;

  # ()

  # i.e.
  # cpanm '-llocal' '-qn' 'Term::ReadKey'
  # cpanm '-llocal' '-qn' 'Term::ReadLine::Gnu'

=cut

$test->for('example', 17, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM_LOG[0][1],
    qr|.*cpanm '-llocal' '-qn' 'Term::ReadKey'|;
  like $$TEST_VENUS_RUN_SYSTEM_LOG[1][1],
    qr|.*cpanm '-llocal' '-qn' 'Term::ReadLine::Gnu'|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*cpanm|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;

  1
});

=example-18 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # asks:
  #   PASS: What's the password
  #
  # ...

  local $ENV{VENUS_FILE} = 't/conf/asks.perl';

  my $run = Venus::Run->new(['echo', '$PASS']);

  $run->execute;

  # ()

  # i.e. echo '$PASS'

=cut

$test->for('example', 18, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  local $TEST_VENUS_RUN_PROMPT = 'secret';
  local $ENV{PASS} = undef;
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|echo secret$|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*echo|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  is_deeply $TEST_VENUS_RUN_PRINT, ["What's the password"];
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-19 handler

  package main;

  use Venus::Run;

  # on linux

  # in config
  #
  # ---
  # func:
  #   dump: /path/to/dump.pl
  #
  # ...

  # in dump.pl (/path/to/dump.pl)
  #
  # sub {
  #   my ($args) = @_;
  #
  #   ...
  # }

  local $ENV{VENUS_FILE} = 't/conf/func.perl';

  my $run = Venus::Run->new(['dump', '--', 'hello']);

  $run->execute;

  # ()

  # i.e. perl -Ilib ... -E '(do "./t/path/etc/dump.pl")->(\@ARGV)' '--' hello

=cut

$test->for('example', 19, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  my $command =
    qr|perl.* '-E' '\(do "./t/path/etc/dump.pl"\)->\(\\\@ARGV\)' '--' hello|;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|$command$|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*perl|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-20 handler

  package main;

  use Venus::Run;

  # on linux

  local $ENV{VENUS_FILE} = 't/conf/when.perl';

  # in config
  #
  # ---
  # exec:
  #   name: echo $OSNAME
  #
  # ...
  # when:
  #   is_lin:
  #     data:
  #       OSNAME: LINUX
  #   is_win:
  #     data:
  #       OSNAME: WINDOW
  #
  # ...

  my $run = Venus::Run->new(['name']);

  $run->execute;

  # ()

  # i.e. echo $OSNAME

  # i.e. echo LINUX

=cut

$test->for('example', 20, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|echo LINUX$|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*echo LINUX|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-21 handler

  package main;

  use Venus::Run;

  # on mswin32

  local $ENV{VENUS_FILE} = 't/conf/when.perl';

  # in config
  #
  # ---
  # exec:
  #   name: echo $OSNAME
  #
  # ...
  # when:
  #   is_lin:
  #     data:
  #       OSNAME: LINUX
  #   is_win:
  #     data:
  #       OSNAME: WINDOW
  #
  # ...

  my $run = Venus::Run->new(['name']);

  $run->execute;

  # ()

  # i.e. echo $OSNAME

  # i.e. echo WINDOWS

=cut

$test->for('example', 21, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'mswin32';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 0;
  like $$TEST_VENUS_RUN_SYSTEM[1], qr|echo WINDOWS$|;
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Using:.*echo WINDOWS|;
  like $$TEST_VENUS_RUN_OUTPUT[1], qr|info|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=example-22 handler

  package main;

  use Venus::Run;

  # on linux

  local $ENV{VENUS_FILE} = 't/conf/help.perl';

  # in config
  #
  # ---
  # exec:
  #   exec: perl -c
  #
  # ...
  # help:
  #   exec: Usage: perl -c <FILE>
  #
  # ...

  my $run = Venus::Run->new(['help', 'exec']);

  $run->execute;

  # ()

  # i.e. Usage: perl -c <FILE>

=cut

$test->for('example', 22, 'handler', sub {
  my ($tryable) = @_;
  local $TEST_VENUS_RUN_EXIT;
  local $TEST_VENUS_RUN_OUTPUT = [];
  local $TEST_VENUS_RUN_SYSTEM = [];
  ok -f '.vns.pl';
  require Venus::Os;
  $Venus::Os::TYPES{$^O} = 'linux';
  my $result = $tryable->result;
  is $TEST_VENUS_RUN_EXIT, 1;
  is_deeply $TEST_VENUS_RUN_SYSTEM, [];
  is $$TEST_VENUS_RUN_OUTPUT[1], 'info';
  like $$TEST_VENUS_RUN_OUTPUT[2], qr|Usage: perl -c \<FILE\>|;
  $TEST_VENUS_RUN_SYSTEM_LOG = [];

  1
});

=method init

The init method returns the default configuration to be used when initializing
the system with a new configuration file.

=signature init

  init() (HashRef)

=metadata init

{
  since => '2.91',
}

=cut

=example-1 init

  # given: synopsis

  package main;

  my $init = $run->init;

  # {
  #   data => {
  #     ECHO => 1,
  #   },
  #   exec => {
  #     brew => 'perlbrew',
  #     cpan => 'cpanm -llocal -qn',
  #     docs => 'perldoc',
  #     each => 'shim -nE',
  #     edit => '$EDITOR $VENUS_FILE',
  #     eval => 'shim -E',
  #     exec => '$PERL',
  #     info => '$PERL -V',
  #     lint => 'perlcritic',
  #     okay => '$PERL -c',
  #     repl => '$REPL',
  #     reup => 'cpanm -qn Venus',
  #     says => 'eval "map log(eval), @ARGV"',
  #     shim => '$PERL -MVenus=true,false,log',
  #     test => '$PROVE',
  #     tidy => 'perltidy',
  #   },
  #   libs => [
  #     '-Ilib',
  #     '-Ilocal/lib/perl5',
  #   ],
  #   path => [
  #     './bin',
  #     './dev',
  #     './local/bin',
  #   ],
  #   perl => {
  #     perl => 'perl',
  #     prove => 'prove',
  #   },
  #   vars => {
  #     PERL => 'perl',
  #     PROVE => 'prove'
  #     REPL => '$PERL -dE0'
  #   },
  # }

=cut

$test->for('example', 1, 'init', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, $init;

  $result
});

=method name

The name method returns the default name for the task. This is used in usage
text and can be controlled via the C<VENUS_RUN_NAME> environment variable, or
the C<NAME> package variable.

=signature name

  name() (Str)

=metadata name

{
  since => '2.91',
}

=cut

=example-1 name

  # given: synopsis

  package main;

  my $name = $run->name;

  # "Venus::Run"

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "Venus::Run";

  $result
});

=example-2 name

  # given: synopsis

  package main;

  local $ENV{VENUS_RUN_NAME} = 'venus-runner';

  my $name = $run->name;

  # "venus-runner"

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  my $value = $ENV{VENUS_RUN_NAME};
  my $result = $tryable->result;
  is $result, "venus-runner";
  $ENV{VENUS_RUN_NAME} = $value;

  $result
});

=example-3 name

  # given: synopsis

  package main;

  local $Venus::Run::NAME = 'venus-runner';

  my $name = $run->name;

  # "venus-runner"

=cut

$test->for('example', 3, 'name', sub {
  my ($tryable) = @_;
  my $value = $Venus::Run::NAME;
  my $result = $tryable->result;
  is $result, "venus-runner";
  $Venus::Run::NAME = $value;

  $result
});

=method opts

The opts method returns the task options declarations.

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

  my $opts = $run->opts;

  # {
  #   'help' => {
  #     help => 'Show help information',
  #   }
  # }

=cut

$test->for('example', 1, 'opts', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, {
    'help' => {
      help => 'Show help information',
    }
  };

  $result
});

=feature config

The CLI provided by this package operates on a configuration file, typically
having a base name of C<.vns> with a Perl, JSON, or YAML file extension. Here
is an example of a configuration file using YAML with the filename
C<.vns.yaml>.

  ---
  data:
    ECHO: true
  exec:
    cpan: cpanm -llocal -qn
    okay: $PERL -c
    repl: $PERL -dE0
    says: $PERL -E "map log(eval), @ARGV"
    test: $PROVE
  libs:
  - -Ilib
  - -Ilocal/lib/perl5
  load:
  - -MVenus=true,false
  path:
  - ./bin
  - ./dev
  - -Ilocal/bin
  perl:
    perl: perl
    prove: prove
  vars:
    PERL: perl
    PROVE: prove

=cut

$test->for('feature', 'config');

=feature config-asks

  ---
  asks:
    HOME: Enter your home dir

The configuration file's C<asks> section provides a list of key/value pairs
where the key is the name of the environment variable and the value is used as
the message used by the CLI to prompt for input if the environment variable is
not defined.

=cut

$test->for('feature', 'config-asks');

=feature config-data

  ---
  data:
    ECHO: true

The configuration file's C<data> section provides a non-dynamic list of
key/value pairs that will be used as environment variables.

=cut

$test->for('feature', 'config-data');

=feature config-exec

  ---
  exec:
    okay: $PERL -c

The configuration file's C<exec> section provides the main dynamic tasks which
can be recursively resolved and expanded.

=cut

$test->for('feature', 'config-exec');

=feature config-find

  ---
  find:
    cpanm: /usr/local/bin/cpanm

The configuration file's C<find> section provides aliases which can be
recursively resolved and expanded for use in other tasks.

=cut

$test->for('feature', 'config-find');

=feature config-flow

  ---
  flow:
    deps:
    - cpan Term::ReadKey
    - cpan Term::ReadLine::Gnu

The configuration file's C<flow> section provides chainable tasks which are
recursively resolved and expanded from other tasks.

=cut

$test->for('feature', 'config-flow');

=feature config-from

  ---
  from:
  - /usr/share/vns/.vns.yaml

The configuration file's C<from> section provides paths to other configuration
files which will be merged before execution allowing the inheritance of of
configuration values.

=cut

$test->for('feature', 'config-from');

=feature config-func

  ---
  func:
    build: ./scripts/build.pl

The configuration file's C<func> section provides a list of static key/value
pairs where the key is the "subcommand" passed to the runner as the first
arugment, and the value is the Perl script that will be loaded and executed.
The Perl script is expected to return a subroutine reference and will be passed
an array reference to the arguments provided.

=cut

$test->for('feature', 'config-func');

=feature config-help

  ---
  help:
    build: Usage: vns build [<option>]

The configuration file's C<help> section provides a list of static key/value
pairs where the key is the "subcommand" to display help text for, and the value
is the help text to be displayed.

=cut

$test->for('feature', 'config-help');

=feature config-libs

  ---
  libs:
  - -Ilib
  - -Ilocal/lib/perl5

The configuration file's C<libs> section provides a list of C<-I/path/to/lib>
"include" statements that will be automatically added to tasks expanded from
the C<perl> section.

=cut

$test->for('feature', 'config-libs');

=feature config-load

  ---
  load:
  - -MVenus=true,false

The configuration file's C<load> section provides a list of C<-MPackage>
"import" statements that will be automatically added to tasks expanded from the
C<perl> section.

=cut

$test->for('feature', 'config-load');

=feature config-path

  ---
  path:
  - ./bin
  - ./dev
  - -Ilocal/bin

The configuration file's C<path> section provides a list of paths to be
prepended to the C<PATH> environment variable which allows programs to be
found.

=cut

$test->for('feature', 'config-path');

=feature config-perl

  ---
  perl:
    perl: perl

The configuration file's C<perl> section provides the dynamic perl tasks which
can serve as tasks with default commands (with options) and which can be
recursively resolved and expanded.

=cut

$test->for('feature', 'config-perl');

=feature config-task

  ---
  task:
    setup: $PERL -MMyApp::Task::Setup -E0 --

The configuration file's C<task> section provides the dynamic perl tasks which
"load" L<Venus::Task> derived packages, and which can be recursively resolved
and expanded. These tasks will typically take the form of C<perl -Ilib
-MMyApp::Task -E0 --> and will be automatically executed as a CLI.

=cut

$test->for('feature', 'config-task');

=feature config-vars

  ---
  vars:
    PERL: perl

The configuration file's C<vars> section provides a list of dynamic key/value
pairs that can be recursively resolved and expanded and will be used as
environment variables.

=back

$test->for('feature', 'config-vars');

=feature config-when

  ---
  when:
    is_lin:
      data:
        OSNAME: LINUX
    is_win:
      data:
        OSNAME: WINDOWS

The configuration file's C<when> section provides a configuration tree to be
merged with the existing configuration based on the name current operating
system. The C<is_$name> key should correspond to one of the types specified by
L<Venus::Os/type>.

=back

$test->for('feature', 'config-when');

=feature config-with

  ---
  with:
    psql: ./psql-tools/.vns.yml

The configuration file's C<with> section provides a list of static key/value
pairs where the key is the "subcommand" passed to the runner as the first
arugment, and the value is the configuration file where the subcommand task
definitions are defined which the runner dispatches to.

=back

$test->for('feature', 'config-with');

=feature vns-cli

Here are example usages of the configuration file mentioned, executed by the
L<vns> CLI, which is simply an executable file which loads this package.

  # Mint a new configuration file
  vns init

  ...

  # Mint a new JSON configuration file
  VENUS_FILE=.vns.json vns init

  # Mint a new YAML configuration file
  VENUS_FILE=.vns.yaml vns init

  ...

  # Install a distribution
  vns cpan $DIST

  # i.e.
  # cpanm --llocal -qn $DIST

  # Install dependencies in the CWD
  vns deps

  # i.e.
  # cpanm --llocal -qn --installdeps .

  # Check that a package can be compiled
  vns okay $FILE

  # i.e.
  # perl -Ilib -Ilocal/lib/perl5 -c $FILE

  # Use the Perl debugger as a REPL
  vns repl

  # i.e.
  # perl -Ilib -Ilocal/lib/perl5 -dE0

  # Evaluate arbitrary Perl expressions
  vns exec ...

  # i.e.
  # perl -Ilib -Ilocal/lib/perl5 -MVenus=log -E $@

  # Test the Perl project in the CWD
  vns test t

  # i.e.
  # prove -Ilib -Ilocal/lib/perl5 t

=cut

$test->for('feature', 'vns-cli');

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Run.pod') if $ENV{RENDER};

unlink '.vns.pl';

ok 1 and done_testing;
