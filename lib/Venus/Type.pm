package Venus::Type;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

with 'Venus::Role::Accessible';

use Scalar::Util ();

# METHODS

sub code {
  my ($self) = @_;

  my $package = $self->package;

  return "ARRAY" if $package eq "Venus::Array";
  return "BOOLEAN" if $package eq "Venus::Boolean";
  return "HASH" if $package eq "Venus::Hash";
  return "CODE" if $package eq "Venus::Code";
  return "FLOAT" if $package eq "Venus::Float";
  return "NUMBER" if $package eq "Venus::Number";
  return "STRING" if $package eq "Venus::String";
  return "SCALAR" if $package eq "Venus::Scalar";
  return "REGEXP" if $package eq "Venus::Regexp";
  return "UNDEF" if $package eq "Venus::Undef";

  return undef;
}

sub deduce {
  my ($self) = @_;

  my $data = $self->get;

  return $self->object_undef if not(defined($data));
  return $self->deduce_blessed if scalar_is_blessed($data);
  return $self->deduce_defined;
}

sub deduce_boolean {
  my ($self) = @_;

  my $data = $self->get;

  return $self->object_boolean;
}

sub deduce_blessed {
  my ($self) = @_;

  my $data = $self->get;

  return $self->object_regexp if $data->isa('Regexp');
  return $data;
}

sub deduce_deep {
  my ($self) = @_;

  my $data = $self->deduce;

  if ($data and $data->isa('Venus::Hash')) {
    for my $i (keys %{$data->get}) {
      my $val = $data->get->{$i};
      $data->get->{$i} = ref($val)
        ? $self->class->new(value => $val)->deduce_deep
        : $self->class->new(value => $val)->deduce;
    }
  }
  if ($data and $data->isa('Venus::Array')) {
    for (my $i = 0; $i < @{$data->get}; $i++) {
      my $val = $data->get->[$i];
      $data->get->[$i] = ref($val)
        ? $self->class->new(value => $val)->deduce_deep
        : $self->class->new(value => $val)->deduce;
    }
  }

  return $data;
}

sub deduce_defined {
  my ($self) = @_;

  my $data = $self->get;

  return $self->deduce_references if ref($data);
  return $self->deduce_boolean if scalar_is_boolean($data);
  return $self->deduce_numberlike if scalar_is_numeric($data);
  return $self->deduce_stringlike;
}

sub deduce_numberlike {
  my ($self) = @_;

  my $data = $self->get;

  return $self->object_float if $data =~ /\./;
  return $self->object_number;
}

sub deduce_references {
  my ($self) = @_;

  my $data = $self->get;

  return $self->object_array if ref($data) eq 'ARRAY';
  return $self->object_code if ref($data) eq 'CODE';
  return $self->object_hash if ref($data) eq 'HASH';
  return $self->object_scalar; # glob, etc
}

sub deduce_stringlike {
  my ($self) = @_;

  my $data = $self->get;

  return $self->object_string;
}

sub detract {
  my ($self) = @_;

  my $data = $self->get;

  return $data if not(scalar_is_blessed($data));

  return $data->value if UNIVERSAL::isa($data, 'Venus::Kind');

  return $data;
}

sub detract_deep {
  my ($self) = @_;

  my $data = $self->detract;

  if ($data and ref($data) and ref($data) eq 'HASH') {
    for my $i (keys %{$data}) {
      my $val = $data->{$i};
      $data->{$i} = scalar_is_blessed($val)
        ? $self->class->new(value => $val)->detract_deep
        : $self->class->new(value => $val)->detract;
    }
  }
  if ($data and ref($data) and ref($data) eq 'ARRAY') {
    for (my $i = 0; $i < @{$data}; $i++) {
      my $val = $data->[$i];
      $data->[$i] = scalar_is_blessed($val)
        ? $self->class->new(value => $val)->detract_deep
        : $self->class->new(value => $val)->detract;
    }
  }

  return $data;
}

sub package {
  my ($self) = @_;

  my $data = $self->deduce;

  return ref($data);
}

sub object_array {
  my ($self) = @_;

  require Venus::Array;

  return Venus::Array->new([@{$self->get}]);
}

sub object_boolean {
  my ($self) = @_;

  require Venus::Boolean;

  return Venus::Boolean->new($self->get);
}

sub object_code {
  my ($self) = @_;

  require Venus::Code;

  return Venus::Code->new($self->get);
}

sub object_float {
  my ($self) = @_;

  require Venus::Float;

  return Venus::Float->new($self->get);
}

sub object_hash {
  my ($self) = @_;

  require Venus::Hash;

  return Venus::Hash->new({%{$self->get}});
}

sub object_number {
  my ($self) = @_;

  require Venus::Number;

  return Venus::Number->new($self->get);
}

sub object_regexp {
  my ($self) = @_;

  require Venus::Regexp;

  return Venus::Regexp->new($self->get);
}

sub object_scalar {
  my ($self) = @_;

  require Venus::Scalar;

  return Venus::Scalar->new($self->get);
}

sub object_string {
  my ($self) = @_;

  require Venus::String;

  return Venus::String->new($self->get);
}

sub object_undef {
  my ($self) = @_;

  require Venus::Undef;

  return Venus::Undef->new($self->get);
}

sub scalar_is_blessed {
  my ($value) = @_;

  return Scalar::Util::blessed($value);
}

sub scalar_is_boolean {
  my ($value) = @_;

  return Scalar::Util::isdual($value) && (
    ("$value" == "1" && ($value + 0) == 1) ||
    ("$value" == "0" && ($value + 0) == 0)
  );
}

sub scalar_is_numeric {
  my ($value) = @_;

  return Scalar::Util::looks_like_number($value) && length(do{
    no if $] >= 5.022, "feature", "bitwise";
    no warnings "numeric";
    $value & ""
  });
}

1;
