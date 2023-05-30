package Venus::Process;

use 5.018;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  '~~' => 'explain',
  fallback => 1,
);

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

require Config;
require Cwd;
require File::Spec;
require POSIX;

state $GETCWD = Cwd->getcwd;
state $MAPSIG = {%SIG};

# ATTRIBUTES

attr 'alarm';

# HOOKS

sub _alarm {
  CORE::alarm(shift);
}

sub _chdir {
  CORE::chdir(shift);
}

sub _exit {
  POSIX::_exit(shift);
}

sub _exitcode {
  $? >> 8;
}

sub _fork {
  CORE::fork();
}

sub _forkable {
  $Config::Config{d_pseudofork} ? 0 : 1;
}

sub _kill {
  CORE::kill(@_);
}

sub _open {
  CORE::open(shift, shift, shift);
}

sub _pid {
  $$;
}

sub _setsid {
  POSIX::setsid();
}

sub _waitpid {
  CORE::waitpid(shift, shift);
}

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->expression('string');

  return $assert;
}

sub chdir {
  my ($self, $path) = @_;

  $path ||= $GETCWD;

  _chdir($path) or $self->throw('error_on_chdir', $path, _pid())->error;

  return $self;
}

sub check {
  my ($self, $pid) = @_;

  my $result = _waitpid($pid, POSIX::WNOHANG());

  return wantarray ? ($result, _exitcode) : $result;
}

sub count {
  my ($self, $code, @args) = @_;

  $code ||= 'watchlist';

  my @result = $self->$code(@args);

  my $count = (@result == 1 && ref $result[0] eq 'ARRAY') ? @{$result[0]} : @result;

  return $count;
}

sub daemon {
  my ($self) = @_;

  if (my $process = $self->fork) {
    return $process->disengage->do('setsid');
  }
  else {
    return $self->exit;
  }
}

sub default {
  return _pid();
}

sub disengage {
  my ($self) = @_;

  $self->chdir(File::Spec->rootdir);

  $self->$_(File::Spec->devnull) for qw(stdin stdout stderr);

  return $self;
}

sub engage {
  my ($self) = @_;

  $self->chdir;

  $self->$_ for qw(stdin stdout stderr);

  return $self;
}

sub exit {
  my ($self, $code) = @_;

  return _exit($code // 0);
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub fork {
  my ($self, $code, @args) = @_;

  if (not(_forkable())) {
    $self->throw('error_on_fork_support', _pid())->error;
  }
  if (defined(my $pid = _fork())) {
    my $process;

    if ($pid) {
      $self->watch($pid);
      return wantarray ? (undef, $pid) : undef;
    }

    $process = $self->class->new;

    my $orig_seed = srand;
    my $self_seed = substr(((time ^ $$) ** 2), 0, length($orig_seed));
    srand $self_seed;

    _alarm($self->alarm) if defined $self->alarm;

    if ($code) {
      local $_ = $process;
      $process->$code(@args);
    }

    return wantarray ? ($process, _pid()) : $process;
  }
  else {
    $self->throw('error_on_fork_process', _pid())->error;
  }
}

sub forks {
  my ($self, $count, $code, @args) = @_;

  my $pid;
  my @pids;
  my $process;

  for (my $i = 1; $i <= ($count || 0); $i++) {
    ($process, $pid) = $self->fork($code, @args, $i);
    if (!$process) {
      push @pids, $pid;
    }
    if ($process) {
      last;
    }
  }

  return wantarray ? ($process ? ($process, []) : ($process, [@pids]) ) : $process;
}

sub kill {
  my ($self, $name, @pids) = @_;

  return _kill(uc($name), @pids);
}

sub killall {
  my ($self, $name, @pids) = @_;

  $name ||= 'INT';

  my $result = [map $self->kill($name, $_), (@pids ? @pids : $self->watchlist)];

  return wantarray ? @{$result} : $result;
}

sub pid {
  my ($self) = @_;

  return $self->value;
}

sub pids {
  my ($self) = @_;

  my $result = [$self->pid, $self->watchlist];

  return wantarray ? @{$result} : $result;
}

sub ping {
  my ($self, @pids) = @_;

  return $self->kill(0, @pids);
}

sub prune {
  my ($self) = @_;

  $self->unwatch($self->stopped);

  return $self;
}

sub restart {
  my ($self, $code) = @_;

  my $result = [];

  $self->status(sub {
    push @{$result}, $code->(@_) if ($_[1] == -1) || ($_[1] == $_[0])
  });

  return wantarray ? @{$result} : $result;
}

sub setsid {
  my ($self) = @_;

  return _setsid != -1 || $self->throw('error_on_setid', _pid())->error;
}

sub started {
  my ($self) = @_;

  my $result = [];

  $self->status(sub {
    push @{$result}, $_[0] if $_[1] > -1 && $_[1] != $_[0]
  });

  return wantarray ? @{$result} : $result;
}

sub status {
  my ($self, $code) = @_;

  my $result = [];
  my $watchlist = $self->watchlist;

  for my $pid (@{$watchlist}) {
    local $_ = $pid;
    push @{$result}, $code->($pid, $self->check($pid));
  }

  return wantarray ? @{$result} : $result;
}

sub stderr {
  my ($self, $path) = @_;

  state $STDERR;

  if (!$STDERR) {
    _open($STDERR, '>&', \*STDERR);
  }
  if (!$path) {
    _open(\*STDERR, '>&', $STDERR);
  }
  else {
    _open(\*STDERR, '>&', IO::File->new($path, 'w'))
      or $self->throw('error_on_stderr', $path, _pid())->error;
  }

  return $self;
}

sub stdin {
  my ($self, $path) = @_;

  state $STDIN;

  if (!$STDIN) {
    _open($STDIN, '<&', \*STDIN);
  }
  if (!$path) {
    _open(\*STDIN, '<&', $STDIN);
  }
  else {
    _open(\*STDIN, '<&', IO::File->new($path, 'r'))
      or $self->throw('error_on_stdin', $path, _pid())->error;
  }

  return $self;
}

sub stdout {
  my ($self, $path) = @_;

  state $STDOUT;

  if (!$STDOUT) {
    _open($STDOUT, '>&', \*STDOUT);
  }
  if (!$path) {
    _open(\*STDOUT, '>&', $STDOUT);
  }
  else {
    _open(\*STDOUT, '>&', IO::File->new($path, 'w'))
      or $self->throw('error_on_stdout', $path, _pid())->error;
  }

  return $self;
}

sub stopped {
  my ($self) = @_;

  my $result = [];

  $self->status(sub {
    push @{$result}, $_[0] if ($_[1] == -1) || ($_[1] == $_[0])
  });

  return wantarray ? @{$result} : $result;
}

sub trap {
  my ($self, $name, $expr) = @_;

  $SIG{uc($name)} = !ref($expr) ? uc($expr) : sub {
    local($!, $?);
    return $expr->(@_);
  };

  return $self;
}

sub wait {
  my ($self, $pid) = @_;

  my $result = _waitpid($pid, 0);

  return wantarray ? ($result, _exitcode) : $result;
}

sub waitall {
  my ($self, @pids) = @_;

  my $result = [map [$self->wait($_)], @pids ? @pids : $self->watchlist];

  return wantarray ? @{$result} : $result;
}

sub watch {
  my ($self, @args) = @_;

  my $watchlist = $self->watchlist;

  my %seen; @{$watchlist} = grep !$seen{$_}++, @{$watchlist}, @args;

  return wantarray ? @{$watchlist} : $watchlist;
}

sub watchlist {
  my ($self) = @_;

  my $watchlist = $self->{watchlist} ||= [];

  return wantarray ? @{$watchlist} : $watchlist;
}

sub work {
  my ($self, $code, @args) = @_;

  my @returned = $self->fork(sub{
    my ($process) = @_;
    local $_ = $process;
    $process->$code(@args);
    $process->exit;
  });

  return $returned[-1];
}

sub works {
  my ($self, $count, $code, @args) = @_;

  my $result = [];

  for (my $i = 1; $i <= ($count || 0); $i++) {
    push @{$result}, scalar($self->work($code, @args));
  }

  return wantarray ? @{$result} : $result;
}

sub untrap {
  my ($self, $name) = @_;

  if ($name) {
    $SIG{uc($name)} = $$MAPSIG{uc($name)};
  }
  else {
    %SIG = %$MAPSIG;
  }

  return $self;
}

sub unwatch {
  my ($self, @args) = @_;

  my $watchlist = $self->watchlist;

  my %seen = map +($_, 1), @args;

  @{$watchlist} = grep !$seen{$_}++, @{$watchlist}, @args;

  return wantarray ? @{$watchlist} : $watchlist;
}

# ERRORS

sub error_on_chdir {
  my ($self, $path, $pid) = @_;

  return {
    name => 'on.chdir',
    message => "Can't chdir \"$path\": $!",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_fork_process {
  my ($self, $pid) = @_;

  return {
    name => 'on.fork.process',
    message => "Can't fork process $pid: $!",
    stash => {
      pid => $pid,
    }
  };
}

sub error_on_fork_support {
  my ($self, $pid) = @_;

  return {
    name => 'on.fork.support',
    message => "Can't fork process $pid: Fork emulation not supported",
    stash => {
      pid => $pid,
    }
  };
}

sub error_on_setid {
  my ($self, $pid) = @_;

  return {
    name => 'on.setid',
    message => "Can't start a new session: $!",
    stash => {
      pid => $pid,
    }
  };
}

sub error_on_stderr {
  my ($self, $path, $pid) = @_;

  return {
    name => 'on.stderr',
    message => "Can't redirect STDERR to \"$path\": $!",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_stdin {
  my ($self, $path, $pid) = @_;

  return {
    name => 'on.stdin',
    message => "Can't redirect STDIN to \"$path\": $!",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_stdout {
  my ($self, $path, $pid) = @_;

  return {
    name => 'on.stdout',
    message => "Can't redirect STDOUT to \"$path\": $!",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

1;
