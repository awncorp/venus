package Venus::Scalar;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

use overload (
  '${}' => sub{$_[0]->value},
  '*{}' => sub{$_[0]->value},
);

# METHODS

sub default {
  return \'';
}

1;
