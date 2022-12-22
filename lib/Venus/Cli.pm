package Venus::Cli;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Optional';

require POSIX;

# ATTRIBUTES

attr 'init';
attr 'path';
attr 'args';
attr 'data';
attr 'logs';
attr 'opts';
attr 'vars';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    init => $data,
  };
}

# DEFAULTS

sub default_args {
  my ($self) = @_;

  require Venus::Args;

  return Venus::Args->new($self->init);
}

sub default_data {
  my ($self) = @_;

  require Venus::Data;

  return Venus::Data->new($self->path);
}

sub default_init {
  my ($self) = @_;

  return [@ARGV];
}

sub default_logs {
  my ($self) = @_;

  require Venus::Log;

  return Venus::Log->new('info');
}

sub default_opts {
  my ($self) = @_;

  require Venus::Opts;

  return Venus::Opts->new(value => $self->init, specs => $self->options);
}

sub default_path {
  my ($self) = @_;

  require Venus::Path;
  require Venus::Space;

  return Venus::Path->new(Venus::Space->new(ref $self)->included || $0);
}

sub default_vars {
  my ($self) = @_;

  require Venus::Vars;

  return Venus::Vars->new;
}

# HOOKS

sub _exit {
  POSIX::_exit(shift);
}

# METHODS

sub arg {
  my ($self, $item) = @_;

  return defined $item ? $self->opts->unused->[$item] : undef;
}

sub execute {
  my ($self) = @_;

  return $self->opt('help') ? $self->okay : $self->fail;
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

sub help {
  my ($self, @data) = @_;

  my $content = $self->data->string(@data ? @data : ('head1', 'OPTIONS'));

  my ($space) = $content =~ /(^\s+)/;

  return (defined $space) ? $content =~ s/^$space//mgr : $content;
}

sub log_debug {
  my ($self, @data) = @_;

  return $self->logs->debug(@data);
}

sub log_error {
  my ($self, @data) = @_;

  return $self->logs->error(@data);
}

sub log_fatal {
  my ($self, @data) = @_;

  return $self->logs->fatal(@data);
}

sub log_info {
  my ($self, @data) = @_;

  return $self->logs->info(@data);
}

sub log_trace {
  my ($self, @data) = @_;

  return $self->logs->trace(@data);
}

sub log_warn {
  my ($self, @data) = @_;

  return $self->logs->warn(@data);
}

sub okay {
  my ($self, $method, @args) = @_;

  return $self->exit(0, $method, @args);
}

sub opt {
  my ($self, $item) = @_;

  return defined $item ? $self->opts->get($item) : undef;
}

sub options {
  my ($self) = @_;

  return ['help|h'];
}

1;
