package Venus::Hash;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Value';

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

# MODIFIERS

around get => sub {
  my ($orig, $self, @args) = @_;

  return $self->$orig if $#_ < 2;

  my ($index) = @args;

  return $self->value->{$index};
};

around set => sub {
  my ($orig, $self, @args) = @_;

  return $self->$orig(@args) if $#_ < 3;

  my ($index, $value) = @args;

  return $self->value->{$index} = $value;
};

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

  return $failed ? 0 : 1;
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

  return $found ? 1 : 0;
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

  return CORE::exists($data->{$key}) ? 1 : 0;
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

sub list {
  my ($self) = @_;

  return (%{$self->value});
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
  my ($self, $lvalue, @rvalue) = @_;

  if (!$lvalue) {
    return $self->get;
  }

  if (!@rvalue) {
    @rvalue = ($lvalue);
    $lvalue = $self->get;
  }

  if (@rvalue > 1) {
    @rvalue = ($lvalue, @rvalue);
    $lvalue = $self->get;
  }

  my $result = {%{$lvalue}};

  for my $rvalue (@rvalue) {
    for my $index (CORE::keys(%$rvalue)) {
      my $lprop = $$lvalue{$index};
      my $rprop = $$rvalue{$index};

      $result->{$index}
        = ((ref($rprop) eq 'HASH') and (ref($lprop) eq 'HASH'))
        ? merge($self, $lprop, $rprop)
        : $rprop;
    }
  }

  if (!$self->{merge}++) {
    $result = merge($self, $self->get, $result);
    CORE::delete($self->{merge});
  }

  return $result;
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

  return $found ? 0 : 1;
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

  return $found == 1 ? 1 : 0;
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

sub slice {
  my ($self, @args) = @_;

  my $data = $self->get;

  return [@{$data}{@args}];
}

1;
