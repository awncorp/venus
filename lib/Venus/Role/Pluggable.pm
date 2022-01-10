package Venus::Role::Pluggable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Proxyable';

# BUILDERS

sub build_proxy {
  return undef;
}

# MODIFIERS

around build_proxy => sub {
  my ($orig, $self, $package, $method, @args) = @_;

  require Venus::Space;

  my $space = Venus::Space->new($package)->child('plugin', $method);

  return $self->$orig($package, $method, @args) if !$space->tryload;

  return sub {
    return $space->build->execute($self, @args);
  };
};

1;
