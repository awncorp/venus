package Venus::Role::Testable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub isfalse {
  my ($self, $code, @args) = @_;

  $code ||= $self->can('value') ? 'value' : sub{};

  require Venus::Boolean;

  return $self->$code(@args) ? Venus::Boolean::FALSE() : Venus::Boolean::TRUE();
}

sub istrue {
  my ($self, $code, @args) = @_;

  $code ||= $self->can('value') ? 'value' : sub{};

  require Venus::Boolean;

  return $self->$code(@args) ? Venus::Boolean::TRUE() : Venus::Boolean::FALSE();
}

1;
