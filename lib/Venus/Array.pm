package Venus::Array;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Value';

with 'Venus::Role::Mappable';

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

  return $failed ? false : true;
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

  return $found ? true : false;
}

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->expression('arrayref');

  return $assert;
}

sub call {
  my ($self, $mapper, $method, @args) = @_;

  require Venus::Type;

  return $self->$mapper(sub{
    my ($key, $val) = @_;

    my $type = Venus::Type->new($val)->deduce;

    local $_ = $type;

    $type->$method(@args)
  });
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

  return $index <= $#{$data} ? true : false;
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

sub get {
  my ($self, @args) = @_;

  return $self->value if !int@args;

  my ($index) = @args;

  return $self->value->[$index];
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

sub head {
  my ($self, $size) = @_;

  my $data = $self->get;

  $size = !$size ? 1 : $size > @$data ? @$data : $size;

  my $index = $size - 1;

  return [@{$data}[0..$index]];
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

sub length {
  my ($self) = @_;

  return $self->count;
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

  return $found ? false : true;
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

  return $found == 1 ? true : false;
}

sub order {
  my ($self, @args) = @_;

  my $data = $self->get;

  my %seen = ();

  @{$data} = (map $data->[$_], grep !$seen{$_}++, (@args), 0..$#{$data});

  return $self;
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

sub range {
  my ($self, @args) = @_;

  return $self->slice(@args) if @args > 1;

  my ($note) = @args;

  return $self->slice if !defined $note;

  my ($f, $l) = split /:/, $note, 2;

  $l = $f if !defined $l;

  my $data = $self->get;

  $f = 0 if !defined $f || $f eq '';
  $l = $#$data if !defined $l || $l eq '';

  return $self->slice((0+$f)..(0+$l));
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

sub set {
  my ($self, @args) = @_;

  return $self->value if !int@args;

  my ($index, $value) = @args;

  return $self->value->[$index] = $value;
}

sub shift {
  my ($self) = @_;

  my $data = $self->get;

  return CORE::shift(@$data);
}

sub shuffle {
  my ($self) = @_;

  my $data = $self->get;
  my $result = [@$data];

  for my $index (0..$#$result) {
    my $other = int(rand(@$result));
    my $stash = $result->[$index];
    $result->[$index] = $result->[$other];
    $result->[$other] = $stash;
  }

  return $result;
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

sub tail {
  my ($self, $size) = @_;

  my $data = $self->get;

  $size = !$size ? 1 : $size > @$data ? @$data : $size;

  my $index = $#$data - ($size - 1);

  return [@{$data}[$index..$#$data]];
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
