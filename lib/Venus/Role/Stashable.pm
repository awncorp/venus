package Venus::Role::Stashable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  $self->{'$stash'} = delete $data->{'$stash'} || {} if !$self->{'$stash'};

  return $self;
};

# METHODS

sub stash {
  my ($self, $key, $value) = @_;

  return $self->{'$stash'} if !exists $_[1];

  return $self->{'$stash'}->{$key} if !exists $_[2];

  $self->{'$stash'}->{$key} = $value;

  return $value;
}

# EXPORTS

sub EXPORT {
  ['stash']
}

1;
