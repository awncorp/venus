package Venus::Role::Doable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub do {
  my ($self, $code, @args) = @_;

  $code ||= sub{};

  local $_ = $self;
  $self->$code(@args);

  return $self;
}

1;
