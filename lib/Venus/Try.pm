package Venus::Try;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base';

base 'Venus::Kind::Utility';

use Scalar::Util ();

# ATTRIBUTES

attr 'invocant';
attr 'arguments';
attr 'on_try';
attr 'on_catch';
attr 'on_default';
attr 'on_finally';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    on_try => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->on_catch([]) if !defined $self->on_catch;

  return $self;
}

# METHODS

sub any {
  my ($self) = @_;

  $self->on_default(sub{(@_)});

  return $self;
}

sub call {
  my ($self, $callback) = @_;

  $self->on_try($self->callback($callback));

  return $self;
}

sub callback {
  my ($self, $callback) = @_;

  if (not(UNIVERSAL::isa($callback, 'CODE'))) {
    my $method;
    my $invocant = $self->invocant;

    if (defined($invocant)) {
      $method = $invocant->can($callback);
    }
    else {
      $method = $self->can($callback);
    }

    if (!$method) {
      $self->throw('error_on_callback', {
        invocant => $invocant,
        callback => $callback,
      });
    }

    $callback = sub {goto $method};
  }

  return $callback;
}

sub catch {
  my ($self, $package, $callback) = @_;

  $callback ||= sub{(@_)};

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

  if ($variable) {
    $self->on_default(sub{($$variable) = @_})
  }
  else {
    $self->catch('Venus::Error');
  }

  return $self;
}

sub execute {
  my ($self, $callback, @args) = @_;

  unshift @args, @{$self->arguments}
    if $self->arguments && @{$self->arguments};

  unshift @args, $self->invocant
    if defined($self->invocant);

  return wantarray ? ($callback->(@args)) : $callback->(@args);
}

sub finally {
  my ($self, $callback) = @_;

  $self->on_finally($self->callback($callback));

  return $self;
}

sub maybe {
  my ($self) = @_;

  $self->on_default(sub{(undef)});

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
        if (UNIVERSAL::isa($caught, 'Venus::Error')) {
          $caught->throw;
        }
        else {
          require Venus::Error;
          Venus::Error->throw($caught);
        }
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

# ERRORS

sub error_on_callback {
  my ($self, $data) = @_;

  my $callback = $data->{callback};
  my $invocant = $data->{invocant};

  my $message = sprintf(
    qq(Can't locate object method "%s" on package "%s"), ($callback,
      $invocant ? (ref($invocant) || $invocant) : (ref($self) || $self))
  );

  my $stash = {
    invocant => $invocant,
    callback => $callback,
  };

  my $result = {
    name => 'on.callback',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

1;
