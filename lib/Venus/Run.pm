package Venus::Run;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Task';

require Venus;

our $NAME = __PACKAGE__;

# HOOKS

sub _print {
  do {local $| = 1; CORE::print(@_, "\n")}
}

sub _prompt {
  do {local $\ = ''; local $_ = <STDIN>; chomp; $_}
}

# METHODS

state $args = {
  'command' => {
    help => 'Command to run',
    required => 1,
  }
};

sub args {

  return $args;
}

state $cmds = {
  'help' => {
    help => 'Display help and usages',
    arg => 'command',
  },
  'init' => {
    help => 'Initialize the configuration file',
    arg => 'command',
  },
};

sub cmds {

  return $cmds;
}

sub conf {
  my ($self) = @_;

  require Venus::Config;

  return Venus::Config->read_file($self->file)->value;
}

sub file {

  return $ENV{VENUS_FILE} || (grep -f, map ".vns.$_", qw(yaml yml json js perl pl))[0]
}

state $footer = <<"EOF";
Config:

Here is an example configuration in YAML (e.g. in .vns.yaml).

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

Examples:

Here are examples usages using the example YAML configuration.

  # Mint a new configuration file
  vns init

  # Install a distribution
  vns cpan \$DIST

  # Install dependencies in the CWD
  vns deps

  # Check that a package can be compiled
  vns okay \$FILE

  # Use the Perl debugger as a REPL
  vns repl

  # Evaluate arbitrary Perl expressions
  vns exec ...

  # Test the Perl project in the CWD
  vns test t

Copyright 2022-2023, Vesion $Venus::VERSION, The Venus "AUTHOR" and "CONTRIBUTORS"

More information on "vns" and/or the "Venus" standard library, visit
https://p3rl.org/vns.
EOF

sub footer {

  return $footer;
}

sub handler {
  my ($self, $data) = @_;

  my $help = $data->{help};
  my $next = $data->{command};

  return $self->okay if !$help && !$next;

  return $self->handler_for_help($data) if (!$next && $help) || (lc($next) eq 'help');

  return $self->handler_for_init($data) if lc($next) eq 'init';

  return $self->handler_for_exec($data);
}

sub handler_for_exec {
  my ($self, $data) = @_;

  my $code = sub {
    my $command = join ' ', @_;

    $self->log_info('Using:', $command) if $ENV{ECHO};

    my $error = $self->catch('system', $command);

    $self->log_error("Error running command! $command") if $error;
  };

  return $self->okay(sub{_exec($code, $self->conf, @{$self->data})});
}

sub handler_for_help {
  my ($self, $data) = @_;

  return $self->fail(sub{$self->log_info($self->help)});
}

sub handler_for_init {
  my ($self, $data) = @_;

  my $file = $self->file;

  return $self->fail('log_error', "Already using $file") if $file && -f $file;

  $file ||= '.vns.pl';

  require Venus::Config;

  my $init = $self->init;

  Venus::Config->new($self->init)->write_file($file);

  return $self->okay('log_info', "Initialized with generated file $file");
}

state $init = {
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

sub init {

  return $init;
}

sub name {

  return $ENV{VENUS_RUN_NAME} || $NAME;
}

state $opts = {
  'help' => {
    help => 'Show help information',
  }
};

sub opts {

  return $opts;
}

# ROUTINES

sub _exec {
  my ($code, $conf, @data) = @_;

  return () if !@data;

  $conf = _set_conf($conf);

  my %ORIG_ENV = %ENV;

  _set_vars($conf);

  _set_path($conf);

  _set_libs($conf);

  for my $step (_flow($conf, @data)) {
    my ($prog, @args) = @{$step};

    $code->($prog, @args) if $prog;
  }

  %ENV = %ORIG_ENV;

  return (@data);
}

sub _find {
  my ($seen, $conf, @data) = @_;

  return () if !@data;

  @data = map _split($_), @data;

  my @item = map {s/^\$//r} shift @data;

  @item = (_find_in_exec($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_find($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_flow($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_func($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_perl($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_task($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_vars($seen, $conf, @item));

  if (@item > 1) {
    unshift @data, @item; @item = shift @data;
  }

  @item = (_find_in_with($seen, $conf, @item));

  if (@item > 1) {
    shift @data; unshift @data, @item; @item = shift @data;
  }

  return (@item, @data);
}

sub _find_in_exec {
  my ($seen, $conf, $item) = @_;

  return $conf->{exec}
    ? (
    $conf->{exec}{$item}
    ? (do {
      my $value = $conf->{exec}{$item};
      ($value eq $item)
        ? ($value)
        : (_find_in_seen($seen, $conf, 'exec', $item, $value));
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_find {
  my ($seen, $conf, $item) = @_;

  return $conf->{find}
    ? (
    $conf->{find}{$item}
    ? (do {
      my $value = $conf->{find}{$item};
      ($value eq $item)
        ? ($value)
        : (_find_in_seen($seen, $conf, 'find', $item, $value));
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_flow {
  my ($seen, $conf, $item) = @_;

  return $conf->{flow}
    ? (
    $conf->{flow}{$item}
    ? (do {
      my $value = $conf->{flow}{$item};
      join ' && ', map +(join(' ', _exec(sub{}, $conf, $_))), @{$value}
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_func {
  my ($seen, $conf, $item) = @_;

  return $conf->{func}
    ? (
    $conf->{func}{$item}
    ? (do {
      my $value = _vars($conf->{func}{$item});
      ('perl', '-E', "(do \"$value\")->(\\\@ARGV)")
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_perl {
  my ($seen, $conf, $item) = @_;

  return $conf->{perl}
    ? (
    $conf->{perl}{$item}
    ? (do {
      my $value = $conf->{perl}{$item};
      ($value eq $item)
        ? ($value)
        : (_find_in_seen($seen, $conf, 'perl', $item, $value));
    },
      _load_from_libs($seen, $conf),
      _load_from_load($seen, $conf),
    )
    : ($item)
    )
    : ($item);
}

sub _find_in_task {
  my ($seen, $conf, $item) = @_;

  return $conf->{task}
    ? (
    $conf->{task}{$item}
    ? (do {
      $ENV{VENUS_TASK_RUN} = 1;
      my $value = $conf->{task}{$item};
      ($value eq $item)
        ? ($value)
        : (_find_in_seen($seen, $conf, 'task', $item, $value));
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_vars {
  my ($seen, $conf, $item) = @_;

  return $conf->{vars}
    ? (
    $conf->{vars}{$item}
    ? (do {
      my $value = $conf->{vars}{$item};
      ($value eq $item)
        ? ($value)
        : (_find_in_seen($seen, $conf, 'vars', $item, $value));
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_with {
  my ($seen, $conf, $item) = @_;

  return $conf->{with}
    ? (
    $conf->{with}{$item}
    ? (do {
      $ENV{ECHO} = 0;
      $ENV{VENUS_FILE} = _vars($conf->{with}{$item});
      $ENV{VENUS_RUN_NAME} || 'vns';
    })
    : ($item)
    )
    : ($item);
}

sub _find_in_seen {
  my ($seen, $conf, $item, $name, $value) = @_;

  return $seen->{$item}{$name}++
    ? ((_split($value))[0])
    : (_find($seen, $conf, $value));
}

sub _flow {
  my ($conf, @data) = @_;

  return () if !@data;

  my $item = shift @data;

  return $conf->{flow}
    ? (
    $conf->{flow}{$item}
    ? (do {
     (map _flow($conf, $_, @data), @{$conf->{flow}{$item}});
    })
    : (_prep($conf, $item, @data))
    )
    : (_prep($conf, $item, @data));
}

sub _libs {
  my ($conf) = @_;

  return (map /^-I\w*?(.*)$/, _load_from_libs({}, $conf));
}

sub _load_from_libs {
  my ($seen, $conf) = @_;

  return !$seen->{libs}++ ? ($conf->{libs} ? (@{$conf->{libs}}) : ()) : ();
}

sub _load_from_load {
  my ($seen, $conf) = @_;

  return !$seen->{load}++ ? ($conf->{load} ? (@{$conf->{load}}) : ()) : ();
}

sub _make {
  my ($conf, $name) = @_;

  my ($item, @data) = _find({}, $conf, $name);

  require Venus::Os;

  my $path = Venus::Os->which($item);

  return (($path ? $path : $item), @data);
}

sub _prep {
  my ($conf, @data) = @_;

  my @args = map _vars($_), grep defined, _make($conf, shift(@data)), @data;

  my $prog = shift @args;

  require Venus::Os;

  for (my $i = 0; $i < @args; $i++) {
    if ($args[$i] =~ /^\|+$/) {
      next;
    }
    if ($args[$i] =~ /^\&+$/) {
      next;
    }
    if ($args[$i] =~ /^\w+$/) {
      next;
    }
    if ($args[$i] =~ /^[<>]+$/) {
      next;
    }
    if ($args[$i] =~ /^\d[<>&]+\d?$/) {
      next;
    }
    if ($args[$i] =~ /\$[A-Z]\w+/) {
      next;
    }
    if ($args[$i] =~ /^\$\((.*)\)$/) {
      if ($1) {
        $args[$i] = "\$(@{[@{_prep($conf, $1)}]})";
      }
      next;
    }
    $args[$i] = Venus::Os->quote($args[$i]);
  }

  return [$prog ? ($prog, @args) : ()];
}

sub _split {
  my ($text) = @_;

  return (grep length, ($text // '') =~ /(?x)(?:"([^"]*)"|([^\s]*))\s?/g);
}

sub _set_conf {
  my ($conf) = @_;

  $conf = Venus::merge(Venus::Config->read_file(_vars($_))->value, $conf)
    for (
      $conf->{from}
      ? ((ref $conf->{from} eq 'ARRAY') ? (@{$conf->{from}}) : ($conf->{from}))
      : ()
    );

  return $conf;
}

sub _set_libs {
  my ($conf) = @_;

  require Venus::Os;
  require Venus::Path;

  my %seen;
  $ENV{PERL5LIB} = join((Venus::Os->is_win ? ';' : ':'),
    (grep !$seen{$_}++, map Venus::Path->new(_vars($_))->absolute, _libs($conf)));

  return $conf;
}

sub _set_path {
  my ($conf) = @_;

  require Venus::Os;
  require Venus::Path;

  if (my $path = $conf->{path}) {
    $ENV{PATH} = join((Venus::Os->is_win ? ';' : ':'),
      (map Venus::Path->new(_vars($_))->absolute, @{$conf->{path}}), $ENV{PATH});
  }

  return $conf;
}

sub _set_vars {
  my ($conf) = @_;

  if (my $vars = $conf->{data}) {
    $ENV{$_} = join(' ', grep defined, $vars->{$_}) for keys %{$vars};
  }

  if (my $vars = $conf->{vars}) {
    $ENV{$_} = join(' ', grep defined, _find({}, $conf, $_)) for keys %{$vars};
  }

  if (my $asks = $conf->{asks}) {
    for my $key (sort keys %{$asks}) {
      next if defined $ENV{$key}; _print $asks->{$key}; $ENV{$key} = _prompt;
    }
  }

  return $conf;
}

sub _vars {
  (($_[0] // '') =~ s{\$([A-Z]+)}{$ENV{$1}//"\$".$1}egr)
}

# AUTORUN

run Venus::Run;

1;
