package Venus;

use 5.018;

use strict;
use warnings;

# VERSION

our $VERSION = '0.08';

# AUTHORITY

our $AUTHORITY = 'cpan:CPANERY';

# IMPORTS

sub import {
  my ($package, @exports) = @_;

  my $target = caller;

  no strict 'refs';

  my %seen;
  for my $name (grep !$seen{$_}++, @exports, 'true', 'false') {
    *{"${target}::${name}"} = $package->can($name) if !$target->can($name);
  }

  return $package;
}

# FUNCTIONS

sub catch (&) {
  my (@args) = @_;

  my ($callback) = @_;

  require Venus::Try;

  my $error;

  my @result = Venus::Try->new($callback)->error(\$error)->result;

  return wantarray ? ($error ? ($error, undef) : ($error, @result)) : $error;
}

sub error (;$) {
  my ($data) = @_;

  $data //= {};
  $data->{context} //= (caller(1))[3];

  require Venus::Throw;

  return Venus::Throw->new->error($data);
}

sub false () {
  require Venus::Boolean;

  return Venus::Boolean::FALSE();
}

sub raise ($;$) {
  my ($package, $data) = @_;

  my $parent = 'Venus::Error';

  ($package, $parent) = (@$package) if (ref($package) eq 'ARRAY');

  $data //= {};
  $data->{context} //= (caller(1))[3];

  $parent = 'Venus::Error' if !$parent;

  require Venus::Throw;

  return Venus::Throw->new(package => $package, parent => $parent)->error($data);
}

sub true () {
  require Venus::Boolean;

  return Venus::Boolean::TRUE();
}

1;