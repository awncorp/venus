package Venus::Os;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Kind::Utility';

our %TYPES;

# HOOKS

sub _osname {
  $TYPES{$^O} || $^O
}

# BUILDERS

sub build_arg {
  my ($self) = @_;

  return {};
}

# METHODS

sub call {
  my ($self, $name, @args) = @_;

  return if !$name;

  require Venus::Path;

  my $which = $self->which($name);

  return if !$which;

  my $path = Venus::Path->new($which);

  my $expr = join ' ', @args;

  return $path->try('mkcall')->maybe->result($expr || ());
}

sub find {
  my ($self, $name, @paths) = @_;

  return if !$name;

  require File::Spec;

  return [$name] if File::Spec->splitdir($name) > 1;

  my $result = [grep -f, map File::Spec->catfile($_, $name), @paths];

  return wantarray ? @{$result} : $result;
}

sub is_bsd {

  return true if lc(_osname()) eq 'freebsd';
  return true if lc(_osname()) eq 'openbsd';

  return false;
}

sub is_cyg {

  return true if lc(_osname()) eq 'cygwin';
  return true if lc(_osname()) eq 'msys';

  return false;
}

sub is_dos {

  return true if is_win();

  return false;
}

sub is_lin {

  return true if lc(_osname()) eq 'linux';

  return false;
}

sub is_mac {

  return true if lc(_osname()) eq 'macos';
  return true if lc(_osname()) eq 'darwin';

  return false;
}

sub is_non {

  return false if is_bsd();
  return false if is_cyg();
  return false if is_dos();
  return false if is_lin();
  return false if is_mac();
  return false if is_sun();
  return false if is_vms();
  return false if is_win();

  return true;
}

sub is_sun {

  return true if lc(_osname()) eq 'solaris';
  return true if lc(_osname()) eq 'sunos';

  return false;
}

sub is_vms {

  return true if lc(_osname()) eq 'vms';

  return false;
}

sub is_win {

  return true if lc(_osname()) eq 'mswin32';
  return true if lc(_osname()) eq 'dos';
  return true if lc(_osname()) eq 'os2';

  return false;
}

sub name {
  my ($self) = @_;

  my $name = _osname();

  return $name;
}

sub paths {
  my ($self) = @_;

  require File::Spec;

  my %seen;

  my $result = [grep !$seen{$_}++, File::Spec->path];

  return wantarray ? @{$result} : $result;
}

sub quote {
  my ($self, $data) = @_;

  if (!defined $data) {
    return '';
  }
  elsif ($self->is_win) {
    return ($data =~ /^"/ && $data =~ /"$/)
      ? $data
      : ('"' . (($data =~ s/"/\\"/gr) || "") . '"');
  }
  else {
    return ($data =~ /^'/ && $data =~ /'$/)
      ? $data
      : ("'" . (($data =~ s/'/'\\''/gr) || "") . "'");
  }
}

sub type {
  my ($self) = @_;

  my @types = qw(
    is_lin
    is_mac
    is_win
    is_bsd
    is_cyg
    is_sun
    is_vms
  );

  my $result = [grep $self->$_, @types];

  return $result->[0] || 'is_non';
}

sub where {
  my ($self, $name) = @_;

  my $result = $self->find($name, $self->paths);

  return wantarray ? @{$result} : $result;
}

sub which {
  my ($self, $name) = @_;

  my $result = $self->where($name);

  return $result->[0];
}

1;
