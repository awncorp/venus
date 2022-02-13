package Venus::Role;

use 5.018;

use strict;
use warnings;

# IMPORT

sub import {
  my ($class, @args) = @_;

  my $target = caller;

  require Moo;

  die $@ if not eval "package $target; use Moo::Role; use Venus; 1";

  my $has = $target->can('has') or return;

  no strict 'refs';
  no warnings 'redefine';

  *{"${target}::base"} = *{"${target}::extends"} if !$target->can('base');
  *{"${target}::has"} = generate([$class, $target], $has);

  return;
}

# FUNCTIONS

my $wrappers = {
};

sub generate {
  my ($info, $orig) = @_;

  return sub { @_ = options($info, @_); goto $orig };
}

sub options {
  my ($info, $name, %opts) = @_;

  %opts = (is => 'rw') unless %opts;

  $opts{mod} = 1 if $name =~ s/^\+//;

  %opts = (%opts, $wrappers->{new}->($info, $name, %opts)) if defined $opts{new};
  %opts = (%opts, $wrappers->{bld}->($info, $name, %opts)) if defined $opts{bld};
  %opts = (%opts, $wrappers->{clr}->($info, $name, %opts)) if defined $opts{clr};
  %opts = (%opts, $wrappers->{crc}->($info, $name, %opts)) if defined $opts{crc};
  %opts = (%opts, $wrappers->{def}->($info, $name, %opts)) if defined $opts{def};
  %opts = (%opts, $wrappers->{hnd}->($info, $name, %opts)) if defined $opts{hnd};
  %opts = (%opts, $wrappers->{isa}->($info, $name, %opts)) if defined $opts{isa};
  %opts = (%opts, $wrappers->{lzy}->($info, $name, %opts)) if defined $opts{lzy};
  %opts = (%opts, $wrappers->{opt}->($info, $name, %opts)) if defined $opts{opt};
  %opts = (%opts, $wrappers->{pre}->($info, $name, %opts)) if defined $opts{pre};
  %opts = (%opts, $wrappers->{rdr}->($info, $name, %opts)) if defined $opts{rdr};
  %opts = (%opts, $wrappers->{req}->($info, $name, %opts)) if defined $opts{req};
  %opts = (%opts, $wrappers->{tgr}->($info, $name, %opts)) if defined $opts{tgr};
  %opts = (%opts, $wrappers->{use}->($info, $name, %opts)) if defined $opts{use};
  %opts = (%opts, $wrappers->{wkr}->($info, $name, %opts)) if defined $opts{wkr};
  %opts = (%opts, $wrappers->{wrt}->($info, $name, %opts)) if defined $opts{wrt};

  $name = "+$name" if delete $opts{mod} || delete $opts{modify};

  return ($name, %opts);
}

$wrappers->{new} = sub {
  my ($info, $name, %opts) = @_;

  if (delete $opts{new}) {
    $opts{builder} = "new_${name}";
    $opts{lazy} = 1;
  }

  return (%opts);
};

$wrappers->{bld} = sub {
  my ($info, $name, %opts) = @_;

  $opts{builder} = delete $opts{bld};

  return (%opts);
};

$wrappers->{clr} = sub {
  my ($info, $name, %opts) = @_;

  $opts{clearer} = delete $opts{clr};

  return (%opts);
};

$wrappers->{crc} = sub {
  my ($info, $name, %opts) = @_;

  $opts{coerce} = delete $opts{crc};

  return (%opts);
};

$wrappers->{def} = sub {
  my ($info, $name, %opts) = @_;

  $opts{default} = delete $opts{def};

  return (%opts);
};

$wrappers->{hnd} = sub {
  my ($info, $name, %opts) = @_;

  $opts{handles} = delete $opts{hnd};

  return (%opts);
};

$wrappers->{isa} = sub {
  my ($info, $name, %opts) = @_;

  return (%opts) if ref($opts{isa});

  die $@ if not eval "require registry; 1";

  my $registry = registry::access($info->[1]);

  return (%opts) if !$registry;

  my $constraint = $registry->lookup($opts{isa});

  return (%opts) if !$constraint;

  $opts{isa} = $constraint;

  return (%opts);
};

$wrappers->{lzy} = sub {
  my ($info, $name, %opts) = @_;

  $opts{lazy} = delete $opts{lzy};

  return (%opts);
};

$wrappers->{opt} = sub {
  my ($info, $name, %opts) = @_;

  delete $opts{opt};

  $opts{required} = 0;

  return (%opts);
};

$wrappers->{pre} = sub {
  my ($info, $name, %opts) = @_;

  $opts{predicate} = delete $opts{pre};

  return (%opts);
};

$wrappers->{rdr} = sub {
  my ($info, $name, %opts) = @_;

  $opts{reader} = delete $opts{rdr};

  return (%opts);
};

$wrappers->{req} = sub {
  my ($info, $name, %opts) = @_;

  delete $opts{req};

  $opts{required} = 1;

  return (%opts);
};

$wrappers->{tgr} = sub {
  my ($info, $name, %opts) = @_;

  $opts{trigger} = delete $opts{tgr};

  return (%opts);
};

$wrappers->{use} = sub {
  my ($info, $name, %opts) = @_;

  if (my $use = delete $opts{use}) {
    $opts{builder} = $wrappers->{use_builder}->($info, $name, @$use);
    $opts{lazy} = 1;
  }

  return (%opts);
};

$wrappers->{use_builder} = sub {
  my ($info, $name, $sub, @args) = @_;

  return sub {
    my ($self) = @_;

    my $point = $self->can($sub);
    die "$name cannot 'use' method '$sub' via @{[$info->[1]]}" if !$point;

    @_ = ($self, @args);

    goto $point;
  };
};

$wrappers->{wkr} = sub {
  my ($info, $name, %opts) = @_;

  $opts{weak_ref} = delete $opts{wkr};

  return (%opts);
};

$wrappers->{wrt} = sub {
  my ($info, $name, %opts) = @_;

  $opts{writer} = delete $opts{wrt};

  return (%opts);
};

1;
