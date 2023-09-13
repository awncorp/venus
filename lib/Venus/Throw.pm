package Venus::Throw;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Stashable';

use overload (
  '""' => sub{$_[0]->catch('error')->explain},
  '~~' => sub{$_[0]->catch('error')->explain},
  fallback => 1,
);

# ATTRIBUTES

attr 'frame';
attr 'name';
attr 'message';
attr 'package';
attr 'parent';
attr 'context';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    package => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->parent('Venus::Error') if !$self->parent;

  return $self;
}

# METHODS

sub as {
  my ($self, $name) = @_;

  $self->name($name);

  return $self;
}

sub assertion {
  my ($self) = @_;

  my $assertion = $self->SUPER::assertion;

  $assertion->match('string')->format(sub{
    (ref $self || $self)->new($_)
  });

  return $assertion;
}

sub capture {
  my ($self, @args) = @_;

  my $frame = $self->frame;

  $self->stash(captured => {
    callframe => [caller($frame // 1)],
    arguments => [@args],
  });

  return $self;
}

sub error {
  my ($self, $data) = @_;

  require Venus::Error;

  my $frame = $self->frame;
  my $name = $self->name;
  my $context = $self->context || (caller($frame // 1))[3];
  my $package = $self->package || join('::', map ucfirst, (caller(0))[0], 'error');
  my $parent = $self->parent;
  my $message = $self->message;

  $data //= {};
  $data->{context} //= $context;
  $data->{message} //= $message if $message;
  $data->{name} //= $name if $name;

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

sub on {
  my ($self, $name) = @_;

  my $frame = $self->frame;

  my $routine = (split(/::/, (caller($frame // 1))[3]))[-1];

  undef $routine if $routine eq '__ANON__' || $routine eq '(eval)';

  $self->name(join('.', 'on', grep defined, $routine, $name)) if $routine || $name;

  return $self;
}

1;
