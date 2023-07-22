package Venus::Unpack;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Utility';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    args => ref $data eq 'ARRAY' ? $data : [$data],
  };
}

# METHODS

sub all {
  my ($self) = @_;

  $self->use(0..$#{$self->{args}});

  return $self;
}

sub arg {
  my ($self, $name) = @_;

  return $self->{args}->[$name];
}

sub args {
  my ($self, @args) = @_;

  $self->{args} = [@args] if @args;

  return wantarray ? (@{$self->{args}}) : $self->{args};
}

sub array {
  my ($self) = @_;

  require Venus::Array;

  return Venus::Array->new(scalar $self->args);
}

sub cast {
  my ($self, @args) = @_;

  require Venus::Type;

  my $code = sub {
    my ($self, $data, $into) = @_;

    my $type = Venus::Type->new($data);

    return $into ? $type->cast($into) : $type->deduce;
  };

  return $self->list('foreach', $code, @args);
}

sub checks {
  my ($self, @args) = @_;

  require Venus::Assert;

  my $code = sub {
    my ($self, $data, $expr, $index) = @_;

    my $name = 'argument #' . ($index + 1);
    return scalar Venus::Assert->new($name)->expression($expr)->check($data);
  };

  return $self->list('foreach', $code, @args);
}

sub copy {
  my ($self, @args) = @_;

  for (my $i = 0; $i < @args; $i += 2) {
    my $name = $args[$i];
    my $attr = $args[$i+1];
    $self->can($attr)
      ? $self->$attr($self->get($name))
      : ($self->{$attr} = $self->get($name));
  }

  return $self;
}

sub first {
  my ($self) = @_;

  $self->use(0) if @{$self->{args}};

  return $self;
}

sub foreach {
  my ($self, $code, @args) = @_;

  my $results = [];

  return $results if !$code;

  for my $name (0..$#{$self->{uses}}) {
    my $data = $self->get($self->{uses}->[$name]);
    my $args = $name > $#args ? $args[-1] : $args[$name];
    push @$results, $self->$code($data, $args, $name);
  }

  return $results;
}

sub from {
  my ($self, $data) = @_;

  $self = $self->new if !ref $self;

  $self->{from} = ref $data || $data if $data;

  return $self;
}

sub get {
  my ($self, $name) = @_;

  return if !defined $name;

  return $self->{args}->[$name];
}

sub into {
  my ($self, @args) = @_;

  require Venus::Space;

  my $code = sub {
    my ($self, $data, $name) = @_;

    return $data if UNIVERSAL::isa($data, $name);
    return Venus::Space->new($name)->load->new($data);
  };

  return $self->list('foreach', $code, @args);
}

sub last {
  my ($self) = @_;

  $self->use($#{$self->{args}}) if @{$self->{args}};

  return $self;
}

sub list {
  my ($self, $code, @args) = @_;

  my $results = $self->$code(@args);

  return wantarray ? (ref $results eq 'ARRAY' ? @$results : $results) : $results;
}

sub move {
  my ($self, @args) = @_;

  my %seen;
  for (my $i = 0; $i < @args; $i += 2) {
    $seen{$args[$i]}++;
    my $name = $args[$i];
    my $attr = $args[$i+1];
    $self->can($attr)
      ? $self->$attr($self->get($name))
      : ($self->{$attr} = $self->get($name));
  }

  $self->{args} = [map $self->{args}[$_], grep !$seen{$_}++, 0..$#{$self->{args}}];

  return $self;
}

sub name {
  my ($self, $data) = @_;

  $self->{name} = $data if $data;

  return $self;
}

sub one {
  my ($self, $code, @args) = @_;

  my $results = $self->$code(@args);

  return $results->[0];
}

sub reset {
  my ($self, @args) = @_;

  $self->{args} = [@args] if @args;
  $self->{uses} = [];

  return $self;
}

sub set {
  my ($self, @args) = @_;

  return $self->{args} if !@args;

  return $self->{args} = $args[0] if @args == 1 && ref $args[0] eq 'HASH';

  my ($index, $value) = @args;

  return if not defined $index;

  return $self->{args}->[$index] = $value;
}

sub signature {
  my ($self, @args) = @_;

  require Venus::Assert;

  my (@frame_0) = ((caller(0))[0..3]);
  my (@frame_1) = ((caller(1))[0..3]);

  my $file = $frame_0[1];
  my $line = $frame_0[2];
  my $package = $self->{from} || $frame_0[0];
  my $routine = $self->{name} || $frame_1[3];
  my $from = $self->{from};
  my $name = $self->{name};

  $routine = $routine ? qq{"@{[(split /::/, $routine)[-1]]}"} : '(undefined)';

  my $code = sub {
    my ($self, $data, $expr, $index) = @_;

    my @name;
    my $number = $index + 1;

    push @name, "argument #$number for signature";
    push @name, $name ? "\"$name\"" : $routine;
    push @name, $from ? "from \"$from\"" : "in package \"$package\"";
    push @name, $file =~ /\(eval\s*\d*\)/
      ? "in (eval)" : "in file \"$file\" at line $line";

    return scalar Venus::Assert->new(join ' ', @name)->expression($expr)->validate(
      $data
    );
  };

  return $self->list('foreach', $code, @args);
}

sub types {
  my ($self, @args) = @_;

  $self->validate(@args);

  return $self;
}

sub use {
  my ($self, @args) = @_;

  $self->{uses} = [map 0+$_, @args];

  return $self;
}

sub validate {
  my ($self, @args) = @_;

  require Venus::Assert;

  my $code = sub {
    my ($self, $data, $expr, $index) = @_;

    my $name = 'argument #' . ($index + 1);
    return scalar Venus::Assert->new($name)->expression($expr)->validate($data);
  };

  return $self->list('foreach', $code, @args);
}

1;
