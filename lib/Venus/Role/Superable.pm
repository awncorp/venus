package Venus::Role::Superable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub super {
  require mro;
  goto \&next::method
}

# EXPORTS

sub EXPORT {
  ['super']
}

1;
