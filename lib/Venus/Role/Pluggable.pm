package Venus::Role::Pluggable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Proxyable')) {
    die "${self} requires ${from} to consume Venus::Role::Proxyable";
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
    return $space->build->execute($self, @args);
  };
}

# EXPORTS

sub EXPORT {
  ['build_proxy']
}

1;
