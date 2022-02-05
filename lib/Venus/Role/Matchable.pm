package Venus::Role::Matchable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub match {
  my ($self, $method, @args) = @_;

  require Venus::Match;

  my $match = Venus::Match->new($method ? scalar($self->$method(@args)) : $self);

  return $match;
}

1;
