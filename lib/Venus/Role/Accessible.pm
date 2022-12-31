package Venus::Role::Accessible;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->isa('Venus::Core')) {
    fault "${self} requires ${from} to derive from Venus::Core";
  }

  return $self;
}

# METHODS

sub access {
  my ($self, $name, @args) = @_;

  return if !$name;

  return $self->$name(@args);
}

sub assign {
  my ($self, $name, $code, @args) = @_;

  return if !$name;
  return if !$code;

  return $self->access($name, $self->$code(@args));
}

# EXPORTS

sub EXPORT {
  ['access', 'assign']
}

1;
