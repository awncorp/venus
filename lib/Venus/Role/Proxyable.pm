package Venus::Role::Proxyable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

# METHODS

sub AUTOLOAD {
  require Venus::Error;

  my ($package, $method) = our $AUTOLOAD =~ m[^(.+)::(.+)$];

  my $build = $package->can('BUILDPROXY');

  my $error = qq(Can't locate object method "$method" via package "$package");

  Venus::Error->throw($error) unless $build && ref($build) eq 'CODE';

  my $proxy = $build->($package, $method, @_);

  Venus::Error->throw($error) unless $proxy && ref($proxy) eq 'CODE';

  goto &$proxy;
}

sub BUILDPROXY {
  require Venus::Error;

  my ($package, $method, $self, @args) = @_;

  my $build = $self->can('build_proxy');

  return $build->($self, $package, $method, @args) if $build;

  my $error = qq(Can't locate object method "build_proxy" via package "$package");

  Venus::Error->throw($error);
}

sub DESTROY {
  return;
}

1;
