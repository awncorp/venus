package Venus::Core::Class;

use 5.018;

use strict;
use warnings;

no warnings 'once';

use base 'Venus::Core';

# METHODS

sub BUILD {
  my ($self, @data) = @_;

  no strict 'refs';

  my @roles = @{$self->META->roles};

  for my $action (grep defined, map *{"${_}::BUILD"}{"CODE"}, @roles) {
    $self->$action(@data);
  }

  return $self;
}

sub DESTROY {
  my ($self, @data) = @_;

  no strict 'refs';

  my @mixins = @{$self->META->mixins};

  for my $action (grep defined, map *{"${_}::DESTROY"}{"CODE"}, @mixins) {
    $self->$action(@data);
  }

  my @roles = @{$self->META->roles};

  for my $action (grep defined, map *{"${_}::DESTROY"}{"CODE"}, @roles) {
    $self->$action(@data);
  }

  return $self;
}

sub does {
  my ($self, @args) = @_;

  return $self->DOES(@args);
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

sub import {
  my ($self, @args) = @_;

  my $target = caller;

  $self->USE($target);

  return $self->IMPORT($target, @args);
}

sub meta {
  my ($self) = @_;

  return $self->META;
}

sub new {
  my ($self, @args) = @_;

  return $self->BLESS(@args);
}

sub unimport {
  my ($self, @args) = @_;

  my $target = caller;

  return $self->UNIMPORT($target, @args);
}

1;
