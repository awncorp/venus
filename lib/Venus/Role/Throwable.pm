package Venus::Role::Throwable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub throw {
  my ($self, $name) = @_;

  my $context = (caller(1))[3];
  my $package = $name || join('::', map ucfirst, ref($self), 'error');

  require Venus::Throw;

  return Venus::Throw->new(package => $package, context => $context);
}

1;
