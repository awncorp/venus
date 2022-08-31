package Venus::Role::Assertable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDIT

sub AUDIT {
  my ($self, $from) = @_;

  my $name = ref $self || $self;

  if (!$from->can('assertion')) {
    die "${from} requires 'assertion' to consume ${name}";
  }

  return $self;
}

# METHODS

sub assert {
  my ($self, $data) = @_;

  return $self->assertion->validate($data);
}

sub check {
  my ($self, $data) = @_;

  return $self->assertion->check($data);
}

sub coerce {
  my ($self, $data) = @_;

  return $self->assertion->coerce($data);
}

sub make {
  my ($self, $data) = @_;

  return UNIVERSAL::isa($data, ref $self || $self)
    ? $data
    : $self->new($self->assert($self->coerce($data)));
}

# EXPORTS

sub EXPORT {
  ['assert', 'check', 'coerce', 'make']
}

1;
