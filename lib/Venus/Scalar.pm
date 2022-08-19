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

sub default {
  return \'';
}

1;
