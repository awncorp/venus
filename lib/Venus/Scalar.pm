package Venus::Scalar;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Kind::Value';

use overload (
  '${}' => sub{$_[0]->value},
  '*{}' => sub{$_[0]->value},
  fallback => 1,
);

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->constraints->clear;

  $assert->constraint('scalar', true);

  return $assert;
}

sub default {
  return \'';
}

1;
