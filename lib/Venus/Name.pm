package Venus::Name;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

use overload (
  '""' => 'explain',
  '.' => sub{$_[0]->value . "$_[1]"},
  'eq' => sub{$_[0]->value eq "$_[1]"},
  'ne' => sub{$_[0]->value ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0]->value)]}/},
  '~~' => 'explain',
  fallback => 1,
);

my $sep = qr/'|__|::|\\|\//;

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
}

# METHODS

sub default {
  return 'Venus';
}

sub dist {
  my ($self) = @_;

  return $self->label =~ s/_/-/gr;
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub file {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_file;

  my $string = $self->package;

  return join '__', map {
    join '_', map {lc} map {split /_/} grep {length}
    split /([A-Z]{1}[^A-Z]*)/
  } split /$sep/, $string;
}

sub format {
  my ($self, $method, $format) = @_;

  my $string = $self->$method;

  return sprintf($format || '%s', $string);
}

sub label {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_label;

  return join '_', split /$sep/, $self->package;
}

sub lookslike_a_file {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[a-z](?:\w*[a-z])?$/;
}

sub lookslike_a_label {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[A-Z](?:\w*[a-zA-Z0-9])?$/;
}

sub lookslike_a_package {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[A-Z](?:(?:\w|::)*[a-zA-Z0-9])?$/;
}

sub lookslike_a_path {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^[A-Z](?:(?:\w|\\|\/|[\:\.]{1}[a-zA-Z0-9])*[a-zA-Z0-9])?$/;
}

sub lookslike_a_pragma {
  my ($self) = @_;

  my $string = $self->get;

  return $string =~ /^\[\w+\]$/;
}

sub package {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_package;

  return substr($self->get, 1, -1) if $self->lookslike_a_pragma;

  my $string = $self->get;

  if ($string !~ $sep) {
    return join '', map {ucfirst} split /[^a-zA-Z0-9]/, $string;
  } else {
    return join '::', map {
      join '', map {ucfirst} split /[^a-zA-Z0-9]/
    } split /$sep/, $string;
  }
}

sub path {
  my ($self) = @_;

  return $self->get if $self->lookslike_a_path;

  return join '/', split /$sep/, $self->package;
}

1;
