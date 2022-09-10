package Venus::Role::Rejectable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self) = @_;

  my %attrs = map +($_, $_), $self->META->attrs;
  my @unknowns = sort grep !exists($attrs{$_}), keys %$self;
  delete $self->{$_} for @unknowns;

  return $self;
}

1;
