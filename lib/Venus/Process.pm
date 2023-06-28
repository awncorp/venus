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

our $CWD = Cwd->getcwd;
our $MAPSIG = {%SIG};
our $PATH = $CWD;
our $PID = $$;
our $PPID;

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

sub _ping {
  _kill(0, @_);
}

sub _setsid {
  POSIX::setsid();
}

sub _time {
  CORE::time();
}

sub _waitpid {
  CORE::waitpid(shift, shift);
}

# BUILD

sub build_self {
  my ($self, $data) = @_;

  $PID = $self->value if $self->value;

  return $self;
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

  $path ||= $CWD;

  _chdir($path) or $self->throw('error_on_chdir', $path, $PID, $!)->error;

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

sub data {
  my ($self, @args) = @_;

  my @pids = @args ? @args : ($self->watchlist);

  return 0 if !@pids;

  my $result = 0;

  require Venus::Path;

  my $path = Venus::Path->new($PATH);

  $path = $path->child($self->exchange) if $self->exchange;

  for my $pid (@pids) {
    next if !(my $pdir = $path->child($self->recv_key($pid)))->exists;

    $result += 1 for CORE::glob($pdir->child('*.data')->absolute);
  }

  return $result;
}

sub decode {
  my ($self, $data) = @_;

  require Venus::Dump;

  return Venus::Dump->new->decode($data);
}

sub default {
  return $PID;
}

sub disengage {
  my ($self) = @_;

  $self->chdir(File::Spec->rootdir);

  $self->$_(File::Spec->devnull) for qw(stdin stdout stderr);

  return $self;
}

sub encode {
  my ($self, $data) = @_;

  require Venus::Dump;

  return Venus::Dump->new($data)->encode;
}

sub engage {
  my ($self) = @_;

  $self->chdir;

  $self->$_ for qw(stdin stdout stderr);

  return $self;
}

sub exchange {
  my ($self, $name) = @_;

  return $name ? ($self->{exchange} = $name) : $self->{exchange};
}

sub exit {
  my ($self, $code) = @_;

  return _exit($code // 0);
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub followers {
  my ($self) = @_;

  my $leader = $self->leader;

  my $result = [sort grep {$_ != $leader} $self->others_active, $self->pid];

  return wantarray ? @{$result} : $result;
}

sub fork {
  my ($self, $code, @args) = @_;

  if (not(_forkable())) {
    $self->throw('error_on_fork_support', $PID)->error;
  }
  if (defined(my $pid = _fork())) {
    if ($pid) {
      $self->watch($pid);
      return wantarray ? (undef, $pid) : undef;
    }

    $PPID = $PID;
    $PID = $$;
    my $process = $self->class->new;

    my $orig_seed = srand;
    my $self_seed = substr(((time ^ $$) ** 2), 0, length($orig_seed));
    srand $self_seed;

    _alarm($self->alarm) if defined $self->alarm;

    if ($code) {
      local $_ = $process;
      $process->$code(@args);
    }

    return wantarray ? ($process, $PID) : $process;
  }
  else {
    $self->throw('error_on_fork_process', $PID, $!)->error;
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

sub is_leader {
  my ($self) = @_;

  return $self->leader == $self->pid ? true : false;
}

sub is_follower {
  my ($self) = @_;

  return $self->is_leader ? false : true;
}

sub is_registered {
  my ($self) = @_;

  return (grep {$_ == $self->pid} $self->registrants) ? true : false;
}

sub is_unregistered {
  my ($self) = @_;

  return $self->is_registered ? false : true;
}

sub join {
  my ($self, $name) = @_;

  $self->exchange($name) if $name;

  $self->register;

  @{$self->watchlist} = ();

  return $self;
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

sub leader {
  my ($self) = @_;

  my $leader = (sort $self->others_active, $self->pid)[0];

  return $leader;
}

sub leave {
  my ($self, $name) = @_;

  $self->unregister;

  delete $self->{exchange};
  delete $self->{watchlist};

  return $self;
}

sub others {
  my ($self) = @_;

  my $pid = $self->pid;

  my $result = [grep {$_ != $pid} $self->registrants];

  return wantarray ? @{$result} : $result;
}

sub others_active {
  my ($self) = @_;

  my $pid = $self->pid;

  my $result = [grep $self->ping($_), $self->others];

  return wantarray ? @{$result} : $result;
}

sub others_inactive {
  my ($self) = @_;

  my $pid = $self->pid;

  my $result = [grep !$self->ping($_), $self->others];

  return wantarray ? @{$result} : $result;
}

sub pid {
  my ($self, @data) = @_;

  return $self->value if !@data;

  return $self->value((($PID) = @data));
}

sub pids {
  my ($self) = @_;

  my $result = [$self->pid, $self->watchlist];

  return wantarray ? @{$result} : $result;
}

sub ppid {
  my ($self, @data) = @_;

  my $pid = @data ? (($PPID) = @data) : $PPID;

  return $pid;
}

sub ping {
  my ($self, @pids) = @_;

  return _ping(@pids);
}

sub poll {
  my ($self, $timeout, $code, @args) = @_;

  if (!$code) {
    $code = 'recvall';
  }

  if (!$timeout) {
    $timeout = 0;
  }

  my $result = [];

  my $time = _time();
  my $then = $time + $timeout;
  my $seen = 0;

  while (time <= $then) {
    last if $seen = (@{$result} = grep defined, $self->$code(@args));
  }

  if (!$seen) {
    $self->throw('error_on_timeout_poll', $timeout, $code)->error;
  }

  return wantarray ? @{$result} : $result;
}

sub pool {
  my ($self, $count, $timeout) = @_;

  if (!$count) {
    $count = 1;
  }

  if (!$timeout) {
    $timeout = 0;
  }

  my @pids;
  my $time = _time();
  my $then = $time + $timeout;
  my $seen = 0;

  while (time <= $then) {
    last if ($seen = (@pids = $self->others_active)) >= $count;
  }

  if ($seen < $count) {
    $self->throw('error_on_timeout_pool', $timeout, $count)->error;
  }

  @{$self->watchlist} = @pids;

  return $self;
}

sub prune {
  my ($self) = @_;

  $self->unwatch($self->stopped);

  return $self;
}

sub read {
  my ($self, $key) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($PATH);

  $path = $path->child($self->exchange) if $self->exchange;

  $path = $path->child($key);

  $path->catch('mkdirs') if !$path->exists;

  my $file = (CORE::glob($path->child('*.data')->absolute))[0];

  return undef if !$file;

  $path = Venus::Path->new($file);

  my $data = $path->read;

  $path->unlink;

  return $data;
}

sub recall {
  my ($self, $pid) = @_;

  ($pid) = grep {$_ == $pid} $self->others_inactive if $pid;

  return undef if !$pid;

  my $key = $self->send_key($pid);

  my $string = $self->read($key);

  return undef if !defined $string;

  my $data = $self->decode($string);

  return $data;
}

sub recallall {
  my ($self) = @_;

  my $result = [];

  for my $pid (grep defined, $self->ppid, $self->watchlist) {
    my $data = $self->recall($pid);
    push @{$result}, $data if defined $data;
  }

  return wantarray ? @{$result} : $result;
}

sub recv {
  my ($self, $pid) = @_;

  return undef if !$pid;

  my $key = $self->recv_key($pid);

  my $string = $self->read($key);

  return undef if !defined $string;

  my $data = $self->decode($string);

  return $data;
}

sub recvall {
  my ($self) = @_;

  my $result = [];

  for my $pid (grep defined, $self->ppid, $self->watchlist) {
    my $data = $self->recv($pid);
    push @{$result}, $data if defined $data;
  }

  return wantarray ? @{$result} : $result;
}

sub recv_key {
  my ($self, $pid) = @_;

  return CORE::join '.', $pid, $self->pid;
}

sub register {
  my ($self) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($PATH);

  $path = $path->child($self->exchange) if $self->exchange;

  my $key = $self->send_key($self->pid);

  $path = $path->child($key);

  $path->catch('mkdirs') if !$path->exists;

  return $self;
}

sub registrants {
  my ($self) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($PATH);

  $path = $path->child($self->exchange) if $self->exchange;

  my $result = [
    map /(\d+)$/, grep /(\d+)\.\1$/, CORE::glob($path->child('*.*')->absolute)
  ];

  return wantarray ? @{$result} : $result;
}

sub restart {
  my ($self, $code) = @_;

  my $result = [];

  $self->status(sub {
    push @{$result}, $code->(@_) if ($_[1] == -1) || ($_[1] == $_[0])
  });

  return wantarray ? @{$result} : $result;
}

sub send {
  my ($self, $pid, $data) = @_;

  return $self if !$pid;

  my $string = $self->encode($data);

  my $key = $self->send_key($pid);

  $self->write($key, $string);

  return $self;
}

sub sendall {
  my ($self, $data) = @_;

  for my $pid (grep defined, $self->ppid, $self->watchlist) {
    $self->send($pid, $data);
  }

  return $self;
}

sub send_key {
  my ($self, $pid) = @_;

  return CORE::join '.', $self->pid, $pid;
}

sub setsid {
  my ($self) = @_;

  return _setsid != -1 || $self->throw('error_on_setid', $PID, $!)->error;
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
      or $self->throw('error_on_stderr', $path, $PID, $!)->error;
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
      or $self->throw('error_on_stdin', $path, $PID, $!)->error;
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
      or $self->throw('error_on_stdout', $path, $PID, $!)->error;
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

sub sync {
  my ($self, $count, $timeout) = @_;

  if (!$count) {
    $count = 1;
  }

  if (!$timeout) {
    $timeout = 0;
  }

  my $time = _time();
  my $then = $time + $timeout;
  my $msgs = 0;

  while (time <= $then) {
    last if ($msgs = (scalar grep $self->data($_), $self->pool->watchlist)) >= $count;
  }

  if ($msgs < $count) {
    $self->throw('error_on_timeout_sync', $timeout, $count)->error;
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

sub write {
  my ($self, $key, $data) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($PATH);

  $path = $path->child($self->exchange) if $self->exchange;

  $path = $path->child($key);

  $path->catch('mkdirs') if !$path->exists;

  require Time::HiRes;

  $path = $path->child(CORE::join '.', Time::HiRes::gettimeofday(), 'data');

  $path->write($data);

  return $self;
}

sub unregister {
  my ($self) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($PATH);

  $path = $path->child($self->exchange) if $self->exchange;

  my $key = $self->recv_key($self->pid);

  $path = $path->child($key);

  $path->rmdirs if $path->exists;

  return $self;
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
  my ($self, $path, $pid, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.chdir',
    message => "Can't chdir \"$path\": $err",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_fork_process {
  my ($self, $pid, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.fork.process',
    message => "Can't fork process $pid: $err",
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
  my ($self, $pid, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.setid',
    message => "Can't start a new session: $err",
    stash => {
      pid => $pid,
    }
  };
}

sub error_on_stderr {
  my ($self, $path, $pid, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.stderr',
    message => "Can't redirect STDERR to \"$path\": $err",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_stdin {
  my ($self, $path, $pid, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.stdin',
    message => "Can't redirect STDIN to \"$path\": $err",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_stdout {
  my ($self, $path, $pid, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.stdout',
    message => "Can't redirect STDOUT to \"$path\": $err",
    stash => {
      path => $path,
      pid => $pid,
    }
  };
}

sub error_on_timeout_poll {
  my ($self, $timeout, $code) = @_;

  my $name = ref $code eq 'CODE' ? '__ANON__' : "\"$code\"";
  my $exchange = $self->exchange;
  my $pid = $self->pid;

  return {
    name => 'on.timeout.poll',
    message => "Timed out after $timeout seconds in process $pid while polling $name",
    stash => {
      exchange => $exchange,
      pid => $pid,
      code => $code,
      timeout => $timeout,
    }
  };
}

sub error_on_timeout_pool {
  my ($self, $timeout, $pool_size) = @_;

  my $exchange = $self->exchange;
  my $pid = $self->pid;

  return {
    name => 'on.timeout.pool',
    message => "Timed out after $timeout seconds in process $pid while pooling",
    stash => {
      exchange => $exchange,
      pid => $pid,
      pool_size => $pool_size,
      timeout => $timeout,
    }
  };
}

sub error_on_timeout_sync {
  my ($self, $timeout, $pool_size) = @_;

  my $exchange = $self->exchange;
  my $pid = $self->pid;

  return {
    name => 'on.timeout.sync',
    message => "Timed out after $timeout seconds in process $pid while syncing",
    stash => {
      exchange => $exchange,
      pid => $pid,
      pool_size => $pool_size,
      timeout => $timeout,
    }
  };
}

1;
