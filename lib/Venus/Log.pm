package Venus::Log;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

# ATTRIBUTES

attr 'handler';
attr 'level';
attr 'separator';

# STATE

state $NAME = {trace => 1, debug => 2, info => 3, warn => 4, error => 5, fatal => 6};
state $CODE = {reverse %$NAME};

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    level => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->level($self->level_name($self->level) || $self->level_name(1));
  $self->handler(sub{shift; CORE::print(STDOUT @_, "\n")}) if !$self->handler;
  $self->separator(" ") if !$self->separator;

  return $self;
}

# METHODS

sub commit {
  my ($self, $level, @args) = @_;

  my $req_level = $self->level_code($level);
  my $set_level = $self->level_code($self->level);

  return ($req_level && $set_level && ($req_level >= $set_level))
    ? $self->write($level, $self->output($self->input(@args)))
    : $self;
}

sub debug {
  my ($self, @args) = @_;

  return $self->commit('debug', @args);
}

sub error {
  my ($self, @args) = @_;

  return $self->commit('error', @args);
}

sub fatal {
  my ($self, @args) = @_;

  return $self->commit('fatal', @args);
}

sub info {
  my ($self, @args) = @_;

  return $self->commit('info', @args);
}

sub input {
  my ($self, @args) = @_;

  return (@args);
}

sub level_code {
  my ($self, $data) = @_;

  $data = $data ? lc $data : $self->level;

  return undef if !defined $data;

  return $$NAME{$data} || ($$CODE{$data} && $$NAME{$$CODE{$data}});
}

sub level_name {
  my ($self, $data) = @_;

  $data = $data ? lc $data : $self->level;

  return undef if !defined $data;

  return $$CODE{$data} || ($$NAME{$data} && $$CODE{$$NAME{$data}});
}

sub output {
  my ($self, @args) = @_;

  return (join $self->separator, map $self->string($_), @args);
}

sub string {
  my ($self, $data) = @_;

  require Scalar::Util;

  if (!defined $data) {
    return '';
  }

  my $blessed = Scalar::Util::blessed($data);
  my $isvenus = $blessed && $data->isa('Venus::Core') && $data->can('does');

  if (!$blessed && !ref $data) {
    return $data;
  }
  if ($blessed && ref($data) eq 'Regexp') {
    return "$data";
  }
  if ($isvenus && $data->does('Venus::Role::Explainable')) {
    return $self->dump(sub{$data->explain});
  }
  if ($isvenus && $data->does('Venus::Role::Valuable')) {
    return $self->dump(sub{$data->value});
  }
  if ($isvenus && $data->does('Venus::Role::Dumpable')) {
    return $data->dump;
  }
  if ($blessed && overload::Method($data, '""')) {
    return "$data";
  }
  if ($blessed && $data->can('as_string')) {
    return $data->as_string;
  }
  if ($blessed && $data->can('to_string')) {
    return $data->to_string;
  }
  if ($blessed && $data->isa('Venus::Kind')) {
    return $data->stringified;
  }
  else {
    return $self->dump(sub{$data});
  }
}

sub trace {
  my ($self, @args) = @_;

  return $self->commit('trace', @args);
}

sub warn {
  my ($self, @args) = @_;

  return $self->commit('warn', @args);
}

sub write {
  my ($self, $level, @args) = @_;

  $self->handler->($level, @args);

  return $self;
}

1;
