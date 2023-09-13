package Venus::Future;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

# STATE

state $FULFILLED = 'fulfilled';
state $PENDING = 'pending';
state $REJECTED = 'rejected';

# HOOKS

sub _time {
  CORE::time();
}

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    promise => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->{status} = $PENDING;

  return $self if !exists $data->{promise};

  $self->promise($data->{promise});

  my $tryable = $self->try('fulfill')->error;

  my $result = $tryable->result;

  $self->reject($result) if UNIVERSAL::isa($result, 'Venus::Error');

  return $self;
}

# METHODS

sub catch {
  my ($self, $on_reject) = @_;

  return $self->then(undef, $on_reject);
}

sub finally {
  my ($self, $on_finally) = @_;

  my $future = $self->class->new;

  my $is_rejectable = my $is_resolvable = ref $on_finally eq 'CODE'
    ? true : false;

  if ($is_resolvable && $self->is_fulfilled) {
    local $_ = $self->{value};
    $on_finally->($self->{value});
  }
  elsif ($is_rejectable && $self->is_rejected) {
    local $_ = $self->{issue};
    $on_finally->($self->{issue});
  }
  else {
    if ($is_resolvable && $is_rejectable) {
      $self->on_finally($self->then_finally($future, $on_finally));
    }
  }

  return $future;
}

sub fulfill {
  my ($self) = @_;

  return true if !$self->is_pending;

  my $is_suspended = $self->is_suspended;

  $self->resume if $is_suspended;

  return $self->is_fulfilled ? true : false if $is_suspended;

  return false if !$self->{promise};

  my $rejectable = $self->try('reject');

  my $resolvable = $self->try('resolve');

  $self->{promise}->($resolvable, $rejectable);

  return $self->is_pending ? false : true;
}

sub is {
  my ($self, $name) = @_;

  my $method = "is_$name";

  return $self->can($method) ?  ($self->$method ? true : false) : false;
}

sub is_fulfilled {
  my ($self) = @_;

  my $status = $self->{status};

  return ($status && $status eq $FULFILLED) ? true : false;
}

sub is_pending {
  my ($self) = @_;

  my $status = $self->{status};

  return ($status && $status eq $PENDING) ? true : false;
}

sub is_promised {
  my ($self) = @_;

  return exists $self->{promise} ? true : false;
}

sub is_rejected {
  my ($self) = @_;

  my $status = $self->{status};

  return ($status && $status eq $REJECTED) ? true : false;
}

sub is_resuming {
  my ($self) = @_;

  return exists $self->{resuming} ? true : false;
}

sub is_suspended {
  my ($self) = @_;

  my $has_resume = exists $self->{resume} ? true : false;

  return false if !$has_resume;

  my $has_method = defined $self->{resume}->{method} ? true : false;

  return false if !$has_method;

  my $has_position = defined $self->{resume}->{position} ? true : false;

  return false if !$has_position;

  my $has_value = exists $self->{resume}->{value} ? true : false;

  return false if !$has_value;

  return true;
}

sub is_thenable {
  my ($self, $value) = @_;

  $value = $self if @_ < 2 ;

  require Scalar::Util;

  my $blessed = Scalar::Util::blessed($value);

  return false if !$blessed;

  my $is_future = $value->isa('Venus::Future') ? true : false;

  return true if $is_future;

  return $value->can('then') ? true : false;
}

sub issue {
  my ($self) = @_;

  return $self->{issue};
}

sub on {
  my ($self, @args) = @_;

  require Venus;
  for my $pair (Venus::pairs(Venus::hashref(@args))) {
    my ($name, $callback) = Venus::list($pair);
    my $method = "on_$name";
    $self->$method($callback) if $self->can($method);
  }

  return $self;
}

sub on_finally {
  my ($self, $code) = @_;

  push @{$self->{on_finally}}, $code if $code;

  return $self;
}

sub on_fulfilled {
  my ($self, $code) = @_;

  push @{$self->{on_fulfilled}}, $code if $code;

  return $self;
}

sub on_rejected {
  my ($self, $code) = @_;

  push @{$self->{on_rejected}}, $code if $code;

  return $self;
}

sub promise {
  my ($self, $code) = @_;

  $self->{promise} ||= $code if $code;

  return $self;
}

sub reject {
  my ($self, $issue) = @_;

  return $self if !$self->is_pending;

  my $position = 0;

  if ($self->is_suspended) {
    my $future = $self->{resume}->{future};
    my $is_thenable = $self->is_thenable($future);
    my $is_future = $future->isa('Venus::Future');

    return $self if $is_future && $future->is_pending;
    return $self if $is_future && $future->is_fulfilled;

    $position
      = ($is_future && $future->is_fulfilled)
      ? ($self->{resume}->{position} + 1)
      : $self->{resume}->{position};
  }

  my $on_finally = $self->{on_finally} || [];

  my $on_rejected = $self->{on_rejected} || [];

  my @callbacks = (@{$on_rejected}, @{$on_finally});

  for (my $i = $position; $i < @callbacks; $i++) {
    my $callback = $callbacks[$i];
    local $_ = $issue;
    my $future = $callback->($issue);
    my $is_future = $self->is_thenable($future)
      && $future->isa('Venus::Future') ? true : false;
    if ($is_future && $future->is_pending) {
      $future->resume;
    }
    if ($is_future && $future->is_pending) {
      $self->suspend('reject', $i, $issue, $future);
      last;
    }
  }

  return $self if $self->is_suspended;

  delete $self->{on_finally};
  delete $self->{on_fulfilled};
  delete $self->{on_rejected};
  delete $self->{promise};
  delete $self->{resume};
  delete $self->{resuming};

  $self->{status} = $REJECTED;

  $self->{issue} = $issue;

  return $self;
}

sub resolve {
  my ($self, $value) = @_;

  return $self if !$self->is_pending;

  my $position = 0;

  if ($self->is_suspended) {
    my $future = $self->{resume}->{future};
    my $is_thenable = $self->is_thenable($future);
    my $is_future = $future->isa('Venus::Future');

    return $self if $is_future && $future->is_pending;
    return $self if $is_future && $future->is_rejected;

    $position
      = ($is_future && $future->is_fulfilled)
      ? ($self->{resume}->{position} + 1)
      : $self->{resume}->{position};
  }

  my $on_finally = $self->{on_finally} || [];

  my $on_fulfilled = $self->{on_fulfilled} || [];

  my @callbacks = (@{$on_fulfilled}, @{$on_finally});

  for (my $i = $position; $i < @callbacks; $i++) {
    my $callback = $callbacks[$i];
    local $_ = $value;
    my $future = $callback->($value);
    my $is_future = $self->is_thenable($future)
      && $future->isa('Venus::Future') ? true : false;
    if ($is_future && $future->is_pending) {
      $future->resume;
    }
    if ($is_future && $future->is_pending) {
      $self->suspend('resolve', $i, $value, $future);
      last;
    }
  }

  return $self if $self->is_suspended;

  delete $self->{on_finally};
  delete $self->{on_fulfilled};
  delete $self->{on_rejected};
  delete $self->{promise};
  delete $self->{resume};
  delete $self->{resuming};

  $self->{status} = $FULFILLED;

  $self->{value} = $value;

  return $self;
}

sub resume {
  my ($self) = @_;

  my $resume = delete $self->{resume} or return $self;

  $self->{resuming} = true;

  my $method = $resume->{method};

  my $value = $resume->{value};

  return $self->$method($value);
}

sub status {
  my ($self) = @_;

  return $self->{status};
}

sub suspend {
  my ($self, $method, $position, $value, $future) = @_;

  delete $self->{resuming};

  $self->{resume} = {
    method => $method,
    position => $position,
    value => $value,
    future => $future,
  };

  return $self;
}

sub then {
  my ($self, $on_fulfill, $on_reject) = @_;

  my $future = $self->class->new;

  my $is_rejectable = ref $on_reject eq 'CODE' ? true : false;
  my $is_resolvable = ref $on_fulfill eq 'CODE' ? true : false;

  if ($is_resolvable && $self->is_fulfilled) {
    local $_ = $self->{value};
    $on_fulfill->($self->{value});
  }
  elsif ($is_rejectable && $self->is_rejected) {
    local $_ = $self->{issue};
    $on_reject->($self->{issue});
  }
  else {
    if ($is_resolvable && $self->is_pending) {
      $self->on_fulfilled($self->then_fulfill($future, $on_fulfill));
    }
    if ($is_rejectable && $self->is_pending) {
      $self->on_rejected($self->then_reject($future, $on_reject));
    }
  }

  return $future;
}

sub then_finally {
  my ($self, $future, $on_finally) = @_;

  return sub {
    my ($value) = @_;

    if (ref $on_finally eq 'CODE') {
      local $_ = $value;
      my $result = $on_finally->($value);
      if ($self->is_thenable($result)) {
        if ($self->is_resuming) {
          return $future;
        }
        elsif ($result->isa('Venus::Future') && $result->is_fulfilled) {
          return $result;
        }
        else {
          return $result->then($future->defer('resolve'), $future->defer('reject'));
        }
      }
      else {
        return $future->resolve($result);
      }
    }
    else {
      return $future->resolve($value);
    }
  };
}

sub then_fulfill {
  my ($self, $future, $on_fulfill) = @_;

  return sub {
    my ($value) = @_;

    if (ref $on_fulfill eq 'CODE') {
      local $_ = $value;
      my $result = $on_fulfill->($value);
      if ($self->is_thenable($result)) {
        if ($self->is_resuming) {
          return $future;
        }
        elsif ($result->isa('Venus::Future') && $result->is_fulfilled) {
          return $result;
        }
        else {
          return $result->then($future->defer('resolve'), $future->defer('reject'));
        }
      }
      else {
        return $future->resolve($result);
      }
    }
    else {
      return $future->resolve($value);
    }
  };
}

sub then_reject {
  my ($self, $future, $on_reject) = @_;

  return sub {
    my ($issue) = @_;

    if (ref $on_reject eq 'CODE') {
      local $_ = $issue;
      my $result = $on_reject->($issue);
      if ($self->is_thenable($result)) {
        if ($self->is_resuming) {
          return $future;
        }
        elsif ($result->isa('Venus::Future') && $result->is_fulfilled) {
          return $result;
        }
        else {
          return $result->then($future->defer('resolve'), $future->defer('reject'));
        }
      }
      else {
        return $future->reject($result);
      }
    }
    else {
      return $future->reject($issue);
    }
  };
}

sub value {
  my ($self) = @_;

  return $self->{value};
}

sub wait {
  my ($self, $timeout) = @_;

  if (defined $timeout) {
    my $seen = 0;
    my $time = _time();
    my $then = $time + $timeout;
    while (time <= $then) {
      last if $seen = $self->fulfill;
    }
    if (!$seen) {
      $self->error({throw => 'error_on_timeout', timeout => $timeout});
    }
  }
  else {
    while (1) {
      last if $self->fulfill;
    }
  }

  return $self;
}

# ERRORS

sub error_on_timeout {
  my ($self, $data) = @_;

  my $message = 'Future timed-out after {{timeout}} seconds';

  my $stash = {
    timeout => $data->{timeout},
  };

  my $result = {
    name => 'on.timeout',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

1;
