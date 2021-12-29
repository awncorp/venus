package Venus::Role::Valuable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

# ATTRIBUTES

has value => (
  is => 'rw',
  default => sub {$_[0]->default},
);

# METHODS

sub default {
  return;
}

1;
