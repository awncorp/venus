package Venus::Role::Makeable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  $data = $self->making($data);

  for my $name (keys %$data) {
    $self->{$name} = $data->{$name};
  }

  return $self;
};

# METHODS

sub makers {
  my ($self) = @_;

  return {};
}

sub make_args {
  my ($self, $data, $spec) = @_;

  for my $name (grep exists($data->{$_}), sort keys %$spec) {
    $data->{$name} = $self->make_onto(
      $data, $name, $spec->{$name}, $data->{$name},
    );
  }

  return $data;
}

sub make_attr {
  my ($self, $name, @args) = @_;

  return $self->{$name} if !@args;

  return $self->{$name} = $self->making({$name, $args[0]})->{$name};
}

sub make_into {
  my ($self, $class, $value) = @_;

  require Scalar::Util;
  require Venus::Space;

  $class = (my $space = Venus::Space->new($class))->load;

  my $name = lc $space->label;

  if (my $method = $self->can("make_into_${name}")) {
    return $self->$method($class, $value);
  }
  if (Scalar::Util::blessed($value) && $value->isa($class)) {
    return $value;
  }
  else {
    return $class->make($value);
  }
}

sub make_onto {
  my ($self, $data, $name, $class, $value) = @_;

  require Venus::Space;

  $class = Venus::Space->new($class)->load;

  $value = $data->{$name} if $#_ < 4;

  if (my $method = $self->can("make_${name}")) {
    return $data->{$name} = $self->$method(\&make_into, $class, $value);
  }
  else {
    return $data->{$name} = $self->make_into($class, $value);
  }
}

sub making {
  my ($self, $data) = @_;

  my $spec = $self->makers;

  return $data if !%$spec;

  return $self->make_args($data, $spec);
}

# EXPORTS

sub EXPORT {
  [
    'make_args',
    'make_attr',
    'make_into',
    'make_onto',
    'makers',
    'making',
  ]
}

1;
