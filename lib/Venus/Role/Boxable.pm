package Venus::Role::Boxable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub box {
  my ($self, $method, @args) = @_;

  require Venus::Box;

  my $value = $method ? $self->$method(@args) : $self;

  return Venus::Box->new(value => $value);
}

1;
