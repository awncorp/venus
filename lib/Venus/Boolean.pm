package Venus::Boolean;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

use Scalar::Util ();

state $true = Scalar::Util::dualvar(1, "1");
state $true_ref = \$true;
state $true_type = 'true';

state $false = Scalar::Util::dualvar(0, "0");
state $false_ref = \$false;
state $false_type = 'false';

use overload (
  '!' => sub{"$_[0]" ? $false : $true},
  '<' => sub{!!$_[0] < !!$_[1] ? $true : $false},
  '<=' => sub{!!$_[0] <= $_[1] ? $true : $false},
  '>' => sub{!!$_[0] > !!$_[1] ? $true : $false},
  '>=' => sub{!!$_[0] >= !!$_[1] ? $true : $false},
  '!=' => sub{!!$_[0] != !!$_[1] ? $true : $false},
  '0+' => sub{"$_[0]" ? $true : $false},
  '==' => sub{!!$_[0] == !!$_[1] ? $true : $false},
  'bool' => sub{!!$_[0] ? $true : $false},
  'eq' => sub{"$_[0]" eq "$_[1]" ? $true : $false},
  'ne' => sub{"$_[0]" ne "$_[1]" ? $true : $false},
  'qr' => sub{"$_[0]" ? qr/$true/ : qr/$false/},
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

  $data->{value} = (defined $data->{value} && !!$data->{value})
    ? $true
    : $false;

  return $data;
}

sub build_nil {
  my ($self, $data) = @_;

  return {
    value => {},
  };
}

sub build_self {
  my ($self, $data) = @_;

  my $value = $data->{value};
  my $isdual = Scalar::Util::isdual($value);

  if ($isdual && ("$value" == "1" && ($value + 0) == 1)) {
    $self->{value} = $true;
  }
  elsif ($isdual && ("$value" == "0" && ($value + 0) == 0)) {
    $self->{value} = $false;
  }
  else {
    $self->{value} = $value ? $true : $false;
  }

  return $self;
}

# METHODS

sub default {
  return $false;
}

sub is_false {
  my ($self) = @_;

  return $self->get ? $false : $true;
}

sub is_true {
  my ($self) = @_;

  return $self->get ? $true : $false;
}

sub negate {
  my ($self) = @_;

  return $self->get ? $false : $true;
}

sub type {
  my ($self) = @_;

  return $self->get ? $true_type : $false_type;
}

sub TO_FALSE {
  return $false;
}

sub TO_JSON {
  my ($self) = @_;

  no strict 'refs';

  return $self->get ? $true_ref : $false_ref;
}

sub TO_TRUE {
  return $true;
}

1;
