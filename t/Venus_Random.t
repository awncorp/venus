package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

if (require Venus::Random && Venus::Random->new(42)->range(1, 50) != 38) {
  diag "OS ($^O) rand function is undeterministic" if $ENV{VENUS_DEBUG};
  goto SKIP;
}

my $test = test(__FILE__);

sub trunc {
  map substr($_, 0, 12), ref $_[0] eq 'ARRAY' ? @$_[0] : @_
}

=name

Venus::Random

=cut

$test->for('name');

=tagline

Random Class

=cut

$test->for('tagline');

=abstract

Random Class for Perl 5

=cut

$test->for('abstract');

=includes

method: bit
method: boolean
method: byte
method: character
method: collect
method: digit
method: float
method: letter
method: lowercased
method: nonzero
method: number
method: pick
method: range
method: repeat
method: reseed
method: reset
method: restore
method: select
method: symbol
method: uppercased

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Random;

  my $random = Venus::Random->new(42);

  # my $bit = $random->bit;

  # 1

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Random');

  $result
});

=description

This package provides an object-oriented interface for Perl's pseudo-random
number generator (or PRNG) which produces a deterministic sequence of bits
which approximate true randomness.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Valuable

=cut

$test->for('inherits');

=method bit

The bit method returns a C<1> or C<0> value, randomly.

=signature bit

  bit() (Int)

=metadata bit

{
  since => '1.11',
}

=example-1 bit

  # given: synopsis

  package main;

  my $bit = $random->bit;

  # 0

  # $bit = $random->bit;

  # 1

=cut

$test->for('example', 1, 'bit', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  my $random = Venus::Random->new(42);

  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;
  is $random->bit, 0;
  is $random->bit, 0;
  is $random->bit, 1;

  !$result
});

=method boolean

The boolean method returns a C<true> or C<false> value, randomly.

=signature boolean

  boolean() (Bool)

=metadata boolean

{
  since => '1.11',
}

=example-1 boolean

  # given: synopsis

  package main;

  my $boolean = $random->boolean;

  # 0

  # $boolean = $random->boolean;

  # 1

=cut

$test->for('example', 1, 'boolean', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  my $random = Venus::Random->new(42);

  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;
  is $random->boolean, 0;
  is $random->boolean, 0;
  is $random->boolean, 1;

  !$result
});

=method byte

The byte method returns random byte characters, randomly.

=signature byte

  byte() (Str)

=metadata byte

{
  since => '1.11',
}

=example-1 byte

  # given: synopsis

  package main;

  my $byte = $random->byte;

  # "\xBE"

  # $byte = $random->byte;

  # "W"

=cut

$test->for('example', 1, 'byte', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->byte, "\xBE";
  is $random->byte, "W";
  is $random->byte, "\34";
  is $random->byte, "l";
  is $random->byte, "\24";
  is $random->byte, "\xDB";
  is $random->byte, "\x7F";
  is $random->byte, "z";
  is $random->byte, "\xB0";
  is $random->byte, "\xD5";
  is $random->byte, "v";
  is $random->byte, "\x93";
  is $random->byte, "\x88";
  is $random->byte, "\6";
  is $random->byte, "\xC5";
  is $random->byte, "\x99";
  is $random->byte, "\xE8";
  is $random->byte, "}";
  is $random->byte, "\x89";
  is $random->byte, "\x7F";
  is $random->byte, "p";
  is $random->byte, "Y";
  is $random->byte, "\xEC";
  is $random->byte, "\17";
  is $random->byte, "\xDC";
  is $random->byte, "\xF8";
  is $random->byte, "\xD9";
  is $random->byte, "\@";
  is $random->byte, 4;
  is $random->byte, "\30";
  is $random->byte, "M";
  is $random->byte, "\xBA";
  is $random->byte, "\16";
  is $random->byte, "F";
  is $random->byte, "J";
  is $random->byte, "\x90";
  is $random->byte, "\xDA";
  is $random->byte, 7;
  is $random->byte, "\xCD";
  is $random->byte, "\xD1";
  is $random->byte, 6;
  is $random->byte, "\26";
  is $random->byte, "\x8E";
  is $random->byte, "\x86";
  is $random->byte, "\xDD";
  is $random->byte, "\xEE";
  is $random->byte, "#";
  is $random->byte, "\x8B";
  is $random->byte, "\x84";
  is $random->byte, "K";

  $result
});

=method character

The character method returns a random character, which is either a L</digit>,
L</letter>, or L</symbol> value.

=signature character

  character() (Str)

=metadata character

{
  since => '1.11',
}

=example-1 character

  # given: synopsis

  package main;

  my $character = $random->character;

  # ")"

  # $character = $random->character;

  # 4

=cut

$test->for('example', 1, 'character', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->character, ")";
  is $random->character, 4;
  is $random->character, 8;
  is $random->character, "R";
  is $random->character, "+";
  is $random->character, "a";
  is $random->character, "}";
  is $random->character, "[";
  is $random->character, "L";
  is $random->character, "b";
  is $random->character, "?";
  is $random->character, "&";
  is $random->character, 0;
  is $random->character, 7;
  is $random->character, 2;
  is $random->character, 5;
  is $random->character, "^";
  is $random->character, ",";
  is $random->character, 0;
  is $random->character, "w";
  is $random->character, "\$";
  is $random->character, "h";
  is $random->character, 4;
  is $random->character, 1;
  is $random->character, 5;
  is $random->character, 5;
  is $random->character, ">";
  is $random->character, "*";
  is $random->character, 0;
  is $random->character, "M";
  is $random->character, "V";
  is $random->character, "d";
  is $random->character, "G";
  is $random->character, "^";
  is $random->character, "'";
  is $random->character, "q";
  is $random->character, 6;
  is $random->character, 9;
  is $random->character, 5;
  is $random->character, "a";
  is $random->character, "}";
  is $random->character, 8;
  is $random->character, "G";
  is $random->character, "X";
  is $random->character, "*";
  is $random->character, "V";
  is $random->character, ">";
  is $random->character, "t";
  is $random->character, "Y";
  is $random->character, 2;

  $result
});

=method collect

The collect method dispatches to the specified method or coderef, repeatedly
based on the number of C<$times> specified, and returns the random concatenated
results from each dispatched call. By default, if no arguments are provided,
this method dispatches to L</digit>.

=signature collect

  collect(Int $times, Str|CodeRef $code, Any @args) (Int|Str)

=metadata collect

{
  since => '1.11',
}

=example-1 collect

  # given: synopsis

  package main;

  my $collect = $random->collect;

  # 7

  # $collect = $random->collect;

  # 3

=cut

$test->for('example', 1, 'collect', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->collect, 7;
  is $random->collect, 3;
  is $random->collect, 1;
  is $random->collect, 4;
  is $random->collect, 0;
  is $random->collect, 8;
  is $random->collect, 4;
  is $random->collect, 4;
  is $random->collect, 6;
  is $random->collect, 8;
  is $random->collect, 4;
  is $random->collect, 5;
  is $random->collect, 5;
  is $random->collect, 0;
  is $random->collect, 7;
  is $random->collect, 6;
  is $random->collect, 9;
  is $random->collect, 4;
  is $random->collect, 5;
  is $random->collect, 4;
  is $random->collect, 4;
  is $random->collect, 3;
  is $random->collect, 9;
  is $random->collect, 0;
  is $random->collect, 8;
  is $random->collect, 9;
  is $random->collect, 8;
  is $random->collect, 2;
  is $random->collect, 2;
  is $random->collect, 0;
  is $random->collect, 3;
  is $random->collect, 7;
  is $random->collect, 0;
  is $random->collect, 2;
  is $random->collect, 2;
  is $random->collect, 5;
  is $random->collect, 8;
  is $random->collect, 2;
  is $random->collect, 8;
  is $random->collect, 8;
  is $random->collect, 2;
  is $random->collect, 0;
  is $random->collect, 5;
  is $random->collect, 5;
  is $random->collect, 8;
  is $random->collect, 9;
  is $random->collect, 1;
  is $random->collect, 5;
  is $random->collect, 5;
  is $random->collect, 2;

  $result
});

=example-2 collect

  # given: synopsis

  package main;

  my $collect = $random->collect(2);

  # 73

  # $collect = $random->collect(2);

  # 14

=cut

$test->for('example', 2, 'collect', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->collect(2), 73;
  is $random->collect(2), 14;
  is $random->collect(2), "08";
  is $random->collect(2), 44;
  is $random->collect(2), 68;
  is $random->collect(2), 45;
  is $random->collect(2), 50;
  is $random->collect(2), 76;
  is $random->collect(2), 94;
  is $random->collect(2), 54;
  is $random->collect(2), 43;
  is $random->collect(2), 90;
  is $random->collect(2), 89;
  is $random->collect(2), 82;
  is $random->collect(2), 20;
  is $random->collect(2), 37;
  is $random->collect(2), "02";
  is $random->collect(2), 25;
  is $random->collect(2), 82;
  is $random->collect(2), 88;
  is $random->collect(2), 20;
  is $random->collect(2), 55;
  is $random->collect(2), 89;
  is $random->collect(2), 15;
  is $random->collect(2), 52;
  is $random->collect(2), 34;
  is $random->collect(2), 11;
  is $random->collect(2), 25;
  is $random->collect(2), "05";
  is $random->collect(2), 89;
  is $random->collect(2), 62;
  is $random->collect(2), 20;
  is $random->collect(2), 64;
  is $random->collect(2), 45;
  is $random->collect(2), 28;
  is $random->collect(2), 36;
  is $random->collect(2), 15;
  is $random->collect(2), 12;
  is $random->collect(2), 92;
  is $random->collect(2), 87;
  is $random->collect(2), 68;
  is $random->collect(2), 62;
  is $random->collect(2), 61;
  is $random->collect(2), 91;
  is $random->collect(2), 56;
  is $random->collect(2), 90;
  is $random->collect(2), 75;
  is $random->collect(2), 28;
  is $random->collect(2), 60;
  is $random->collect(2), 25;

  $result
});

=example-3 collect

  # given: synopsis

  package main;

  my $collect = $random->collect(5, "letter");

  # "iKWMv"

  # $collect = $random->collect(5, "letter");

  # "Papmm"


=cut

$test->for('example', 3, 'collect', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->collect(5, "letter"), "iKWMv";
  is $random->collect(5, "letter"), "Papmm";
  is $random->collect(5, "letter"), "JbzgC";
  is $random->collect(5, "letter"), "SHOfv";
  is $random->collect(5, "letter"), "CnyOh";
  is $random->collect(5, "letter"), "LDNNy";
  is $random->collect(5, "letter"), "hAkOV";
  is $random->collect(5, "letter"), "QPGfu";
  is $random->collect(5, "letter"), "vgcdp";
  is $random->collect(5, "letter"), "apVcP";
  is $random->collect(5, "letter"), "Xgfyp";
  is $random->collect(5, "letter"), "tdfLb";
  is $random->collect(5, "letter"), "jIAJT";
  is $random->collect(5, "letter"), "KAltj";
  is $random->collect(5, "letter"), "Oifzb";
  is $random->collect(5, "letter"), "eesgA";
  is $random->collect(5, "letter"), "yDozy";
  is $random->collect(5, "letter"), "hcHlF";
  is $random->collect(5, "letter"), "XCvlZ";
  is $random->collect(5, "letter"), "mPRyi";
  is $random->collect(5, "letter"), "SnVrl";
  is $random->collect(5, "letter"), "mKNca";
  is $random->collect(5, "letter"), "rrDxj";
  is $random->collect(5, "letter"), "TASmr";
  is $random->collect(5, "letter"), "csLVp";
  is $random->collect(5, "letter"), "yYMAt";
  is $random->collect(5, "letter"), "KXjSK";
  is $random->collect(5, "letter"), "NEsUg";
  is $random->collect(5, "letter"), "mslBf";
  is $random->collect(5, "letter"), "QAECp";
  is $random->collect(5, "letter"), "TuFxc";
  is $random->collect(5, "letter"), "jjkNg";
  is $random->collect(5, "letter"), "VtVqr";
  is $random->collect(5, "letter"), "mSsUT";
  is $random->collect(5, "letter"), "ZoUhz";
  is $random->collect(5, "letter"), "WbLiJ";
  is $random->collect(5, "letter"), "FUjAJ";
  is $random->collect(5, "letter"), "WAklk";
  is $random->collect(5, "letter"), "deyNM";
  is $random->collect(5, "letter"), "tLJKO";
  is $random->collect(5, "letter"), "aZUYM";
  is $random->collect(5, "letter"), "wNWoS";
  is $random->collect(5, "letter"), "lyUeQ";
  is $random->collect(5, "letter"), "OfUqO";
  is $random->collect(5, "letter"), "wJCWb";
  is $random->collect(5, "letter"), "dohqM";
  is $random->collect(5, "letter"), "mxJLp";
  is $random->collect(5, "letter"), "ANIhy";
  is $random->collect(5, "letter"), "cVGea";
  is $random->collect(5, "letter"), "gZTEt";

  $result
});

=example-4 collect

  # given: synopsis

  package main;

  my $collect = $random->collect(10, "character");

  # ")48R+a}[Lb"

  # $collect = $random->collect(10, "character");

  # "?&0725^,0w"

=cut

$test->for('example', 4, 'collect', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->collect(10, "character"), ")48R+a}[Lb";
  is $random->collect(10, "character"), "?&0725^,0w";
  is $random->collect(10, "character"), "\$h4155>*0M";
  is $random->collect(10, "character"), "VdG^'q695a";
  is $random->collect(10, "character"), "}8GX*V>tY2";
  is $random->collect(10, "character"), "bL41TH9t-5";
  is $random->collect(10, "character"), ")^?!%\$p08_";
  is $random->collect(10, "character"), "7z<V29Fc9,";
  is $random->collect(10, "character"), "ZKRqS]8;=E";
  is $random->collect(10, "character"), "NY6rU;TE;r";
  is $random->collect(10, "character"), "#dV}c+AiX-";
  is $random->collect(10, "character"), "74m8+>8sA7";
  is $random->collect(10, "character"), "3A1YT\"P}8j";
  is $random->collect(10, "character"), "_5&w%{rI?~";
  is $random->collect(10, "character"), "~[{U*i\"2iD";
  is $random->collect(10, "character"), "4>A3l8lZ78";
  is $random->collect(10, "character"), "#M'LKu1%~\@";
  is $random->collect(10, "character"), "w58{6O_}0O";
  is $random->collect(10, "character"), "^8|5.K3<88";
  is $random->collect(10, "character"), "h\\Px34i1I*";
  is $random->collect(10, "character"), "w4&7561&%6";
  is $random->collect(10, "character"), "%78+82fIm=";
  is $random->collect(10, "character"), "-<\$BO=_9P7";
  is $random->collect(10, "character"), "qhCACM3L4J";
  is $random->collect(10, "character"), "]A133!##l6";
  is $random->collect(10, "character"), "}B#89X4}\$(";
  is $random->collect(10, "character"), "4:]5*2r!89";
  is $random->collect(10, "character"), "3~fq3'181{";
  is $random->collect(10, "character"), "I4#21VU'6:";
  is $random->collect(10, "character"), "40J.;aY1.0";
  is $random->collect(10, "character"), "f!'6&34*Zm";
  is $random->collect(10, "character"), "xj6/8j1|./";
  is $random->collect(10, "character"), "61gT57414E";
  is $random->collect(10, "character"), "p867-k&c,2";
  is $random->collect(10, "character"), ">\@.zjW:u+m";
  is $random->collect(10, "character"), "7E08;A2894";
  is $random->collect(10, "character"), "F03/{/7%kR";
  is $random->collect(10, "character"), "{[91lI+(Ot";
  is $random->collect(10, "character"), "5~q82PB6v3";
  is $random->collect(10, "character"), "5(\@,]\$\\D(6";
  is $random->collect(10, "character"), "mn3d20NCyk";
  is $random->collect(10, "character"), "&X}R629c3H";
  is $random->collect(10, "character"), "~\@3(AS>\",o";
  is $random->collect(10, "character"), "L4~A361x+6";
  is $random->collect(10, "character"), "zU59U2|f9?";
  is $random->collect(10, "character"), "\$766uU^H1x";
  is $random->collect(10, "character"), "|M5O6-2847";
  is $random->collect(10, "character"), "zN}3yK7~N/";
  is $random->collect(10, "character"), "U8400/50rU";
  is $random->collect(10, "character"), "323?n46&0-";

  $result
});

=method digit

The digit method returns a random digit between C<0> and C<9>.

=signature digit

  digit() (Int)

=metadata digit

{
  since => '1.11',
}

=example-1 digit

  # given: synopsis

  package main;

  my $digit = $random->digit;

  # 7

  # $digit = $random->digit;

  # 3

=cut

$test->for('example', 1, 'digit', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->digit, 7;
  is $random->digit, 3;
  is $random->digit, 1;
  is $random->digit, 4;
  is $random->digit, 0;
  is $random->digit, 8;
  is $random->digit, 4;
  is $random->digit, 4;
  is $random->digit, 6;
  is $random->digit, 8;
  is $random->digit, 4;
  is $random->digit, 5;
  is $random->digit, 5;
  is $random->digit, 0;
  is $random->digit, 7;
  is $random->digit, 6;
  is $random->digit, 9;
  is $random->digit, 4;
  is $random->digit, 5;
  is $random->digit, 4;
  is $random->digit, 4;
  is $random->digit, 3;
  is $random->digit, 9;
  is $random->digit, 0;
  is $random->digit, 8;
  is $random->digit, 9;
  is $random->digit, 8;
  is $random->digit, 2;
  is $random->digit, 2;
  is $random->digit, 0;
  is $random->digit, 3;
  is $random->digit, 7;
  is $random->digit, 0;
  is $random->digit, 2;
  is $random->digit, 2;
  is $random->digit, 5;
  is $random->digit, 8;
  is $random->digit, 2;
  is $random->digit, 8;
  is $random->digit, 8;
  is $random->digit, 2;
  is $random->digit, 0;
  is $random->digit, 5;
  is $random->digit, 5;
  is $random->digit, 8;
  is $random->digit, 9;
  is $random->digit, 1;
  is $random->digit, 5;
  is $random->digit, 5;
  is $random->digit, 2;

  $result
});

=method float

The float method returns a random float.

=signature float

  float(Int $place, Int $from, Int $upto) (Num)

=metadata float

{
  since => '1.11',
}

=example-1 float

  # given: synopsis

  package main;

  my $float = $random->float;

  # 1447361.5

  # $float = $random->float;

  # "0.0000"

=cut

$test->for('example', 1, 'float', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->float), trunc("1447361.5");
  is trunc($random->float), trunc("0.0000");
  is trunc($random->float), trunc("482092.1040");
  is trunc($random->float), trunc("1555.7410393");
  is trunc($random->float), trunc("243073010.62968");
  is trunc($random->float), trunc("211.129029505");
  is trunc($random->float), trunc("24482222.86154329");
  is trunc($random->float), trunc("6.556");
  is trunc($random->float), trunc("0.00");
  is trunc($random->float), trunc("17652140.46803842");
  is trunc($random->float), trunc("4.19828");
  is trunc($random->float), trunc("50807265.7");
  is trunc($random->float), trunc("13521.258");
  is trunc($random->float), trunc("0.54");
  is trunc($random->float), trunc("0.00000000");
  is trunc($random->float), trunc("2996.60");
  is trunc($random->float), trunc("219329.0876");
  is trunc($random->float), trunc("51.256");
  is trunc($random->float), trunc("1.2");
  is trunc($random->float), trunc("165823309.60632405");
  is trunc($random->float), trunc("207785.414616");
  is trunc($random->float), trunc("12976.090746608");
  is trunc($random->float), trunc("2184.285870579");
  is trunc($random->float), trunc("4962126.07");
  is trunc($random->float), trunc("52996.93");
  is trunc($random->float), trunc("233.659434202");
  is trunc($random->float), trunc("208182.10328548");
  is trunc($random->float), trunc("446099950.92124");
  is trunc($random->float), trunc("27197.291840737");
  is trunc($random->float), trunc("2.1292108");
  is trunc($random->float), trunc("11504.2135");
  is trunc($random->float), trunc("86.1");
  is trunc($random->float), trunc("0.000");
  is trunc($random->float), trunc("0.000000000");
  is trunc($random->float), trunc("2814337.555595279");
  is trunc($random->float), trunc("0.000000000");
  is trunc($random->float), trunc("19592108.75910050");
  is trunc($random->float), trunc("7955940.0889820");
  is trunc($random->float), trunc("10842452.67346");
  is trunc($random->float), trunc("236808.75850632");
  is trunc($random->float), trunc("65.1309632");
  is trunc($random->float), trunc("898218603.151974320");
  is trunc($random->float), trunc("25368.54295825");
  is trunc($random->float), trunc("13.232559545");
  is trunc($random->float), trunc("1884.0766");
  is trunc($random->float), trunc("0.824919221");
  is trunc($random->float), trunc("45112657.8201");
  is trunc($random->float), trunc("29867.7308");
  is trunc($random->float), trunc("0.000000");
  is trunc($random->float), trunc("242355.0");

  $result
});

=example-2 float

  # given: synopsis

  package main;

  my $float = $random->float(2);

  # 380690.82

  # $float = $random->float(2);

  # 694.57

=cut

$test->for('example', 2, 'float', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->float(2)), trunc("380690.82");
  is trunc($random->float(2)), trunc("694.57");
  is trunc($random->float(2)), trunc("3306.92");
  is trunc($random->float(2)), trunc("26738855.41");
  is trunc($random->float(2)), trunc("1992.27");
  is trunc($random->float(2)), trunc("444768.09");
  is trunc($random->float(2)), trunc("21736.58");
  is trunc($random->float(2)), trunc("55.62");
  is trunc($random->float(2)), trunc("82512590.60");
  is trunc($random->float(2)), trunc("1.94");
  is trunc($random->float(2)), trunc("40.27");
  is trunc($random->float(2)), trunc("15.84");
  is trunc($random->float(2)), trunc("17325459.15");
  is trunc($random->float(2)), trunc("1896115.91");
  is trunc($random->float(2)), trunc("45346.49");
  is trunc($random->float(2)), trunc("75658691.16");
  is trunc($random->float(2)), trunc("9128.13");
  is trunc($random->float(2)), trunc("259.37");
  is trunc($random->float(2)), trunc("3.71");
  is trunc($random->float(2)), trunc("76656.85");
  is trunc($random->float(2)), trunc("74168.40");
  is trunc($random->float(2)), trunc("0.00");
  is trunc($random->float(2)), trunc("1249.76");
  is trunc($random->float(2)), trunc("21344208.40");
  is trunc($random->float(2)), trunc("0.77");
  is trunc($random->float(2)), trunc("19.51");
  is trunc($random->float(2)), trunc("47493144.38");
  is trunc($random->float(2)), trunc("15672283.68");
  is trunc($random->float(2)), trunc("96970.04");
  is trunc($random->float(2)), trunc("2.46");
  is trunc($random->float(2)), trunc("26264064.08");
  is trunc($random->float(2)), trunc("23515.13");
  is trunc($random->float(2)), trunc("24106.51");
  is trunc($random->float(2)), trunc("35366.70");
  is trunc($random->float(2)), trunc("164118589.68");
  is trunc($random->float(2)), trunc("79.12");
  is trunc($random->float(2)), trunc("303408540.24");
  is trunc($random->float(2)), trunc("794078.78");
  is trunc($random->float(2)), trunc("42119354.52");
  is trunc($random->float(2)), trunc("362.02");
  is trunc($random->float(2)), trunc("16504.73");
  is trunc($random->float(2)), trunc("11.17");
  is trunc($random->float(2)), trunc("0.26");
  is trunc($random->float(2)), trunc("1516813.10");
  is trunc($random->float(2)), trunc("0.00");
  is trunc($random->float(2)), trunc("5503.21");
  is trunc($random->float(2)), trunc("3210731.64");
  is trunc($random->float(2)), trunc("30470.18");
  is trunc($random->float(2)), trunc("15951197.43");
  is trunc($random->float(2)), trunc("42222726.33");

  $result
});

=example-3 float

  # given: synopsis

  package main;

  my $float = $random->float(2, 1, 5);

  # 3.98

  # $float = $random->float(2, 1, 5);

  # 2.37

=cut

$test->for('example', 3, 'float', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->float(2, 1, 5), 3.98;
  is $random->float(2, 1, 5), 2.37;
  is $random->float(2, 1, 5), 1.44;
  is $random->float(2, 1, 5), 2.69;
  is $random->float(2, 1, 5), 1.32;
  is $random->float(2, 1, 5), 4.43;
  is $random->float(2, 1, 5), "3.00";
  is $random->float(2, 1, 5), 2.92;
  is $random->float(2, 1, 5), 3.76;
  is $random->float(2, 1, 5), 4.34;
  is $random->float(2, 1, 5), 2.85;
  is $random->float(2, 1, 5), 3.31;
  is $random->float(2, 1, 5), 3.14;
  is $random->float(2, 1, 5), "1.10";
  is $random->float(2, 1, 5), 4.08;
  is $random->float(2, 1, 5), "3.40";
  is $random->float(2, 1, 5), 4.64;
  is $random->float(2, 1, 5), 2.96;
  is $random->float(2, 1, 5), 3.14;
  is $random->float(2, 1, 5), 2.99;
  is $random->float(2, 1, 5), 2.75;
  is $random->float(2, 1, 5), "2.40";
  is $random->float(2, 1, 5), 4.69;
  is $random->float(2, 1, 5), 1.24;
  is $random->float(2, 1, 5), 4.44;
  is $random->float(2, 1, 5), 4.89;
  is $random->float(2, 1, 5), "4.40";
  is $random->float(2, 1, 5), 2.01;
  is $random->float(2, 1, 5), 1.82;
  is $random->float(2, 1, 5), 1.39;
  is $random->float(2, 1, 5), 2.21;
  is $random->float(2, 1, 5), 3.91;
  is $random->float(2, 1, 5), 1.22;
  is $random->float(2, 1, 5), "2.10";
  is $random->float(2, 1, 5), 2.16;
  is $random->float(2, 1, 5), 3.26;
  is $random->float(2, 1, 5), 4.42;
  is $random->float(2, 1, 5), 1.86;
  is $random->float(2, 1, 5), 4.21;
  is $random->float(2, 1, 5), 4.27;
  is $random->float(2, 1, 5), 1.85;
  is $random->float(2, 1, 5), 1.35;
  is $random->float(2, 1, 5), 3.23;
  is $random->float(2, 1, 5), "3.10";
  is $random->float(2, 1, 5), 4.46;
  is $random->float(2, 1, 5), 4.73;
  is $random->float(2, 1, 5), 1.56;
  is $random->float(2, 1, 5), 3.18;
  is $random->float(2, 1, 5), 3.08;
  is $random->float(2, 1, 5), 2.17;

  $result
});

=example-4 float

  # given: synopsis

  package main;

  my $float = $random->float(3, 1, 2);

  # 1.745

  # $float = $random->float(3, 1, 2);

  # 1.343

=cut

$test->for('example', 4, 'float', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->float(3, 1, 2), 1.745;
  is $random->float(3, 1, 2), 1.343;
  is $random->float(3, 1, 2), 1.111;
  is $random->float(3, 1, 2), 1.422;
  is $random->float(3, 1, 2), 1.081;
  is $random->float(3, 1, 2), 1.856;
  is $random->float(3, 1, 2), 1.499;
  is $random->float(3, 1, 2), 1.479;
  is $random->float(3, 1, 2), 1.691;
  is $random->float(3, 1, 2), 1.835;
  is $random->float(3, 1, 2), 1.463;
  is $random->float(3, 1, 2), 1.578;
  is $random->float(3, 1, 2), 1.534;
  is $random->float(3, 1, 2), 1.026;
  is $random->float(3, 1, 2), "1.770";
  is $random->float(3, 1, 2), 1.601;
  is $random->float(3, 1, 2), 1.909;
  is $random->float(3, 1, 2), 1.489;
  is $random->float(3, 1, 2), 1.536;
  is $random->float(3, 1, 2), 1.497;
  is $random->float(3, 1, 2), 1.438;
  is $random->float(3, 1, 2), "1.350";
  is $random->float(3, 1, 2), 1.922;
  is $random->float(3, 1, 2), "1.060";
  is $random->float(3, 1, 2), "1.860";
  is $random->float(3, 1, 2), 1.972;
  is $random->float(3, 1, 2), 1.849;
  is $random->float(3, 1, 2), 1.252;
  is $random->float(3, 1, 2), 1.206;
  is $random->float(3, 1, 2), 1.097;
  is $random->float(3, 1, 2), 1.302;
  is $random->float(3, 1, 2), 1.728;
  is $random->float(3, 1, 2), 1.055;
  is $random->float(3, 1, 2), 1.274;
  is $random->float(3, 1, 2), "1.290";
  is $random->float(3, 1, 2), 1.566;
  is $random->float(3, 1, 2), 1.855;
  is $random->float(3, 1, 2), 1.216;
  is $random->float(3, 1, 2), 1.802;
  is $random->float(3, 1, 2), 1.817;
  is $random->float(3, 1, 2), 1.214;
  is $random->float(3, 1, 2), 1.089;
  is $random->float(3, 1, 2), 1.557;
  is $random->float(3, 1, 2), 1.525;
  is $random->float(3, 1, 2), 1.864;
  is $random->float(3, 1, 2), 1.933;
  is $random->float(3, 1, 2), 1.139;
  is $random->float(3, 1, 2), 1.544;
  is $random->float(3, 1, 2), 1.519;
  is $random->float(3, 1, 2), 1.293;

  $result
});

=method letter

The letter method returns a random letter, which is either an L</uppercased> or
L</lowercased> value.

=signature letter

  letter() (Str)

=metadata letter

{
  since => '1.11',
}

=example-1 letter

  # given: synopsis

  package main;

  my $letter = $random->letter;

  # "i"

  # $letter = $random->letter;

  # "K"

=cut

$test->for('example', 1, 'letter', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->letter, "i";
  is $random->letter, "K";
  is $random->letter, "W";
  is $random->letter, "M";
  is $random->letter, "v";
  is $random->letter, "P";
  is $random->letter, "a";
  is $random->letter, "p";
  is $random->letter, "m";
  is $random->letter, "m";
  is $random->letter, "J";
  is $random->letter, "b";
  is $random->letter, "z";
  is $random->letter, "g";
  is $random->letter, "C";
  is $random->letter, "S";
  is $random->letter, "H";
  is $random->letter, "O";
  is $random->letter, "f";
  is $random->letter, "v";
  is $random->letter, "C";
  is $random->letter, "n";
  is $random->letter, "y";
  is $random->letter, "O";
  is $random->letter, "h";
  is $random->letter, "L";
  is $random->letter, "D";
  is $random->letter, "N";
  is $random->letter, "N";
  is $random->letter, "y";
  is $random->letter, "h";
  is $random->letter, "A";
  is $random->letter, "k";
  is $random->letter, "O";
  is $random->letter, "V";
  is $random->letter, "Q";
  is $random->letter, "P";
  is $random->letter, "G";
  is $random->letter, "f";
  is $random->letter, "u";
  is $random->letter, "v";
  is $random->letter, "g";
  is $random->letter, "c";
  is $random->letter, "d";
  is $random->letter, "p";
  is $random->letter, "a";
  is $random->letter, "p";
  is $random->letter, "V";
  is $random->letter, "c";
  is $random->letter, "P";

  $result
});

=method lowercased

The lowercased method returns a random lowercased letter.

=signature lowercased

  lowercased() (Str)

=metadata lowercased

{
  since => '1.11',
}

=example-1 lowercased

  # given: synopsis

  package main;

  my $lowercased = $random->lowercased;

  # "t"

  # $lowercased = $random->lowercased;

  # "i"

=cut

$test->for('example', 1, 'lowercased', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->lowercased, "t";
  is $random->lowercased, "i";
  is $random->lowercased, "c";
  is $random->lowercased, "k";
  is $random->lowercased, "c";
  is $random->lowercased, "w";
  is $random->lowercased, "m";
  is $random->lowercased, "m";
  is $random->lowercased, "r";
  is $random->lowercased, "v";
  is $random->lowercased, "m";
  is $random->lowercased, "p";
  is $random->lowercased, "n";
  is $random->lowercased, "a";
  is $random->lowercased, "u";
  is $random->lowercased, "p";
  is $random->lowercased, "x";
  is $random->lowercased, "m";
  is $random->lowercased, "n";
  is $random->lowercased, "m";
  is $random->lowercased, "l";
  is $random->lowercased, "j";
  is $random->lowercased, "x";
  is $random->lowercased, "b";
  is $random->lowercased, "w";
  is $random->lowercased, "z";
  is $random->lowercased, "w";
  is $random->lowercased, "g";
  is $random->lowercased, "f";
  is $random->lowercased, "c";
  is $random->lowercased, "h";
  is $random->lowercased, "s";
  is $random->lowercased, "b";
  is $random->lowercased, "h";
  is $random->lowercased, "h";
  is $random->lowercased, "o";
  is $random->lowercased, "w";
  is $random->lowercased, "f";
  is $random->lowercased, "u";
  is $random->lowercased, "v";
  is $random->lowercased, "f";
  is $random->lowercased, "c";
  is $random->lowercased, "o";
  is $random->lowercased, "n";
  is $random->lowercased, "w";
  is $random->lowercased, "y";
  is $random->lowercased, "d";
  is $random->lowercased, "o";
  is $random->lowercased, "n";
  is $random->lowercased, "h";

  $result
});

=method nonzero

The nonzero method dispatches to the specified method or coderef and returns
the random value ensuring that it's never zero, not even a percentage of zero.
By default, if no arguments are provided, this method dispatches to L</digit>.

=signature nonzero

  nonzero(Str|CodeRef $code, Any @args) (Int|Str)

=metadata nonzero

{
  since => '1.11',
}

=example-1 nonzero

  # given: synopsis

  package main;

  my $nonzero = $random->nonzero;

  # 7

  # $nonzero = $random->nonzero;

  # 3

=cut

$test->for('example', 1, 'nonzero', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->nonzero, 7;
  is $random->nonzero, 3;
  is $random->nonzero, 1;
  is $random->nonzero, 4;
  is $random->nonzero, 8;
  is $random->nonzero, 4;
  is $random->nonzero, 4;
  is $random->nonzero, 6;
  is $random->nonzero, 8;
  is $random->nonzero, 4;
  is $random->nonzero, 5;
  is $random->nonzero, 5;
  is $random->nonzero, 7;
  is $random->nonzero, 6;
  is $random->nonzero, 9;
  is $random->nonzero, 4;
  is $random->nonzero, 5;
  is $random->nonzero, 4;
  is $random->nonzero, 4;
  is $random->nonzero, 3;
  is $random->nonzero, 9;
  is $random->nonzero, 8;
  is $random->nonzero, 9;
  is $random->nonzero, 8;
  is $random->nonzero, 2;
  is $random->nonzero, 2;
  is $random->nonzero, 3;
  is $random->nonzero, 7;
  is $random->nonzero, 2;
  is $random->nonzero, 2;
  is $random->nonzero, 5;
  is $random->nonzero, 8;
  is $random->nonzero, 2;
  is $random->nonzero, 8;
  is $random->nonzero, 8;
  is $random->nonzero, 2;
  is $random->nonzero, 5;
  is $random->nonzero, 5;
  is $random->nonzero, 8;
  is $random->nonzero, 9;
  is $random->nonzero, 1;
  is $random->nonzero, 5;
  is $random->nonzero, 5;
  is $random->nonzero, 2;
  is $random->nonzero, 3;
  is $random->nonzero, 4;
  is $random->nonzero, 1;
  is $random->nonzero, 1;
  is $random->nonzero, 2;
  is $random->nonzero, 5;

  $result
});

=example-2 nonzero

  # given: synopsis

  package main;

  my $nonzero = $random->nonzero("pick");

  # 1.74452500006101

  # $nonzero = $random->nonzero("pick");

  # 1.34270147871891

=cut

$test->for('example', 2, 'nonzero', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->nonzero("pick")), trunc("1.74452500006101");
  is trunc($random->nonzero("pick")), trunc("1.34270147871891");
  is trunc($random->nonzero("pick")), trunc("1.11108528244416");
  is trunc($random->nonzero("pick")), trunc("1.42233895798831");
  is trunc($random->nonzero("pick")), trunc("1.08111117117831");
  is trunc($random->nonzero("pick")), trunc("1.85644070802662");
  is trunc($random->nonzero("pick")), trunc("1.49879942219408");
  is trunc($random->nonzero("pick")), trunc("1.47881429064463");
  is trunc($random->nonzero("pick")), trunc("1.69081244430564");
  is trunc($random->nonzero("pick")), trunc("1.83459376596215");
  is trunc($random->nonzero("pick")), trunc("1.46289983439946");
  is trunc($random->nonzero("pick")), trunc("1.5776380603106");
  is trunc($random->nonzero("pick")), trunc("1.53397276092527");
  is trunc($random->nonzero("pick")), trunc("1.02588992248072");
  is trunc($random->nonzero("pick")), trunc("1.76981204150115");
  is trunc($random->nonzero("pick")), trunc("1.60113641395593");
  is trunc($random->nonzero("pick")), trunc("1.90883275351445");
  is trunc($random->nonzero("pick")), trunc("1.48938481428107");
  is trunc($random->nonzero("pick")), trunc("1.53598974721394");
  is trunc($random->nonzero("pick")), trunc("1.49669095601804");
  is trunc($random->nonzero("pick")), trunc("1.43763751683027");
  is trunc($random->nonzero("pick")), trunc("1.34967725286383");
  is trunc($random->nonzero("pick")), trunc("1.92192218572714");
  is trunc($random->nonzero("pick")), trunc("1.06039159882871");
  is trunc($random->nonzero("pick")), trunc("1.85989410236673");
  is trunc($random->nonzero("pick")), trunc("1.97198998677624");
  is trunc($random->nonzero("pick")), trunc("1.84890372478558");
  is trunc($random->nonzero("pick")), trunc("1.25187731990221");
  is trunc($random->nonzero("pick")), trunc("1.20578560434642");
  is trunc($random->nonzero("pick")), trunc("1.09677224923537");
  is trunc($random->nonzero("pick")), trunc("1.30186990851854");
  is trunc($random->nonzero("pick")), trunc("1.72848495280885");
  is trunc($random->nonzero("pick")), trunc("1.05539717362683");
  is trunc($random->nonzero("pick")), trunc("1.27396181123785");
  is trunc($random->nonzero("pick")), trunc("1.28977139272935");
  is trunc($random->nonzero("pick")), trunc("1.56573009953997");
  is trunc($random->nonzero("pick")), trunc("1.85517543970009");
  is trunc($random->nonzero("pick")), trunc("1.21610080933634");
  is trunc($random->nonzero("pick")), trunc("1.80173044923592");
  is trunc($random->nonzero("pick")), trunc("1.81684752985822");
  is trunc($random->nonzero("pick")), trunc("1.21368445304509");
  is trunc($random->nonzero("pick")), trunc("1.08873438899161");
  is trunc($random->nonzero("pick")), trunc("1.55717420926014");
  is trunc($random->nonzero("pick")), trunc("1.52478508962086");
  is trunc($random->nonzero("pick")), trunc("1.8641211929522");
  is trunc($random->nonzero("pick")), trunc("1.93316076129385");
  is trunc($random->nonzero("pick")), trunc("1.13895989130389");
  is trunc($random->nonzero("pick")), trunc("1.54446423796457");
  is trunc($random->nonzero("pick")), trunc("1.5192197320834");
  is trunc($random->nonzero("pick")), trunc("1.29349717538767");

  $result
});

=example-3 nonzero

  # given: synopsis

  package main;

  my $nonzero = $random->nonzero("number");

  # 3427014

  # $nonzero = $random->nonzero("number");

  # 3

=cut

$test->for('example', 3, 'nonzero', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->nonzero("number")), trunc("3427014");
  is trunc($random->nonzero("number")), trunc(3);
  is trunc($random->nonzero("number")), trunc(4);
  is trunc($random->nonzero("number")), trunc("6907");
  is trunc($random->nonzero("number")), trunc("46289982");
  is trunc($random->nonzero("number")), trunc("53396");
  is trunc($random->nonzero("number")), trunc(6);
  is trunc($random->nonzero("number")), trunc("489384813");
  is trunc($random->nonzero("number")), trunc("49668");
  is trunc($random->nonzero("number")), trunc("3496");
  is trunc($random->nonzero("number")), trunc("60391598");
  is trunc($random->nonzero("number")), trunc("97198997");
  is trunc($random->nonzero("number")), trunc("25187731");
  is trunc($random->nonzero("number")), trunc(9);
  is trunc($random->nonzero("number")), trunc("727");
  is trunc($random->nonzero("number")), trunc(2);
  is trunc($random->nonzero("number")), trunc("85516");
  is trunc($random->nonzero("number")), trunc("79");
  is trunc($random->nonzero("number")), trunc("21368445");
  is trunc($random->nonzero("number")), trunc(5);
  is trunc($random->nonzero("number")), trunc("93316075");
  is trunc($random->nonzero("number")), trunc(4);
  is trunc($random->nonzero("number")), trunc("29349");
  is trunc($random->nonzero("number")), trunc("460");
  is trunc($random->nonzero("number")), trunc(1);
  is trunc($random->nonzero("number")), trunc("53");
  is trunc($random->nonzero("number")), trunc(8);
  is trunc($random->nonzero("number")), trunc("687274333");
  is trunc($random->nonzero("number")), trunc("25");
  is trunc($random->nonzero("number")), trunc(4);
  is trunc($random->nonzero("number")), trunc("5399");
  is trunc($random->nonzero("number")), trunc("83");
  is trunc($random->nonzero("number")), trunc("616");
  is trunc($random->nonzero("number")), trunc(5);
  is trunc($random->nonzero("number")), trunc(2);
  is trunc($random->nonzero("number")), trunc("214385396");
  is trunc($random->nonzero("number")), trunc("77348229");
  is trunc($random->nonzero("number")), trunc("822785");
  is trunc($random->nonzero("number")), trunc("252538");
  is trunc($random->nonzero("number")), trunc("102945");
  is trunc($random->nonzero("number")), trunc("126048771");
  is trunc($random->nonzero("number")), trunc("61415");
  is trunc($random->nonzero("number")), trunc("35565999");
  is trunc($random->nonzero("number")), trunc("5959162");
  is trunc($random->nonzero("number")), trunc("82");
  is trunc($random->nonzero("number")), trunc("90573");
  is trunc($random->nonzero("number")), trunc("57");
  is trunc($random->nonzero("number")), trunc("896");
  is trunc($random->nonzero("number")), trunc("260780618");
  is trunc($random->nonzero("number")), trunc("218398");

  $result
});

=example-4 nonzero

  # given: synopsis

  package main;

  my $nonzero = $random->nonzero("number", 0, 10);

  # 8

  # $nonzero = $random->nonzero("number", 0, 10);

  # 3

=cut

$test->for('example', 4, 'nonzero', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->nonzero("number", 0, 10), 8;
  is $random->nonzero("number", 0, 10), 3;
  is $random->nonzero("number", 0, 10), 1;
  is $random->nonzero("number", 0, 10), 4;
  is $random->nonzero("number", 0, 10), 8;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 7;
  is $random->nonzero("number", 0, 10), 9;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 6;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 7;
  is $random->nonzero("number", 0, 10), 6;
  is $random->nonzero("number", 0, 10), 9;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 4;
  is $random->nonzero("number", 0, 10), 3;
  is $random->nonzero("number", 0, 10), 10;
  is $random->nonzero("number", 0, 10), 8;
  is $random->nonzero("number", 0, 10), 10;
  is $random->nonzero("number", 0, 10), 9;
  is $random->nonzero("number", 0, 10), 2;
  is $random->nonzero("number", 0, 10), 2;
  is $random->nonzero("number", 0, 10), 1;
  is $random->nonzero("number", 0, 10), 3;
  is $random->nonzero("number", 0, 10), 8;
  is $random->nonzero("number", 0, 10), 2;
  is $random->nonzero("number", 0, 10), 3;
  is $random->nonzero("number", 0, 10), 6;
  is $random->nonzero("number", 0, 10), 9;
  is $random->nonzero("number", 0, 10), 2;
  is $random->nonzero("number", 0, 10), 8;
  is $random->nonzero("number", 0, 10), 8;
  is $random->nonzero("number", 0, 10), 2;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 9;
  is $random->nonzero("number", 0, 10), 10;
  is $random->nonzero("number", 0, 10), 1;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 3;
  is $random->nonzero("number", 0, 10), 3;
  is $random->nonzero("number", 0, 10), 5;
  is $random->nonzero("number", 0, 10), 2;
  is $random->nonzero("number", 0, 10), 1;
  is $random->nonzero("number", 0, 10), 2;

  $result
});

=method number

The number method returns a random number within the range provided. If no
arguments are provided, the range is from C<0> to C<2147483647>. If only the
first argument is provided, it's treated as the desired length of the number.

=signature number

  number(Int $from, Int $upto) (Num)

=metadata number

{
  since => '1.11',
}

=example-1 number

  # given: synopsis

  package main;

  my $number = $random->number;

  # 3427014

  # $number = $random->number;

  # 3

=cut

$test->for('example', 1, 'number', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->number), trunc("3427014");
  is trunc($random->number), trunc("3");
  is trunc($random->number), trunc("0");
  is trunc($random->number), trunc("4787");
  is trunc($random->number), trunc("834592");
  is trunc($random->number), trunc("5775");
  is trunc($random->number), trunc("2588");
  is trunc($random->number), trunc("6011363");
  is trunc($random->number), trunc("489384813");
  is trunc($random->number), trunc("49668");
  is trunc($random->number), trunc("3496");
  is trunc($random->number), trunc("60391598");
  is trunc($random->number), trunc("97198997");
  is trunc($random->number), trunc("25187731");
  is trunc($random->number), trunc("9");
  is trunc($random->number), trunc("727");
  is trunc($random->number), trunc("0");
  is trunc($random->number), trunc("56");
  is trunc($random->number), trunc("21610080");
  is trunc($random->number), trunc("81684752");
  is trunc($random->number), trunc("8");
  is trunc($random->number), trunc("52477");
  is trunc($random->number), trunc("93316075");
  is trunc($random->number), trunc("4");
  is trunc($random->number), trunc("29349");
  is trunc($random->number), trunc("460");
  is trunc($random->number), trunc("1");
  is trunc($random->number), trunc("53");
  is trunc($random->number), trunc("0");
  is trunc($random->number), trunc("94305100");
  is trunc($random->number), trunc("284745");
  is trunc($random->number), trunc("1");
  is trunc($random->number), trunc("406193");
  is trunc($random->number), trunc("5399");
  is trunc($random->number), trunc("83");
  is trunc($random->number), trunc("616");
  is trunc($random->number), trunc("5");
  is trunc($random->number), trunc("2");
  is trunc($random->number), trunc("214385396");
  is trunc($random->number), trunc("77348229");
  is trunc($random->number), trunc("822785");
  is trunc($random->number), trunc("252538");
  is trunc($random->number), trunc("102945");
  is trunc($random->number), trunc("126048771");
  is trunc($random->number), trunc("61415");
  is trunc($random->number), trunc("35565999");
  is trunc($random->number), trunc("5959162");
  is trunc($random->number), trunc("82");
  is trunc($random->number), trunc("90573");
  is trunc($random->number), trunc("57");

  $result
});

=example-2 number

  # given: synopsis

  package main;

  my $number = $random->number(5, 50);

  # 39

  # $number = $random->number(5, 50);

  # 20

=cut

$test->for('example', 2, 'number', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->number(5, 50), 39;
  is $random->number(5, 50), 20;
  is $random->number(5, 50), 10;
  is $random->number(5, 50), 24;
  is $random->number(5, 50), 8;
  is $random->number(5, 50), 44;
  is $random->number(5, 50), 27;
  is $random->number(5, 50), 27;
  is $random->number(5, 50), 36;
  is $random->number(5, 50), 43;
  is $random->number(5, 50), 26;
  is $random->number(5, 50), 31;
  is $random->number(5, 50), 29;
  is $random->number(5, 50), 6;
  is $random->number(5, 50), 40;
  is $random->number(5, 50), 32;
  is $random->number(5, 50), 46;
  is $random->number(5, 50), 27;
  is $random->number(5, 50), 29;
  is $random->number(5, 50), 27;
  is $random->number(5, 50), 25;
  is $random->number(5, 50), 21;
  is $random->number(5, 50), 47;
  is $random->number(5, 50), 7;
  is $random->number(5, 50), 44;
  is $random->number(5, 50), 49;
  is $random->number(5, 50), 44;
  is $random->number(5, 50), 16;
  is $random->number(5, 50), 14;
  is $random->number(5, 50), 9;
  is $random->number(5, 50), 18;
  is $random->number(5, 50), 38;
  is $random->number(5, 50), 7;
  is $random->number(5, 50), 17;
  is $random->number(5, 50), 18;
  is $random->number(5, 50), 31;
  is $random->number(5, 50), 44;
  is $random->number(5, 50), 14;
  is $random->number(5, 50), 41;
  is $random->number(5, 50), 42;
  is $random->number(5, 50), 14;
  is $random->number(5, 50), 9;
  is $random->number(5, 50), 30;
  is $random->number(5, 50), 29;
  is $random->number(5, 50), 44;
  is $random->number(5, 50), 47;
  is $random->number(5, 50), 11;
  is $random->number(5, 50), 30;
  is $random->number(5, 50), 28;
  is $random->number(5, 50), 18;

  $result
});

=example-3 number

  # given: synopsis

  package main;

  my $number = $random->number(100, 20);

  # 42

  # $number = $random->number(100, 20);

  # 73

=cut

$test->for('example', 3, 'number', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->number(100, 20), 42;
  is $random->number(100, 20), 73;
  is $random->number(100, 20), 92;
  is $random->number(100, 20), 67;
  is $random->number(100, 20), 94;
  is $random->number(100, 20), 33;
  is $random->number(100, 20), 61;
  is $random->number(100, 20), 63;
  is $random->number(100, 20), 46;
  is $random->number(100, 20), 35;
  is $random->number(100, 20), 64;
  is $random->number(100, 20), 55;
  is $random->number(100, 20), 58;
  is $random->number(100, 20), 98;
  is $random->number(100, 20), 40;
  is $random->number(100, 20), 53;
  is $random->number(100, 20), 29;
  is $random->number(100, 20), 62;
  is $random->number(100, 20), 58;
  is $random->number(100, 20), 61;
  is $random->number(100, 20), 66;
  is $random->number(100, 20), 73;
  is $random->number(100, 20), 28;
  is $random->number(100, 20), 96;
  is $random->number(100, 20), 33;
  is $random->number(100, 20), 24;
  is $random->number(100, 20), 33;
  is $random->number(100, 20), 81;
  is $random->number(100, 20), 84;
  is $random->number(100, 20), 93;
  is $random->number(100, 20), 77;
  is $random->number(100, 20), 43;
  is $random->number(100, 20), 96;
  is $random->number(100, 20), 79;
  is $random->number(100, 20), 78;
  is $random->number(100, 20), 56;
  is $random->number(100, 20), 33;
  is $random->number(100, 20), 83;
  is $random->number(100, 20), 37;
  is $random->number(100, 20), 36;
  is $random->number(100, 20), 84;
  is $random->number(100, 20), 93;
  is $random->number(100, 20), 56;
  is $random->number(100, 20), 59;
  is $random->number(100, 20), 32;
  is $random->number(100, 20), 27;
  is $random->number(100, 20), 90;
  is $random->number(100, 20), 57;
  is $random->number(100, 20), 59;
  is $random->number(100, 20), 77;

  $result
});

=example-4 number

  # given: synopsis

  package main;

  my $number = $random->number(5);

  # 74451

  # $number = $random->number(5);

  # 34269

=cut

$test->for('example', 4, 'number', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->number(5), 74451;
  is $random->number(5), 34269;
  is $random->number(5), 11108;
  is $random->number(5), 42233;
  is $random->number(5), 8111;
  is $random->number(5), 85643;
  is $random->number(5), 49879;
  is $random->number(5), 47880;
  is $random->number(5), 69080;
  is $random->number(5), 83458;
  is $random->number(5), 46289;
  is $random->number(5), 57763;
  is $random->number(5), 53396;
  is $random->number(5), 2588;
  is $random->number(5), 76980;
  is $random->number(5), 60113;
  is $random->number(5), 90882;
  is $random->number(5), 48937;
  is $random->number(5), 53598;
  is $random->number(5), 49668;
  is $random->number(5), 43763;
  is $random->number(5), 34967;
  is $random->number(5), 92191;
  is $random->number(5), 6039;
  is $random->number(5), 85988;
  is $random->number(5), 97198;
  is $random->number(5), 84889;
  is $random->number(5), 25187;
  is $random->number(5), 20578;
  is $random->number(5), 9677;
  is $random->number(5), 30186;
  is $random->number(5), 72847;
  is $random->number(5), 5539;
  is $random->number(5), 27395;
  is $random->number(5), 28976;
  is $random->number(5), 56572;
  is $random->number(5), 85516;
  is $random->number(5), 21609;
  is $random->number(5), 80172;
  is $random->number(5), 81683;
  is $random->number(5), 21368;
  is $random->number(5), 8873;
  is $random->number(5), 55716;
  is $random->number(5), 52477;
  is $random->number(5), 86411;
  is $random->number(5), 93315;
  is $random->number(5), 13895;
  is $random->number(5), 54445;
  is $random->number(5), 51921;
  is $random->number(5), 29349;

  $result
});

=method pick

The pick method is the random number generator and returns a random number. By
default, calling this method is equivalent to call L<perlfunc/rand>. This
method can be overridden in a subclass to provide a custom generator, e.g. a
more cyptographically secure generator.

=signature pick

  pick(Num $data) (Num)

=metadata pick

{
  since => '1.23',
}

=example-1 pick

  # given: synopsis

  package main;

  my $pick = $random->pick;

  # 0.744525000061007

  # $pick = $random->pick;

  # 0.342701478718908

=cut

$test->for('example', 1, 'pick', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->pick), trunc("0.74452500006100");
  is trunc($random->pick), trunc("0.342701478718908");
  is trunc($random->pick), trunc("0.111085282444161");
  is trunc($random->pick), trunc("0.422338957988309");
  is trunc($random->pick), trunc("0.0811111711783106");
  is trunc($random->pick), trunc("0.856440708026625");
  is trunc($random->pick), trunc("0.498799422194079");
  is trunc($random->pick), trunc("0.478814290644628");
  is trunc($random->pick), trunc("0.690812444305639");
  is trunc($random->pick), trunc("0.834593765962154");
  is trunc($random->pick), trunc("0.462899834399462");
  is trunc($random->pick), trunc("0.577638060310598");
  is trunc($random->pick), trunc("0.53397276092527");
  is trunc($random->pick), trunc("0.0258899224807152");
  is trunc($random->pick), trunc("0.769812041501151");
  is trunc($random->pick), trunc("0.601136413955935");
  is trunc($random->pick), trunc("0.908832753514449");
  is trunc($random->pick), trunc("0.489384814281067");
  is trunc($random->pick), trunc("0.535989747213943");
  is trunc($random->pick), trunc("0.496690956018035");
  is trunc($random->pick), trunc("0.437637516830268");
  is trunc($random->pick), trunc("0.349677252863827");
  is trunc($random->pick), trunc("0.921922185727137");
  is trunc($random->pick), trunc("0.0603915988287085");
  is trunc($random->pick), trunc("0.859894102366727");
  is trunc($random->pick), trunc("0.971989986776236");
  is trunc($random->pick), trunc("0.848903724785583");
  is trunc($random->pick), trunc("0.251877319902214");
  is trunc($random->pick), trunc("0.205785604346421");
  is trunc($random->pick), trunc("0.0967722492353715");
  is trunc($random->pick), trunc("0.301869908518537");
  is trunc($random->pick), trunc("0.728484952808849");
  is trunc($random->pick), trunc("0.0553971736268331");
  is trunc($random->pick), trunc("0.273961811237854");
  is trunc($random->pick), trunc("0.289771392729346");
  is trunc($random->pick), trunc("0.565730099539969");
  is trunc($random->pick), trunc("0.855175439700094");
  is trunc($random->pick), trunc("0.216100809336339");
  is trunc($random->pick), trunc("0.801730449235915");
  is trunc($random->pick), trunc("0.816847529858215");
  is trunc($random->pick), trunc("0.213684453045094");
  is trunc($random->pick), trunc("0.088734388991611");
  is trunc($random->pick), trunc("0.557174209260136");
  is trunc($random->pick), trunc("0.524785089620856");
  is trunc($random->pick), trunc("0.864121192952201");
  is trunc($random->pick), trunc("0.933160761293848");
  is trunc($random->pick), trunc("0.138959891303895");
  is trunc($random->pick), trunc("0.544464237964569");
  is trunc($random->pick), trunc("0.519219732083403");
  is trunc($random->pick), trunc("0.293497175387671");

  $result
});

=example-2 pick

  # given: synopsis

  package main;

  my $pick = $random->pick(100);

  # 74.4525000061007

  # $pick = $random->pick(100);

  # 34.2701478718908

=cut

$test->for('example', 2, 'pick', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->pick(100)), trunc("74.4525000061007");
  is trunc($random->pick(100)), trunc("34.2701478718908");
  is trunc($random->pick(100)), trunc("11.1085282444161");
  is trunc($random->pick(100)), trunc("42.2338957988309");
  is trunc($random->pick(100)), trunc("8.11111711783106");
  is trunc($random->pick(100)), trunc("85.6440708026625");
  is trunc($random->pick(100)), trunc("49.8799422194079");
  is trunc($random->pick(100)), trunc("47.8814290644628");
  is trunc($random->pick(100)), trunc("69.0812444305639");
  is trunc($random->pick(100)), trunc("83.4593765962154");
  is trunc($random->pick(100)), trunc("46.2899834399462");
  is trunc($random->pick(100)), trunc("57.7638060310598");
  is trunc($random->pick(100)), trunc("53.397276092527");
  is trunc($random->pick(100)), trunc("2.58899224807152");
  is trunc($random->pick(100)), trunc("76.9812041501151");
  is trunc($random->pick(100)), trunc("60.1136413955935");
  is trunc($random->pick(100)), trunc("90.8832753514449");
  is trunc($random->pick(100)), trunc("48.9384814281067");
  is trunc($random->pick(100)), trunc("53.5989747213943");
  is trunc($random->pick(100)), trunc("49.6690956018035");
  is trunc($random->pick(100)), trunc("43.7637516830268");
  is trunc($random->pick(100)), trunc("34.9677252863827");
  is trunc($random->pick(100)), trunc("92.1922185727137");
  is trunc($random->pick(100)), trunc("6.03915988287085");
  is trunc($random->pick(100)), trunc("85.9894102366727");
  is trunc($random->pick(100)), trunc("97.1989986776236");
  is trunc($random->pick(100)), trunc("84.8903724785583");
  is trunc($random->pick(100)), trunc("25.1877319902214");
  is trunc($random->pick(100)), trunc("20.5785604346421");
  is trunc($random->pick(100)), trunc("9.67722492353715");
  is trunc($random->pick(100)), trunc("30.1869908518537");
  is trunc($random->pick(100)), trunc("72.8484952808849");
  is trunc($random->pick(100)), trunc("5.53971736268331");
  is trunc($random->pick(100)), trunc("27.3961811237854");
  is trunc($random->pick(100)), trunc("28.9771392729346");
  is trunc($random->pick(100)), trunc("56.5730099539969");
  is trunc($random->pick(100)), trunc("85.5175439700094");
  is trunc($random->pick(100)), trunc("21.6100809336339");
  is trunc($random->pick(100)), trunc("80.1730449235915");
  is trunc($random->pick(100)), trunc("81.6847529858215");
  is trunc($random->pick(100)), trunc("21.3684453045094");
  is trunc($random->pick(100)), trunc("8.8734388991611");
  is trunc($random->pick(100)), trunc("55.7174209260136");
  is trunc($random->pick(100)), trunc("52.4785089620856");
  is trunc($random->pick(100)), trunc("86.4121192952201");
  is trunc($random->pick(100)), trunc("93.3160761293848");
  is trunc($random->pick(100)), trunc("13.8959891303895");
  is trunc($random->pick(100)), trunc("54.4464237964569");
  is trunc($random->pick(100)), trunc("51.9219732083403");
  is trunc($random->pick(100)), trunc("29.3497175387671");

  $result
});

=example-3 pick

  # given: synopsis

  package main;

  my $pick = $random->pick(2);

  # 1.48905000012201

  # $pick = $random->pick(2);

  # 0.685402957437816

=cut

$test->for('example', 3, 'pick', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is trunc($random->pick(2)), trunc("1.48905000012201");
  is trunc($random->pick(2)), trunc("0.685402957437816");
  is trunc($random->pick(2)), trunc("0.222170564888323");
  is trunc($random->pick(2)), trunc("0.844677915976618");
  is trunc($random->pick(2)), trunc("0.162222342356621");
  is trunc($random->pick(2)), trunc("1.71288141605325");
  is trunc($random->pick(2)), trunc("0.997598844388158");
  is trunc($random->pick(2)), trunc("0.957628581289256");
  is trunc($random->pick(2)), trunc("1.38162488861128");
  is trunc($random->pick(2)), trunc("1.66918753192431");
  is trunc($random->pick(2)), trunc("0.925799668798923");
  is trunc($random->pick(2)), trunc("1.1552761206212");
  is trunc($random->pick(2)), trunc("1.06794552185054");
  is trunc($random->pick(2)), trunc("0.0517798449614304");
  is trunc($random->pick(2)), trunc("1.5396240830023");
  is trunc($random->pick(2)), trunc("1.20227282791187");
  is trunc($random->pick(2)), trunc("1.8176655070289");
  is trunc($random->pick(2)), trunc("0.978769628562134");
  is trunc($random->pick(2)), trunc("1.07197949442789");
  is trunc($random->pick(2)), trunc("0.993381912036071");
  is trunc($random->pick(2)), trunc("0.875275033660536");
  is trunc($random->pick(2)), trunc("0.699354505727655");
  is trunc($random->pick(2)), trunc("1.84384437145427");
  is trunc($random->pick(2)), trunc("0.120783197657417");
  is trunc($random->pick(2)), trunc("1.71978820473345");
  is trunc($random->pick(2)), trunc("1.94397997355247");
  is trunc($random->pick(2)), trunc("1.69780744957117");
  is trunc($random->pick(2)), trunc("0.503754639804427");
  is trunc($random->pick(2)), trunc("0.411571208692841");
  is trunc($random->pick(2)), trunc("0.193544498470743");
  is trunc($random->pick(2)), trunc("0.603739817037074");
  is trunc($random->pick(2)), trunc("1.4569699056177");
  is trunc($random->pick(2)), trunc("0.110794347253666");
  is trunc($random->pick(2)), trunc("0.547923622475707");
  is trunc($random->pick(2)), trunc("0.579542785458692");
  is trunc($random->pick(2)), trunc("1.13146019907994");
  is trunc($random->pick(2)), trunc("1.71035087940019");
  is trunc($random->pick(2)), trunc("0.432201618672678");
  is trunc($random->pick(2)), trunc("1.60346089847183");
  is trunc($random->pick(2)), trunc("1.63369505971643");
  is trunc($random->pick(2)), trunc("0.427368906090187");
  is trunc($random->pick(2)), trunc("0.177468777983222");
  is trunc($random->pick(2)), trunc("1.11434841852027");
  is trunc($random->pick(2)), trunc("1.04957017924171");
  is trunc($random->pick(2)), trunc("1.7282423859044");
  is trunc($random->pick(2)), trunc("1.8663215225877");
  is trunc($random->pick(2)), trunc("0.277919782607789");
  is trunc($random->pick(2)), trunc("1.08892847592914");
  is trunc($random->pick(2)), trunc("1.03843946416681");
  is trunc($random->pick(2)), trunc("0.586994350775342");

  $result
});

=method range

The range method returns a random number within the range provided. If no
arguments are provided, the range is from C<0> to C<2147483647>.

=signature range

  range(Str $from, Str $to) (Int)

=metadata range

{
  since => '1.11',
}

=example-1 range

  # given: synopsis

  package main;

  my $range = $random->range(1, 10);

  # 8

  # $range = $random->range(1, 10);

  # 4

=cut

$test->for('example', 1, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->range(1, 10), 8;
  is $random->range(1, 10), 4;
  is $random->range(1, 10), 2;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 1;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 7;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 1;
  is $random->range(1, 10), 8;
  is $random->range(1, 10), 7;
  is $random->range(1, 10), 10;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 5;
  is $random->range(1, 10), 4;
  is $random->range(1, 10), 10;
  is $random->range(1, 10), 1;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 10;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 3;
  is $random->range(1, 10), 3;
  is $random->range(1, 10), 1;
  is $random->range(1, 10), 4;
  is $random->range(1, 10), 8;
  is $random->range(1, 10), 1;
  is $random->range(1, 10), 3;
  is $random->range(1, 10), 3;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 3;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 3;
  is $random->range(1, 10), 1;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 9;
  is $random->range(1, 10), 10;
  is $random->range(1, 10), 2;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 6;
  is $random->range(1, 10), 3;

  $result
});

=example-2 range

  # given: synopsis

  package main;

  my $range = $random->range(10, 1);

  # 5

  # $range = $random->range(10, 1);

  # 8

=cut

$test->for('example', 2, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->range(10, 1), 5;
  is $random->range(10, 1), 8;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 5;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 3;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 7;
  is $random->range(10, 1), 8;
  is $random->range(10, 1), 3;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 3;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 8;
  is $random->range(10, 1), 9;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 8;
  is $random->range(10, 1), 5;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 8;
  is $random->range(10, 1), 8;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 9;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 9;
  is $random->range(10, 1), 10;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 4;
  is $random->range(10, 1), 3;
  is $random->range(10, 1), 9;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 6;
  is $random->range(10, 1), 8;

  $result
});

=example-3 range

  # given: synopsis

  package main;

  my $range = $random->range(0, 60);

  # 45

  # $range = $random->range(0, 60);

  # 20

=cut

$test->for('example', 3, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->range(0, 60), 45;
  is $random->range(0, 60), 20;
  is $random->range(0, 60), 6;
  is $random->range(0, 60), 25;
  is $random->range(0, 60), 4;
  is $random->range(0, 60), 52;
  is $random->range(0, 60), 30;
  is $random->range(0, 60), 29;
  is $random->range(0, 60), 42;
  is $random->range(0, 60), 50;
  is $random->range(0, 60), 28;
  is $random->range(0, 60), 35;
  is $random->range(0, 60), 32;
  is $random->range(0, 60), 1;
  is $random->range(0, 60), 46;
  is $random->range(0, 60), 36;
  is $random->range(0, 60), 55;
  is $random->range(0, 60), 29;
  is $random->range(0, 60), 32;
  is $random->range(0, 60), 30;
  is $random->range(0, 60), 26;
  is $random->range(0, 60), 21;
  is $random->range(0, 60), 56;
  is $random->range(0, 60), 3;
  is $random->range(0, 60), 52;
  is $random->range(0, 60), 59;
  is $random->range(0, 60), 51;
  is $random->range(0, 60), 15;
  is $random->range(0, 60), 12;
  is $random->range(0, 60), 5;
  is $random->range(0, 60), 18;
  is $random->range(0, 60), 44;
  is $random->range(0, 60), 3;
  is $random->range(0, 60), 16;
  is $random->range(0, 60), 17;
  is $random->range(0, 60), 34;
  is $random->range(0, 60), 52;
  is $random->range(0, 60), 13;
  is $random->range(0, 60), 48;
  is $random->range(0, 60), 49;
  is $random->range(0, 60), 13;
  is $random->range(0, 60), 5;
  is $random->range(0, 60), 33;
  is $random->range(0, 60), 32;
  is $random->range(0, 60), 52;
  is $random->range(0, 60), 56;
  is $random->range(0, 60), 8;
  is $random->range(0, 60), 33;
  is $random->range(0, 60), 31;
  is $random->range(0, 60), 17;

  $result
});

=example-4 range

  # given: synopsis

  package main;

  my $range = $random->range(-5, -1);

  # -2

  # $range = $random->range(-5, -1);

  # -4

=cut

$test->for('example', 4, 'range', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->range(-5, -1), -2;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -2;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -2;
  is $random->range(-5, -1), -2;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -2;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -4;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -1;
  is $random->range(-5, -1), -5;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -3;
  is $random->range(-5, -1), -4;

  $result
});

=method repeat

The repeat method dispatches to the specified method or coderef, repeatedly
based on the number of C<$times> specified, and returns the random results from
each dispatched call. In list context, the results from each call is returned
as a list, in scalar context the results are concatenated.

=signature repeat

  repeat(Int $times, Str|CodeRef $code, Any @args) (Int|Str)

=metadata repeat

{
  since => '1.11',
}

=example-1 repeat

  # given: synopsis

  package main;

  my @repeat = $random->repeat(2);

  # (7, 3)

  # @repeat = $random->repeat(2);

  # (1, 4)


=cut

$test->for('example', 1, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is_deeply [$random->repeat(2)], [7, 3];
  is_deeply [$random->repeat(2)], [1, 4];
  is_deeply [$random->repeat(2)], [0, 8];
  is_deeply [$random->repeat(2)], [4, 4];
  is_deeply [$random->repeat(2)], [6, 8];
  is_deeply [$random->repeat(2)], [4, 5];
  is_deeply [$random->repeat(2)], [5, 0];
  is_deeply [$random->repeat(2)], [7, 6];
  is_deeply [$random->repeat(2)], [9, 4];
  is_deeply [$random->repeat(2)], [5, 4];
  is_deeply [$random->repeat(2)], [4, 3];
  is_deeply [$random->repeat(2)], [9, 0];
  is_deeply [$random->repeat(2)], [8, 9];
  is_deeply [$random->repeat(2)], [8, 2];
  is_deeply [$random->repeat(2)], [2, 0];
  is_deeply [$random->repeat(2)], [3, 7];
  is_deeply [$random->repeat(2)], [0, 2];
  is_deeply [$random->repeat(2)], [2, 5];
  is_deeply [$random->repeat(2)], [8, 2];
  is_deeply [$random->repeat(2)], [8, 8];
  is_deeply [$random->repeat(2)], [2, 0];
  is_deeply [$random->repeat(2)], [5, 5];
  is_deeply [$random->repeat(2)], [8, 9];
  is_deeply [$random->repeat(2)], [1, 5];
  is_deeply [$random->repeat(2)], [5, 2];

  $result
});

=example-2 repeat

  # given: synopsis

  package main;

  my @repeat = $random->repeat(2, "float");

  # (1447361.5, "0.0000")

  # @repeat = $random->repeat(2, "float");

  # ("482092.1040", 1555.7410393)


=cut

$test->for('example', 2, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc(1447361.5), trunc("0.0000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("482092.1040"), trunc("1555.7410393")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("243073010.62968"), trunc("211.129029505")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("24482222.86154329"), trunc("6.556")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("0.00"), trunc("17652140.46803842")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("4.19828"), trunc("50807265.7")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("13521.258"), trunc("0.54")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("0.00000000"), trunc("2996.60")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("219329.0876"), trunc("51.256")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("1.2"), trunc("165823309.60632405")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("207785.414616"), trunc("12976.090746608")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("2184.285870579"), trunc("4962126.07")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("52996.93"), trunc("233.659434202")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("208182.10328548"), trunc("446099950.92124")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("27197.291840737"), trunc("2.1292108")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("11504.2135"), trunc("86.1")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("0.000"), trunc("0.000000000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("2814337.555595279"), trunc("0.000000000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("19592108.75910050"), trunc("7955940.0889820")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("10842452.67346"), trunc("236808.75850632")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("65.1309632"), trunc("898218603.151974320")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("25368.54295825"), trunc("13.232559545")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("1884.0766"), trunc("0.824919221")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("45112657.8201"), trunc("29867.7308")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("0.000000"), trunc("242355.0")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("441578271.4"), trunc("306151066.8583753")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("20089.0"), trunc("39.796373")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("3957537.963587"), trunc("980620.6971")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("3432846.381807"), trunc("259.606")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("2.978163"), trunc("7357424.866739")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("32449.6"), trunc("4.2612638")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("883940.5"), trunc("65.6")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("28888.177"), trunc("33.42273901")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("2.4"), trunc("857.0034")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("56816969.0888"), trunc("128687950.53139541")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("32255201.78919"), trunc("0.0000000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("112.8"), trunc("661.365279709")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("4.7003750"), trunc("1817.78179")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("3278.66699936"), trunc("150198904.49644646")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("0.000000000"), trunc("6219.25577121")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("4.47927"), trunc("31446229.542313")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("515.873542695"), trunc("0.0000000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("230595277.91726"), trunc("4835844.88")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("247375172.79516402"), trunc("0.0000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("50.455"), trunc("36.78468310")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("179.427"), trunc("17845232.53113518")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("168937448.725562"), trunc("18313039.6442055")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("49613658.9"), trunc("3.01152290")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("167.4974"), trunc("0.0000")];
  is_deeply [trunc($random->repeat(2, "float"))],
    [trunc("143953.7"), trunc("0.472408092")];

  $result
});

=example-3 repeat

  # given: synopsis

  package main;

  my @repeat = $random->repeat(2, "character");

  # (")", 4)

  # @repeat = $random->repeat(2, "character");

  # (8, "R")

=cut

$test->for('example', 3, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is_deeply [$random->repeat(2, "character")], [")", 4];
  is_deeply [$random->repeat(2, "character")], [8, "R"];
  is_deeply [$random->repeat(2, "character")], ["+", "a"];
  is_deeply [$random->repeat(2, "character")], ["}", "["];
  is_deeply [$random->repeat(2, "character")], ["L", "b"];
  is_deeply [$random->repeat(2, "character")], ["?", "&"];
  is_deeply [$random->repeat(2, "character")], [0, 7];
  is_deeply [$random->repeat(2, "character")], [2, 5];
  is_deeply [$random->repeat(2, "character")], ["^", ","];
  is_deeply [$random->repeat(2, "character")], [0, "w"];
  is_deeply [$random->repeat(2, "character")], ["\$", "h"];
  is_deeply [$random->repeat(2, "character")], [4, 1];
  is_deeply [$random->repeat(2, "character")], [5, 5];
  is_deeply [$random->repeat(2, "character")], [">", "*"];
  is_deeply [$random->repeat(2, "character")], [0, "M"];
  is_deeply [$random->repeat(2, "character")], ["V", "d"];
  is_deeply [$random->repeat(2, "character")], ["G", "^"];
  is_deeply [$random->repeat(2, "character")], ["'", "q"];
  is_deeply [$random->repeat(2, "character")], [6, 9];
  is_deeply [$random->repeat(2, "character")], [5, "a"];
  is_deeply [$random->repeat(2, "character")], ["}", 8];
  is_deeply [$random->repeat(2, "character")], ["G", "X"];
  is_deeply [$random->repeat(2, "character")], ["*", "V"];
  is_deeply [$random->repeat(2, "character")], [">", "t"];
  is_deeply [$random->repeat(2, "character")], ["Y", 2];
  is_deeply [$random->repeat(2, "character")], ["b", "L"];
  is_deeply [$random->repeat(2, "character")], [4, 1];
  is_deeply [$random->repeat(2, "character")], ["T", "H"];
  is_deeply [$random->repeat(2, "character")], [9, "t"];
  is_deeply [$random->repeat(2, "character")], ["-", 5];
  is_deeply [$random->repeat(2, "character")], [")", "^"];
  is_deeply [$random->repeat(2, "character")], ["?", "!"];
  is_deeply [$random->repeat(2, "character")], ["%", "\$"];
  is_deeply [$random->repeat(2, "character")], ["p", 0];
  is_deeply [$random->repeat(2, "character")], [8, "_"];
  is_deeply [$random->repeat(2, "character")], [7, "z"];
  is_deeply [$random->repeat(2, "character")], ["<", "V"];
  is_deeply [$random->repeat(2, "character")], [2, 9];
  is_deeply [$random->repeat(2, "character")], ["F", "c"];
  is_deeply [$random->repeat(2, "character")], [9, ","];
  is_deeply [$random->repeat(2, "character")], ["Z", "K"];
  is_deeply [$random->repeat(2, "character")], ["R", "q"];
  is_deeply [$random->repeat(2, "character")], ["S", "]"];
  is_deeply [$random->repeat(2, "character")], [8, ";"];
  is_deeply [$random->repeat(2, "character")], ["=", "E"];
  is_deeply [$random->repeat(2, "character")], ["N", "Y"];
  is_deeply [$random->repeat(2, "character")], [6, "r"];
  is_deeply [$random->repeat(2, "character")], ["U", ";"];
  is_deeply [$random->repeat(2, "character")], ["T", "E"];
  is_deeply [$random->repeat(2, "character")], [";", "r"];

  $result
});

=method reseed

The reseed method sets the L<perlfunc/srand> (i.e. the PRNG seed) to the value
provided, or the default value used on instanstiation when no seed is passed to
the constructor. This method returns the object that invoked it.

=signature reseed

  reseed(Str $seed) (Random)

=metadata reseed

{
  since => '1.11',
}

=example-1 reseed

  # given: synopsis

  package main;

  my $reseed = $random->reseed;

  # bless({value => ...}, "Venus::Random")

  # my $bit = $random->bit;

  # 0

=cut

$test->for('example', 1, 'reseed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Random');
  ok $result->value != 42;

  $result
});

=example-2 reseed

  # given: synopsis

  package main;

  my $reseed = $random->reseed(42);

  # bless({value => 42}, "Venus::Random")

  # my $bit = $random->bit;

  # 0

=cut

$test->for('example', 2, 'reseed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Random');
  ok $result->value == 42;
  ok $result->bit == 0;

  $result
});

=method reset

The reset method sets the L<perlfunc/srand> (i.e. the PRNG seed) to the default
value used on instanstiation when no seed is passed to the constructor. This
method returns the object that invoked it.

=signature reset

  reset() (Random)

=metadata reset

{
  since => '1.11',
}

=example-1 reset

  # given: synopsis

  package main;

  my $reset = $random->reset;

  # bless({value => ...}, "Venus::Random")

=cut

$test->for('example', 1, 'reset', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Random');
  ok $result->value != 42;

  $result
});

=method restore

The restore method sets the L<perlfunc/srand> (i.e. the PRNG seed) to the
original value used by L<perlfunc/rand>. This method returns the object that
invoked it.

=signature restore

  restore() (Random)

=metadata restore

{
  since => '1.11',
}

=example-1 restore

  # given: synopsis

  package main;

  my $restore = $random->restore;

  # bless({value => ...}, "Venus::Random")

=cut

$test->for('example', 1, 'restore', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Random');
  ok $result->value != 42;

  $result
});

=method select

The select method returns a random value from the I<"hashref"> or I<"arrayref">
provided.

=signature select

  select(ArrayRef|HashRef $data) (Any)

=metadata select

{
  since => '1.11',
}

=example-1 select

  # given: synopsis

  package main;

  my $select = $random->select(["a".."d"]);

  # "c"

  # $select = $random->select(["a".."d"]);

  # "b"

=cut

$test->for('example', 1, 'select', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "b";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "d";
  is $random->select(["a".."d"]), "a";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "c";
  is $random->select(["a".."d"]), "b";

  $result
});

=example-2 select

  # given: synopsis

  package main;

  my $select = $random->select({"a".."h"});

  # "f"

  # $select = $random->select({"a".."h"});

  # "d"

=cut

$test->for('example', 2, 'select', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "d";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "h";
  is_deeply $random->select({"a".."h"}), "b";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "f";
  is_deeply $random->select({"a".."h"}), "d";

  $result
});

=method symbol

The symbol method returns a random symbol.

=signature symbol

  symbol() (Str)

=metadata symbol

{
  since => '1.11',
}

=example-1 symbol

  # given: synopsis

  package main;

  my $symbol = $random->symbol;

  # "'"

  # $symbol = $random->symbol;

  # ")"

=cut

$test->for('example', 1, 'symbol', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->symbol, "'";
  is $random->symbol, ")";
  is $random->symbol, "#";
  is $random->symbol, "=";
  is $random->symbol, "\@";
  is $random->symbol, ".";
  is $random->symbol, "[";
  is $random->symbol, "+";
  is $random->symbol, ";";
  is $random->symbol, ",";
  is $random->symbol, "+";
  is $random->symbol, "{";
  is $random->symbol, "]";
  is $random->symbol, "~";
  is $random->symbol, "'";
  is $random->symbol, "}";
  is $random->symbol, "<";
  is $random->symbol, "[";
  is $random->symbol, "]";
  is $random->symbol, "[";
  is $random->symbol, "=";
  is $random->symbol, ")";
  is $random->symbol, "<";
  is $random->symbol, "!";
  is $random->symbol, ".";
  is $random->symbol, "?";
  is $random->symbol, ".";
  is $random->symbol, "&";
  is $random->symbol, "^";
  is $random->symbol, "\@";
  is $random->symbol, "(";
  is $random->symbol, ":";
  is $random->symbol, "!";
  is $random->symbol, "*";
  is $random->symbol, "*";
  is $random->symbol, "{";
  is $random->symbol, ".";
  is $random->symbol, "^";
  is $random->symbol, "\"";
  is $random->symbol, ",";
  is $random->symbol, "^";
  is $random->symbol, "\@";
  is $random->symbol, "{";
  is $random->symbol, "]";
  is $random->symbol, ".";
  is $random->symbol, "<";
  is $random->symbol, "\$";
  is $random->symbol, "]";
  is $random->symbol, "]";
  is $random->symbol, "(";

  $result
});

=method uppercased

The uppercased method returns a random uppercased letter.

=signature uppercased

  uppercased() (Str)

=metadata uppercased

{
  since => '1.11',
}

=example-1 uppercased

  # given: synopsis

  package main;

  my $uppercased = $random->uppercased;

  # "T"

  # $uppercased = $random->uppercased;

  # "I"

=cut

$test->for('example', 1, 'uppercased', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  my $random = Venus::Random->new(42);

  is $random->uppercased, "T";
  is $random->uppercased, "I";
  is $random->uppercased, "C";
  is $random->uppercased, "K";
  is $random->uppercased, "C";
  is $random->uppercased, "W";
  is $random->uppercased, "M";
  is $random->uppercased, "M";
  is $random->uppercased, "R";
  is $random->uppercased, "V";
  is $random->uppercased, "M";
  is $random->uppercased, "P";
  is $random->uppercased, "N";
  is $random->uppercased, "A";
  is $random->uppercased, "U";
  is $random->uppercased, "P";
  is $random->uppercased, "X";
  is $random->uppercased, "M";
  is $random->uppercased, "N";
  is $random->uppercased, "M";
  is $random->uppercased, "L";
  is $random->uppercased, "J";
  is $random->uppercased, "X";
  is $random->uppercased, "B";
  is $random->uppercased, "W";
  is $random->uppercased, "Z";
  is $random->uppercased, "W";
  is $random->uppercased, "G";
  is $random->uppercased, "F";
  is $random->uppercased, "C";
  is $random->uppercased, "H";
  is $random->uppercased, "S";
  is $random->uppercased, "B";
  is $random->uppercased, "H";
  is $random->uppercased, "H";
  is $random->uppercased, "O";
  is $random->uppercased, "W";
  is $random->uppercased, "F";
  is $random->uppercased, "U";
  is $random->uppercased, "V";
  is $random->uppercased, "F";
  is $random->uppercased, "C";
  is $random->uppercased, "O";
  is $random->uppercased, "N";
  is $random->uppercased, "W";
  is $random->uppercased, "Y";
  is $random->uppercased, "D";
  is $random->uppercased, "O";
  is $random->uppercased, "N";
  is $random->uppercased, "H";

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

SKIP:
$test->render('lib/Venus/Random.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
