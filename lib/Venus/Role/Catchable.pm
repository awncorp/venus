package Venus::Role::Catchable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Tryable')) {
    fault "${self} requires ${from} to consume Venus::Role::Tryable";
  }

  return $self;
}

# METHODS

sub catch {
  my ($self, $method, @args) = @_;

  my @result = $self->try($method, @args)->error(\my $error)->result;

  return wantarray ? ($error ? ($error, undef) : ($error, @result)) : $error;
}

sub maybe {
  my ($self, $method, @args) = @_;

  my @result = $self->try($method, @args)->error(\my $error)->result;

  return wantarray ? ($error ? (undef) : (@result)) : ($error ? undef : $result[0]);
}

# EXPORTS

sub EXPORT {
  ['catch', 'maybe']
}

1;
