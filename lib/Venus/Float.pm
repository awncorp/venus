package Venus::Float;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Number';

# METHODS

sub default {
  return '0.0';
}

1;
