package Venus::Float;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Number';

# METHODS

sub default {
  return '0.0';
}

1;
