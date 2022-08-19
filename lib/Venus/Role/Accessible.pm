package Venus::Role::Accessible;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Valuable')) {
    die "${self} requires ${from} to consume Venus::Role::Valuable";
  }

  return $self;
}

# METHODS

sub get {
  my ($self) = @_;

  return $self->value;
}

sub set {
  my ($self, $value) = @_;

  return $self->value($value);
}

# EXPORTS

sub EXPORT {
  ['get', 'set']
}

1;
