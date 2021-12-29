package Venus::Role::Stashable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

# BUILDERS

sub BUILD {

  return $_[0];
}

# MODIFIERS

around BUILD => sub {
  my ($orig, $self, $args) = @_;

  $self->$orig($args);

  $self->{'$stash'} = delete $args->{'$stash'} || {} if !$self->{'$stash'};

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

1;
