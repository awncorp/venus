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
  $engine->boolean_values(
    Scalar::Util::dualvar(0, "0"),
    Scalar::Util::dualvar(1, "1")
  );

  return $self->engine($engine);
}

sub decode {
  my ($self, $data) = @_;

  return $self->set($self->engine->decode($data));
}

sub encode {
  my ($self) = @_;

  return $self->engine->encode($self->get);
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
    'JSON::PP' => '0',
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

1;
