package Venus::Role::Printable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'fault';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Dumpable')) {
    fault "${self} requires ${from} to consume Venus::Role::Dumpable";
  }

  return $self;
}

# METHODS

sub print {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args));
}

sub print_json {
  my ($self, $method, @args) = @_;

  require Venus::Json;

  my $value = $method ? scalar($self->$method(@args)) : $self;

  require Scalar::Util;

  if (Scalar::Util::blessed($value)) {
    $value = $value->value if $value->isa('Venus::Kind');
  }

  return $self->printer(Venus::Json->new($value)->encode);
}

sub print_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args));
}

sub print_string {
  my ($self, $method, @args) = @_;

  local $_ = $self;

  return $self->printer($method ? scalar($self->$method(@args)) : $self);
}

sub print_yaml {
  my ($self, $method, @args) = @_;

  require Venus::Yaml;

  my $value = $method ? scalar($self->$method(@args)) : $self;

  require Scalar::Util;

  if (Scalar::Util::blessed($value)) {
    $value = $value->value if $value->isa('Venus::Kind');
  }

  return $self->printer(Venus::Yaml->new($value)->encode);
}

sub printer {
  my ($self, @args) = @_;

  return CORE::print(STDOUT @args);
}

sub say {
  my ($self, @args) = @_;

  return $self->printer($self->dump(@args), "\n");
}

sub say_json {
  my ($self, $method, @args) = @_;

  require Venus::Json;

  my $value = $method ? scalar($self->$method(@args)) : $self;

  require Scalar::Util;

  if (Scalar::Util::blessed($value)) {
    $value = $value->value if $value->isa('Venus::Kind');
  }

  return $self->printer(Venus::Json->new($value)->encode, "\n");
}

sub say_pretty {
  my ($self, @args) = @_;

  return $self->printer($self->dump_pretty(@args), "\n");
}

sub say_string {
  my ($self, $method, @args) = @_;

  local $_ = $self;

  return $self->printer(($method ? scalar($self->$method(@args)) : $self), "\n");
}

sub say_yaml {
  my ($self, $method, @args) = @_;

  require Venus::Yaml;

  my $value = $method ? scalar($self->$method(@args)) : $self;

  require Scalar::Util;

  if (Scalar::Util::blessed($value)) {
    $value = $value->value if $value->isa('Venus::Kind');
  }

  return $self->printer(Venus::Yaml->new($value)->encode, "\n");
}

# EXPORTS

sub EXPORT {
  [
    'print',
    'print_json',
    'print_pretty',
    'print_string',
    'print_yaml',
    'printer',
    'say',
    'say_json',
    'say_pretty',
    'say_string',
    'say_yaml',
  ]
}

1;
