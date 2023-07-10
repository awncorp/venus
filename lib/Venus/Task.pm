package Venus::Task;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

require POSIX;

# ATTRIBUTES

attr 'data';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    data => $data,
  };
}

sub build_args {
  my ($self, $args) = @_;

  my $data = $args->{data};

  $data = defined $data ? (ref $data eq 'ARRAY' ? $data : [$data]) : [@ARGV];

  $args->{data} = $data;

  return $args;
}

# HOOKS

sub _exit {
  POSIX::_exit(shift);
}

sub _system {
  local $SIG{__WARN__} = sub {};
  CORE::system(@_) or return 0;
}

sub _print {
  CORE::print(@_);
}

# METHODS

sub args {
  my ($self) = @_;

  return {};
}

sub cli {
  my ($self) = @_;

  require Venus::Cli;

  return $self->{'$cli'} ||= Venus::Cli->new(data => $self->data);
}

sub cmds {
  my ($self) = @_;

  return {};
}

sub execute {
  my ($self) = @_;

  $self->prepare;

  my $parsed = $self->cli->parsed;

  $self->startup($parsed);
  $self->handler($parsed);
  $self->shutdown($parsed);

  return $self;
}

sub exit {
  my ($self, $code, $method, @args) = @_;

  $self->$method(@args) if $method;

  $code ||= 0;

  _exit($code);
}

sub fail {
  my ($self, $method, @args) = @_;

  return $self->exit(1, $method, @args);
}

sub handler {
  my ($self, $data) = @_;

  $self->usage if $data->{help};

  return $self;
}

sub help {
  my ($self) = @_;

  return $self->cli->help;
}

sub log {
  my ($self) = @_;

  require Venus::Log;

  return $self->{'$log'} ||= Venus::Log->new(
    level => $self->log_level,
    handler => $self->defer('output')
  );
}

sub log_debug {
  my ($self, @args) = @_;

  return $self->log->debug(@args);
}

sub log_error {
  my ($self, @args) = @_;

  return $self->log->error(@args);
}

sub log_fatal {
  my ($self, @args) = @_;

  return $self->log->fatal(@args);
}

sub log_info {
  my ($self, @args) = @_;

  return $self->log->info(@args);
}

sub log_level {

  return 'info';
}

sub log_trace {
  my ($self, @args) = @_;

  return $self->log->trace(@args);
}

sub log_warn {
  my ($self, @args) = @_;

  return $self->log->warn(@args);
}

sub name {
  my ($self) = @_;

  return $0;
}

sub okay {
  my ($self, $method, @args) = @_;

  return $self->exit(0, $method, @args);
}

sub opts {
  my ($self) = @_;

  return {};
}

sub output {
  my ($self, $level, @data) = @_;

  local $|=1;

  _print(@data, "\n") if @data;

  return $self;
}

sub prepare {
  my ($self) = @_;

  my $cli = $self->cli;

  $cli->data($self->data);

  my $args = $self->args;
  my $cmds = $self->cmds;
  my $name = $self->name;
  my $opts = $self->opts;

  $cli->set('arg', $_, $args->{$_}) for sort keys %{$args};
  $cli->set('cmd', $_, $cmds->{$_}) for sort keys %{$cmds};
  $cli->set('opt', $_, $opts->{$_}) for sort keys %{$opts};

  $cli->set('str', 'name', $name) if !$cli->str('name') && $name;

  if ($self->can('description') && (my $description = $self->description)) {
    $cli->set('str', 'description', $description) if !$cli->str('description');
  }

  if ($self->can('header') && (my $header = $self->header)) {
    $cli->set('str', 'header', $header) if !$cli->str('header');
  }

  if ($self->can('footer') && (my $footer = $self->footer)) {
    $cli->set('str', 'footer', $footer) if !$cli->str('footer');
  }

  $self->log->do('level' => $self->log_level)->handler($self->defer('output'));

  return $self;
}

sub run {
  my ($self, @args) = @_;

  my $CAN_RUN = not(caller(1)) || scalar(caller(1)) eq 'main';

  $self->class->new(@args)->maybe('execute') if $ENV{VENUS_TASK_RUN} && $CAN_RUN;

  return $self;
}

sub startup {
  my ($self, $data) = @_;

  return $self;
}

sub shutdown {
  my ($self, $data) = @_;

  return $self;
}

sub system {
  my ($self, @args) = @_;

  (_system(@args) == 0) or $self->throw('error_on_system_call', \@args, $?)->error;

  return $self;
}

sub usage {
  my ($self) = @_;

  $self->fail(sub{$self->log_info($self->help)});

  return $self;
}

# ERRORS

sub error_on_system_call {
  my ($self, $args, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.system.call',
    message => "Can't make system call \"@$args\": $err",
    stash => {
      args => $args,
    }
  };
}

1;
