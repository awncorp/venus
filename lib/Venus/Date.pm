package Venus::Date;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';
with 'Venus::Role::Explainable';

use overload (
  '""' => 'explain',
  '!=' => sub{("$_[0]" + 0) != ($_[1] + 0)},
  '+' => sub{("$_[0]" + 0) + ($_[1] + 0)},
  '-' => sub{("$_[0]" + 0) - ($_[1] + 0)},
  '0+' => sub{($_[0]->epoch + 0)},
  '<' => sub{("$_[0]" + 0) < ($_[1] + 0)},
  '<=' => sub{("$_[0]" + 0) <= ($_[1] + 0)},
  '==' => sub{("$_[0]" + 0) == ($_[1] + 0)},
  '>' => sub{("$_[0]" + 0) > ($_[1] + 0)},
  '>=' => sub{("$_[0]" + 0) >= ($_[1] + 0)},
  'eq' => sub{"$_[0]" eq "$_[1]"},
  'ne' => sub{"$_[0]" ne "$_[1]"},
  '~~' => 'explain',
  fallback => 1,
);

# ATTRIBUTES

attr 'day';
attr 'month';
attr 'year';
attr 'hour';
attr 'minute';
attr 'second';

# BUILDERS

sub build_arg {
  my ($self, $time) = @_;

  my $data = {};
  my @time = gmtime $time;

  $data->{day} //= $time[3];
  $data->{hour} //= $time[2];
  $data->{minute} //= $time[1];
  $data->{month} //= $time[4] + 1;
  $data->{second} //= $time[0];
  $data->{year} //= $time[5] + 1900;

  return $data;
}

sub build_args {
  my ($self, $data) = @_;

  my @time = gmtime time;

  $data->{day} //= $time[3];
  $data->{hour} //= $time[2];
  $data->{minute} //= $time[1];
  $data->{month} //= $time[4] + 1;
  $data->{second} //= $time[0];
  $data->{year} //= $time[5] + 1900;

  return $data;
}

# METHODS

sub add {
  my ($self, $data) = @_;

  for my $name (qw(days hours minutes months seconds years)) {
    if (my $code = $self->can("add_$name")) {
      $self->$code($data->{$name});
    }
  }

  return $self;
}

sub add_days {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_DAY * $size) if $size;

  return $self->reset($self->epoch + $size);
}

sub add_hours {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_HOUR * $size) if $size;

  return $self->reset($self->epoch + $size);
}

sub add_hms {
  my ($self, $h, $m, $s) = @_;

  my $data = {};

  $data->{hours} = $h if defined $h;
  $data->{minutes} = $m if defined $m;
  $data->{seconds} = $s if defined $s;

  return $self->add($data);
}

sub add_mdy {
  my ($self, $m, $d, $y) = @_;

  my $data = {};

  $data->{days} = $d if defined $d;
  $data->{months} = $m if defined $m;
  $data->{years} = $y if defined $y;

  return $self->add($data);
}

sub add_minutes {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_MINUTE * $size) if $size;

  return $self->reset($self->epoch + $size);
}

sub add_months {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_MONTH * $size) if $size;

  return $self->reset($self->epoch + $size);
}

sub add_seconds {
  my ($self, $size) = @_;

  $size //= 0;

  return $self->reset($self->epoch + $size);
}

sub add_years {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_YEAR * $size) if $size;

  return $self->reset($self->epoch + $size);
}

sub epoch {
  my ($self) = @_;

  return $self->timepiece->epoch;
}

sub explain {
  my ($self) = @_;

  return $self->epoch;
}

sub format {
  my ($self, @args) = @_;

  return $self->timepiece->strftime(@args);
}

sub hms {
  my ($self) = @_;

  return $self->timepiece->hms;
}

sub iso8601 {
  my ($self) = @_;

  return $self->timepiece->datetime;
}

sub mdy {
  my ($self) = @_;

  return $self->timepiece->mdy;
}

sub parse {
  my ($self, @args) = @_;

  my $timepiece = $self->timepiece->strptime(@args);

  return $self->reset($timepiece->epoch);
}

sub reset {
  my ($self, $time) = @_;

  $time ||= time;

  my @time = gmtime $time;

  $self->day($time[3]);
  $self->hour($time[2]);
  $self->minute($time[1]);
  $self->month($time[4] + 1);
  $self->second($time[0]);
  $self->year($time[5] + 1900);

  return $self;
}

sub restart {
  my ($self, $here) = @_;

  my $timepiece = $self->timepiece->truncate(to => $here);

  return $self->reset($timepiece->epoch);
}

sub restart_day {
  my ($self) = @_;

  return $self->restart('day');
}

sub restart_hour {
  my ($self) = @_;

  return $self->restart('hour');
}

sub restart_minute {
  my ($self) = @_;

  return $self->restart('minute');
}

sub restart_month {
  my ($self) = @_;

  return $self->restart('month');
}

sub restart_quarter {
  my ($self) = @_;

  return $self->restart('quarter');
}

sub restart_second {
  my ($self) = @_;

  return $self->restart('second');
}

sub restart_year {
  my ($self) = @_;

  return $self->restart('year');
}

sub rfc822 {
  my ($self) = @_;

  return $self->format('%a, %d %b %Y %H:%M:%S %z');
}

sub rfc1123 {
  my ($self) = @_;

  return $self->format('%a, %d %b %Y %T GMT');
}

sub rfc3339 {
  my ($self) = @_;

  return "@{[$self->iso8601]}Z";
}

sub rfc7231 {
  my ($self) = @_;

  return $self->timepiece->strftime;
}

sub set {
  my ($self, $data) = @_;

  for my $name (qw(day hour minute month second year)) {
    if (defined $data->{$name}) {
      $self->$name($data->{$name});
    }
  }

  return $self;
}

sub set_hms {
  my ($self, $h, $m, $s) = @_;

  my $data = {};

  $data->{hour} = $h if defined $h;
  $data->{minute} = $m if defined $m;
  $data->{second} = $s if defined $s;

  return $self->set($data);
}

sub set_mdy {
  my ($self, $m, $d, $y) = @_;

  my $data = {};

  $data->{day} = $d if defined $d;
  $data->{month} = $m if defined $m;
  $data->{year} = $y if defined $y;

  return $self->set($data);
}

sub string {
  my ($self) = @_;

  return $self->rfc3339;
}

sub sub {
  my ($self, $data) = @_;

  for my $name (qw(days hours minutes months seconds years)) {
    if (my $code = $self->can("sub_$name")) {
      $self->$code($data->{$name});
    }
  }

  return $self;
}

sub sub_days {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_DAY * $size) if $size;

  return $self->reset($self->epoch - $size);
}

sub sub_hours {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_HOUR * $size) if $size;

  return $self->reset($self->epoch - $size);
}

sub sub_hms {
  my ($self, $h, $m, $s) = @_;

  my $data = {};

  $data->{hours} = $h if defined $h;
  $data->{minutes} = $m if defined $m;
  $data->{seconds} = $s if defined $s;

  return $self->sub($data);
}

sub sub_mdy {
  my ($self, $m, $d, $y) = @_;

  my $data = {};

  $data->{days} = $d if defined $d;
  $data->{months} = $m if defined $m;
  $data->{years} = $y if defined $y;

  return $self->sub($data);
}

sub sub_minutes {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_MINUTE * $size) if $size;

  return $self->reset($self->epoch - $size);
}

sub sub_months {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_MONTH * $size) if $size;

  return $self->reset($self->epoch - $size);
}

sub sub_seconds {
  my ($self, $size) = @_;

  $size //= 0;

  return $self->reset($self->epoch - $size);
}

sub sub_years {
  my ($self, $size) = @_;

  $size //= 0;

  $size = ($self->timeseconds->ONE_YEAR * $size) if $size;

  return $self->reset($self->epoch - $size);
}

sub timelocal {
  my ($self) = @_;

  require Time::Local;

  my $day = $self->day;
  my $hour = $self->hour;
  my $minute = $self->minute;
  my $month = $self->month - 1;
  my $second = $self->second;
  my $year = $self->year;

  return Time::Local::timegm($second, $minute, $hour, $day, $month, $year);
}

sub timepiece {
  my ($self) = @_;

  require Time::Piece;

  return Time::Piece->gmtime(0 + $self->timelocal);
}

sub timeseconds {
  my ($self, $time) = @_;

  require Time::Seconds;

  return Time::Seconds->new($time // 0);
}

1;
