package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Boolean

=cut

$test->for('name');

=tagline

Boolean Class

=cut

$test->for('tagline');

=abstract

Boolean Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default
method: is_false
method: is_true
method: negate
method: type

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Boolean;

  my $boolean = Venus::Boolean->new;

  # $boolean->negate;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=description

This package provides a representation for boolean values.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method default

The default method returns the default value, i.e. C<0>.

=signature default

  default() (Bool)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $boolean->default;

  # 0

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method is_false

The is_false method returns C<false> if the boolean is falsy, otherwise returns
C<true>.

=signature is_false

  is_false() (Bool)

=metadata is_false

{
  since => '0.01',
}

=example-1 is_false

  # given: synopsis;

  my $is_false = $boolean->is_false;

  # 1

=cut

$test->for('example', 1, 'is_false', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method is_true

The is_true method returns C<true> if the boolean is truthy, otherwise returns
C<false>.

=signature is_true

  is_true() (Bool)

=metadata is_true

{
  since => '0.01',
}

=example-1 is_true

  # given: synopsis;

  my $is_true = $boolean->is_true;

  # 0

=cut

$test->for('example', 1, 'is_true', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method negate

The negate method returns C<true> if the boolean is falsy, otherwise returns
C<false>.

=signature negate

  negate() (Bool)

=metadata negate

{
  since => '0.01',
}

=example-1 negate

  # given: synopsis;

  my $negate = $boolean->negate;

  # 1

=cut

$test->for('example', 1, 'negate', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method type

The type method returns the word C<'true'> if the boolean is truthy, otherwise
returns C<'false'>.

=signature type

  type() (Str)

=metadata type

{
  since => '0.01',
}

=example-1 type

  # given: synopsis;

  my $type = $boolean->type;

  # "false"

=cut

$test->for('example', 1, 'type', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "false";

  $result
});

=operator (!)

This package overloads the C<!> operator.

=cut

$test->for('operator', '(!)');

=example-1 (!)

  # given: synopsis;

  my $result = !$boolean;

  # 1

=cut

$test->for('example', 1, '(!)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (E<lt>)

This package overloads the C<E<lt>> operator.

=cut

$test->for('operator', '(E<lt>)');

=example-1 (E<lt>)

  # given: synopsis;

  my $result = $boolean < 1;

  # 1

=cut

$test->for('example', 1, '(E<lt>)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (E<lt>=)

This package overloads the C<E<lt>=> operator.

=cut

$test->for('operator', '(E<lt>=)');

=example-1 (E<lt>=)

  # given: synopsis;

  my $result = $boolean <= 0;

  # 1

=cut

$test->for('example', 1, '(E<lt>=)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (E<gt>)

This package overloads the C<E<gt>> operator.

=cut

$test->for('operator', '(E<gt>)');

=example-1 (E<gt>)

  # given: synopsis;

  my $result = $boolean > 0;

  # 0

=cut

$test->for('example', 1, '(E<gt>)', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=operator (E<gt>=)

This package overloads the C<E<gt>=> operator.

=cut

$test->for('operator', '(E<gt>=)');

=example-1 (E<gt>=)

  # given: synopsis;

  my $result = $boolean >= 0;

  # 1

=cut

$test->for('example', 1, '(E<gt>=)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (!=)

This package overloads the C<!=> operator.

=cut

$test->for('operator', '(!=)');

=example-1 (!=)

  # given: synopsis;

  my $result = $boolean != 1;

  # 1

=cut

$test->for('example', 1, '(!=)', sub {
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

  my $result = $boolean == 0;

  # 1

=cut

$test->for('example', 1, '(==)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (bool)

This package overloads the C<bool> operator.

=cut

$test->for('operator', '(bool)');

=example-1 (bool)

  # given: synopsis;

  my $result = !!$boolean;

  # 0

=cut

$test->for('example', 1, '(bool)', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $boolean eq '0';

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

  my $result = $boolean ne '1';

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $result = '0' =~ qr/$boolean/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
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

$test->render('lib/Venus/Boolean.pod') if $ENV{RENDER};

ok 1 and done_testing;