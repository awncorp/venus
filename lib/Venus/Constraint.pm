package Venus::Constraint;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

use Venus::Check;

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

# ATTRIBUTES

attr 'on_eval';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    on_eval => ref $data eq 'ARRAY' ? $data : [$data],
  };
}

sub build_args {
  my ($self, $data) = @_;

  $data->{on_eval} = [] if !$data->{on_eval};

  return $data;
}

# METHODS

sub accept {
  my ($self, $name, @args) = @_;

  if (!$name) {
    return $self;
  }
  if ($self->check->can($name)) {
    $self->check->accept($name, @args);
  }
  else {
    $self->check->identity($name, @args);
  }
  return $self;
}

sub check {
  my ($self, @args) = @_;

  $self->{check} = $args[0] if @args;

  return $self->{check} ||= Venus::Check->new;
}

sub clear {
  my ($self) = @_;

  @{$self->on_eval} = ();

  $self->check->clear;

  return $self;
}

sub ensure {
  my ($self, @code) = @_;

  push @{$self->on_eval}, @code;

  return $self;
}

sub eval {
  my ($self, $data) = @_;

  my $result = false;

  if (!($result = $self->check->eval($data))) {
    return $result;
  }

  for my $callback (@{$self->on_eval}) {
    local $_ = $data;
    $result = $self->$callback($data) ? true : false;
    last if !$result;
  }

  return $result;
}

sub evaler {
  my ($self) = @_;

  return $self->defer('eval');
}

sub result {
  my ($self, $data) = @_;

  return $self->eval($data);
}

1;
