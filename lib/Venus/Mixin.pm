package Venus::Mixin;

use 5.018;

use strict;
use warnings;

# IMPORT

sub import {
  my ($self, @args) = @_;

  my $from = caller;

  require Venus::Core::Mixin;

  no strict 'refs';
  no warnings 'redefine';
  no warnings 'once';

  @args = grep defined && !ref && /^[A-Za-z]/, @args;

  my %exports = map +($_,$_), @args ? @args : qw(
    attr
    base
    false
    from
    mixin
    role
    test
    true
    with
  );

  @{"${from}::ISA"} = 'Venus::Core::Mixin';

  if ($exports{"attr"} && !*{"${from}::attr"}{"CODE"}) {
    *{"${from}::attr"} = sub {@_ = ($from, @_); goto \&attr};
  }
  if ($exports{"base"} && !*{"${from}::base"}{"CODE"}) {
    *{"${from}::base"} = sub {@_ = ($from, @_); goto \&base};
  }
  if ($exports{"catch"} && !*{"${from}::catch"}{"CODE"}) {
    *{"${from}::catch"} = sub (&) {require Venus; goto \&Venus::catch};
  }
  if ($exports{"error"} && !*{"${from}::error"}{"CODE"}) {
    *{"${from}::error"} = sub (;$) {require Venus; goto \&Venus::error};
  }
  if (!*{"${from}::false"}{"CODE"}) {
    *{"${from}::false"} = sub {require Venus; Venus::false()};
  }
  if ($exports{"from"} && !*{"${from}::from"}{"CODE"}) {
    *{"${from}::from"} = sub {@_ = ($from, @_); goto \&from};
  }
  if ($exports{"raise"} && !*{"${from}::raise"}{"CODE"}) {
    *{"${from}::raise"} = sub ($;$) {require Venus; goto \&Venus::raise};
  }
  if ($exports{"mixin"} && !*{"${from}::mixin"}{"CODE"}) {
    *{"${from}::mixin"} = sub {@_ = ($from, @_); goto \&mixin};
  }
  if ($exports{"role"} && !*{"${from}::role"}{"CODE"}) {
    *{"${from}::role"} = sub {@_ = ($from, @_); goto \&role};
  }
  if ($exports{"test"} && !*{"${from}::test"}{"CODE"}) {
    *{"${from}::test"} = sub {@_ = ($from, @_); goto \&test};
  }
  if (!*{"${from}::true"}{"CODE"}) {
    *{"${from}::true"} = sub {require Venus; Venus::true()};
  }
  if ($exports{"with"} && !*{"${from}::with"}{"CODE"}) {
    *{"${from}::with"} = sub {@_ = ($from, @_); goto \&test};
  }

  ${"${from}::META"} = {};

  return $self;
}

sub attr {
  my ($from, @args) = @_;

  $from->ATTR(@args);

  return $from;
}

sub base {
  my ($from, @args) = @_;

  $from->BASE(@args);

  return $from;
}

sub from {
  my ($from, @args) = @_;

  $from->FROM(@args);

  return $from;
}

sub mixin {
  my ($from, @args) = @_;

  $from->MIXIN(@args);

  return $from;
}

sub role {
  my ($from, @args) = @_;

  $from->ROLE(@args);

  return $from;
}

sub test {
  my ($from, @args) = @_;

  $from->TEST(@args);

  return $from;
}

1;
