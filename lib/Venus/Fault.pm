package Venus::Fault;

use 5.018;

use strict;
use warnings;

use overload (
  '""' => 'explain',
  'eq' => sub{$_[0]->{message} eq "$_[1]"},
  'ne' => sub{$_[0]->{message} ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0]->{message})]}/},
  '~~' => 'explain',
  fallback => 1,
);

# METHODS

sub new {
  return bless({message => $_[1] || 'Exception!'})->trace;
}

sub explain {
  my ($self) = @_;

  $self->trace(1) if !@{$self->frames};

  my $frames = $self->{'$frames'};

  my $file = $frames->[0][1];
  my $line = $frames->[0][2];
  my $pack = $frames->[0][0];
  my $subr = $frames->[0][3];

  my $message = $self->{message};

  my @stacktrace = ("$message in $file at line $line");

  push @stacktrace, 'Traceback (reverse chronological order):' if @$frames > 1;

  @stacktrace = (join("\n\n", grep defined, @stacktrace), '');

  for (my $i = 1; $i < @$frames; $i++) {
    my $pack = $frames->[$i][0];
    my $file = $frames->[$i][1];
    my $line = $frames->[$i][2];
    my $subr = $frames->[$i][3];

    push @stacktrace, "$subr\n  in $file at line $line";
  }

  return join "\n", @stacktrace, "";
}

sub frames {
  my ($self) = @_;

  return $self->{'$frames'} //= [];
}

sub throw {
  my ($self, @args) = @_;

  $self = $self->new(@args) if !ref $self;

  die $self;
}

sub trace {
  my ($self, $offset, $limit) = @_;

  my $frames = $self->frames;

  @$frames = ();

  for (my $i = $offset // 1; my @caller = caller($i); $i++) {
    push @$frames, [@caller];

    last if defined $limit && $i + 1 == $offset + $limit;
  }

  return $self;
}

1;
