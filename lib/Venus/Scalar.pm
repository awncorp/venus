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

  my $assertion = $self->SUPER::assertion;

  $assertion->match('scalarref')->format(sub{
    (ref $self || $self)->new($_)
  });

  return $assertion;
}

sub default {
  return \'';
}

1;
