package Venus::Role::Mappable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# AUDIT

sub AUDIT {
  my ($self, $from) = @_;

  my $name = ref $self || $self;

  if (!$from->can('all')) {
    fault "${from} requires 'all' to consume ${name}";
  }

  if (!$from->can('any')) {
    fault "${from} requires 'any' to consume ${name}";
  }

  if (!$from->can('call')) {
    fault "${from} requires 'call' to consume ${name}";
  }

  if (!$from->can('count')) {
    fault "${from} requires 'count' to consume ${name}";
  }

  if (!$from->can('delete')) {
    fault "${from} requires 'delete' to consume ${name}";
  }

  if (!$from->can('each')) {
    fault "${from} requires 'each' to consume ${name}";
  }

  if (!$from->can('empty')) {
    fault "${from} requires 'empty' to consume ${name}";
  }

  if (!$from->can('exists')) {
    fault "${from} requires 'exists' to consume ${name}";
  }

  if (!$from->can('grep')) {
    fault "${from} requires 'grep' to consume ${name}";
  }

  if (!$from->can('iterator')) {
    fault "${from} requires 'iterator' to consume ${name}";
  }

  if (!$from->can('keys')) {
    fault "${from} requires 'keys' to consume ${name}";
  }

  if (!$from->can('map')) {
    fault "${from} requires 'map' to consume ${name}";
  }

  if (!$from->can('none')) {
    fault "${from} requires 'none' to consume ${name}";
  }

  if (!$from->can('one')) {
    fault "${from} requires 'one' to consume ${name}";
  }

  if (!$from->can('pairs')) {
    fault "${from} requires 'pairs' to consume ${name}";
  }

  if (!$from->can('random')) {
    fault "${from} requires 'random' to consume ${name}";
  }

  if (!$from->can('reverse')) {
    fault "${from} requires 'reverse' to consume ${name}";
  }

  if (!$from->can('slice')) {
    fault "${from} requires 'slice' to consume ${name}";
  }

  return $self;
}

1;
