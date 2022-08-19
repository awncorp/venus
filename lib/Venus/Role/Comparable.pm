package Venus::Role::Comparable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

require Scalar::Util;
require Venus::Type;

# METHODS

sub eq {
  my ($self, $data) = @_;

  $data = Venus::Type->new(value => $data)->deduce;

  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return 1;
  }
  if (Scalar::Util::blessed($data) && !$data->isa('Venus::Kind')) {
    return 0;
  }
  if ($self->comparer('eq') eq 'numified') {
    return $self->numified == $data->numified ? 1 : 0;
  }
  elsif ($self->comparer('eq') eq 'stringified') {
    return $self->stringified eq $data->stringified ? 1 : 0;
  }
  elsif (my $method = $self->comparer('eq')) {
    return $self->$method eq $data->$method ? 1 : 0;
  }
  else {
    return 0;
  }
}

sub ge {
  my ($self, $data) = @_;

  if ($self->gt($data) || $self->eq($data)) {
    return 1;
  }
  else {
    return 0;
  }
}

sub gele {
  my ($self, $ge, $le) = @_;

  if ($self->ge($ge) && $self->le($le)) {
    return 1;
  }
  else {
    return 0;
  }
}

sub gt {
  my ($self, $data) = @_;

  $data = Venus::Type->new(value => $data)->deduce;

  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return 0;
  }
  if (Scalar::Util::blessed($data) && !$data->isa('Venus::Kind')) {
    return 0;
  }
  if ($self->comparer('gt') eq 'numified') {
    return $self->numified > $data->numified ? 1 : 0;
  }
  elsif ($self->comparer('gt') eq 'stringified') {
    return $self->stringified gt $data->stringified ? 1 : 0;
  }
  elsif (my $method = $self->comparer('gt')) {
    return $self->$method gt $data->$method ? 1 : 0;
  }
  else {
    return 0;
  }
}

sub gtlt {
  my ($self, $gt, $lt) = @_;

  if ($self->gt($gt) && $self->lt($lt)) {
    return 1;
  }
  else {
    return 0;
  }
}

sub lt {
  my ($self, $data) = @_;

  $data = Venus::Type->new(value => $data)->deduce;

  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return 0;
  }
  if (Scalar::Util::blessed($data) && !$data->isa('Venus::Kind')) {
    return 0;
  }
  if ($self->comparer('lt') eq 'numified') {
    return $self->numified < $data->numified ? 1 : 0;
  }
  elsif ($self->comparer('lt') eq 'stringified') {
    return $self->stringified lt $data->stringified ? 1 : 0;
  }
  elsif (my $method = $self->comparer('lt')) {
    return $self->$method lt $data->$method ? 1 : 0;
  }
  else {
    return 0;
  }
}

sub le {
  my ($self, $data) = @_;

  if ($self->lt($data) || $self->eq($data)) {
    return 1;
  }
  else {
    return 0;
  }
}

sub ne {
  my ($self, $data) = @_;

  return $self->eq($data) ? 0 : 1;
}

sub tv {
  my ($self, $data) = @_;

  if (!Scalar::Util::blessed($data)) {
    return 0;
  }
  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return 1;
  }
  if ($data->isa($self->class)) {
    return $self->eq($data);
  }
  else {
    return 0;
  }
}

# EXPORTS

sub EXPORT {
  ['eq', 'ge', 'gele', 'gt', 'gtlt', 'lt', 'le', 'ne', 'tv']
}

1;
