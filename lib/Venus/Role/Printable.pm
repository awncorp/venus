package Venus::Role::Printable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Dumpable')) {
    die "${self} requires ${from} to consume Venus::Role::Dumpable";
  }

  return $self;
}

# METHODS

sub print {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args));
}

sub print_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args));
}

sub print_string {
  my ($self, $method, @args) = @_;

  local $_ = $self;

  return $self->printer($method ? scalar($self->$method(@args)) : $self);
}

sub printer {
  my ($self, @args) = @_;

  return CORE::print(STDOUT @args);
}

sub say {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args), "\n");
}

sub say_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args), "\n");
}

sub say_string {
  my ($self, $method, @args) = @_;

  local $_ = $self;

  return $self->printer(($method ? scalar($self->$method(@args)) : $self), "\n");
}

# EXPORTS

sub EXPORT {
  [
    'print',
    'print_pretty',
    'print_string',
    'printer',
    'say',
    'say_pretty',
    'say_string',
  ]
}

1;
