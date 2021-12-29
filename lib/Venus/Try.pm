package Venus::Try;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

use Scalar::Util ();

# ATTRIBUTES

has 'invocant' => (
  is => 'ro'
);

has 'arguments' => (
  is => 'ro'
);

has 'on_try' => (
  is => 'rw'
);

has 'on_catch' => (
  is => 'rw',
  default => sub {[]},
);

has 'on_default' => (
  is => 'rw'
);

has 'on_finally' => (
  is => 'rw'
);

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    on_try => $data,
  };
}

# METHODS

sub call {
  my ($self, $callback) = @_;

  $self->on_try($self->callback($callback));

  return $self;
}

sub callback {
  my ($self, $callback) = @_;

  if (not(UNIVERSAL::isa($callback, 'CODE'))) {
    my $invocant = $self->invocant;
    my $method = $invocant ? $invocant->can($callback) : $self->can($callback);

    require Venus::Error;
    Venus::Error->new(sprintf(
      qq(Can't locate object method "%s" on package "%s"),
      ($callback, $invocant ? ref($invocant) : ref($self))))->throw if !$method;

    $callback = sub {goto $method};
  }

  return $callback;
}

sub catch {
  my ($self, $package, $callback) = @_;

  push @{$self->on_catch}, [$package, $self->callback($callback)];

  return $self;
}

sub default {
  my ($self, $callback) = @_;

  $self->on_default($self->callback($callback));

  return $self;
}

sub error {
  my ($self, $variable) = @_;

  $self->on_default(sub{($$variable) = @_});

  return $self;
}

sub execute {
  my ($self, $callback, @args) = @_;

  unshift @args, @{$self->arguments}
    if $self->arguments && @{$self->arguments};
  unshift @args, $self->invocant
    if $self->invocant;

  return wantarray ? ($callback->(@args)) : $callback->(@args);
}

sub finally {
  my ($self, $callback) = @_;

  $self->on_finally($self->callback($callback));

  return $self;
}

sub maybe {
  my ($self) = @_;

  $self->on_default(sub{''});

  return $self;
}

sub no_catch {
  my ($self) = @_;

  $self->on_catch([]);

  return $self;
}

sub no_default {
  my ($self) = @_;

  $self->on_default(undef);

  return $self;
}

sub no_finally {
  my ($self) = @_;

  $self->on_finally(undef);

  return $self;
}

sub no_try {
  my ($self) = @_;

  $self->on_try(undef);

  return $self;
}

sub result {
  my ($self, @args) = @_;

  my $dollarat = $@;
  my @returned;

  # try
  my $error = do {
    local $@;
    eval {
      my $tryer = $self->on_try;
      @returned = ($self->execute($tryer, @args));
    };
    $@;
  };

  # catch
  if ($error) {
    my $caught = $error;
    my $catchers = $self->on_catch;
    my $default = $self->on_default;

    for my $catcher (@$catchers) {
      if (UNIVERSAL::isa($caught, $catcher->[0])) {
        @returned = ($catcher->[1]->($caught));
        last;
      }
    }

    # catchall
    if(!@returned) {
      if ($default) {
        @returned = ($default->($caught))
      }
    }

    # uncaught
    if(!@returned) {
      if (Scalar::Util::blessed($caught)) {
        die $caught;
      }
      else {
        require Venus::Error;
        Venus::Error->new($caught)->throw;
      }
    }
  }

  # finally
  if (my $finally = $self->on_finally) {
    $self->execute($finally, @args);
  }

  $@ = $dollarat;

  return wantarray ? (@returned) : $returned[0];
}

1;
