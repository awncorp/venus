package Venus::Number;

use 5.018;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

use overload (
  '!' => sub{!$_[0]->get},
  '!=' => sub{$_[0]->get != ($_[1] + 0)},
  '%' => sub{$_[0]->get % ($_[1] + 0)},
  '*' => sub{$_[0]->get * ($_[1] + 0)},
  '+' => sub{$_[0]->get + ($_[1] + 0)},
  '-' => sub{$_[0]->get - ($_[1] + 0)},
  '.' => sub{$_[0]->get . ($_[1] + 0)},
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
);

# METHODS

sub abs {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::abs($data);
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

sub int {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::int($data);
}

sub log {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::log($data);
}

sub mod {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return $data % ($arg + 0);
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

sub range {
  my ($self, $arg) = @_;

  my $data = $self->get;

  return [
    ($data > ($arg + 0)) ? CORE::reverse(($arg + 0)..$data) : ($data..($arg + 0))
  ];
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

1;
