package Venus::Boolean;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Kind::Value';

use Venus::True;
use Venus::False;

state $true = Venus::True->value;
state $true_ref = \$true;
state $true_type = 'true';

state $false = Venus::False->value;
state $false_ref = \$false;
state $false_type = 'false';

use overload (
  '!' => sub{$_[0]->get ? $false : $true},
  '<' => sub{!!$_[0] < !!$_[1] ? $true : $false},
  '<=' => sub{!!$_[0] <= !!$_[1] ? $true : $false},
  '>' => sub{!!$_[0] > !!$_[1] ? $true : $false},
  '>=' => sub{!!$_[0] >= !!$_[1] ? $true : $false},
  '!=' => sub{!!$_[0] != !!$_[1] ? $true : $false},
  '==' => sub{!!$_[0] == !!$_[1] ? $true : $false},
  'bool' => sub{!!$_[0] ? $true : $false},
  'eq' => sub{"$_[0]" eq "$_[1]" ? $true : $false},
  'ne' => sub{"$_[0]" ne "$_[1]" ? $true : $false},
  'qr' => sub{"$_[0]" ? qr/$true/ : qr/$false/},
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

  $data->{value} = BOOL(TO_BOOL($data->{value}));

  return $self;
}

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->boolean;

  return $assert;
}

sub comparer {
  my ($self) = @_;

  return 'numified';
}

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

sub numified {
  my ($self) = @_;

  return 0 + $self->value;
}

sub string {
  my ($self) = @_;

  return $self->get ? $true_type : $false_type;
}

sub BOOL {
  return $_[0] ? $true : $false;
}

sub BOOL_REF {
  return $_[0] ? $true_ref : $false_ref;
}

sub FALSE {
  return $false;
}

sub FROM_BOOL {
  my ($value) = @_;

  my $object = Scalar::Util::blessed($value);
  my $scalar = ((Scalar::Util::reftype($value) // '') eq 'SCALAR') ? 1 : 0;

  if ($object && $scalar && defined($$value) && !ref($$value) && $$value == 1) {
    return $true;
  }
  elsif ($object && $scalar && defined($$value) && !ref($$value) && $$value == 0) {
    return $false;
  }
  elsif ($object && $value->isa('Venus::True')) {
    return $value->value;
  }
  elsif ($object && $value->isa('Venus::False')) {
    return $value->value;
  }
  elsif ($object && $value->isa('Venus::Boolean')) {
    return $value->get;
  }
  else {
    return $value;
  }
}

sub TO_BOOL {
  my ($value) = @_;

  my $isdual = Scalar::Util::isdual($value);

  if ($isdual && ("$value" && "$value" == "1" && ($value + 0) == 1)) {
    return $true;
  }
  elsif ($isdual && (("$value" eq "") || ("$value" == "0" && ($value + 0) == 0))) {
    return $false;
  }
  else {
    return $value;
  }
}

sub TO_BOOL_REF {
  my ($value) = @_;

  my $isdual = Scalar::Util::isdual($value);

  if ($isdual && ("$value" && "$value" == "1" && ($value + 0) == 1)) {
    return $true_ref;
  }
  elsif ($isdual && (("$value" eq "") || ("$value" == "0" && ($value + 0) == 0))) {
    return $false_ref;
  }
  else {
    return $value;
  }
}

sub TO_BOOL_JPO {
  my ($value) = @_;

  require JSON::PP;

  my $isdual = Scalar::Util::isdual($value);

  if ($isdual && ("$value" && "$value" == "1" && ($value + 0) == 1)) {
    return JSON::PP::true();
  }
  elsif ($isdual && (("$value" eq "") || ("$value" == "0" && ($value + 0) == 0))) {
    return JSON::PP::false();
  }
  else {
    return $value;
  }
}

sub TO_BOOL_TFO {
  my ($value) = @_;

  my $isdual = Scalar::Util::isdual($value);

  if ($isdual && ("$value" && "$value" == "1" && ($value + 0) == 1)) {
    return Venus::True->new;
  }
  elsif ($isdual && (("$value" eq "") || ("$value" == "0" && ($value + 0) == 0))) {
    return Venus::False->new;
  }
  else {
    return $value;
  }
}

sub TO_JSON {
  my ($self) = @_;

  no strict 'refs';

  return $self->get ? $true_ref : $false_ref;
}

sub TRUE {
  return $true;
}

1;
