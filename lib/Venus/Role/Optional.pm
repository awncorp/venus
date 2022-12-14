package Venus::Role::Optional;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub clear {
  my ($self, $name) = @_;

  return if !$name;

  return delete $self->{$name};
}

sub has {
  my ($self, $name) = @_;

  return if !$name;

  return exists $self->{$name} ? true : false;
}

sub reset {
  my ($self, $name, @data) = @_;

  return if !$name || !$self->can($name);

  my $value = $self->clear($name);

  $self->$name(@data);

  return $value;
}

# BUILDERS

sub BUILD {
  my ($self, $data) = @_;

  for my $name ($self->META->attrs) {
    my @data = (exists $data->{$name} ? $data->{$name} : ());

    # option: default
    option_default($self, $name, @data);

    # option: initial
    option_initial($self, $name, @data);

    # option: require
    option_require($self, $name, @data);

    # option: coerce
    @data = option_coerce($self, $name, @data) if exists $data->{$name};

    # option: check
    option_check($self, $name, @data);

    # option: assert
    option_assert($self, $name, @data);
  }

  return $self;
}

# EXTENSIONS

sub ITEM {
  my ($self, $name, @data) = @_;

  my $value;

  return undef if !$name;

  @data = (!@data ? READ($self, $name, @data) : WRITE($self, $name, @data));

 # option: check
  option_check($self, $name, @data);

  # option: assert
  option_assert($self, $name, @data);

  # option: trigger
  option_trigger($self, $name, @data);

  return $data[0];
}

sub READ {
  my ($self, $name, @data) = @_;

  # option: default
  option_default($self, $name, @data);

  # option: builder
  option_builder($self, $name, @data);

  # option: coerce
  option_coerce($self, $name, @data);

  # option: reader
  return option_reader($self, $name, @data);
}

sub WRITE {
  my ($self, $name, @data) = @_;

  # option: readwrite
  option_readwrite($self, $name, @data);

  # option: readonly
  option_readonly($self, $name, @data);

  # option: builder
  option_builder($self, $name, @data);

  # option: coerce
  @data = option_coerce($self, $name, @data);

  # option: writer
  return option_writer($self, $name, @data);
}

# EXPORTS

sub EXPORT {
  ['clear', 'has', 'ITEM', 'reset']
}

# OPTIONS

sub option_assert {
  my ($self, $name, @data) = @_;

  if (my $code = $self->can("assert_${name}")) {
    require Scalar::Util;
    require Venus::Assert;
    my $label = join '.', ref $self, $name;
    my $assert = Venus::Assert->new($label);
    my $value = @data ? $data[0] : $self->{$name};
    my $return = $code->($self, $value, $assert);
    if (Scalar::Util::blessed($return)) {
      if ($return->isa('Venus::Assert')) {
        $return->validate($value);
      }
      else {
        require Venus::Throw;
        my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
        $throw->name('on.assert');
        $throw->message("Invalid return value: \"assert_$name\" in $self");
        $throw->stash(data => $value);
        $throw->stash(name => $name);
        $throw->stash(self => $self);
        $throw->error;
      }
    }
    elsif (length($return)) {
      $assert->name($label);
      $assert->accept($return)->validate($value);
    }
    else {
      require Venus::Throw;
      my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
      $throw->name('on.assert');
      $throw->message("Invalid return value: \"assert_$name\" in $self");
      $throw->stash(data => $value);
      $throw->stash(name => $name);
      $throw->stash(self => $self);
      $throw->error;
    }
  }
  return;
}

sub option_builder {
  my ($self, $name, @data) = @_;

  if (my $code = $self->can("build_${name}")) {
    my @return = $code->($self, (@data ? @data : $self->{$name}));
    $self->{$name} = $return[0] if @return;
  }
  return;
}

sub option_check {
  my ($self, $name, @data) = @_;

  if (my $code = $self->can("check_${name}")) {
    require Venus::Throw;
    my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
    $throw->name('on.check');
    $throw->message("Checking attribute value failed: \"$name\" in $self");
    $throw->stash(data => [@data]);
    $throw->stash(name => $name);
    $throw->stash(self => $self);
    if (!$code->($self, @data)) {
      $throw->error;
    }
  }
  return;
}

sub option_coerce {
  my ($self, $name, @data) = @_;

  if ((my $code = $self->can("coerce_${name}")) && (@data || exists $self->{$name})) {
    require Scalar::Util;
    require Venus::Space;
    my $value = @data ? $data[0] : $self->{$name};
    my $return = $code->($self, @data);
    my $package = Venus::Space->new($return)->load;
    my $method = $package->can('DOES')
      && $package->DOES('Venus::Role::Assertable') ? 'make' : 'new';
    return $self->{$name} = $package->$method($value)
      if !Scalar::Util::blessed($value)
      || (Scalar::Util::blessed($value) && !$value->isa($return));
  }
  return $data[0];
}

sub option_default {
  my ($self, $name, @data) = @_;

  if ((my $code = $self->can("default_${name}")) && !@data) {
    $self->{$name} = $code->($self, @data) if !exists $self->{$name};
  }
  return;
}

sub option_initial {
  my ($self, $name, @data) = @_;

  if ((my $code = $self->can("initial_${name}")) && !@data) {
    $self->{$name} = $code->($self, @data) if !exists $self->{$name};
  }
  return;
}

sub option_reader {
  my ($self, $name, @data) = @_;

  if ((my $code = $self->can("read_${name}")) && !@data) {
    return $code->($self, @data);
  }
  else {
    return $self->{$name};
  }
}

sub option_readonly {
  my ($self, $name, @data) = @_;

  if (my $code = ($self->can("readonly_${name}") || $self->can("readonly"))) {
    require Venus::Throw;
    my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
    $throw->name('on.readonly');
    $throw->message("Setting read-only attribute: \"$name\" in $self");
    $throw->stash(data => $data[0]);
    $throw->stash(name => $name);
    $throw->stash(self => $self);
    if ($code->($self, @data)) {
      $throw->error;
    }
  }
  return;
}

sub option_readwrite {
  my ($self, $name, @data) = @_;

  if (my $code = ($self->can("readwrite_${name}") || $self->can("readwrite"))) {
    require Venus::Throw;
    my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
    $throw->name('on.readwrite');
    $throw->message("Setting read-only attribute: \"$name\" in $self");
    $throw->stash(data => $data[0]);
    $throw->stash(name => $name);
    $throw->stash(self => $self);
    if (!$code->($self, @data)) {
      $throw->error;
    }
  }
  return;
}

sub option_require {
  my ($self, $name, @data) = @_;

  if (my $code = $self->can("require_${name}")) {
    require Venus::Throw;
    my $throw = Venus::Throw->new(join('::', map ucfirst, ref($self), 'error'));
    $throw->name('on.require');
    $throw->message("Missing required attribute: \"$name\" in $self");
    $throw->stash(data => [@data]);
    $throw->stash(name => $name);
    $throw->stash(self => $self);
    if ($code->($self, @data) && !@data) {
      $throw->error;
    }
  }
  return;
}

sub option_trigger {
  my ($self, $name, @data) = @_;

  if (my $code = $self->can("trigger_${name}")) {
    $code->($self, @data);
  }
  return;
}

sub option_writer {
  my ($self, $name, @data) = @_;

  if (my $code = $self->can("write_${name}")) {
    return $code->($self, @data);
  }
  else {
    return $self->{$name} = $data[0];
  }
}

1;
