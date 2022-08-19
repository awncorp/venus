package Venus::Role::Testable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub is_false {
  my ($self, $code, @args) = @_;

  $code ||= $self->can('value') ? 'value' : sub{};

  require Venus::Boolean;

  return $self->$code(@args) ? Venus::Boolean::FALSE() : Venus::Boolean::TRUE();
}

sub isfalse {
  my ($self, @args) = @_;

  return $self->is_false(@args);
}

sub is_true {
  my ($self, $code, @args) = @_;

  $code ||= $self->can('value') ? 'value' : sub{};

  require Venus::Boolean;

  return $self->$code(@args) ? Venus::Boolean::TRUE() : Venus::Boolean::FALSE();
}

sub istrue {
  my ($self, @args) = @_;

  return $self->is_true(@args);
}

# EXPORTS

sub EXPORT {
  ['is_false', 'is_true', 'isfalse', 'istrue']
}

1;
