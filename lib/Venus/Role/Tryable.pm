package Venus::Role::Tryable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub try {
  my ($self, $callback, @args) = @_;

  require Venus::Try;

  my $try = Venus::Try->new(invocant => $self, arguments => [@args]);

  return $try if !$callback;

  return $try->call($callback);
}

1;
