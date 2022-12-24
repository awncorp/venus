package Venus::Role::Serializable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub serialize {
  my ($self) = @_;

  if ( Scalar::Util::blessed($self)
    && $self->isa('Venus::Core')
    && $self->can('DOES')
    && $self->DOES('Venus::Role::Valuable'))
  {
    return deconstruct($self, $self->value);
  }

  if (UNIVERSAL::isa($self, 'ARRAY')) {
    return deconstruct($self, [@{$self}]);
  }

  if (UNIVERSAL::isa($self, 'CODE')) {
    return sub{goto \&$self};
  }

  if (UNIVERSAL::isa($self, 'HASH')) {
    return deconstruct($self, {%{$self}});
  }

  if (UNIVERSAL::isa($self, 'REF')) {
    return deconstruct($self, ${$self});
  }

  if (UNIVERSAL::isa($self, 'REGEXP')) {
    return qr/$self/;
  }

  if (UNIVERSAL::isa($self, 'SCALAR')) {
    return deconstruct($self, ${$self});
  }

  require Venus::Throw;
  my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
  $throw->name('on.serialize');
  $throw->message("Can't serialize the object: $self");
  $throw->stash(self => $self);
  $throw->error;
}

sub deconstruct {
  my ($self, $value) = @_;

  require Scalar::Util;

  if ( Scalar::Util::blessed($value)
    && $value->isa('Venus::Core')
    && $value->can('DOES')
    && $value->DOES('Venus::Role::Serializable'))
  {
    return $value->serialize;
  }

  if (UNIVERSAL::isa($value, 'CODE')) {
    return sub{goto \&$value};
  }

  if (UNIVERSAL::isa($value, 'REF')) {
    return deconstruct($self, ${$value});
  }

  if (UNIVERSAL::isa($value, 'REGEXP')) {
    return qr/$value/;
  }

  if (UNIVERSAL::isa($value, 'SCALAR')) {
    return deconstruct($self, ${$value});
  }

  if (UNIVERSAL::isa($value, 'HASH')) {
    my $result = {};
    for my $key (keys %{$value}) {
      $result->{$key} = deconstruct($self, $value->{$key});
    }
    return $result;
  }

  if (UNIVERSAL::isa($value, 'ARRAY')) {
    my $result = [];
    for my $key (keys @{$value}) {
      $result->[$key] = deconstruct($self, $value->[$key]);
    }
    return $result;
  }

  if (Scalar::Util::blessed($value)) {
    require Venus::Throw;
    my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
    $throw->name('on.serialize.deconstruct');
    $throw->message("Can't serialize properties in the object: $self");
    $throw->stash(self => $self);
    $throw->error;
  }

  return $value;
}

# EXPORTS

sub EXPORT {
  ['serialize']
}

1;
