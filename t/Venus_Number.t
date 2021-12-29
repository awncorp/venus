package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Number

=cut

$test->for('name');

=tagline

Number Class

=cut

$test->for('tagline');

=abstract

Number Class for Perl 5

=cut

$test->for('abstract');

=includes

method: abs
method: atan2
method: cos
method: decr
method: default
method: exp
method: hex
method: incr
method: int
method: log
method: mod
method: neg
method: pow
method: range
method: sin
method: sqrt

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1_000);

  # $number->abs;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating number data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method abs

The abs method returns the absolute value of the number.

=signature abs

  abs() (Num)

=metadata abs

{
  since => '0.01',
}

=example-1 abs

  # given: synopsis;

  my $abs = $number->abs;

  # 1000

=cut

$test->for('example', 1, 'abs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1000;

  $result
});

=example-2 abs

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $abs = $number->abs;

  # 12

=cut

$test->for('example', 2, 'abs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12;

  $result
});

=example-3 abs

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(-12);

  my $abs = $number->abs;

  # 12

=cut

$test->for('example', 3, 'abs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12;

  $result
});

=method atan2

The atan2 method returns the arctangent of Y/X in the range -PI to PI.

=signature atan2

  atan2() (Num)

=metadata atan2

{
  since => '0.01',
}

=example-1 atan2

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1);

  my $atan2 = $number->atan2(1);

  # 0.785398163397448

=cut

$test->for('example', 1, 'atan2', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '0.785398163397448';

  $result
});

=method cos

The cos method computes the cosine of the number (expressed in radians).

=signature cos

  cos() (Num)

=metadata cos

{
  since => '0.01',
}

=example-1 cos

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $cos = $number->cos;

  # 0.843853958732492

=cut

$test->for('example', 1, 'cos', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '0.843853958732492';

  $result
});

=method decr

The decr method returns the numeric number decremented by 1.

=signature decr

  decr() (Num)

=metadata decr

{
  since => '0.01',
}

=example-1 decr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $decr = $number->decr;

  # 123456788

=cut

$test->for('example', 1, 'decr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456788;

  $result
});

=example-2 decr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $decr = $number->decr(123456788);

  # 1

=cut

$test->for('example', 2, 'decr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method default

The default method returns the default value, i.e. C<0>.

=signature default

  default() (Int)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $number->default;

  # 0

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method exp

The exp method returns e (the natural logarithm base) to the power of the
number.

=signature exp

  exp() (Num)

=metadata exp

{
  since => '0.01',
}

=example-1 exp

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(0);

  my $exp = $number->exp;

  # 1

=cut

$test->for('example', 1, 'exp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 exp

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1);

  my $exp = $number->exp;

  # 2.71828182845905

=cut

$test->for('example', 2, 'exp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '2.71828182845905';

  $result
});

=example-3 exp

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(1.5);

  my $exp = $number->exp;

  # 4.48168907033806

=cut

$test->for('example', 3, 'exp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '4.48168907033806';

  $result
});

=method hex

The hex method returns a hex string representing the value of the number.

=signature hex

  hex() (Str)

=metadata hex

{
  since => '0.01',
}

=example-1 hex

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(175);

  my $hex = $number->hex;

  # "0xaf"

=cut

$test->for('example', 1, 'hex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "0xaf";

  $result
});

=method incr

The incr method returns the numeric number incremented by 1.

=signature incr

  incr() (Num)

=metadata incr

{
  since => '0.01',
}

=example-1 incr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456789);

  my $incr = $number->incr;

  # 123456790

=cut

$test->for('example', 1, 'incr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456790;

  $result
});

=example-2 incr

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(123456790);

  my $incr = $number->incr(-1);

  # 123456789

=cut

$test->for('example', 2, 'incr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 123456789;

  $result
});

=method int

The int method returns the integer portion of the number. Do not use this
method for rounding.

=signature int

  int() (Int)

=metadata int

{
  since => '0.01',
}

=example-1 int

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12.5);

  my $int = $number->int;

  # 12

=cut

$test->for('example', 1, 'int', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 12;

  $result
});

=method log

The log method returns the natural logarithm (base e) of the number.

=signature log

  log() (Num)

=metadata log

{
  since => '0.01',
}

=example-1 log

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $log = $number->log;

  # 9.42100640177928

=cut

$test->for('example', 1, 'log', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '9.42100640177928';

  $result
});

=method mod

The mod method returns the division remainder of the number divided by the
argment.

=signature mod

  mod() (Int)

=metadata mod

{
  since => '0.01',
}

=example-1 mod

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(1);

  # 0

=cut

$test->for('example', 1, 'mod', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-2 mod

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(2);

  # 0

=cut

$test->for('example', 2, 'mod', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-3 mod

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12);

  my $mod = $number->mod(5);

  # 2

=cut

$test->for('example', 3, 'mod', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
});

=method neg

The neg method returns a negative version of the number.

=signature neg

  neg() (Num)

=metadata neg

{
  since => '0.01',
}

=example-1 neg

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $neg = $number->neg;

  # -12345

=cut

$test->for('example', 1, 'neg', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == -12345;

  $result
});

=method pow

The pow method returns a number, the result of a math operation, which is the
number to the power of the argument.

=signature pow

  pow() (Num)

=metadata pow

{
  since => '0.01',
}

=example-1 pow

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $pow = $number->pow(3);

  # 1881365963625

=cut

$test->for('example', 1, 'pow', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1881365963625;

  $result
});

=method range

The range method returns an array reference containing integer increasing values
up-to or down-to the limit specified.

=signature range

  range() (ArrayRef)

=metadata range

{
  since => '0.01',
}

=example-1 range

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(5);

  my $range = $number->range(9);

  # [5..9]

=cut

$test->for('example', 1, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [5..9];

  $result
});

=example-2 range

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(5);

  my $range = $number->range(1);

  # [5, 4, 3, 2, 1]

=cut

$test->for('example', 2, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [5, 4, 3, 2, 1];

  $result
});

=method sin

The sin method returns the sine of the number (expressed in radians).

=signature sin

  sin() (Num)

=metadata sin

{
  since => '0.01',
}

=example-1 sin

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $sin = $number->sin;

  # -0.993771636455681

=cut

$test->for('example', 1, 'sin', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ '-0.993';

  $result
});

=method sqrt

The sqrt method returns the positive square root of the number.

=signature sqrt

  sqrt() (Num)

=metadata sqrt

{
  since => '0.01',
}

=example-1 sqrt

  package main;

  use Venus::Number;

  my $number = Venus::Number->new(12345);

  my $sqrt = $number->sqrt;

  # 111.108055513541

=cut

$test->for('example', 1, 'sqrt', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ '111.10';

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

$test->render('lib/Venus/Number.pod') if $ENV{RENDER};

ok 1 and done_testing;