package Venus::Role::Pluggable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Proxyable')) {
    fault "${self} requires ${from} to consume Venus::Role::Proxyable";
  }

  return $self;
}

# METHODS

sub build_proxy {
  my ($self, $package, $method, @args) = @_;

  require Venus::Space;

  my $space = Venus::Space->new($package)->child('plugin', $method);

  return undef if !$space->tryload;

  return sub {
    if ($space->package->can('construct')) {
      my $class = $space->load;

      return $class->construct($self, @args)->execute;
    }
    else {
      my $class = $space->load;

      return $class->new->execute($self, @args);
    }
  };
}

# EXPORTS

sub EXPORT {
  ['build_proxy']
}

1;
