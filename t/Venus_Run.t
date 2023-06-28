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

my $test = test(__FILE__);

my $init = {
  data => {
    ECHO => 1,
  },
  exec => {
    brew => 'perlbrew',
    cpan => 'cpanm -llocal -qn',
    deps => 'cpan --installdeps .',
    each => '$PERL -MVenus=true,false,log -nE',
    eval => '$PERL -MVenus=true,false,log -E',
    exec => '$PERL',
    info => '$PERL -V',
    okay => '$PERL -c',
    repl => '$PERL -dE0',
    says => 'eval "map log($_), map eval, @ARGV"',
    test => '$PROVE'
  },
  find => {
  },
  libs => [
    '-Ilib',
    '-Ilocal/lib/perl5',
  ],
  load => [
  ],
  path => [
    './bin',
    './dev',
    './local/bin',
  ],
  perl => {
    perl => 'perl',
    prove => 'prove',
    'perl-5.18.0' => 'perlbrew exec --with perl-5.18.0 perl',
    'prove-5.18.0' => 'perlbrew exec --with perl-5.18.0 prove'
  },
  task => {
  },
  vars => {
    PERL => 'perl',
    PROVE => 'prove'
  },
};

our $TEST_VENUS_RUN_EXIT;
our $TEST_VENUS_RUN_OUTPUT = [];
our $TEST_VENUS_RUN_SYSTEM = [];

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
    $TEST_VENUS_RUN_SYSTEM = [@_];
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

This package is a L<Venus::Task> which provides generic task running
capabilities. A simple CLI using this package has been made available in
L<vns>.

+=head1 USAGES

Here is an example configuration file in YAML (e.g. in C<.vns.yaml>).

  ---
  data:
    ECHO: true
  exec:
    okay: \$PERL -c
    cpan: cpanm -llocal -qn
    deps: cpan --installdeps .
    each: \$PERL -MVenus=log -nE
    exec: \$PERL -MVenus=log -E
    repl: \$PERL -dE0
    says: exec "map log(\$_), map eval, \@ARGV"
    test: \$PROVE
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

The following describes the configuration file sections and how they're used:

+=over 4

+=item *

The C<data> section provides a non-dynamic list of key/value pairs that will
be used as environment variables.

+=item *

The C<exec> section provides the main dynamic tasks which can be recursively
resolved and expanded.

+=item *

The C<find> section provides aliases which can be recursively resolved and
expanded for use in other tasks.

+=item *

The C<libs> section provides a list of C<-I/path/to/lib> "include" statements
that will be automatically added to tasks expanded from the C<perl> section.

+=item *

The C<load> section provides a list of C<-MPackage> "import" statements
that will be automatically added to tasks expanded from the C<perl> section.

+=item *

The C<path> section provides a list of paths to be prepended to the C<PATH>
environment variable which allows programs to be found.

+=item *

The C<perl> section provides the dynamic perl tasks which can serve as tasks
with default commands (with options) and which can be recursively resolved and
expanded.

+=item *

The C<task> section provides the dynamic perl tasks which "load" L<Venus::Task>
derived packages, and which can be recursively resolved and expanded. These
tasks will typically take the form of C<perl -Ilib -MMyApp::Task -E0 --> and
will be automatically executed as a CLI.

+=item *

The C<vars> section provides a list of dynamic key/value pairs that can be
recursively resolved and expanded and will be used as environment variables.

+=back

Here are example usages using the example YAML configuration file and the
L<vns> CLI.

  # Mint a new configuration file
  vns init

  ...

  # Install a distribution
  vns cpan $DIST

  i.e. $(which cpanm) --llocal -qn $DIST

  # Install dependencies in the CWD
  vns deps

  i.e. $(which cpanm) --llocal -qn --installdeps .

  # Check that a package can be compiled
  vns okay $FILE

  i.e. $(which perl) -Ilib -Ilocal/lib/perl5 -c $FILE

  # Use the Perl debugger as a REPL
  vns repl

  i.e. $(which perl) -Ilib -Ilocal/lib/perl5 -dE0

  # Evaluate arbitrary Perl expressions
  vns exec ...

  i.e. $(which perl) -Ilib -Ilocal/lib/perl5 -MVenus=log -E $@

  # Test the Perl project in the CWD
  vns test t

  i.e. $(which prove) -Ilib -Ilocal/lib/perl5 t

This package and CLI allows you to define task definitions for any application,
which you can run using the name of the task. You can reuse existing task
definitions in new tasks which will be recursively resolved when needed. You
can define static and dynamic environment variables, and also pre-define
"includes" and the order in which they're declared.

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
  like $result, qr|says: exec "map log\(\$_\), map eval, \@ARGV"|;
  like $result, qr|test: \$PROVE|;
  like $result, qr|libs:|;
  like $result, qr|- -Ilib|;
  like $result, qr|- -Ilocal/lib/perl5|;
  like $result, qr|load:|;
  like $result, qr|- -MVenus=true,false|;
  like $result, qr|path:|;
  like $result, qr|- ./bin|;
  like $result, qr|- ./dev|;
  like $result, qr|- -Ilocal/bin|;
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

  1
});

=example-6 handler

  package main;

  use Venus::Run;

  # on linux

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

  1
});

=example-7 handler

  package main;

  use Venus::Run;

  # on linux

  my $run = Venus::Run->new(['deps']);

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

  1
});

=example-8 handler

  package main;

  use Venus::Run;

  # on linux

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

  1
});

=example-9 handler

  package main;

  use Venus::Run;

  # on linux

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

  1
});

=example-10 handler

  package main;

  use Venus::Run;

  # on linux

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

  1
});

=example-11 handler

  package main;

  use Venus::Run;

  # on linux

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
  #     deps => 'cpan --installdeps .',
  #     each => '$PERL -MVenus=true,false,log -nE',
  #     eval => '$PERL -MVenus=true,false,log -E',
  #     exec => '$PERL',
  #     info => '$PERL -V',
  #     okay => '$PERL -c',
  #     repl => '$PERL -dE0',
  #     says => 'eval "map log($_), map eval, @ARGV"',
  #     test => '$PROVE'
  #   },
  #   find => {
  #   },
  #   libs => [
  #     '-Ilib',
  #     '-Ilocal/lib/perl5',
  #   ],
  #   load => [
  #   ],
  #   path => [
  #     './bin',
  #     './dev',
  #     './local/bin',
  #   ],
  #   perl => {
  #     perl => 'perl',
  #     prove => 'prove',
  #     'perl-5.18.0' => 'perlbrew exec --with perl-5.18.0 perl',
  #     'prove-5.18.0' => 'perlbrew exec --with perl-5.18.0 prove'
  #   },
  #   task => {
  #   },
  #   vars => {
  #     PERL => 'perl',
  #     PROVE => 'prove'
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

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Run.pod') if $ENV{RENDER};

unlink '.vns.pl';

ok 1 and done_testing;
