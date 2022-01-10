package Venus::Role::Accessible;

use 5.018;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Buildable';
with 'Venus::Role::Valuable';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
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

1;
