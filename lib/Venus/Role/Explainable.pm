package Venus::Role::Explainable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDIT

sub AUDIT {
  my ($self, $from) = @_;

  my $name = ref $self || $self;

  if (!$from->can('explain')) {
    die "${from} requires 'explain' to consume ${name}";
  }

  return $self;
}

1;
