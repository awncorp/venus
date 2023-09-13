package Venus::Role::Patchable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub patch {
  my ($self, $name, $code) = @_;

  require Venus::Space;

  my $space = Venus::Space->new(ref $self || $self);

  return $space->patch($name, $code);
}

# EXPORTS

sub EXPORT {
  ['patch']
}

1;
