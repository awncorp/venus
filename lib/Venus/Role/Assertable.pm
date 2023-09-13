package Venus::Role::Assertable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# METHODS

sub assert {
  my ($self, $data) = @_;

  return $self->assertion->result($data);
}

sub assertion {
  my ($self) = @_;

  require Venus::Assert;

  my $class = ref $self || $self;

  my $assert = Venus::Assert->new($class);

  $assert->match('hashref')->format(sub{
    $class->new($_)
  });

  $assert->accept($class);

  return $assert;
}

sub check {
  my ($self, $data) = @_;

  return $self->assertion->valid($data);
}

sub coerce {
  my ($self, $data) = @_;

  return $self->assertion->coerce($data);
}

sub make {
  my ($self, $data) = @_;

  return UNIVERSAL::isa($data, ref $self || $self)
    ? $data
    : $self->assert($data);
}

# EXPORTS

sub EXPORT {
  ['assert', 'assertion', 'check', 'coerce', 'make']
}

1;
