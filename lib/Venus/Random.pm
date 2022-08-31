package Venus::Random;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';

# STATE

state $ORIG_SEED = srand;
state $SELF_SEED = substr(((time ^ $$) ** 2), 0, length($ORIG_SEED));
srand $ORIG_SEED;

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->reseed($self->value);

  return $self;
}

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->constraints->clear;

  $assert->constraint('number', true);

  return $assert;
}

sub bit {
  my ($self) = @_;

  return $self->select([1, 0]);
}

sub boolean {
  my ($self) = @_;

  return $self->select([true, false]);
}

sub byte {
  my ($self) = @_;

  return chr(int($self->pick * 256));
}

sub character {
  my ($self) = @_;

  my $code = $self->select(['digit', 'letter', 'symbol']);

  return $self->$code;
}

sub collect {
  my ($self, $times, $code, @args) = @_;

  return scalar($self->repeat($times, $code, @args));
}

sub digit {
  my ($self) = @_;

  return int($self->pick(10));
}

sub float {
  my ($self, $place, $from, $upto) = @_;

  $from //= 0;
  $upto //= $self->number;

  my $tmp; $tmp = $from and $from = $upto and $upto = $tmp if $from > $upto;

  $place //= $self->nonzero;

  return sprintf("%.${place}f", $from + rand() * ($upto - $from));
}

sub letter {
  my ($self) = @_;

  my $code = $self->select(['uppercased', 'lowercased']);

  return $self->$code;
}

sub lowercased {
  my ($self) = @_;

  return lc(chr($self->range(97, 122)));
}

sub pick {
  my ($self, $data) = @_;

  return $data ? rand($data) : rand;
}

sub nonzero {
  my ($self, $code, @args) = @_;

  $code ||= 'digit';

  my $value = $self->$code(@args);

  return
    ($value < 0 && $value > -1) ? ($value + -1)
    : (($value < 1 && $value > 0) ? ($value + 1)
    : ($value == 0 ? $self->nonzero : $value));
}

sub number {
  my ($self, $from, $upto) = @_;

  $upto //= 0;
  $from //= $self->digit;

  return $self->range($from, $upto) if $upto;

  return int($self->pick(10 ** ($from > 9 ? 9 : $from) -1));
}

sub range {
  my ($self, $from, $upto) = @_;

  return 0 if !defined $from;
  return 0 if !defined $upto && $from == 0;

  return $from if $from == $upto;

  my $ceil = 2147483647;

  $from = 0 if !$from || $from > $ceil;
  $upto = $ceil if !$upto || $upto > $ceil;

  return $from + int($self->pick(($upto-$from) + 1));
}

sub repeat {
  my ($self, $times, $code, @args) = @_;

  my @values;

  $code ||= 'digit';
  $times ||= 1;

  push @values, $self->$code(@args) for 1..$times;

  return wantarray ? (@values) : join('', @values);
}

sub reseed {
  my ($self, $seed) = @_;

  my $THIS_SEED = !$seed || $seed =~ /\D/ ? $SELF_SEED : $seed;

  $self->value($THIS_SEED);

  srand $THIS_SEED;

  return $self;
}

sub reset {
  my ($self) = @_;

  $self->reseed($SELF_SEED);

  srand $SELF_SEED;

  return $self;
}

sub restore {
  my ($self) = @_;

  $self->reseed($ORIG_SEED);

  srand $ORIG_SEED;

  return $self;
}

sub select {
  my ($self, $data) = @_;

  if (UNIVERSAL::isa($data, 'ARRAY')) {
    my $keys = @$data;
    my $rand = $self->range(0, $keys <= 0 ? 0 : $keys - 1);
    return (@$data)[$rand];
  }

  if (UNIVERSAL::isa($data, 'HASH')) {
    my $keys = keys(%$data);
    my $rand = $self->range(0, $keys <= 0 ? 0 : $keys - 1);
    return $$data{(sort keys %$data)[$rand]};
  }

  return undef;
}

sub symbol {
  my ($self) = @_;

  state $symbols = [split //, q(~!@#$%^&*\(\)-_=+[]{}\|;:'",./<>?)];

  return $self->select($symbols);
}

sub uppercased {
  my ($self) = @_;

  return uc(chr($self->range(97, 122)));
}

1;
