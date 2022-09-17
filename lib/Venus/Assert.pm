package Venus::Assert;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

use Venus::Match;
use Venus::Type;

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

use overload (
  '&{}' => sub{$_[0]->validator},
  fallback => 1,
);

# ATTRIBUTES

attr 'message';
attr 'name';

# BUILDERS

sub build_arg {
  my ($self, $name) = @_;

  return {
    name => $name,
  };
}

sub build_self {
  my ($self, $data) = @_;

  my $name = 'Unknown';
  my $message = 'Type assertion (%s) failed: received (%s)';

  $self->name($name) if !$self->name;
  $self->message($message) if !$self->message;
  $self->conditions;

  return $self;
}

# METHODS

sub any {
  my ($self) = @_;

  $self->constraints->when(sub{true})->then(sub{true});

  return $self;
}

sub accept {
  my ($self, $name, @args) = @_;

  if (!$name) {
    return $self;
  }
  if ($self->can($name)) {
    return $self->$name(@args);
  }
  else {
    return $self->identity($name, @args);
  }
}

sub array {
  my ($self, @code) = @_;

  $self->constraint('array', @code ? @code : sub{true});

  return $self;
}

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->string;

  return $assert;
}

sub boolean {
  my ($self, @code) = @_;

  $self->constraint('boolean', @code ? @code : sub{true});

  return $self;
}

sub check {
  my ($self, $data) = @_;

  my $value = Venus::Type->new(value => $data);

  my @args = (value => $value, on_none => sub{false});

  return $self->constraints->renew(@args)->result;
}

sub clear {
  my ($self) = @_;

  $self->constraints->clear;
  $self->coercions->clear;

  return $self;
}

sub code {
  my ($self, @code) = @_;

  $self->constraint('code', @code ? @code : sub{true});

  return $self;
}

sub coerce {
  my ($self, $data) = @_;

  my $value = Venus::Type->new(value => $data);

  my @args = (value => $value, on_none => sub{$data});

  return $self->coercions->renew(@args)->result;
}

sub coercion {
  my ($self, $type, $code) = @_;

  $self->coercions->when('coded', $type)->then($code);

  return $self;
}

sub coercions {
  my ($self) = @_;

  my $match = Venus::Match->new;

  return $self->{coercions} ||= $match if ref $self;

  return $match;
}

sub conditions {
  my ($self) = @_;

  return $self;
}

sub constraint {
  my ($self, $type, $code) = @_;

  $self->constraints->when('coded', $type)->then($code);

  return $self;
}

sub constraints {
  my ($self) = @_;

  my $match = Venus::Match->new;

  return $self->{constraints} ||= $match if ref $self;

  return $match;
}

sub consumes {
  my ($self, $role) = @_;

  my $where = $self->constraint('object', sub{true})->constraints->where;

  $where->when(sub{$_->value->DOES($role)})->then(sub{true});

  return $self;
}

sub defined {
  my ($self, @code) = @_;

  $self->constraints->when(sub{CORE::defined($_->value)})
    ->then(@code ? @code : sub{true});

  return $self;
}

sub enum {
  my ($self, @data) = @_;

  for my $item (@data) {
    $self->constraints->when(sub{$_->value eq $item})->then(sub{true});
  }

  return $self;
}

sub float {
  my ($self, @code) = @_;

  $self->constraint('float', @code ? @code : sub{true});

  return $self;
}

sub format {
  my ($self, $name, @code) = @_;

  if (!$name) {
    return $self;
  }
  if (lc($name) eq 'array') {
    return $self->coercion('array', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'boolean') {
    return $self->coercion('boolean', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'code') {
    return $self->coercion('code', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'float') {
    return $self->coercion('float', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'hash') {
    return $self->coercion('hash', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'number') {
    return $self->coercion('number', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'object') {
    return $self->coercion('object', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'regexp') {
    return $self->coercion('regexp', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'scalar') {
    return $self->coercion('scalar', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'string') {
    return $self->coercion('string', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'undef') {
    return $self->coercion('undef', @code ? (@code) : sub{$_->value});
  }
  else {
    return $self->coercion('object', sub {
      UNIVERSAL::isa($_->value, $name)
        ? (@code ? $code[0]->($_->value) : $_->value)
        : $_->value;
    });
  }
}

sub hash {
  my ($self, @code) = @_;

  $self->constraint('hash', @code ? @code : sub{true});

  return $self;
}

sub identity {
  my ($self, $name) = @_;

  $self->constraint('object', sub {$_->value->isa($name) ? true : false});

  return $self;
}

sub maybe {
  my ($self, $match, @args) = @_;

  $self->$match(@args) if $match;
  $self->undef;

  return $self;
}

sub number {
  my ($self, @code) = @_;

  $self->constraint('number', @code ? @code : sub{true});

  return $self;
}

sub object {
  my ($self, @code) = @_;

  $self->constraint('object', @code ? @code : sub{true});

  return $self;
}

sub package {
  my ($self) = @_;

  my $where = $self->constraint('string', sub{true})->constraints->where;

  $where->when(sub{$_->value =~ /^[A-Z](?:(?:\w|::)*[a-zA-Z0-9])?$/})->then(sub{
    require Venus::Space;

    Venus::Space->new($_->value)->loaded
  });

  return $self;
}

sub reference {
  my ($self, @code) = @_;

  $self->constraints
    ->when(sub{CORE::defined($_->value) && ref($_->value)})
    ->then(@code ? @code : sub{true});

  return $self;
}

sub regexp {
  my ($self, @code) = @_;

  $self->constraint('regexp', @code ? @code : sub{true});

  return $self;
}

sub routines {
  my ($self, @data) = @_;

  $self->object->constraints->then(sub{
    my $value = $_->value;
    (@data == grep $value->can($_), @data) ? true : false
  });

  return $self;
}

sub scalar {
  my ($self, @code) = @_;

  $self->constraint('scalar', @code ? @code : sub{true});

  return $self;
}

sub string {
  my ($self, @code) = @_;

  $self->constraint('string', @code ? @code : sub{true});

  return $self;
}

sub tuple {
  my ($self, @data) = @_;

  $self->array->constraints->then(sub{
    my $check = 0;
    my $value = $_->value;
    return false if @data != @$value;
    for (my $i = 0; $i < @data; $i++) {
      my ($match, @args) = (ref $data[$i]) ? (@{$data[$i]}) : ($data[$i]);
      $check++ if $self->new->$match(@args)->check($value->[$i]);
    }
    (@data == $check) ? true : false
  });

  return $self;
}

sub undef {
  my ($self, @code) = @_;

  $self->constraint('undef', @code ? @code : sub{true});

  return $self;
}

sub validate {
  my ($self, $data) = @_;

  my $valid = $self->check($data);

  return $data if $valid;

  require Scalar::Util;

  my $received = defined $data
    ? (
    ref $data
    ? "$data"
    : (Scalar::Util::looks_like_number($data) ? $data : "'$data'"))
    : "undef";

  my $throw;
  $throw = $self->throw;
  $throw->name('on.validate');
  $throw->message(sprintf($self->message, $self->name, $received));
  $throw->stash(identity => lc(Venus::Type->new(value => $data)->identify));
  $throw->stash(variable => $data);
  $throw->error;

  return $throw;
}

sub validator {
  my ($self) = @_;
  return sub {
    $self->validate(@_)
  }
}

sub value {
  my ($self, @code) = @_;

  $self->constraints
    ->when(sub{CORE::defined($_->value) && !ref($_->value)})
    ->then(@code ? @code : sub{true});

  return $self;
}

sub within {
  my ($self, $type) = @_;

  if (!$type) {
    return $self;
  }

  my $where = $self->new;

  if (lc($type) eq 'hash') {
    $self->defined(sub{
      my $value = $_->value;
      UNIVERSAL::isa($value, 'HASH')
        && CORE::values(%$value) == grep $where->check($_), CORE::values(%$value)
    });
  }
  elsif (lc($type) eq 'array') {
    $self->defined(sub{
      my $value = $_->value;
      UNIVERSAL::isa($value, 'ARRAY')
        && @$value == grep $where->check($_), @$value
    });
  }
  else {
    my $throw;
    $throw = $self->throw;
    $throw->name('on.within');
    $throw->message(qq(Invalid type ("$type") provided to the "within" method));
    $throw->stash(argument => $type);
    $throw->error;
  }

  return $where;
}

1;
