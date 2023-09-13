package Venus::Sealed;

use 5.018;

use strict;
use warnings;

use Venus::Class 'with';

with 'Venus::Role::Buildable';
with 'Venus::Role::Proxyable';
with 'Venus::Role::Tryable';
with 'Venus::Role::Throwable';
with 'Venus::Role::Catchable';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
}

sub build_args {
  my ($self, $data) = @_;

  if (not(keys %$data == 1 && exists $data->{value})) {
    $data = (exists $data->{value}) ? {value => $data->{value}} : {};
  }

  require Storable;

  $data = Storable::dclone($data);

  my $state = {
    (exists $data->{value} ? (value => $data->{value}) : ())
  };

  my $subs = {
    map +($_, $self->can($_)), grep /^__\w+$/, $self->meta->subs,
  };

  my $scope = sub {
    my ($self, $name, @args) = @_;

    return if !$name;

    my $method = "__$name";

    return if !$subs->{$method};

    return $subs->{$method}->($self, $data, $state, @args);
  };

  return {
    scope => $scope,
  };
}

sub build_self {
  my ($self, $data) = @_;

  return $self;
}

sub build_proxy {
  my ($self, $package, $name, @args) = @_;

  my $method = $self->can("__$name");

  if (!$method && ref $method ne 'CODE') {
    return undef;
  }

  return sub {
    return $self->{scope}->($self, $name, @args);
  };
}

# METHODS

sub __get {
  my ($self, $init, $data) = @_;

  return $data->{value};
}

sub __set {
  my ($self, $init, $data, $value) = @_;

  return $data->{value} = $value;
}

1;
