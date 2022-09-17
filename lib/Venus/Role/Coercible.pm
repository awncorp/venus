package Venus::Role::Coercible;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  $data = $self->coercion($data);

  for my $name (keys %$data) {
    $self->{$name} = $data->{$name};
  }

  return $self;
};

# METHODS

sub coerce {
  my ($self) = @_;

  return {}; # deprecate coerce soon!
}

sub coercers {
  my ($self) = @_;

  return $self->can('coerce') ? $self->coerce : {};
}

sub coerce_args {
  my ($self, $data, $spec) = @_;

  for my $name (grep exists($data->{$_}), sort keys %$spec) {
    $data->{$name} = $self->coerce_onto(
      $data, $name, $spec->{$name}, $data->{$name},
    );
  }

  return $data;
}

sub coerce_attr {
  my ($self, $name, @args) = @_;

  return $self->{$name} if !@args;

  return $self->{$name} = $self->coercion({$name, $args[0]})->{$name};
}

sub coerce_into {
  my ($self, $class, $value) = @_;

  require Scalar::Util;
  require Venus::Space;

  $class = (my $space = Venus::Space->new($class))->load;

  my $name = lc $space->label;

  if (my $method = $self->can("coerce_into_${name}")) {
    return $self->$method($class, $value);
  }
  if (Scalar::Util::blessed($value) && $value->isa($class)) {
    return $value;
  }
  else {
    return $class->new($value);
  }
}

sub coerce_onto {
  my ($self, $data, $name, $class, $value) = @_;

  require Venus::Space;

  $class = Venus::Space->new($class)->load;

  $value = $data->{$name} if $#_ < 4;

  if (my $method = $self->can("coerce_${name}")) {
    return $data->{$name} = $self->$method(\&coerce_into, $class, $value);
  }
  else {
    return $data->{$name} = $self->coerce_into($class, $value);
  }
}

sub coercion {
  my ($self, $data) = @_;

  my $spec = $self->coercers;

  return $data if !%$spec;

  return $self->coerce_args($data, $spec);
}

# EXPORTS

sub EXPORT {
  [
    'coerce_args',
    'coerce_attr',
    'coerce_into',
    'coerce_onto',
    'coercers',
    'coercion',
  ]
}

1;
