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

# HOOKS

sub _exitcode {
  $? >> 8;
}

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

sub copy {
  my ($self, $path) = @_;

  require File::Copy;

  File::Copy::copy("$self", "$path")
    or $self->throw('error_on_copy', $path, $!)->error;

  return $self;
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

sub extension {
  my ($self, $name) = @_;

  my $basename = $self->basename;

  return ($basename =~ /\.?.+\.([^\.]+)$/)[0] || undef if !$name;

  return $self->sibling(join '.', $basename, $name);
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

  $handle->open($path, @args)
    or $self->throw('error_on_open', $path, $!)->error;

  return $handle;
}

sub mkcall {
  my ($self, @args) = @_;

  require File::Spec;

  my $path = File::Spec->catfile(File::Spec->splitdir($self->get));

  my $result;

  require Venus::Os;

  my $args = join ' ', map Venus::Os->quote($_), grep defined, @args;

  (defined($result = ($args ? qx($path $args) : qx($path))))
    or $self->throw('error_on_mkcall', $path, $!)->error;

  chomp $result;

  return wantarray ? ($result, _exitcode()) : $result;
}

sub mkdir {
  my ($self, $mode) = @_;

  my $path = $self->get;

  ($mode ? CORE::mkdir($path, $mode) : CORE::mkdir($path))
    or $self->throw('error_on_mkdir', $path, $!)->error;

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

sub mktemp_dir {
  my ($self) = @_;

  require File::Temp;

  return $self->class->new(File::Temp::tempdir());
}

sub mktemp_file {
  my ($self) = @_;

  require File::Temp;

  return $self->class->new((File::Temp::tempfile())[1]);
}

sub mkfile {
  my ($self) = @_;

  my $path = $self->get;

  return $self if $self->exists;

  $self->open('>');

  CORE::utime(undef, undef, $path)
    or $self->throw('error_on_mkfile', $path, $!)->error;

  return $self;
}

sub move {
  my ($self, $path) = @_;

  require File::Copy;

  File::Copy::move("$self", "$path")
    or $self->throw('error_on_move', $path, $!)->error;

  return $self->class->make($path)->absolute;
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

  CORE::open(my $handle, '<', $path)
    or $self->throw('error_on_read_open', $path, $!)->error;

  CORE::binmode($handle, $binmode) or do {
    $self->throw('error_on_read_binmode', $path, $binmode, $!)->error;
  } if defined($binmode);

  my $result = my $content = '';

  while ($result = $handle->sysread(my $buffer, 131072, 0)) {
    $content .= $buffer;
  }

  $self->throw('error_on_read_error', $path, $!)->error if !defined $result;

  require Venus::Os;
  $content =~ s/\015\012/\012/g if Venus::Os->is_win;

  return $content;
}

sub relative {
  my ($self, $path) = @_;

  require File::Spec;

  $path ||= $self->default;

  return $self->class->new(File::Spec->abs2rel($self->get, $path));
}

sub rename {
  my ($self, $path) = @_;

  $path = $self->class->make($path);

  $path = $self->sibling("$path") if $path->is_relative;

  return $self->move($path);
}

sub rmdir {
  my ($self) = @_;

  my $path = $self->get;

  CORE::rmdir($path)
    or $self->throw('error_on_rmdir', $path, $!)->error;

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

sub root {
  my ($self, $spec, $base) = @_;

  my @paths;

  for my $path ($self->absolute->lineage) {
    if ($path->child($base)->test($spec)) {
      push @paths, $path;
      last;
    }
  }

  return @paths ? (-f $paths[0] ? $paths[0]->parent : $paths[0]) : undef;
}

sub seek {
  my ($self, $spec, $base) = @_;

  if ((my $path = $self->child($base))->test($spec)) {
    return $path;
  }
  else {
    for my $path ($self->directories) {
      my $sought = $path->seek($spec, $base);
      return $sought if $sought;
    }
    return undef;
  }
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

  CORE::unlink($path)
    or $self->throw('error_on_unlink', $path, $!)->error;

  return $self;
}

sub write {
  my ($self, $data, $binmode) = @_;

  my $path = $self->get;

  CORE::open(my $handle, '>', $path)
    or $self->throw('error_on_write_open', $path, $!)->error;

  CORE::binmode($handle, $binmode) or do {
    $self->throw('error_on_write_binmode', $path, $binmode, $!)->error;
  } if defined($binmode);

  (($handle->syswrite($data) // -1) == length($data))
    or $self->throw('error_on_write_error', $path, $!)->error;

  return $self;
}

# ERRORS

sub error_on_copy {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.copy',
    message => "Can't copy \"$self\" to \"$path\": $err",
    stash => {
      path => $path,
      self => $self,
    },
  };
}

sub error_on_mkcall {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.mkcall',
    message => ("Can't make system call to \"$path\": "
        . ($err ? "$err" : sprintf("exit code (%s)", _exitcode()))),
    stash => {
      path => $path,
    },
  };
}

sub error_on_mkdir {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.mkdir',
    message => "Can't make directory \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_mkfile {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.mkfile',
    message => "Can't make file \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_move {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.move',
    message => "Can't move \"$self\" to \"$path\": $err",
    stash => {
      path => $path,
      self => $self,
    },
  };
}

sub error_on_open {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.open',
    message => "Can't open \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_read_binmode {
  my ($self, $path, $binmode, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.read.binmode',
    message => "Can't binmode \"$path\": $err",
    stash => {
      binmode => $binmode,
      path => $path,
    },
  };
}

sub error_on_read_error {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.read.error',
    message => "Can't read from file \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_read_open {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.read.open',
    message => "Can't read \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_rmdir {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.rmdir',
    message => "Can't rmdir \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_write_binmode {
  my ($self, $path, $binmode, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.write.binmode',
    message => "Can't binmode \"$path\": $err",
    stash => {
      binmode => $binmode,
      path => $path,
    },
  };
}

sub error_on_write_error {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.write.error',
    message => "Can't write to file \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_write_open {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.write.open',
    message => "Can't write \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

sub error_on_unlink {
  my ($self, $path, $err) = @_;

  $err = "" if !defined $err;

  return {
    name => 'on.unlink',
    message => "Can't unlink \"$path\": $err",
    stash => {
      path => $path,
    },
  };
}

1;
