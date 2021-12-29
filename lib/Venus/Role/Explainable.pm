package Venus::Role::Explainable;

use 5.014;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  '~~' => 'explain',
);

use Moo::Role;

requires 'explain';

1;
