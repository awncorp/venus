package Venus::Role::Boxable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub box {
  my ($self, $method, @args) = @_;

  require Venus::Box;

  local $_ = $self;

  my $value = $method ? $self->$method(@args) : $self;

  return Venus::Box->new(value => $value);
}

# EXPORTS

sub EXPORT {
  ['box']
}

1;
