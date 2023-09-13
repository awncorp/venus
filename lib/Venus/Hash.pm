package Venus::Hash;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Value';

with 'Venus::Role::Mappable';

# BUILDERS

sub build_args {
  my ($self, $data) = @_;

  if (keys %$data == 1 && exists $data->{value}) {
    return $data;
  }
  return {
    value => $data
  };
}

# METHODS

sub all {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $failed = 0;

  for my $index (CORE::keys %$data) {
    my $value = $data->{$index};

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

  for my $index (CORE::keys %$data) {
    my $value = $data->{$index};

    local $_ = $value;
    $found++ if $code->($index, $value);

    CORE::last if $found;
  }

  return $found ? true : false;
}

sub call {
  my ($self, $mapper, $method, @args) = @_;

  require Venus::Type;

  return $self->$mapper(sub{
    my ($key, $val) = @_;

    my $type = Venus::Type->new($val)->deduce;

    local $_ = $type;

    $key, $type->$method(@args)
  });
}

sub count {
  my ($self) = @_;

  my $data = $self->get;

  return scalar(CORE::keys(%$data));
}

sub default {
  return {};
}

sub delete {
  my ($self, $key) = @_;

  my $data = $self->get;

  return CORE::delete($data->{$key});
}

sub each {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $results = [];

  for my $index (CORE::sort(CORE::keys(%$data))) {
    my $value = $data->{$index};

    local $_ = $value;
    CORE::push(@$results, $code->($index, $value));
  }

  return wantarray ? (@$results) : $results;
}

sub empty {
  my ($self) = @_;

  my $data = $self->get;

  CORE::delete(@$data{CORE::keys(%$data)});

  return $data;
}

sub exists {
  my ($self, $key) = @_;

  my $data = $self->get;

  return CORE::exists($data->{$key}) ? true : false;
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

sub get {
  my ($self, @args) = @_;

  return $self->value if !@args;

  my ($index) = @args;

  return $self->value->{$index};
}

sub grep {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $result = [];

  for my $index (CORE::sort(CORE::keys(%$data))) {
    my $value = $data->{$index};

    local $_ = $value;
    CORE::push(@$result, $index, $value) if $code->($index, $value);
  }

  return wantarray ? (@$result) : $result;
}

sub iterator {
  my ($self) = @_;

  my $data = $self->get;
  my @keys = CORE::sort(CORE::keys(%{$data}));

  my $i = 0;
  my $j = 0;

  return sub {
    return undef if $i > $#keys;
    return wantarray ? ($keys[$j++], $data->{$keys[$i++]}) : $data->{$keys[$i++]};
  }
}

sub keys {
  my ($self) = @_;

  my $data = $self->get;

  return [CORE::sort(CORE::keys(%$data))];
}

sub length {
  my ($self) = @_;

  return $self->count;
}

sub list {
  my ($self) = @_;

  return wantarray ? (%{$self->value}) : scalar(CORE::keys(%{$self->value}));
}

sub map {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $result = [];

  for my $index (CORE::sort(CORE::keys(%$data))) {
    my $value = $data->{$index};

    local $_ = $value;
    CORE::push(@$result, ($code->($index, $value)));
  }

  return wantarray ? (@$result) : $result;
}

sub merge {
  my ($self, @rvalues) = @_;

  require Venus;

  my $lvalue = {%{$self->get}};

  return Venus::merge($lvalue, @rvalues);
}

sub none {
  my ($self, $code) = @_;

  my $data = $self->get;

  $code = sub{} if !$code;

  my $found = 0;

  for my $index (CORE::sort(CORE::keys(%$data))) {
    my $value = $data->{$index};

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

  for my $index (CORE::sort(CORE::keys(%$data))) {
    my $value = $data->{$index};

    local $_ = $value;
    $found++ if $code->($index, $value);

    CORE::last if $found > 1;
  }

  return $found == 1 ? true : false;
}

sub pairs {
  my ($self) = @_;

  my $data = $self->get;

  my $result = [CORE::map { [$_, $data->{$_}] } CORE::sort(CORE::keys(%$data))];

  return wantarray ? (@$result) : $result;
}

sub path {
  my ($self, $path) = @_;

  my @path = CORE::grep(/./, CORE::split(/\W/, $path));

  return wantarray ? ($self->find(@path)) : $self->find(@path);
}

sub puts {
  my ($self, @args) = @_;

  my $result = [];

  require Venus::Array;

  for (my $i = 0; $i < @args; $i += 2) {
    my ($into, $path) = @args[$i, $i+1];

    next if !defined $path;

    my $value;
    my @range;

    ($path, @range) = @{$path} if ref $path eq 'ARRAY';

    $value = $self->path($path);
    $value = Venus::Array->new($value)->range(@range) if ref $value eq 'ARRAY';

    if (ref $into eq 'SCALAR') {
      $$into = $value;
    }

    CORE::push @{$result}, $value;
  }

  return wantarray ? (@{$result}) : $result;
}

sub random {
  my ($self) = @_;

  my $data = $self->get;
  my $keys = [CORE::keys(%$data)];

  return $data->{@$keys[rand($#{$keys}+1)]};
}

sub reset {
  my ($self) = @_;

  my $data = $self->get;

  @$data{CORE::keys(%$data)} = ();

  return $data;
}

sub reverse {
  my ($self) = @_;

  my $data = $self->get;

  my $result = {};

  for (CORE::grep(CORE::defined($data->{$_}), CORE::sort(CORE::keys(%$data)))) {
    $result->{$_} = $data->{$_};
  }

  return {CORE::reverse(%$result)};
}

sub set {
  my ($self, @args) = @_;

  return $self->value if !@args;

  return $self->value(@args) if @args == 1 && ref $args[0] eq 'HASH';

  my ($index, $value) = @args;

  return if not defined $index;

  return $self->value->{$index} = $value;
}

sub slice {
  my ($self, @args) = @_;

  my $data = $self->get;

  return [@{$data}{@args}];
}

1;
