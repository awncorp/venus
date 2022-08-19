package Venus::Role::Doable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub do {
  my ($self, $code, @args) = @_;

  $code ||= sub{};

  local $_ = $self;
  $self->$code(@args);

  return $self;
}

# EXPORTS

sub EXPORT {
  ['do']
}

1;
