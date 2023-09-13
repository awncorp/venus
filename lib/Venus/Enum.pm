package Venus::Enum;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Sealed';

use overload (
  '""' => sub{$_[0]->value // ''},
  '~~' => sub{$_[0]->value // ''},
  'eq' => sub{($_[0]->value // '') eq "$_[1]"},
  'ne' => sub{($_[0]->value // '') ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0])]}/},
  fallback => 1,
);

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
    $data = {value => $data};
  }

  my $value = $data->{value};

  if (!ref $value) {
    $value = {}
  }

  if (ref $value eq 'ARRAY') {
    $value = {map +(s/\W//gr, $_), @{$value}};
  }
  else {
    $value = {map +(s/\W//gr, $value->{$_}), keys %{$value}};
  }

  $data->{value} = {
    names => $value,
    codes => {reverse %{$value}},
  };

  return $self->SUPER::build_args($data);
}

# METHODS

sub __get {
  my ($self, $init, $data, $name) = @_;

  return undef if !$name;

  my $class = ref $self || $self;

  my $enum = $class->new(value => $init->{value}->{names});

  $enum->{set} = 1;

  $enum->set($name);

  delete $enum->{set};

  return $enum;
}

sub __set {
  my ($self, $init, $data, $name) = @_;

  return undef if !$name;

  return $self if !exists $self->{set};

  my $names = $init->{value}->{names};

  return $self if !exists $names->{$name};

  $data->{named} //= $name;

  return $self;
}

sub __has {
  my ($self, $init, $data, $match) = @_;

  return false if !$match;

  my $names = $init->{value}->{names};

  return true if $names->{$match};

  my $codes = $init->{value}->{codes};

  return true if $codes->{$match};

  return false;
}

sub __is {
  my ($self, $init, $data, $match) = @_;

  return false if !$match;

  my $name = $self->name;

  return true if $name eq $match;

  my $value = $self->value;

  return true if $value eq $match;

  return false;
}

sub __name {
  my ($self, $init, $data) = @_;

  return $data->{named};
}

sub __names {
  my ($self, $init, $data) = @_;

  my $names = $init->{value}->{names};

  my $list = [sort keys %{$names}];

  return wantarray ? (@{$list}) : $list;
}

sub __items {
  my ($self, $init, $data) = @_;

  my $names = $init->{value}->{names};

  my $list = [map [$_, $names->{$_}], $self->list];

  return wantarray ? (@{$list}) : $list;
}

sub __list {
  my ($self, $init, $data) = @_;

  my $codes = $init->{value}->{codes};

  my $list = [map $codes->{$_}, sort keys %{$codes}];

  return wantarray ? (@{$list}) : $list;
}

sub __value {
  my ($self, $init, $data) = @_;

  my $value = $data->{named};

  return undef if !defined $value;

  return $init->{value}->{names}->{$value};
}

sub __values {
  my ($self, $init, $data) = @_;

  my $codes = $init->{value}->{codes};

  my $list = [sort keys %{$codes}];

  return wantarray ? (@{$list}) : $list;
}

1;
