package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Date

=cut

$test->for('name');

=tagline

Date Class

=cut

$test->for('tagline');

=abstract

Date Class for Perl 5

=cut

$test->for('abstract');

=includes

method: add
method: add_days
method: add_hours
method: add_hms
method: add_mdy
method: add_minutes
method: add_months
method: add_seconds
method: add_years
method: epoch
method: explain
method: format
method: hms
method: iso8601
method: mdy
method: parse
method: reset
method: restart
method: rfc3339
method: rfc7231
method: set
method: set_hms
method: set_mdy
method: string
method: sub
method: sub_days
method: sub_hours
method: sub_hms
method: sub_mdy
method: sub_minutes
method: sub_months
method: sub_seconds
method: sub_years

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Date;

  my $date = Venus::Date->new(570672000);

  # $date->string;
  # '1988-02-01T00:00:00Z'

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for formatting, parsing, and manipulating date
and time data.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable
Venus::Role::Explainable

=cut

$test->for('integrates');

=attributes

day: rw, opt, Int
month: rw, opt, Int
year: rw, opt, Int
hour: rw, opt, Int
minute: rw, opt, Int
second: rw, opt, Int

=cut

$test->for('attributes');

=method add

The add method increments the date and time attributes specified.

=signature add

  add(HashRef $data) (Date)

=metadata add

{
  since => '0.01',
}

=example-1 add

  # given: synopsis;

  $date = $date->add({
    days => 1,
    months => 1,
    years => 1,
  });

  # $date->string; # 1989-03-03T16:17:54Z
  # $date->epoch; # 604945074

=cut

$test->for('example', 1, 'add', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Date');
  ok $result->epoch == 604945074;

  $result
});

=example-2 add

  # given: synopsis;

  $date = $date->add({
    hours => 1,
    minutes => 1,
    seconds => 1,
  });

  # $date->string; # 1988-02-01T01:01:01Z
  # $date->epoch; # 570675661

=cut

$test->for('example', 2, 'add', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Date');
  ok $result->epoch == 570675661;

  $result
});

=method add_days

The add_days method increments the C<day> attribute.

=signature add_days

  add_days(Int $days) (Any)

=metadata add_days

{
  since => '0.01',
}

=example-1 add_days

  # given: synopsis;

  $date = $date->add_days(1);

  # $date->string; # 1988-02-02T00:00:00Z
  # $date->epoch; # 570758400

=cut

$test->for('example', 1, 'add_days', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570758400;

  $result
});

=example-2 add_days

  # given: synopsis;

  $date = $date->add_days(40);

  # $date->string; # 1988-03-12T00:00:00Z
  # $date->epoch; # 574128000

=cut

$test->for('example', 2, 'add_days', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 574128000;

  $result
});

=example-3 add_days

  # given: synopsis;

  $date = $date->add_days(-1);

  # $date->string; # 1988-01-31T00:00:00Z
  # $date->epoch; # 570585600

=cut

$test->for('example', 3, 'add_days', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570585600;

  $result
});

=method add_hours

The add_hours method increments the C<hour> attribute.

=signature add_hours

  add_hours(Int $hours) (Any)

=metadata add_hours

{
  since => '0.01',
}

=example-1 add_hours

  # given: synopsis;

  $date = $date->add_hours(1);

  # $date->string; # 1988-02-01T01:00:00Z
  # $date->epoch; # 570675600

=cut

$test->for('example', 1, 'add_hours', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675600;

  $result
});

=example-2 add_hours

  # given: synopsis;

  $date = $date->add_hours(25);

  # $date->string; # 1988-02-02T01:00:00Z
  # $date->epoch; # 570762000

=cut

$test->for('example', 2, 'add_hours', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570762000;

  $result
});

=example-3 add_hours

  # given: synopsis;

  $date = $date->add_hours(-1);

  # $date->string; # 1988-01-31T23:00:00Z
  # $date->epoch; # 570668400

=cut

$test->for('example', 3, 'add_hours', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570668400;

  $result
});

=method add_hms

The add_hms method increments the C<hour>, C<minute>, and C<second> attributes.

=signature add_hms

  add_hms(Maybe[Int] $hours, Maybe[Int] $minutes, Maybe[Int] $seconds) (Date)

=metadata add_hms

{
  since => '0.01',
}

=example-1 add_hms

  # given: synopsis;

  $date = $date->add_hms(1, 0, 0);

  # $date->string; # 1988-02-01T01:00:00Z
  # $date->epoch; # 570675600

=cut

$test->for('example', 1, 'add_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675600;

  $result
});

=example-2 add_hms

  # given: synopsis;

  $date = $date->add_hms(undef, 1, 1);

  # $date->string; # 1988-02-01T00:01:01Z
  # $date->epoch; # 570672061

=cut

$test->for('example', 2, 'add_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672061;

  $result
});

=example-3 add_hms

  # given: synopsis;

  $date = $date->add_hms(1, 1);

  # $date->string; # 1988-02-01T01:01:00Z
  # $date->epoch; # 570675660

=cut

$test->for('example', 3, 'add_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675660;

  $result
});

=method add_mdy

The add_mdy method increments the C<month>, C<day>, and C<years> attributes.

=signature add_mdy

  add_mdy(Maybe[Int] $months, Maybe[Int] $days, Maybe[Int] $years) (Date)

=metadata add_mdy

{
  since => '0.01',
}

=example-1 add_mdy

  # given: synopsis;

  $date = $date->add_mdy(1, 0, 0);

  # $date->string; # 1988-03-02T10:29:04Z
  # $date->epoch; # 573301744

=cut

$test->for('example', 1, 'add_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 573301744;

  $result
});

=example-2 add_mdy

  # given: synopsis;

  $date = $date->add_mdy(undef, 1, 1);

  # $date->string; # 1989-02-01T05:48:50Z
  # $date->epoch; # 602315330

=cut

$test->for('example', 2, 'add_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 602315330;

  $result
});

=example-3 add_mdy

  # given: synopsis;

  $date = $date->add_mdy(1, 1);

  # $date->string; # 1988-03-03T10:29:04Z
  # $date->epoch; # 573388144

=cut

$test->for('example', 3, 'add_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 573388144;

  $result
});

=method add_minutes

The add_minutes method increments the C<minute> attribute.

=signature add_minutes

  add_minutes(Int $minutes) (Date)

=metadata add_minutes

{
  since => '0.01',
}

=example-1 add_minutes

  # given: synopsis;

  $date = $date->add_minutes(1);

  # $date->string; # 1988-02-01T00:01:00Z
  # $date->epoch; # 570672060

=cut

$test->for('example', 1, 'add_minutes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672060;

  $result
});

=example-2 add_minutes

  # given: synopsis;

  $date = $date->add_minutes(61);

  # $date->string; # 1988-02-01T01:01:00Z
  # $date->epoch; # 570675660

=cut

$test->for('example', 2, 'add_minutes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675660;

  $result
});

=example-3 add_minutes

  # given: synopsis;

  $date = $date->add_minutes(-1);

  # $date->string; # 1988-01-31T23:59:00Z
  # $date->epoch; # 570671940

=cut

$test->for('example', 3, 'add_minutes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570671940;

  $result
});

=method add_months

The add_months method increments the C<month> attribute.

=signature add_months

  add_months(Int $months) (Date)

=metadata add_months

{
  since => '0.01',
}

=example-1 add_months

  # given: synopsis;

  $date = $date->add_months(1);

  # $date->string; # 1988-03-02T10:29:04Z
  # $date->epoch; # 573301744

=cut

$test->for('example', 1, 'add_months', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 573301744;

  $result
});

=example-2 add_months

  # given: synopsis;

  $date = $date->add_months(13);

  # $date->string; # 1989-03-02T16:17:52Z
  # $date->epoch; # 604858672

=cut

$test->for('example', 2, 'add_months', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 604858672;

  $result
});

=example-3 add_months

  # given: synopsis;

  $date = $date->add_months(-1);

  # $date->string; # 1988-01-01T13:30:56Z
  # $date->epoch; # 568042256

=cut

$test->for('example', 3, 'add_months', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 568042256;

  $result
});

=method add_seconds

The add_seconds method increments the C<second> attribute.

=signature add_seconds

  add_seconds(Int $seconds) (Date)

=metadata add_seconds

{
  since => '0.01',
}

=example-1 add_seconds

  # given: synopsis;

  $date = $date->add_seconds(1);

  # $date->string; # 1988-02-01T00:00:01Z
  # $date->epoch; # 570672001

=cut

$test->for('example', 1, 'add_seconds', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672001;

  $result
});

=example-2 add_seconds

  # given: synopsis;

  $date = $date->add_seconds(61);

  # $date->string; # 1988-02-01T00:01:01Z
  # $date->epoch; # 570672061

=cut

$test->for('example', 2, 'add_seconds', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672061;

  $result
});

=example-3 add_seconds

  # given: synopsis;

  $date = $date->add_seconds(-1);

  # $date->string; # 1988-01-31T23:59:59Z
  # $date->epoch; # 570671999

=cut

$test->for('example', 3, 'add_seconds', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570671999;

  $result
});

=method add_years

The add_years method increments the C<year> attribute.

=signature add_years

  add_years(Int $years) (Date)

=metadata add_years

{
  since => '0.01',
}

=example-1 add_years

  # given: synopsis;

  $date = $date->add_years(1);

  # $date->string; # 1989-01-31T05:48:50Z
  # $date->epoch; # 602228930

=cut

$test->for('example', 1, 'add_years', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 602228930;

  $result
});

=example-2 add_years

  # given: synopsis;

  $date = $date->add_years(50);

  # $date->string; # 2038-01-31T02:41:40Z
  # $date->epoch; # 2148518500

=cut

$test->for('example', 2, 'add_years', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 2148518500;

  $result
});

=example-3 add_years

  # given: synopsis;

  $date = $date->add_years(-1);

  # $date->string; # 1987-01-31T18:11:10Z
  # $date->epoch; # 539115070

=cut

$test->for('example', 3, 'add_years', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 539115070;

  $result
});

=method epoch

The epoch method returns the epoch.

=signature epoch

  epoch() (Int)

=metadata epoch

{
  since => '0.01',
}

=example-1 epoch

  # given: synopsis;

  my $epoch = $date->epoch;

  # 570672000

=cut

$test->for('example', 1, 'epoch', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 570672000;

  $result
});

=method explain

The explain method returns the epoch and is used in stringification operations.

=signature explain

  explain() (Int)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $date->explain;

  # 570672000

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 570672000;

  $result
});

=method format

The format method returns the formatted date and time string. See
L<strftime|http://www.unix.com/man-page/FreeBSD/3/strftime/> for formatting
rules.

=signature format

  format(Str $format) (Str)

=metadata format

{
  since => '0.01',
}

=example-1 format

  # given: synopsis;

  my $format = $date->format('%A, %B %e, %Y');

  # Monday, February  1, 1988

=cut

$test->for('example', 1, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Monday, February  1, 1988';

  $result
});

=example-2 format

  # given: synopsis;

  my $format = $date->format('%b %e %a');

  # Feb  1 Mon

=cut

$test->for('example', 2, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Feb  1 Mon';

  $result
});

=method hms

The hms method returns the time formatted as C<hh:mm:ss>.

=signature hms

  hms() (Str)

=metadata hms

{
  since => '0.01',
}

=example-1 hms

  # given: synopsis;

  my $hms = $date->hms;

  # 00:00:00

=cut

$test->for('example', 1, 'hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '00:00:00';

  $result
});

=method iso8601

The iso8601 method returns the date and time formatted as an ISO8601 string.

=signature iso8601

  iso8601() (Str)

=metadata iso8601

{
  since => '0.01',
}

=example-1 iso8601

  # given: synopsis;

  my $iso8601 = $date->iso8601;

  # 1988-02-01T00:00:00

=cut

$test->for('example', 1, 'iso8601', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '1988-02-01T00:00:00';

  $result
});

=method mdy

The mdy method returns the date formatted as C<mm-dd-yyyy>.

=signature mdy

  mdy() (Str)

=metadata mdy

{
  since => '0.01',
}

=example-1 mdy

  # given: synopsis;

  my $mdy = $date->mdy;

  # 02-01-1988

=cut

$test->for('example', 1, 'mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '02-01-1988';

  $result
});

=method parse

The parse method resets and returns a date object based on the parsed time
provided. See L<strptime|http://www.unix.com/man-page/FreeBSD/3/strptime/> for
parsing rules.

=signature parse

  parse(Any @data) (Date)

=metadata parse

{
  since => '0.01',
}

=example-1 parse

  # given: synopsis;

  $date = $date->parse('Monday, February  1, 1988', '%A, %B %e, %Y');

  # $date->string; # 1988-02-01T00:00:00Z
  # $date->epoch; # 570672000

=cut

$test->for('example', 1, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672000;

  $result
});

=method reset

The reset method resets all attributes to correspond with the epoch provided.

=signature reset

  reset(Int $time) (Date)

=metadata reset

{
  since => '0.01',
}

=example-1 reset

  # given: synopsis;

  $date = $date->reset(631152000);

  # $date->string; # 1990-01-01T00:00:00Z
  # $date->epoch; # 631152000

=cut

$test->for('example', 1, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 631152000;

  $result
});

=method restart

The restart method truncates the date and time to the specified unit of time,
e.g. C<year>, C<quarter>, C<month>, C<day>, C<hour>, C<minute>, C<second>.

=signature restart

  restart(Str $interval) (Date)

=metadata restart

{
  since => '0.01',
}

=example-1 restart

  # given: synopsis;

  $date = $date->restart('year');

  # $date->string; # 1988-01-01T00:00:00Z
  # $date->epoch; # 567993600

=cut

$test->for('example', 1, 'restart', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 567993600;

  $result
});

=example-2 restart

  # given: synopsis;

  $date = $date->restart('quarter');

  # $date->string; # 1988-01-01T00:00:00Z
  # $date->epoch; # 567993600

=cut

$test->for('example', 2, 'restart', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 567993600;

  $result
});

=example-3 restart

  # given: synopsis;

  $date = $date->restart('month');

  # $date->string; # 1988-02-01T00:00:00Z
  # $date->epoch; # 570672000

=cut

$test->for('example', 3, 'restart', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672000;

  $result
});

=method rfc822

The rfc822 method returns the date and time formatted as an RFC822 string.

=signature rfc822

  rfc822() (Str)

=metadata rfc822

{
  since => '0.01',
}

=example-1 rfc822

  # given: synopsis;

  my $rfc822 = $date->rfc822;

  # Mon, 01 Feb 1988 00:00:00 +0000

=cut

$test->for('example', 1, 'rfc822', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Mon, 01 Feb 1988 00:00:00 +0000';

  $result
});

=method rfc1123

The rfc1123 method returns the date and time formatted as an RFC1123 string.

=signature rfc1123

  rfc1123() (Str)

=metadata rfc1123

{
  since => '0.01',
}

=example-1 rfc1123

  # given: synopsis;

  my $rfc1123 = $date->rfc1123;

  # Mon, 01 Feb 1988 00:00:00 GMT

=cut

$test->for('example', 1, 'rfc1123', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Mon, 01 Feb 1988 00:00:00 GMT';

  $result
});

=method rfc3339

The rfc3339 method returns the date and time formatted as an RFC3339 string.

=signature rfc3339

  rfc3339() (Str)

=metadata rfc3339

{
  since => '0.01',
}

=example-1 rfc3339

  # given: synopsis;

  my $rfc3339 = $date->rfc3339;

  # 1988-02-01T00:00:00Z

=cut

$test->for('example', 1, 'rfc3339', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '1988-02-01T00:00:00Z';

  $result
});

=method rfc7231

The rfc7231 method returns the date and time formatted as an RFC7231 string.

=signature rfc7231

  rfc7231() (Str)

=metadata rfc7231

{
  since => '0.01',
}

=example-1 rfc7231

  # given: synopsis;

  my $rfc7231 = $date->rfc7231;

  # Mon, 01 Feb 1988 00:00:00 UTC

=cut

$test->for('example', 1, 'rfc7231', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Mon, 01 Feb 1988 00:00:00 UTC';

  $result
});

=method set

The set method sets the date and time attributes specified.

=signature set

  set(HashRef $data) (Date)

=metadata set

{
  since => '0.01',
}

=example-1 set

  # given: synopsis;

  $date = $date->set({
    day => 1,
    month => 1,
    year => 2000,
  });

  # $date->string; # 2000-01-01T00:00:00Z
  # $date->epoch; # 946684800

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 946684800;

  $result
});

=example-2 set

  # given: synopsis;

  $date = $date->set({
    day => 1,
    month => 12,
  });

  # $date->string; # 1988-12-01T00:00:00Z
  # $date->epoch; # 596937600

=cut

$test->for('example', 2, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 596937600;

  $result
});

=example-3 set

  # given: synopsis;

  $date = $date->set({
    day => 1,
    month => 12,
    year => 1979,
  });

  # $date->string; # 1979-12-01T00:00:00Z
  # $date->epoch; # 312854400

=cut

$test->for('example', 3, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 312854400;

  $result
});

=method set_hms

The set_hms method sets the C<hour>, C<minute>, and C<second> attributes.

=signature set_hms

  set_hms(Maybe[Int] $hours, Maybe[Int] $minutes, Maybe[Int] $seconds) (Date)

=metadata set_hms

{
  since => '0.01',
}

=example-1 set_hms

  # given: synopsis;

  $date = $date->set_hms(1, 0, 0);

  # $date->string; # 1988-02-01T01:00:00Z
  # $date->epoch; # 570675600

=cut

$test->for('example', 1, 'set_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675600;

  $result
});

=example-2 set_hms

  # given: synopsis;

  $date = $date->set_hms(undef, 30, 30);

  # $date->string; # 1988-02-01T00:30:30Z
  # $date->epoch; # 570673830

=cut

$test->for('example', 2, 'set_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570673830;

  $result
});

=example-3 set_hms

  # given: synopsis;

  $date = $date->set_hms(0, 59, 59);

  # $date->string; # 1988-02-01T00:59:59Z
  # $date->epoch; # 570675599

=cut

$test->for('example', 3, 'set_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675599;

  $result
});

=method set_mdy

The set_mdy method sets the C<month>, C<day>, and C<year> attributes.


=signature set_mdy

  set_mdy(Maybe[Int] $months, Maybe[Int] $days, Maybe[Int] $years) (Date)

=metadata set_mdy

{
  since => '0.01',
}

=example-1 set_mdy

  # given: synopsis;

  $date = $date->set_mdy(4, 30, 1990);

  # $date->string; # 1990-04-30T00:00:00Z
  # $date->epoch; # 641433600

=cut

$test->for('example', 1, 'set_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 641433600;

  $result
});

=example-2 set_mdy

  # given: synopsis;

  $date = $date->set_mdy(4, 30, undef);

  # $date->string; # 1988-04-30T00:00:00Z
  # $date->epoch; # 578361600

=cut

$test->for('example', 2, 'set_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 578361600;

  $result
});

=example-3 set_mdy

  # given: synopsis;

  $date = $date->set_mdy(undef, 15, undef);

  # $date->string; # 1988-02-15T00:00:00Z
  # $date->epoch; # 571881600

=cut

$test->for('example', 3, 'set_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 571881600;

  $result
});

=method string

The string method returns a date and time string, and is an alias for
L</rfc3339>.

=signature string

  string() (Str)

=metadata string

{
  since => '0.01',
}

=example-1 string

  # given: synopsis;

  my $string = $date->string;

  # 1988-02-01T00:00:00Z

=cut

$test->for('example', 1, 'string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '1988-02-01T00:00:00Z';

  $result
});

=method sub

The sub method method decrements the date and time attributes specified.

=signature sub

  sub(HashRef $data) (Date)

=metadata sub

{
  since => '0.01',
}

=example-1 sub

  # given: synopsis;

  $date = $date->sub({
    days => 1,
    months => 1,
    years => 1,
  });

  # $date->string; # 1986-12-31T07:42:06Z
  # $date->epoch; # 536398926

=cut

$test->for('example', 1, 'sub', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 536398926;

  $result
});

=example-2 sub

  # given: synopsis;

  $date = $date->sub({
    hours => 1,
    minutes => 1,
    seconds => 1,
  });

  # $date->string; # 1988-01-31T22:58:59Z
  # $date->epoch; # 570668339

=cut

$test->for('example', 2, 'sub', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570668339;

  $result
});

=method sub_days

The sub_days method decrements the C<day> attribute.

=signature sub_days

  sub_days(Int $days) (Date)

=metadata sub_days

{
  since => '0.01',
}

=example-1 sub_days

  # given: synopsis;

  $date = $date->sub_days(1);

  # $date->string; # 1988-01-31T00:00:00Z
  # $date->epoch; # 570585600

=cut

$test->for('example', 1, 'sub_days', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570585600;

  $result
});

=example-2 sub_days

  # given: synopsis;

  $date = $date->sub_days(32);

  # $date->string; # 1987-12-31T00:00:00Z
  # $date->epoch; # 567907200

=cut

$test->for('example', 2, 'sub_days', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 567907200;

  $result
});

=example-3 sub_days

  # given: synopsis;

  $date = $date->sub_days(-1);

  # $date->string; # 1988-02-02T00:00:00Z
  # $date->epoch; # 570758400

=cut

$test->for('example', 3, 'sub_days', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570758400;

  $result
});

=method sub_hours

The sub_hours method decrements the C<hour> attribute.

=signature sub_hours

  sub_hours(Int $hours) (Any)

=metadata sub_hours

{
  since => '0.01',
}

=example-1 sub_hours

  # given: synopsis;

  $date = $date->sub_hours(1);

  # $date->string; # 1988-01-31T23:00:00Z
  # $date->epoch; # 570668400

=cut

$test->for('example', 1, 'sub_hours', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570668400;

  $result
});

=example-2 sub_hours

  # given: synopsis;

  $date = $date->sub_hours(25);

  # $date->string; # 1988-01-30T23:00:00Z
  # $date->epoch; # 570582000

=cut

$test->for('example', 2, 'sub_hours', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570582000;

  $result
});

=example-3 sub_hours

  # given: synopsis;

  $date = $date->sub_hours(-1);

  # $date->string; # 1988-02-01T01:00:00Z
  # $date->epoch; # 570675600

=cut

$test->for('example', 3, 'sub_hours', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570675600;

  $result
});

=method sub_hms

The sub_hms method decrements the C<hour>, C<minute>, and C<second> attributes.

=signature sub_hms

  sub_hms(Maybe[Int] $hours, Maybe[Int] $minutes, Maybe[Int] $seconds) (Date)

=metadata sub_hms

{
  since => '0.01',
}

=example-1 sub_hms

  # given: synopsis;

  $date = $date->sub_hms(1, 0, 0);

  # $date->string; # 1988-01-31T23:00:00Z
  # $date->epoch; # 570668400

=cut

$test->for('example', 1, 'sub_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570668400;

  $result
});

=example-2 sub_hms

  # given: synopsis;

  $date = $date->sub_hms(undef, 1, 1);

  # $date->string; # 1988-01-31T23:58:59Z
  # $date->epoch; # 570671939

=cut

$test->for('example', 2, 'sub_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570671939;

  $result
});

=example-3 sub_hms

  # given: synopsis;

  $date = $date->sub_hms(1, 1);

  # $date->string; # 1988-01-31T22:59:00Z
  # $date->epoch; # 570668340

=cut

$test->for('example', 3, 'sub_hms', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570668340;

  $result
});

=method sub_mdy

The sub_mdy method decrements the C<month>, C<day>, and C<year> attributes.

=signature sub_mdy

  sub_mdy(Maybe[Int] $months, Maybe[Int] $days, Maybe[Int] $years) (Date)

=metadata sub_mdy

{
  since => '0.01',
}

=example-1 sub_mdy

  # given: synopsis;

  $date = $date->sub_mdy(1, 1, 1);

  # $date->string; # 1986-12-31T07:42:06Z
  # $date->epoch; # 536398926

=cut

$test->for('example', 1, 'sub_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 536398926;

  $result
});

=example-2 sub_mdy

  # given: synopsis;

  $date = $date->sub_mdy(1, 1, undef);

  # $date->string; # 1987-12-31T13:30:56Z
  # $date->epoch; # 567955856

=cut

$test->for('example', 2, 'sub_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 567955856;

  $result
});

=example-3 sub_mdy

  # given: synopsis;

  $date = $date->sub_mdy(1, 1);

  # $date->string; # 1987-12-31T13:30:56Z
  # $date->epoch; # 567955856

=cut

$test->for('example', 3, 'sub_mdy', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 567955856;

  $result
});

=method sub_minutes

The sub_minutes method decrements the C<minute> attribute.

=signature sub_minutes

  sub_minutes(Int $minutes) (Date)

=metadata sub_minutes

{
  since => '0.01',
}

=example-1 sub_minutes

  # given: synopsis;

  $date = $date->sub_minutes(1);

  # $date->string; # 1988-01-31T23:59:00Z
  # $date->epoch; # 570671940

=cut

$test->for('example', 1, 'sub_minutes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570671940;

  $result
});

=example-2 sub_minutes

  # given: synopsis;

  $date = $date->sub_minutes(61);

  # $date->string; # 1988-01-31T22:59:00Z
  # $date->epoch; # 570668340

=cut

$test->for('example', 2, 'sub_minutes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570668340;

  $result
});

=example-3 sub_minutes

  # given: synopsis;

  $date = $date->sub_minutes(-1);

  # $date->string; # 1988-02-01T00:01:00Z
  # $date->epoch; # 570672060

=cut

$test->for('example', 3, 'sub_minutes', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672060;

  $result
});

=method sub_months

The sub_months method decrements the C<month> attribute.

=signature sub_months

  sub_months(Int $months) (Date)

=metadata sub_months

{
  since => '0.01',
}

=example-1 sub_months

  # given: synopsis;

  $date = $date->sub_months(1);

  # $date->string; # 1988-01-01T13:30:56Z
  # $date->epoch; # 568042256

=cut

$test->for('example', 1, 'sub_months', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 568042256;

  $result
});

=example-2 sub_months

  # given: synopsis;

  $date = $date->sub_months(13);

  # $date->string; # 1987-01-01T07:42:08Z
  # $date->epoch; # 536485328

=cut

$test->for('example', 2, 'sub_months', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 536485328;

  $result
});

=example-3 sub_months

  # given: synopsis;

  $date = $date->sub_months(-1);

  # $date->string; # 1988-03-02T10:29:04Z
  # $date->epoch; # 573301744

=cut

$test->for('example', 3, 'sub_months', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 573301744;

  $result
});

=method sub_seconds

The sub_seconds method decrements the C<second> attribute.

=signature sub_seconds

  sub_seconds(Int $seconds) (Date)

=metadata sub_seconds

{
  since => '0.01',
}

=example-1 sub_seconds

  # given: synopsis;

  $date = $date->sub_seconds(1);

  # $date->string; # 1988-01-31T23:59:59Z
  # $date->epoch; # 570671999

=cut

$test->for('example', 1, 'sub_seconds', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570671999;

  $result
});

=example-2 sub_seconds

  # given: synopsis;

  $date = $date->sub_seconds(61);

  # $date->string; # 1988-01-31T23:58:59Z
  # $date->epoch; # 570671939

=cut

$test->for('example', 2, 'sub_seconds', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570671939;

  $result
});

=example-3 sub_seconds

  # given: synopsis;

  $date = $date->sub_seconds(-1);

  # $date->string; # 1988-02-01T00:00:01Z
  # $date->epoch; # 570672001

=cut

$test->for('example', 3, 'sub_seconds', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 570672001;

  $result
});

=method sub_years

The sub_years method decrements the C<years> attribute.

=signature sub_years

  sub_years(Int $years) (Date)

=metadata sub_years

{
  since => '0.01',
}

=example-1 sub_years

  # given: synopsis;

  $date = $date->sub_years(1);

  # $date->string; # 1987-01-31T18:11:10Z
  # $date->epoch; # 539115070

=cut

$test->for('example', 1, 'sub_years', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 539115070;

  $result
});

=example-2 sub_years

  # given: synopsis;

  $date = $date->sub_years(25);

  # $date->string; # 1963-01-31T22:39:10Z
  # $date->epoch; # -218251250

=cut

$test->for('example', 2, 'sub_years', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == -218251250;

  $result
});

=example-3 sub_years

  # given: synopsis;

  $date = $date->sub_years(-1);

  # $date->string; # 1989-01-31T05:48:50Z
  # $date->epoch; # 602228930

=cut

$test->for('example', 3, 'sub_years', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->epoch == 602228930;

  $result
});

=operator (!=)

This package overloads the C<!=> operator.

=cut

$test->for('operator', '(!=)');

=example-1 (!=)

  # given: synopsis;

  my $result = $date != 570672001;

  # 1

=cut

$test->for('example', 1, '(!=)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (+)

This package overloads the C<+> operator.

=cut

$test->for('operator', '(+)');

=example-1 (+)

  # given: synopsis;

  my $result = $date + 0;

  # 570672000

=cut

$test->for('example', 1, '(+)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 570672000;

  $result
});

=operator (-)

This package overloads the C<-> operator.

=cut

$test->for('operator', '(-)');

=example-1 (-)

  # given: synopsis;

  my $result = $date - 0;

  # 570672000

=cut

$test->for('example', 1, '(-)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 570672000;

  $result
});

=operator (0+)

This package overloads the C<0+> operator.

=cut

$test->for('operator', '(0+)');

=example-1 (0+)

  # given: synopsis;

  my $result = 0 + $date;

  # 570672000

=cut

$test->for('example', 1, '(0+)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 570672000;

  $result
});

=operator (<)

This package overloads the C<<> operator.

=cut

$test->for('operator', '(<)');

=example-1 (<)

  # given: synopsis;

  my $result = $date < 570672001;

  # 1

=cut

$test->for('example', 1, '(<)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (<=)

This package overloads the C<<=> operator.

=cut

$test->for('operator', '(<=)');

=example-1 (<=)

  # given: synopsis;

  my $result = $date <= 570672000;

  # 1

=cut

$test->for('example', 1, '(<=)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (==)

This package overloads the C<==> operator.

=cut

$test->for('operator', '(==)');

=example-1 (==)

  # given: synopsis;

  my $result = $date == 570672000;

  # 1

=cut

$test->for('example', 1, '(==)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (>)

This package overloads the C<>> operator.

=cut

$test->for('operator', '(>)');

=example-1 (>)

  # given: synopsis;

  my $result = $date > 570671999;

  # 1

=cut

$test->for('example', 1, '(>)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (>=)

This package overloads the C<>=> operator.

=cut

$test->for('operator', '(>=)');

=example-1 (>=)

  # given: synopsis;

  my $result = $date >= 570672000;

  # 1

=cut

$test->for('example', 1, '(>=)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $date eq '570672000';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $date ne '560672000';

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/Date.pod') if $ENV{RENDER};

ok 1 and done_testing;