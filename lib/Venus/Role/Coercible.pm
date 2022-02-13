package Venus::Role::Coercible;

use 5.018;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Buildable';

# MODIFIERS

around BUILDARGS => sub {
  my ($orig, $class, @args) = @_;

  return $class->coercion($class->$orig(@args));
};

# METHODS

sub coerce {
  my ($self) = @_;

  return ();
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

sub coerce_into {
  my ($self, $class, $value) = @_;

  require Scalar::Util;
  require Venus::Space;

  $class = Venus::Space->new($class)->load;

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

  my @args = $self->coerce;

  return $data if !@args;

  my $spec = (@args > 1) ? {@args} : (ref($args[0]) eq 'HASH') ? $args[0] : {};

  return $data if !%$spec;

  return $self->coerce_args($data, $spec);
}

1;
