package Venus::Opts;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Proxyable';

# ATTRIBUTES

attr 'named';
attr 'parsed';
attr 'specs';
attr 'warns';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    value => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->named({}) if !$self->named;
  $self->parsed({}) if !$self->parsed;
  $self->specs([]) if !$self->specs;
  $self->warns([]) if !$self->warns;

  return $self->parse;
}

sub build_proxy {
  my ($self, $package, $method, $value) = @_;

  my $has_value = exists $_[3];

  return sub {
    return $self->get($method) if !$has_value; # no value
    return $self->set($method, $value);
  };
}

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->array;

  return $assert;
}

sub default {
  my ($self) = @_;

  return [@ARGV];
}

sub exists {
  my ($self, $name) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return CORE::exists $self->parsed->{$pos};
}

sub get {
  my ($self, $name) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return $self->parsed->{$pos};
}

sub parse {
  my ($self, $extras) = @_;

  return $self->parsed if %{$self->parsed};

  my $value = $self->value;
  my $specs = $self->specs;

  my $parsed = {};
  my @configs = qw(default no_auto_abbrev no_ignore_case);

  $extras = [] if !$extras;

  require Getopt::Long;

  my $warns = [];
  local $SIG{__WARN__} = sub {
    push @$warns, map s/\n+$//gr, @_;
    return;
  };

  # configure parser
  Getopt::Long::Configure(Getopt::Long::Configure(@configs, @$extras));

  # parse args using spec
  Getopt::Long::GetOptionsFromArray([@$value], $parsed, @$specs);

  $self->parsed($parsed);
  $self->warns($warns);

  return $self;
}

sub name {
  my ($self, $name) = @_;

  if (defined $self->named->{$name}) {
    return $self->named->{$name};
  }

  if (defined $self->parsed->{$name}) {
    return $name;
  }

  return undef;
}

sub set {
  my ($self, $name, $data) = @_;

  return if not defined $name;

  my $pos = $self->name($name);

  return if not defined $pos;

  return $self->parsed->{$pos} = $data;
}

sub unnamed {
  my ($self) = @_;

  my $list = [];

  my $opts = $self->parsed;
  my $data = +{reverse %{$self->named}};

  for my $index (sort keys %$opts) {
    unless (exists $data->{$index}) {
      push @$list, $opts->{$index};
    }
  }

  return $list;
}

1;
