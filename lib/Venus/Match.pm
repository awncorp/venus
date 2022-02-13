package Venus::Match;

use 5.018;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

with 'Venus::Role::Accessible';

use Scalar::Util ();

# ATTRIBUTES

has 'on_none' => (
  is => 'rw',
  default => sub{sub{}},
);

has 'on_only' => (
  is => 'rw',
  default => sub{sub{1}},
);

has 'on_then' => (
  is => 'rw',
  default => sub {[]},
);

has 'on_when' => (
  is => 'rw',
  default => sub {[]},
);

# METHODS

sub expr {
  my ($self, $topic) = @_;

  $self->when(sub{
    my $value = $self->value;

    if (!defined $value) {
      return 0;
    }
    if (Scalar::Util::blessed($value) && !overload::Overloaded($value)) {
      return 0;
    }
    if (!Scalar::Util::blessed($value) && ref($value)) {
      return 0;
    }
    if (ref($topic) eq 'Regexp' && "$value" =~ qr/$topic/) {
      return 1;
    }
    elsif ("$value" eq "$topic") {
      return 1;
    }
    else {
      return 0;
    }
  });

  return $self;
}

sub just {
  my ($self, $topic) = @_;

  $self->when(sub{
    my $value = $self->value;

    if (!defined $value) {
      return 0;
    }
    if (Scalar::Util::blessed($value) && !overload::Overloaded($value)) {
      return 0;
    }
    if (!Scalar::Util::blessed($value) && ref($value)) {
      return 0;
    }
    if ("$value" eq "$topic") {
      return 1;
    }
    else {
      return 0;
    }
  });

  return $self;
}

sub none {
  my ($self, $code) = @_;

  $self->on_none(UNIVERSAL::isa($code, 'CODE') ? $code : sub{$code});

  return $self;
}

sub only {
  my ($self, $code) = @_;

  $self->on_only($code);

  return $self;
}

sub result {
  my ($self) = @_;

  my $result;
  my $matched = 0;

  my $value = $self->value;

  local $_ = $value;

  return wantarray ? ($result, $matched) : $result if !$self->on_only->($value);

  for (my $i = 0; $i < @{$self->on_when}; $i++) {
    if ($self->on_when->[$i]->($value)) {
      $result = $self->on_then->[$i]->($value);
      $matched++;
      last;
    }
  }

  if (!$matched) {
    local $_ = $value;
    $result = $self->on_none->($value);
  }

  return wantarray ? ($result, $matched) : $result;
}

sub then {
  my ($self, $code) = @_;

  my $next = $#{$self->on_when};

  $self->on_then->[$next] = UNIVERSAL::isa($code, 'CODE') ? $code : sub{$code};

  return $self;
}

sub when {
  my ($self, $code, @args) = @_;

  my $next = (@{$self->on_when}-$#{$self->on_then}) > 1 ? -1 : @{$self->on_when};

  $self->on_when->[$next] = sub {
    local $_ = $self->value;
    $self->value->$code(@args);
  };

  return $self;
}

1;
