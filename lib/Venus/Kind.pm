package Venus::Kind;

use 5.014;

use strict;
use warnings;

use Moo;

with 'Venus::Role::Boxable';
with 'Venus::Role::Catchable';
with 'Venus::Role::Doable';
with 'Venus::Role::Dumpable';
with 'Venus::Role::Printable';
with 'Venus::Role::Throwable';

# METHODS

sub class {
  my ($self) = @_;

  return ref($self) || $self;
}

sub space {
  my ($self) = @_;

  require Venus::Space;

  return Venus::Space->new($self->class);
}

sub type {
  my ($self, $method, @args) = @_;

  require Venus::Type;

  my $value = $method ? $self->$method(@args) : $self;

  return Venus::Type->new(value => $value);
}

1;
