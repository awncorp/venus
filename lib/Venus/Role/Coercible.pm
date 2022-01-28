package Venus::Role::Coercible;

use 5.018;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Buildable';

# BUILDERS

sub build_args {
  my ($self, $data) = @_;

  return $self->coercion($data);
}

# METHODS

sub coerce {
  my ($self) = @_;

  return ();
}

sub coercion {
  my ($self, $data) = @_;

  my @args = $self->coerce;

  return $data if !@args;

  my $rules = (@args > 1) ? {@args} : (ref($args[0]) eq 'HASH') ? $args[0] : {};

  return $data if !%$rules;

  require Scalar::Util;
  require Venus::Space;

  my $routine = sub {
    my ($self, $class, $value) = @_;

    if (Scalar::Util::blessed($value) && $value->isa($class)) {
      return $value;
    }
    else {
      return $class->new($value);
    }
  };

  my $space = "Venus::Space";

  for my $name (grep exists($data->{$_}), sort keys %$rules) {
    if (my $method = $self->can("coerce_${name}")) {
      $data->{$name} = $self->$method(
        $routine, $space->new($rules->{$name})->load, $data->{$name}
      );
    }
    else {
      $data->{$name} = $self->$routine(
        $space->new($rules->{$name})->load, $data->{$name}
      );
    }
  }

  return $data;
}

1;
