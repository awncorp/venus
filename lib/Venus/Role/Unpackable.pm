package Venus::Role::Unpackable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub unpack {
  my ($self, @args) = @_;

  require Venus::Unpack;

  my $name = (caller(1))[3] =~ s/.*::(\w+)$/$1/gr;

  return Venus::Unpack->from($self)->name($name)->do('args', @args)->all;
}

# EXPORTS

sub EXPORT {
  ['unpack']
}

1;
