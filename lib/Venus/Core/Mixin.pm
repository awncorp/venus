package Venus::Core::Mixin;

use 5.018;

use strict;
use warnings;

use base 'Venus::Core';

# METHODS

sub BUILD {
  my ($self) = @_;

  return $self;
}

sub DESTROY {
  my ($self) = @_;

  return;
}

sub EXPORT {
  my ($self, $into) = @_;

  return [];
}

sub IMPORT {
  my ($self, $into) = @_;

  no strict 'refs';
  no warnings 'redefine';

  for my $name (@{$self->EXPORT($into)}) {
    *{"${into}::${name}"} = \&{"@{[$self->NAME]}::${name}"};
  }

  return $self;
}

sub does {
  my ($self, @args) = @_;

  return $self->DOES(@args);
}

sub meta {
  my ($self) = @_;

  return $self->META;
}

1;
