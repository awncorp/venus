package Venus::Role::Explainable;

use 5.018;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  '~~' => 'explain',
);

use Moo::Role;

# REQUIRES

requires 'explain';

1;
