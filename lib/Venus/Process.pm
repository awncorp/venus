package Venus::Process;

use 5.018;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  '~~' => 'explain',
  fallback => 1,
);

use Venus::Class 'base', 'with';

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

# HOOKS

sub _chdir {
  CORE::chdir(shift);
}

sub _exit {
  POSIX::_exit(shift);
}

sub _exitcode {
  $?;
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

  $assert->clear->string;

  return $assert;
}

sub chdir {
  my ($self, $path) = @_;

  $path ||= $GETCWD;

  _chdir($path) or do {
    my $throw;
    my $error = "Can't chdir $path: $!";
    $throw = $self->throw;
    $throw->name('on.chdir');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->stash(pid => _pid());
    $throw->error;
  };

  return $self;
}

sub check {
  my ($self, $pid) = @_;

  my $result = _waitpid($pid, POSIX::WNOHANG());

  return wantarray ? ($result, _exitcode) : $result;
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
    my $throw;
    my $error = "Can't fork process @{[_pid()]}: Fork emulation not supported";
    $throw = $self->throw;
    $throw->name('on.fork.support');
    $throw->message($error);
    $throw->stash(process => _pid());
    $throw->error;
  }
  if (defined(my $pid = _fork())) {
    my $process;

    if ($pid) {
      return wantarray ? (undef, $pid) : undef;
    }

    $process = $self->class->new;

    my $orig_seed = srand;
    my $self_seed = substr(((time ^ $$) ** 2), 0, length($orig_seed));
    srand $self_seed;

    if ($code) {
      local $_ = $process;
      $process->$code(@args);
    }

    return wantarray ? ($process, _pid()) : $process;
  }
  else {
    my $throw;
    my $error = "Can't fork process @{[_pid()]}: $!";
    $throw = $self->throw;
    $throw->name('on.fork.process');
    $throw->message($error);
    $throw->stash(process => _pid());
    $throw->error;
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

sub setsid {
  my ($self) = @_;

  return _setsid != -1 || do {
    my $throw;
    my $error = "Can't start a new session: $!";
    $throw = $self->throw;
    $throw->name('on.setsid');
    $throw->message($error);
    $throw->stash(pid => _pid());
    $throw->error;
  };
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
    _open(\*STDERR, '>&', IO::File->new($path, 'w')) or do {
      my $throw;
      my $error = "Can't redirect STDERR to $path: $!";
      $throw = $self->throw;
      $throw->name('on.stderr');
      $throw->message($error);
      $throw->stash(path => $path);
      $throw->stash(pid => _pid());
      $throw->error;
    };
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
    _open(\*STDIN, '<&', IO::File->new($path, 'r')) or do {
      my $throw;
      my $error = "Can't redirect STDIN to $path: $!";
      $throw = $self->throw;
      $throw->name('on.stdin');
      $throw->message($error);
      $throw->stash(path => $path);
      $throw->stash(pid => _pid());
      $throw->error;
    };
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
    _open(\*STDOUT, '>&', IO::File->new($path, 'w')) or do {
      my $throw;
      my $error = "Can't redirect STDOUT to $path: $!";
      $throw = $self->throw;
      $throw->name('on.stdout');
      $throw->message($error);
      $throw->stash(path => $path);
      $throw->stash(pid => _pid());
      $throw->error;
    };
  }

  return $self;
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

1;
