package Venus::Vars;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Proxyable';

# ATTRIBUTES

attr 'named';

# BUILDERS

sub build_proxy {
  my ($self, $package, $method, $value) = @_;

  my $has_value = exists $_[3];

  return sub {
    return $self->get($method) if !$has_value; # no value
    return $self->set($method, $value);
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->named({}) if !$self->named;

  return $self;
}

# METHODS

sub default {
  my ($self) = @_;

  return {%ENV};
}

sub exists {
  my ($self, $name) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return exists $self->value->{$pos};
}

sub get {
  my ($self, $name) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return $self->value->{$pos};
}

sub name {
  my ($self, $name) = @_;

  if (defined $self->named->{$name}) {
    return $self->named->{$name};
  }

  if (defined $self->value->{$name}) {
    return $name;
  }

  if (defined $self->value->{uc($name)}) {
    return uc($name);
  }

  return undef;
}

sub set {
  my ($self, $name, $data) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return $self->value->{$pos} = $data;
}

sub unnamed {
  my ($self) = @_;

  my $list = {};

  my $vars = $self->value;
  my $data = +{reverse %{$self->named}};

  for my $index (sort keys %$vars) {
    unless (exists $data->{$index}) {
      $list->{$index} = $vars->{$index};
    }
  }

  return $list;
}

1;
