package Venus::Role::Defaultable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self) = @_;

  return $self if !$self->can('defaults');

  my $defaults = $self->defaults;

  return $self if !$defaults;

  for my $name ($self->META->attrs) {
    if (exists $defaults->{$name} && !exists $self->{$name}) {
      $self->{$name} = $defaults->{$name};
    }
  }

  return $self;
}

1;
