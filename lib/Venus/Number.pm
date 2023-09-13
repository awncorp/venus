package Venus::Number;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Kind::Value';

use overload (
  '!' => sub{!$_[0]->get},
  '!=' => sub{$_[0]->get != ($_[1] + 0)},
  '%' => sub{$_[0]->get % ($_[1] + 0)},
  '*' => sub{$_[0]->get * ($_[1] + 0)},
  '+' => sub{$_[0]->get + ($_[1] + 0)},
  '-' => sub{$_[0]->get - ($_[1] + 0)},
  '/' => sub{$_[0]->get / ($_[1] + 0)},
  '0+' => sub{$_[0]->get + 0},
  '<' => sub{$_[0]->get < ($_[1] + 0)},
  '<=' => sub{$_[0]->get <= ($_[1] + 0)},
  '==' => sub{$_[0]->get == ($_[1] + 0)},
  '>' => sub{$_[0]->get > ($_[1] + 0)},
  '>=' => sub{$_[0]->get >= ($_[1] + 0)},
  'bool' => sub{$_[0]->get + 0},
  'eq' => sub{"$_[0]" eq "$_[1]"},
  'ne' => sub{"$_[0]" ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0]->get)]}/},
  'x' => sub{$_[0]->get x ($_[1] + 0)},
  fallback => 1,
);

# METHODS

sub abs {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::abs($data);
}

sub add {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data + ($arg + 0);
}

sub append {
  my ($self, @args) = @_;

  return $self->append_with(undef, @args);
}

sub append_with {
  my ($self, $delimiter, @args) = @_;

  my $data = $self->get;

  return CORE::join($delimiter // '', $data, @args);
}

sub assertion {
  my ($self) = @_;

  my $assertion = $self->SUPER::assertion;

  $assertion->match('float')->format(sub{
    (ref $self || $self)->new($_)
  });

  $assertion->match('number')->format(sub{
    (ref $self || $self)->new($_)
  });

  return $assertion;
}

sub atan2 {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return CORE::atan2($data, $arg + 0);
}

sub comparer {
  my ($self) = @_;

  return 'numified';
}

sub concat {
  my ($self, @args) = @_;

  my $data = $self->get;

  return CORE::join('', $data, @args);
}

sub contains {
  my ($self, $pattern) = @_;

  my $data = $self->get;

  return 0 unless CORE::defined($pattern);

  my $regexp = UNIVERSAL::isa($pattern, 'Regexp');

  return CORE::index($data, $pattern) < 0 ? 0 : 1 if !$regexp;

  return ($data =~ $pattern) ? true : false;
}

sub cos {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::cos($data);
}

sub decr {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data - (($arg || 1) + 0);
}

sub default {

  return 0;
}

sub div {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data / ($arg + 0);
}

sub exp {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::exp($data);
}

sub hex {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::sprintf('%#x', $data);
}

sub incr {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data + (($arg || 1) + 0);
}

sub index {
  my ($self, $substr, $start) = @_;

  my $data = $self->get;

  return CORE::index($data, $substr) if not(CORE::defined($start));
  return CORE::index($data, $substr, $start);
}

sub int {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::int($data);
}

sub length {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::length($data);
}

sub log {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::log($data);
}

sub lshift {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data << ($arg + 0);
}

sub mod {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data % ($arg + 0);
}

sub multi {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data * ($arg + 0);
}

sub neg {
  my ($self) = @_;

  my $data = $self->get;

  return $data =~ /^-(.*)/ ? $1 : -$data;
}

sub numified {
  my ($self) = @_;

  my $data = $self->get;

  return 0 + $data;
}

sub pow {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data ** ($arg + 0);
}

sub prepend {
  my ($self, @args) = @_;

  return $self->prepend_with(undef, @args);
}

sub prepend_with {
  my ($self, $delimiter, @args) = @_;

  my $data = $self->get;

  return CORE::join($delimiter // '', @args, $data);
}

sub range {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return [
    ($data > ($arg + 0)) ? CORE::reverse(($arg + 0)..$data) : ($data..($arg + 0))
  ];
}

sub repeat {
  my ($self, $count, $delimiter) = @_;

  my $data = $self->get;

  return CORE::join($delimiter // '', CORE::map $data, 1..($count || 1));
}

sub rshift {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data >> ($arg + 0);
}

sub sin {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::sin($data);
}

sub sqrt {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::sqrt($data);
}

sub sub {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data - ($arg + 0);
}

sub substr {
  my ($self, $offset, $length, $replace) = @_;

  my $data = $self->get;

  if (CORE::defined($replace)) {
    my $result = CORE::substr($data, $offset // 0, $length // 0, $replace);
    return wantarray ? ($result, $data) : $data;
  }
  else {
    my $result = CORE::substr($data, $offset // 0, $length // 0);
    return wantarray ? ($result, $data) : $result;
  }
}

1;
