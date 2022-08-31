package Venus::Role::Reflectable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub class {
  my ($self) = @_;

  return ref($self) || $self;
}

sub meta {
  my ($self) = @_;

  require Venus::Meta;

  return Venus::Meta->new(name => $self->class);
}

sub reify {
  my ($self, $method, @args) = @_;

  return $self->type($method, @args)->deduce;
}

sub space {
  my ($self) = @_;

  require Venus::Space;

  return Venus::Space->new($self->class);
}

sub type {
  my ($self, $method, @args) = @_;

  require Venus::Type;

  my $value = $method
    ? $self->$method(@args) : $self->can('value') ? $self->value : $self;

  return Venus::Type->new(value => $value);
}

# EXPORTS

sub EXPORT {
  ['class', 'meta', 'reify', 'space', 'type']
}

1;
