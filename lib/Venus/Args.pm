package Venus::Args;

use 5.018;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

with 'Venus::Role::Accessible';
with 'Venus::Role::Proxyable';

# ATTRIBUTES

has named => (
  is => 'rw',
  default => sub {{}},
);

# BUILDERS

sub build_proxy {
  my ($self, $package, $method, $value) = @_;

  my $has_value = exists $_[3];

  return sub {
    return $self->get($method) if !$has_value; # no value
    return $self->set($method, $value);
  };
}

# METHODS

sub default {
  my ($self) = @_;

  return [@ARGV];
}

sub exists {
  my ($self, $name) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return CORE::exists $self->indexed->{$pos};
}

sub get {
  my ($self, $name) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return $self->indexed->{$pos};
}

sub indexed {
  my ($self) = @_;

  return {map +($_, $self->value->[$_]), 0..$#{$self->value}};
}

sub name {
  my ($self, $name) = @_;

  if (defined $self->named->{$name}) {
    return $self->named->{$name};
  }

  if (defined $self->indexed->{$name}) {
    return $name;
  }

  return undef;
}

sub set {
  my ($self, $name, $data) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return $self->value->[$pos] = $data;
}

sub unnamed {
  my ($self) = @_;

  my $list = [];

  my $argv = $self->indexed;
  my $data = +{reverse %{$self->named}};

  for my $index (sort keys %$argv) {
    unless (exists $data->{$index}) {
      push @$list, $argv->{$index};
    }
  }

  return $list;
}

1;
