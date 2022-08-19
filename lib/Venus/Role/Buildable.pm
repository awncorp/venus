package Venus::Role::Buildable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# BUILDERS

sub BUILD {
  my ($self, $args) = @_;

  if ($self->can('build_self')) {
    $self->build_self($args);
  }

  return $self;
}

sub BUILDARGS {
  my ($self, @args) = @_;

  # build_nil accepts a single-arg (empty hash)
  my $present = @args == 1 && ref $args[0] eq 'HASH' && !%{$args[0]};

  # empty hash argument
  if ($self->can('build_nil') && $present) {
    @args = ($self->build_nil($args[0]));
  }

  # build_arg accepts a single-arg (non-hash)
  my $inflate = @args == 1 && ref $args[0] ne 'HASH';

  # single argument
  if ($self->can('build_arg') && $inflate) {
    @args = ($self->build_arg($args[0]));
  }

  # build_args should not accept a single-arg (non-hash)
  my $ignore = @args == 1 && ref $args[0] ne 'HASH';

  # standard arguments
  if ($self->can('build_args') && !$ignore) {
    @args = ($self->build_args(@args == 1 ? $args[0] : {@args}));
  }

  return (@args);
}

# EXPORTS

sub EXPORT {
  ['BUILDARGS']
}

1;
