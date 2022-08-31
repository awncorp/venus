package Venus::Role::Valuable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'attr';

# ATTRIBUTES

attr 'value';

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  $self->value($self->default) if !exists $data->{value};
}

# METHODS

sub default {

  return;
}

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
  ['default', 'get', 'set', 'value']
}

1;
