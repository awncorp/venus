package Venus::Undef;

use 5.018;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

no overloading;

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->{value} = undef;

  return $self;
}

# METHODS

sub default {
  return undef;
}

1;
