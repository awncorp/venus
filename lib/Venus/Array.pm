package Venus::Array;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

with 'Venus::Role::Mappable';

# MODIFIERS

around get => sub {
  my ($orig, $self, @args) = @_;

  return $self->$orig if $#_ < 2;

  my ($index) = @args;

  return $self->value->[$index];
};

around set => sub {
  my ($orig, $self, @args) = @_;

  return $self->$orig(@args) if $#_ < 3;

  my ($index, $value) = @args;

  return $self->value->[$index] = $value;
};

# METHODS

sub all {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $failed = 0;

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    $failed++ if !$code->($index, $value);

    CORE::last if $failed;
  }

  return $failed ? 0 : 1;
}

sub any {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $found = 0;

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    $found++ if $code->($index, $value);

    CORE::last if $found;
  }

  return $found ? 1 : 0;
}

sub count {
  my ($self) = @_;

  my $data = $self->get;

  return scalar(@$data);
}

sub default {
  return [];
}

sub delete {
  my ($self, $index) = @_;

  my $data = $self->get;

  return CORE::delete($data->[$index]);
}

sub each {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $result = [];

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    CORE::push(@$result, $code->($index, $value));
  }

  return wantarray ? (@$result) : $result;
}

sub empty {
  my ($self) = @_;

  my $data = $self->get;

  $#$data = -1;

  return $self;
}

sub exists {
  my ($self, $index) = @_;

  my $data = $self->get;

  return $index <= $#{$data} ? 1 : 0;
}

sub find {
  my ($self, @args) = @_;

  my $seen = 0;
  my $item = my $data = $self->get;

  for (my $i = 0; $i < @args; $i++) {
    if (ref($item) eq 'ARRAY') {
      if ($args[$i] !~ /^\d+$/) {
        $item = undef;
        $seen = 0;
        CORE::last;
      }
      $seen = $args[$i] <= $#{$item};
      $item = $item->[$args[$i]];
    }
    elsif (ref($item) eq 'HASH') {
      $seen = exists $item->{$args[$i]};
      $item = $item->{$args[$i]};
    }
    else {
      $item = undef;
      $seen = 0;
    }
  }

  return wantarray ? ($item, int(!!$seen)) : $item;
}

sub first {
  my ($self) = @_;

  return $self->get->[0];
}

sub grep {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $result = [];

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    CORE::push(@$result, $value) if $code->($index, $value);
  }

  return wantarray ? (@$result) : $result;
}

sub iterator {
  my ($self) = @_;

  my $data = $self->get;

  my $i = 0;
  my $j = 0;

  return sub {
    return undef if $i > $#{$data};
    return wantarray ? ($j++, $data->[$i++]) : $data->[$i++];
  }
}

sub join {
  my ($self, $delimiter) = @_;

  my $data = $self->get;

  return CORE::join($delimiter // '', @$data);
}

sub keyed {
  my ($self, @keys) = @_;

  my $data = $self->get;

  my $i = 0;
  return {map { $_ => $data->[$i++] } @keys};
}

sub keys {
  my ($self) = @_;

  my $data = $self->get;

  return [0..$#{$data}];
}

sub last {
  my ($self) = @_;

  return $self->value->[-1];
}

sub list {
  my ($self) = @_;

  return wantarray ? (@{$self->value}) : scalar(@{$self->value});
}

sub map {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $result = [];

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    CORE::push(@$result, $code->($index, $value));
  }

  return wantarray ? (@$result) : $result;
}

sub none {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $found = 0;

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    $found++ if $code->($index, $value);

    CORE::last if $found;
  }

  return $found ? 0 : 1;
}

sub one {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $found = 0;

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];

    local $_ = $value;
    $found++ if $code->($index, $value);

    CORE::last if $found > 1;
  }

  return $found == 1 ? 1 : 0;
}

sub pairs {
  my ($self) = @_;

  my $data = $self->get;

  my $i = 0;
  my $result = [map +[$i++, $_], @$data];

  return wantarray ? (@$result) : $result;
}

sub path {
  my ($self, $path) = @_;

  my @path = CORE::grep(/./, CORE::split(/\W/, $path));

  return wantarray ? ($self->find(@path)) : $self->find(@path);
}

sub part {
  my ($self, $code) = @_;

  my $data = $self->get;

  my $results = [[], []];

  for (my $i = 0; $i < @$data; $i++) {
    my $index = $i;
    my $value = $data->[$i];
    local $_ = $value;
    my $result = $code->($index, $value);
    my $slot = $result ? $$results[0] : $$results[1];

    CORE::push(@$slot, $value);
  }

  return wantarray ? (@$results) : $results;
}

sub pop {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::pop(@$data);
}

sub push {
  my ($self, @args) = @_;

  my $data = $self->get;

  CORE::push(@$data, @args);

  return $data;
}

sub random {
  my ($self) = @_;

  my $data = $self->get;

  return @$data[rand($#{$data}+1)];
}

sub reverse {
  my ($self) = @_;

  my $data = $self->get;

  return [CORE::reverse(@$data)];
}

sub rotate {
  my ($self) = @_;

  my $data = $self->get;

  CORE::push(@$data, CORE::shift(@$data));

  return $data;
}

sub rsort {
  my ($self) = @_;

  my $data = $self->get;

  return [CORE::sort { $b cmp $a } @$data];
}

sub shift {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::shift(@$data);
}

sub slice {
  my ($self, @args) = @_;

  my $data = $self->get;

  return [@$data[@args]];
}

sub sort {
  my ($self) = @_;

  my $data = $self->get;

  return [CORE::sort { $a cmp $b } @$data];
}

sub unique {
  my ($self) = @_;

  my $data = $self->get;

  my %seen;
  return [CORE::grep { not $seen{$_}++ } @$data];
}

sub unshift {
  my ($self, @args) = @_;

  my $data = $self->get;

  CORE::unshift(@$data, @args);

  return $data;
}

1;
