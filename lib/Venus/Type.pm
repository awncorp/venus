package Venus::Type;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';

use Scalar::Util ();

# METHODS

sub cast {
  my ($self, $kind, $callback, @args) = @_;

  my $code = $self->code;

  return undef if !$code;

  my $method = join '_', map lc, 'from', $code, 'to', $kind || $code;

  my $result = $self->$method($self->value);

  local $_ = $result;

  $result = Venus::Type->new($result->$callback(@args))->deduce if $callback;

  return $result;
}

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

  return $self->into_undef if not(defined($data));
  return $self->deduce_blessed if scalar_is_blessed($data);
  return $self->deduce_defined;
}

sub deduce_boolean {
  my ($self) = @_;

  my $data = $self->get;

  return $self->into_boolean;
}

sub deduce_blessed {
  my ($self) = @_;

  my $data = $self->get;

  return $self->into_regexp if $data->isa('Regexp');
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
  return $self->deduce_floatlike if scalar_is_float($data);
  return $self->deduce_numberlike if scalar_is_numeric($data);
  return $self->deduce_stringlike;
}

sub deduce_floatlike {
  my ($self) = @_;

  my $data = $self->get;

  return $self->into_float;
}

sub deduce_numberlike {
  my ($self) = @_;

  my $data = $self->get;

  return $self->into_number;
}

sub deduce_references {
  my ($self) = @_;

  my $data = $self->get;

  return $self->into_array if ref($data) eq 'ARRAY';
  return $self->into_code if ref($data) eq 'CODE';
  return $self->into_hash if ref($data) eq 'HASH';
  return $self->into_scalar; # glob, etc
}

sub deduce_stringlike {
  my ($self) = @_;

  my $data = $self->get;

  return $self->into_string;
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

sub from_array_to_array {
  my ($self, $data) = @_;

  return $self->into_array($data);
}

sub from_array_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(1);
}

sub from_array_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_array_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, !!$data, 0));
}

sub from_array_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({map +($_, $data->[$_]), 0..$#$data});
}

sub from_array_to_number {
  my ($self, $data) = @_;

  return $self->into_number(length($self->dump('value')));
}

sub from_array_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[quotemeta($self->dump('value'))]}});
}

sub from_array_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_array_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_array_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_boolean_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_boolean_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean($data);
}

sub from_boolean_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_boolean_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, !!$data, 0));
}

sub from_boolean_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({$data, $data});
}

sub from_boolean_to_number {
  my ($self, $data) = @_;

  return $self->into_number(0+!!$data);
}

sub from_boolean_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[$self->dump('value')]}});
}

sub from_boolean_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_boolean_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_boolean_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_code_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_code_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(1);
}

sub from_code_to_code {
  my ($self, $data) = @_;

  return $self->into_code($data);
}

sub from_code_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, !!$data, 0));
}

sub from_code_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({0, $data});
}

sub from_code_to_number {
  my ($self, $data) = @_;

  return $self->into_number(length($self->dump('value')));
}

sub from_code_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[quotemeta($self->dump('value'))]}});
}

sub from_code_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_code_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_code_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_float_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_float_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean($data);
}

sub from_float_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_float_to_float {
  my ($self, $data) = @_;

  return $self->into_float($data);
}

sub from_float_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({$data, $data});
}

sub from_float_to_number {
  my ($self, $data) = @_;

  return $self->into_number(0+$data);
}

sub from_float_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[quotemeta($self->dump('value'))]}});
}

sub from_float_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_float_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_float_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_hash_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_hash_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(1);
}

sub from_hash_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_hash_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, !!$data, 0));
}

sub from_hash_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash($data);
}

sub from_hash_to_number {
  my ($self, $data) = @_;

  return $self->into_number(length($self->dump('value')));
}

sub from_hash_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[quotemeta($self->dump('value'))]}});
}

sub from_hash_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_hash_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_hash_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_number_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_number_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(!!$data);
}

sub from_number_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_number_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, (split(/\./, "${data}.0"))[0,1]));
}

sub from_number_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({$data, $data});
}

sub from_number_to_number {
  my ($self, $data) = @_;

  return $self->into_number($data);
}

sub from_number_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[quotemeta($self->dump('value'))]}});
}

sub from_number_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_number_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_number_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_regexp_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_regexp_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean($data);
}

sub from_regexp_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_regexp_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, !!$data, 0));
}

sub from_regexp_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({0, $data});
}

sub from_regexp_to_number {
  my ($self, $data) = @_;

  return $self->into_number(length($self->dump('value')));
}

sub from_regexp_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp($data);
}

sub from_regexp_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_regexp_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_regexp_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_scalar_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_scalar_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(1);
}

sub from_scalar_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_scalar_to_float {
  my ($self, $data) = @_;

  return $self->into_float(join('.', map int, !!$data, 0));
}

sub from_scalar_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({0, $data});
}

sub from_scalar_to_number {
  my ($self, $data) = @_;

  return $self->into_number(length($self->dump('value')));
}

sub from_scalar_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[quotemeta($self->dump('value'))]}});
}

sub from_scalar_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar($data);
}

sub from_scalar_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_scalar_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_string_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_string_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(!!$data);
}

sub from_string_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_string_to_float {
  my ($self, $data) = @_;

  require Scalar::Util;

  return $self->into_float(join('.',
    Scalar::Util::looks_like_number($data) ? (split(/\./, "$data.0"))[0,1] : (0,0))
  );
}

sub from_string_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({$data, $data});
}

sub from_string_to_number {
  my ($self, $data) = @_;

  require Scalar::Util;

  return $self->into_float(Scalar::Util::looks_like_number($data) ? 0+$data : 0);
}

sub from_string_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr{@{[$self->dump('value')]}});
}

sub from_string_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\$data);
}

sub from_string_to_string {
  my ($self, $data) = @_;

  return $self->into_string($self->dump('value'));
}

sub from_string_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub from_undef_to_array {
  my ($self, $data) = @_;

  return $self->into_array([$data]);
}

sub from_undef_to_boolean {
  my ($self, $data) = @_;

  return $self->into_boolean(0);
}

sub from_undef_to_code {
  my ($self, $data) = @_;

  return $self->into_code(sub{$data});
}

sub from_undef_to_float {
  my ($self, $data) = @_;

  return $self->into_float('0.0');
}

sub from_undef_to_hash {
  my ($self, $data) = @_;

  return $self->into_hash({});
}

sub from_undef_to_number {
  my ($self, $data) = @_;

  return $self->into_number(0);
}

sub from_undef_to_regexp {
  my ($self, $data) = @_;

  return $self->into_regexp(qr//);
}

sub from_undef_to_scalar {
  my ($self, $data) = @_;

  return $self->into_scalar(\'');
}

sub from_undef_to_string {
  my ($self, $data) = @_;

  return $self->into_string('');
}

sub from_undef_to_undef {
  my ($self, $data) = @_;

  return $self->into_undef($data);
}

sub into_array {
  my ($self, $data) = @_;

  $data = [@{$self->get}] if $#_ <= 0;

  require Venus::Array;

  return Venus::Array->new($data);
}

sub into_boolean {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Boolean;

  return Venus::Boolean->new($data);
}

sub into_code {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Code;

  return Venus::Code->new($data);
}

sub into_float {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Float;

  return Venus::Float->new($data);
}

sub into_hash {
  my ($self, $data) = @_;

  $data = {%{$self->get}} if $#_ <= 0;

  require Venus::Hash;

  return Venus::Hash->new($data);
}

sub into_number {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Number;

  return Venus::Number->new($data);
}

sub into_regexp {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Regexp;

  return Venus::Regexp->new($data);
}

sub into_scalar {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Scalar;

  return Venus::Scalar->new($data);
}

sub into_string {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::String;

  return Venus::String->new($data);
}

sub into_undef {
  my ($self, $data) = @_;

  $data = $self->get if $#_ <= 0;

  require Venus::Undef;

  return Venus::Undef->new($data);
}

sub package {
  my ($self) = @_;

  my $data = $self->deduce;

  return ref($data);
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

sub scalar_is_float {
  my ($value) = @_;

  return Scalar::Util::looks_like_number($value) && length(do{
    $value =~ /^[+-]?([0-9]*)?\.[0-9]+$/;
  });
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
