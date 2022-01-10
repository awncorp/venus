package Venus::Box;

use 5.018;

use strict;
use warnings;

use Moo;

with 'Venus::Role::Buildable';
with 'Venus::Role::Proxyable';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
}

sub build_args {
  my ($self, $data) = @_;

  if (keys %$data == 1 && exists $data->{value}) {
    return $data;
  }
  return {
    value => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  require Venus::Type;

  $data //= {};

  $self->{value} = Venus::Type->new(value => $data->{value})->deduce;

  return $self;
}

sub build_proxy {
  my ($self, $package, $method, @args) = @_;

  require Scalar::Util;

  my $value = $self->{value};

  if (not(Scalar::Util::blessed($value))) {
    require Venus::Error;
    Venus::Error->throw("$package can only operate on objects, not $value");
  }
  if (not($value->can($method) || $value->can('AUTOLOAD'))) {
    return undef;
  }
  return sub {
    my $result = [
      $value->$method(@args)
    ];
    $result = $result->[0] if @$result == 1;
    if (Scalar::Util::blessed($result)) {
      return not(UNIVERSAL::isa($result, 'Venus::Box'))
        ? ref($self)->new(value => $result)
        : $result;
    }
    else {
      require Venus::Type;
      return ref($self)->new(
        value => Venus::Type->new(value => $result)->deduce
      );
    }
  };
}

# METHODS

sub unbox {
  my ($self) = @_;

  my $value = $self->{value};

  return $value;
}

1;
