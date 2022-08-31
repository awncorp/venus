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
    return true;
  }
  if (Scalar::Util::blessed($data) && !$data->isa('Venus::Kind')) {
    return false;
  }
  if ($self->comparer('eq') eq 'numified') {
    return $self->numified == $data->numified ? true : false;
  }
  elsif ($self->comparer('eq') eq 'stringified') {
    return $self->stringified eq $data->stringified ? true : false;
  }
  elsif (my $method = $self->comparer('eq')) {
    return $self->$method eq $data->$method ? true : false;
  }
  else {
    return false;
  }
}

sub ge {
  my ($self, $data) = @_;

  if ($self->gt($data) || $self->eq($data)) {
    return true;
  }
  else {
    return false;
  }
}

sub gele {
  my ($self, $ge, $le) = @_;

  if ($self->ge($ge) && $self->le($le)) {
    return true;
  }
  else {
    return false;
  }
}

sub gt {
  my ($self, $data) = @_;

  $data = Venus::Type->new(value => $data)->deduce;

  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return false;
  }
  if (Scalar::Util::blessed($data) && !$data->isa('Venus::Kind')) {
    return false;
  }
  if ($self->comparer('gt') eq 'numified') {
    return $self->numified > $data->numified ? true : false;
  }
  elsif ($self->comparer('gt') eq 'stringified') {
    return $self->stringified gt $data->stringified ? true : false;
  }
  elsif (my $method = $self->comparer('gt')) {
    return $self->$method gt $data->$method ? true : false;
  }
  else {
    return false;
  }
}

sub gtlt {
  my ($self, $gt, $lt) = @_;

  if ($self->gt($gt) && $self->lt($lt)) {
    return true;
  }
  else {
    return false;
  }
}

sub lt {
  my ($self, $data) = @_;

  $data = Venus::Type->new(value => $data)->deduce;

  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return false;
  }
  if (Scalar::Util::blessed($data) && !$data->isa('Venus::Kind')) {
    return false;
  }
  if ($self->comparer('lt') eq 'numified') {
    return $self->numified < $data->numified ? true : false;
  }
  elsif ($self->comparer('lt') eq 'stringified') {
    return $self->stringified lt $data->stringified ? true : false;
  }
  elsif (my $method = $self->comparer('lt')) {
    return $self->$method lt $data->$method ? true : false;
  }
  else {
    return false;
  }
}

sub le {
  my ($self, $data) = @_;

  if ($self->lt($data) || $self->eq($data)) {
    return true;
  }
  else {
    return false;
  }
}

sub ne {
  my ($self, $data) = @_;

  return $self->eq($data) ? false : true;
}

sub tv {
  my ($self, $data) = @_;

  if (!Scalar::Util::blessed($data)) {
    return false;
  }
  if (Scalar::Util::refaddr($self) eq Scalar::Util::refaddr($data)) {
    return true;
  }
  if ($data->isa($self->class)) {
    return $self->eq($data);
  }
  else {
    return false;
  }
}

# EXPORTS

sub EXPORT {
  ['eq', 'ge', 'gele', 'gt', 'gtlt', 'lt', 'le', 'ne', 'tv']
}

1;
