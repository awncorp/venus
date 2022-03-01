package Venus::Throw;

use 5.018;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

with 'Venus::Role::Stashable';

# ATTRIBUTES

has message => (
  is => 'rw',
);

has package => (
  is => 'ro',
);

has parent => (
  is => 'ro',
  default => 'Venus::Error',
);

has context => (
  is => 'ro',
);

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    package => $data,
  };
}

# METHODS

sub error {
  my ($self, $data) = @_;

  require Venus::Error;

  my $context = $self->context || (caller(1))[3];
  my $package = $self->package || join('::', map ucfirst, (caller(0))[0], 'error');
  my $parent = $self->parent;
  my $message = $self->message;

  $data //= {};
  $data->{context} //= $context;
  $data->{message} //= $message if $message;

  if (%{$self->stash}) {
    $data->{'$stash'} //= $self->stash;
  }

  local $@;
  if (!$package->can('new') and !eval "package $package; use base '$parent'; 1") {
    my $throw = Venus::Throw->new(package => 'Venus::Throw::Error');
    $throw->message($@);
    $throw->stash(package => $package);
    $throw->stash(parent => $parent);
    $throw->error;
  }
  if (!$parent->isa('Venus::Error')) {
    my $throw = Venus::Throw->new(package => 'Venus::Throw::Error');
    $throw->message(qq(Parent '$parent' doesn't derive from 'Venus::Error'));
    $throw->stash(package => $package);
    $throw->stash(parent => $parent);
    $throw->error;
  }
  if (!$package->isa('Venus::Error')) {
    my $throw = Venus::Throw->new(package => 'Venus::Throw::Error');
    $throw->message(qq(Package '$package' doesn't derive from 'Venus::Error'));
    $throw->stash(package => $package);
    $throw->stash(parent => $parent);
    $throw->error;
  }

  @_ = ($package->new($data ? $data : ()));

  goto $package->can('throw');
}

1;
