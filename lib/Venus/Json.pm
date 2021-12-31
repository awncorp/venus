package Venus::Json;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

# ATTRIBUTES

has engine => (
  is => 'rw',
  default => sub {$_[0]->config->utf8},
);

# METHODS

sub config {
  my ($self) = @_;

  my $engine = $self->package;

  $engine = $engine->new
    ->canonical
    ->allow_nonref
    ->allow_unknown
    ->allow_blessed
    ->convert_blessed;

  if ($engine->can('escape_slash')) {
    $engine = $engine->escape_slash;
  }

  require Scalar::Util;
  require Venus::Boolean;

  $engine->boolean_values(
    Venus::Boolean::FALSE(),
    Venus::Boolean::TRUE(),
  );

  return $self->engine($engine);
}

sub decode {
  my ($self, $data) = @_;

  return $self->set($self->engine->decode($data));
}

sub encode {
  my ($self) = @_;

  my $engine = $self->engine;
  my $convert = $engine->get_boolean_values
    && !grep ref, $engine->get_boolean_values;

  # double-traversing the data structure due to lack of serialization hooks
  return $self->engine->encode($convert ? TO_BOOL($self->get) : $self->get);
}

sub explain {
  my ($self) = @_;

  return $self->encode;
}

sub package {
  my ($self) = @_;

  state $engine;

  return $engine if defined $engine;

  my %packages = (
    'JSON::XS' => '3.0',
    'JSON::PP' => '4.00',
  );
  for my $package (qw(JSON::XS JSON::PP)) {
    my $criteria = "require $package; $package->VERSION($packages{$package})";
    if (do {local $@; eval "$criteria"; $@}) {
      next;
    }
    else {
      $engine = $package;
      last;
    }
  }

  return $engine;
}

sub TO_BOOL {
  my ($value) = @_;

  require Venus::Boolean;

  if (ref($value) eq 'HASH') {
    for my $key (keys %$value) {
      $value->{$key} = TO_BOOL($value->{$key});
    }
    return $value;
  }

  if (ref($value) eq 'ARRAY') {
    for my $key (keys @$value) {
      $value->[$key] = TO_BOOL($value->[$key]);
    }
    return $value;
  }

  return Venus::Boolean::TO_BOOL_REF($value);
}

1;
