package Venus::Role::Tryable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub try {
  my ($self, $callback, @args) = @_;

  require Venus::Try;

  my $try = Venus::Try->new(invocant => $self, arguments => [@args]);

  return $try if !$callback;

  return $try->call($callback);
}

# EXPORTS

sub EXPORT {
  ['try']
}

1;
