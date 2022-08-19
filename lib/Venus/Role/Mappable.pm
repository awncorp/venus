package Venus::Role::Mappable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDIT

sub AUDIT {
  my ($self, $from) = @_;

  my $name = ref $self || $self;

  if (!$from->can('all')) {
    die "${from} requires 'all' to consume ${name}";
  }

  if (!$from->can('any')) {
    die "${from} requires 'any' to consume ${name}";
  }

  if (!$from->can('call')) {
    die "${from} requires 'call' to consume ${name}";
  }

  if (!$from->can('count')) {
    die "${from} requires 'count' to consume ${name}";
  }

  if (!$from->can('delete')) {
    die "${from} requires 'delete' to consume ${name}";
  }

  if (!$from->can('each')) {
    die "${from} requires 'each' to consume ${name}";
  }

  if (!$from->can('empty')) {
    die "${from} requires 'empty' to consume ${name}";
  }

  if (!$from->can('exists')) {
    die "${from} requires 'exists' to consume ${name}";
  }

  if (!$from->can('grep')) {
    die "${from} requires 'grep' to consume ${name}";
  }

  if (!$from->can('iterator')) {
    die "${from} requires 'iterator' to consume ${name}";
  }

  if (!$from->can('keys')) {
    die "${from} requires 'keys' to consume ${name}";
  }

  if (!$from->can('map')) {
    die "${from} requires 'map' to consume ${name}";
  }

  if (!$from->can('none')) {
    die "${from} requires 'none' to consume ${name}";
  }

  if (!$from->can('one')) {
    die "${from} requires 'one' to consume ${name}";
  }

  if (!$from->can('pairs')) {
    die "${from} requires 'pairs' to consume ${name}";
  }

  if (!$from->can('random')) {
    die "${from} requires 'random' to consume ${name}";
  }

  if (!$from->can('reverse')) {
    die "${from} requires 'reverse' to consume ${name}";
  }

  if (!$from->can('slice')) {
    die "${from} requires 'slice' to consume ${name}";
  }

  return $self;
}

1;
