package Venus::Role::Printable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Dumpable';

# METHODS

sub print {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args));
}

sub print_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args));
}

sub printer {
  my ($self, @args) = @_;

  return CORE::print(STDOUT @args);
}

sub say {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args), "\n");
}

sub say_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args), "\n");
}

1;
