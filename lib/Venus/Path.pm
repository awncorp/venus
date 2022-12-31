package Venus::Path;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

use overload (
  '""' => 'explain',
  'eq' => sub{$_[0]->value eq "$_[1]"},
  'ne' => sub{$_[0]->value ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0]->value)]}/},
  '~~' => 'explain',
  fallback => 1,
);

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->expression('string');

  return $assert;
}

sub absolute {
  my ($self) = @_;

  require File::Spec;

  return $self->class->new(File::Spec->rel2abs($self->get));
}

sub basename {
  my ($self) = @_;

  require File::Basename;

  return File::Basename::basename($self->get);
}

sub child {
  my ($self, $path) = @_;

  require File::Spec;

  my @parts = File::Spec->splitdir($path);

  return $self->class->new(File::Spec->catfile($self->get, @parts));
}

sub chmod {
  my ($self, $mode) = @_;

  my $path = $self->get;

  CORE::chmod($mode, $path);

  return $self;
}

sub chown {
  my ($self, @args) = @_;

  my $path = $self->get;

  CORE::chown((map $_||-1, @args[0,1]), $path);

  return $self;
}

sub children {
  my ($self) = @_;

  require File::Spec;

  my @paths = map $self->glob($_), '.??*', '*';

  return wantarray ? (@paths) : \@paths;
}

sub default {
  require Cwd;

  return Cwd::getcwd();
}

sub directories {
  my ($self) = @_;

  my @paths = grep -d, $self->children;

  return wantarray ? (@paths) : \@paths;
}

sub exists {
  my ($self) = @_;

  return int!!-e $self->get;
}

sub explain {
  my ($self) = @_;

  return $self->get;
}

sub find {
  my ($self, $expr) = @_;

  $expr = '.*' if !$expr;

  $expr = qr/$expr/ if ref($expr) ne 'Regexp';

  my @paths;

  push @paths, grep {
    $_ =~ $expr
  } map {
    $_->is_directory ? $_->find($expr) : $_
  }
  $self->children;

  return wantarray ? (@paths) : \@paths;
}

sub files {
  my ($self) = @_;

  my @paths = grep -f, $self->children;

  return wantarray ? (@paths) : \@paths;
}

sub glob {
  my ($self, $expr) = @_;

  require File::Spec;

  $expr ||= '*';

  my @paths = map $self->class->new($_),
    CORE::glob +File::Spec->catfile($self->absolute, $expr);

  return wantarray ? (@paths) : \@paths;
}

sub is_absolute {
  my ($self) = @_;

  require File::Spec;

  return int!!(File::Spec->file_name_is_absolute($self->get));
}

sub is_directory {
  my ($self) = @_;

  my $path = $self->get;

  return int!!(-e $path && -d $path);
}

sub is_file {
  my ($self) = @_;

  my $path = $self->get;

  return int!!(-e $path && !-d $path);
}

sub is_relative {
  my ($self) = @_;

  return int!$self->is_absolute;
}

sub lines {
  my ($self, $separator, $binmode) = @_;

  $separator //= "\n";

  return [split /$separator/, $binmode ? $self->read($binmode) : $self->read];
}

sub lineage {
  my ($self) = @_;

  require File::Spec;

  my @parts = File::Spec->splitdir($self->get);

  my @paths = ((
    reverse map $self->class->new(File::Spec->catfile(@parts[0..$_])), 1..$#parts
    ), $self->class->new($parts[0]));

  return wantarray ? (@paths) : \@paths;
}

sub open {
  my ($self, @args) = @_;

  my $path = $self->get;

  require IO::File;

  my $handle = IO::File->new;

  $handle->open($path, @args) or do {
    my $throw;
    my $error = "Can't open $path: $!";
    $throw = $self->throw;
    $throw->name('on.open');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  return $handle;
}

sub mkcall {
  my ($self, $args) = @_;

  my $path = File::Spec->catfile(File::Spec->splitdir($self->get));

  my $result;

  (defined($result = ($args ? qx($path $args) : qx($path)))) or do {
    my $throw;
    my $error = "Can't mkcall $path: " . ($! ? "$!" : "exit code ($?)");
    $throw = $self->throw;
    $throw->name('on.mkcall');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  chomp $result;

  return wantarray ? ($result, $?) : $result;
}

sub mkdir {
  my ($self, $mode) = @_;

  my $path = $self->get;

  ($mode ? CORE::mkdir($path, $mode) : CORE::mkdir($path)) or do {
    my $throw;
    my $error = "Can't mkdir $path: $!";
    $throw = $self->throw;
    $throw->name('on.mkdir');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  return $self;
}

sub mkdirs {
  my ($self, $mode) = @_;

  my @paths;

  for my $path (
    grep !!$_, reverse($self->parents), ($self->is_file ? () : $self)
  )
  {
    if ($path->exists) {
      next;
    }
    else {
      push @paths, $path->mkdir($mode);
    }
  }

  return wantarray ? (@paths) : \@paths;
}

sub mkfile {
  my ($self) = @_;

  my $path = $self->get;

  return $self if $self->exists;

  $self->open('>');

  CORE::utime(undef, undef, $path) or do {
    my $throw;
    my $error = "Can't mkfile $path: $!";
    $throw = $self->throw;
    $throw->name('on.mkfile');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  return $self;
}

sub name {
  my ($self) = @_;

  return $self->absolute->get;
}

sub parent {
  my ($self) = @_;

  require File::Spec;

  my @parts = File::Spec->splitdir($self->get);

  my $path = File::Spec->catfile(@parts[0..$#parts-1]);

  return defined $path ? $self->class->new($path) : undef;
}

sub parents {
  my ($self) = @_;

  my @paths = $self->lineage;

  @paths = @paths[1..$#paths] if @paths;

  return wantarray ? (@paths) : \@paths;
}

sub parts {
  my ($self) = @_;

  require File::Spec;

  return [File::Spec->splitdir($self->get)];
}

sub read {
  my ($self, $binmode) = @_;

  my $path = $self->get;

  CORE::open(my $handle, '<', $path) or do {
    my $throw;
    my $error = "Can't read $path: $!";
    $throw = $self->throw;
    $throw->name('on.read.open');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  CORE::binmode($handle, $binmode) or do {
    my $throw;
    my $error = "Can't binmode $path: $!";
    $throw = $self->throw;
    $throw->name('on.read.binmode');
    $throw->message($error);
    $throw->stash(binmode => $binmode);
    $throw->stash(path => $path);
    $throw->error;
  }
  if defined($binmode);

  my $result = my $content = '';

  while ($result = $handle->sysread(my $buffer, 131072, 0)) {
    $content .= $buffer;
  }

  if (not(defined($result))) {
    my $throw;
    my $error = "Can't read from file $path: $!";
    $throw = $self->throw;
    $throw->name('on.read.error');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  }

  if ($^O =~ /win32/i) {
    $content =~ s/\015\012/\012/g;
  }

  return $content;
}

sub relative {
  my ($self, $path) = @_;

  require File::Spec;

  $path ||= $self->default;

  return $self->class->new(File::Spec->abs2rel($self->get, $path));
}

sub rmdir {
  my ($self) = @_;

  my $path = $self->get;

  CORE::rmdir($path) or do {
    my $throw;
    my $error = "Can't rmdir $path: $!";
    $throw = $self->throw;
    $throw->name('on.rmdir');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  return $self;
}

sub rmdirs {
  my ($self) = @_;

  my @paths;

  for my $path ($self->children) {
    if ($path->is_file) {
      push @paths, $path->unlink;
    }
    else {
      push @paths, $path->rmdirs;
    }
  }

  push @paths, $self->rmdir;

  return wantarray ? (@paths) : \@paths;
}

sub rmfiles {
  my ($self) = @_;

  my @paths;

  for my $path ($self->children) {
    if ($path->is_file) {
      push @paths, $path->unlink;
    }
    else {
      push @paths, $path->rmfiles;
    }
  }

  return wantarray ? (@paths) : \@paths;
}

sub sibling {
  my ($self, $path) = @_;

  require File::Basename;
  require File::Spec;

  return $self->class->new(File::Spec->catfile(
    File::Basename::dirname($self->get), $path));
}

sub siblings {
  my ($self) = @_;

  my @paths = map $self->parent->glob($_), '.??*', '*';

  my %seen = ($self->absolute, 1);

  @paths = grep !$seen{$_}++, @paths;

  return wantarray ? (@paths) : \@paths;
}

sub test {
  my ($self, $spec) = @_;

  return eval(
    join(' ', map("-$_", grep(/^[a-zA-Z]$/, split(//, $spec || 'e'))), '$self')
  );
}

sub unlink {
  my ($self) = @_;

  my $path = $self->get;

  CORE::unlink($path) or do {
    my $throw;
    my $error = "Can't unlink $path: $!";
    $throw = $self->throw;
    $throw->name('on.unlink');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  return $self;
}

sub write {
  my ($self, $data, $binmode) = @_;

  my $path = $self->get;

  CORE::open(my $handle, '>', $path) or do {
    my $throw;
    my $error = "Can't write $path: $!";
    $throw = $self->throw;
    $throw->name('on.write.open');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  CORE::binmode($handle, $binmode) or do {
    my $throw;
    my $error = "Can't binmode $path: $!";
    $throw = $self->throw;
    $throw->name('on.write.binmode');
    $throw->message($error);
    $throw->stash(binmode => $binmode);
    $throw->stash(path => $path);
    $throw->error;
  }
  if defined($binmode);

  (($handle->syswrite($data) // -1) == length($data)) or do {
    my $throw;
    my $error = "Can't write to file $path: $!";
    $throw = $self->throw;
    $throw->name('on.write.error');
    $throw->message($error);
    $throw->stash(path => $path);
    $throw->error;
  };

  return $self;
}

1;
