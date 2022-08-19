package Venus::Core::Role;

use 5.018;

use strict;
use warnings;

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

  my @roles = @{$self->META->roles};

  for my $action (grep defined, map *{"${_}::DESTROY"}{"CODE"}, @roles) {
    $self->$action(@data);
  }

  return $self;
}

sub EXPORT {
  my ($self, $into) = @_;

  return [];
}

sub IMPORT {
  my ($self, $into) = @_;

  no strict 'refs';
  no warnings 'redefine';

  for my $name (grep !*{"${into}::${_}"}{"CODE"}, @{$self->EXPORT($into)}) {
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
