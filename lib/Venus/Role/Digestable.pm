package Venus::Role::Digestable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Dumpable';

# METHODS

sub digester {
  my ($self, $algorithm, $method, @args) = @_;

  my $result = $self->dump($method, @args);

  require Digest;

  my $digest = Digest->new(uc($algorithm || 'sha-1'));

  return $digest->add($result);
}

sub digest {
  my ($self, $algorithm, $method, @args) = @_;

  return $self->hexdigest($algorithm, $method, @args);
}

sub b64digest {
  my ($self, $algorithm, $method, @args) = @_;

  return $self->digester($algorithm, $method, @args)->b64digest;
}

sub bindigest {
  my ($self, $algorithm, $method, @args) = @_;

  return $self->digester($algorithm, $method, @args)->digest;
}

sub hexdigest {
  my ($self, $algorithm, $method, @args) = @_;

  return $self->digester($algorithm, $method, @args)->hexdigest;
}

1;
