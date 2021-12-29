package Venus::Code;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

use overload (
  '&{}' => sub{$_[0]->value},
);

# METHODS

sub call {
  my ($self, @args) = @_;

  my $data = $self->get;

  return $data->(@args);
}

sub compose {
  my ($self, $code, @args) = @_;

  my $data = $self->get;

  return sub { (sub { $code->($data->(@_)) })->(@args, @_) };
}

sub conjoin {
  my ($self, $code) = @_;

  my $data = $self->get;

  return sub { $data->(@_) && $code->(@_) };
}

sub curry {
  my ($self, @args) = @_;

  my $data = $self->get;

  return sub { $data->(@args, @_) };
}

sub default {
  return sub{};
}

sub disjoin {
  my ($self, $code) = @_;

  my $data = $self->get;

  return sub { $data->(@_) || $code->(@_) };
}

sub next {
  my ($self, @args) = @_;

  my $data = $self->get;

  return $data->(@args);
}

sub rcurry {
  my ($self, @args) = @_;

  my $data = $self->get;

  return sub { $data->(@_, @args) };
}

1;
