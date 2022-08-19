package Venus::Role::Matchable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub match {
  my ($self, $method, @args) = @_;

  require Venus::Match;

  my $match = Venus::Match->new($method ? scalar($self->$method(@args)) : $self);

  return $match;
}

# EXPORTS

sub EXPORT {
  ['match']
}

1;
