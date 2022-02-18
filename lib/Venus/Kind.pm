package Venus::Kind;

use 5.018;

use strict;
use warnings;

use Moo;

with 'Venus::Role::Boxable';
with 'Venus::Role::Catchable';
with 'Venus::Role::Digestable';
with 'Venus::Role::Doable';
with 'Venus::Role::Dumpable';
with 'Venus::Role::Matchable';
with 'Venus::Role::Printable';
with 'Venus::Role::Throwable';

# METHODS

sub class {
  my ($self) = @_;

  return ref($self) || $self;
}

sub safe {
  my ($self, $method, @args) = @_;

  my $result = $self->trap($method, @args);

  return(wantarray ? (@$result) : $result->[0]);
}

sub space {
  my ($self) = @_;

  require Venus::Space;

  return Venus::Space->new($self->class);
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

sub type {
  my ($self, $method, @args) = @_;

  require Venus::Type;

  my $value = $method ? $self->$method(@args) : $self;

  return Venus::Type->new(value => $value);
}

1;
