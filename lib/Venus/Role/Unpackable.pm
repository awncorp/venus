package Venus::Role::Unpackable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub unpack {
  my ($self, @args) = @_;

  require Venus::Unpack;

  return Venus::Unpack->from($self)->do('args', @args)->all;
}

# EXPORTS

sub EXPORT {
  ['unpack']
}

1;
