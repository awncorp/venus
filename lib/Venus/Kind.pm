package Venus::Kind;

use 5.018;

use strict;
use warnings;

use Venus::Class 'with';

with 'Venus::Role::Boxable';
with 'Venus::Role::Tryable';
with 'Venus::Role::Catchable';
with 'Venus::Role::Comparable';
with 'Venus::Role::Deferrable';
with 'Venus::Role::Dumpable';
with 'Venus::Role::Digestable';
with 'Venus::Role::Doable';
with 'Venus::Role::Matchable';
with 'Venus::Role::Printable';
with 'Venus::Role::Reflectable';
with 'Venus::Role::Testable';
with 'Venus::Role::Throwable';
with 'Venus::Role::Assertable';
with 'Venus::Role::Serializable';
with 'Venus::Role::Mockable';
with 'Venus::Role::Patchable';

# METHODS

sub checksum {
  my ($self) = @_;

  return $self->digest('md5', 'stringified');
}

sub comparer {
  my ($self, $operation) = @_;

  if (lc($operation) eq 'eq') {
    return 'checksum';
  }
  if (lc($operation) eq 'gt') {
    return 'numified';
  }
  if (lc($operation) eq 'lt') {
    return 'numified';
  }
  else {
    return 'stringified';
  }
}

sub numified {
  my ($self) = @_;

  return CORE::length($self->stringified);
}

sub renew {
  my ($self, @args) = @_;

  my $data = $self->ARGS(@args);

  for my $attr (@{$self->meta->attrs}) {
    $data->{$attr} = $self->$attr if exists $self->{$attr} && !exists $data->{$attr};
  }

  return $self->class->new($data);
}

sub safe {
  my ($self, $method, @args) = @_;

  my $result = $self->trap($method, @args);

  return(wantarray ? (@$result) : $result->[0]);
}

sub self {
  my ($self) = @_;

  return $self;
}

sub stringified {
  my ($self) = @_;

  return $self->dump($self->can('value') ? 'value' : ());
}

sub trap {
  my ($self, $method, @args) = @_;

  no strict;
  no warnings;

  my $result = [[],[],[]];

  return(wantarray ? (@$result) : $result->[0]) if !$method;

  local ($!, $?, $@, $^E);

  local $SIG{__DIE__} = sub{
    push @{$result->[2]}, @_;
  };

  local $SIG{__WARN__} = sub{
    push @{$result->[1]}, @_;
  };

  push @{$result->[0]}, eval {
    local $_ = $self;
    $self->$method(@args);
  };

  return(wantarray ? (@$result) : $result->[0]);
}

1;
