package Venus::Kind::Value;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind';

with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';
with 'Venus::Role::Pluggable';
with 'Venus::Role::Valuable';

# METHODS

sub defined {
  my ($self) = @_;

  return int(CORE::defined($self->get));
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

1;
