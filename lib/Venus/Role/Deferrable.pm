package Venus::Role::Deferrable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# METHODS

sub defer {
  my ($self, $name, @args) = @_;

  return sub {} if !$name;

  my $code = $self->can($name)
    or fault "Unable to defer $name: can't find $name in @{[ref $self]}";

  return sub { local @_ = ($self, @args, @_); goto $code; };
}

# EXPORTS

sub EXPORT {
  ['defer']
}

1;
