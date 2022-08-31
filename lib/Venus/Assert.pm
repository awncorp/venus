package Venus::Assert;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

use Venus::Match;
use Venus::Type;

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

# ATTRIBUTES

attr 'message';
attr 'name';

# BUILDERS

sub build_arg {
  my ($self, $name) = @_;

  return {
    name => $name,
  };
}

sub build_self {
  my ($self, $data) = @_;

  my $name = 'Unknown';
  my $message = 'Type assertion (%s) failed: received %s';

  $self->name($name) if !$self->name;
  $self->message($message) if !$self->message;

  return $self;
}

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->constraints->clear;

  $assert->constraint('string', true);

  return $assert;
}

sub check {
  my ($self, $data) = @_;

  my $value = Venus::Type->new(value => $data);

  my @args = (value => $value, on_none => sub{false});

  return $self->constraints->renew(@args)->result;
}

sub coerce {
  my ($self, $data) = @_;

  my $value = Venus::Type->new(value => $data);

  my @args = (value => $value, on_none => sub{$data});

  return $self->coercions->renew(@args)->result;
}

sub coercion {
  my ($self, $type, $code) = @_;

  $self->coercions->when('coded', $type)->then($code);

  return $self;
}

sub coercions {
  my ($self) = @_;

  my $match = Venus::Match->new;

  return $self->{coercions} ||= $match if ref $self;

  return $match;
}

sub constraint {
  my ($self, $type, $code) = @_;

  $self->constraints->when('coded', $type)->then($code);

  return $self;
}

sub constraints {
  my ($self) = @_;

  my $match = Venus::Match->new;

  return $self->{constraints} ||= $match if ref $self;

  return $match;
}

sub validate {
  my ($self, $data) = @_;

  my $valid = $self->check($data);

  return $data if $valid;

  my $identity = lc Venus::Type->new(value => $data)->identify;
  my $received = defined $data ? "$identity (".(ref($data) || $data).")" : $identity;

  my $throw;
  $throw = $self->throw;
  $throw->name('on.validate');
  $throw->message(sprintf($self->message, $self->name, $received));
  $throw->stash(identity => $identity);
  $throw->stash(variable => $data);
  $throw->error;

  return $throw;
}

1;
