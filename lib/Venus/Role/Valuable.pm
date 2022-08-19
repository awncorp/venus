package Venus::Role::Valuable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'attr';

# ATTRIBUTES

attr 'value';

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  $self->value($self->default) if !exists $data->{value};
}

# METHODS

sub default {
  return;
}

# EXPORTS

sub EXPORT {
  ['value', 'default']
}

1;
