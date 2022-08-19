package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Digestable

=cut

$test->for('name');

=tagline

Digestable Role

=cut

$test->for('tagline');

=abstract

Digestable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: digest
method: digester
method: b64digest
method: bindigest
method: hexdigest

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  attr 'data';

  with 'Venus::Role::Dumpable';
  with 'Venus::Role::Digestable';

  sub execute {
    my ($self, @args) = @_;

    return [$self->data, @args];
  }

  package main;

  my $example = Example->new(data => 123);

  # $example->digest;

  # "a6c3d9ae59f31690eddbdd15271e856a6b6f15d5"

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Digestable');

  $result
});

=description

This package modifies the consuming package and provides methods for producing
message digests from a dump of the object or the return value of a dispatched
method call. All algorithms supported by L<Digest> are supported, e.g.
C<SHA-1>, C<SHA-224>, C<SHA-256>, C<SHA-384>, C<SHA-512>, C<HMAC-MD5>,
C<HMAC-SHA-1>, etc.

=cut

$test->for('description');

=method digest

The digest method returns a hexadecimal formatted digest of a dump of the
object or return value of a dispatched method call. The algorithm defaults to
C<SHA-1>. This method supports dispatching, i.e. providing a method name and
arguments whose return value will be acted on by this method.

=signature digest

  digest(Str $algo, Str $method, Any @args) (Str)

=metadata digest

{
  since => '0.01',
}

=example-1 digest

  package main;

  my $example = Example->new(data => 123);

  my $digest = $example->digest;

  # "fcf148788471488b822cf72b6d6ca9c17554a4c6"

=cut

$test->for('example', 1, 'digest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "fcf148788471488b822cf72b6d6ca9c17554a4c6";

  $result
});

=example-2 digest

  package main;

  my $example = Example->new(data => 123);

  my $digest = $example->digest('sha-1', 'execute');

  # "4feada6a2e48d2cb8a0b7569899f1baadd165c4d"

=cut

$test->for('example', 2, 'digest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "4feada6a2e48d2cb8a0b7569899f1baadd165c4d";

  $result
});

=example-3 digest

  package main;

  my $example = Example->new(data => 123);

  my $digest = $example->digest('sha-1', 'execute', '456');

  # "e557f4efb00ed7599965f6909277ceb737e1ccf7"

=cut

$test->for('example', 3, 'digest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "e557f4efb00ed7599965f6909277ceb737e1ccf7";

  $result
});

=method digester

The digester method returns a L<Digest> object with a dump of the object or
return value of a dispatched method call as the message. The algorithm defaults
to C<SHA-1>. This method supports dispatching, i.e. providing a method name and
arguments whose return value will be acted on by this method.

=signature digester

  digester(Str $algo, Str $method, Any @args) (Str)

=metadata digester

{
  since => '0.01',
}

=example-1 digester

  package main;

  my $example = Example->new(data => 123);

  my $digester = $example->digester;

  # bless(..., "Digest::SHA")

=cut

$test->for('example', 1, 'digester', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Digest::SHA');

  $result
});

=example-2 digester

  package main;

  my $example = Example->new(data => 123);

  my $digester = $example->digester('md5');

  # bless(..., "Digest::MD5")

=cut

$test->for('example', 2, 'digester', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Digest::MD5');

  $result
});

=method b64digest

The b64digest method returns a base64 formatted digest of the object or return
value of a dispatched method call. The algorithm defaults to C<SHA-1>. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method.

=signature b64digest

  b64digest(Str $algo, Str $method, Any @args) (Str)

=metadata b64digest

{
  since => '0.01',
}

=example-1 b64digest

  package main;

  my $example = Example->new(data => 123);

  my $b64digest = $example->b64digest;

  # "/PFIeIRxSIuCLPcrbWypwXVUpMY"

=cut

$test->for('example', 1, 'b64digest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "/PFIeIRxSIuCLPcrbWypwXVUpMY";

  $result
});

=example-2 b64digest

  package main;

  my $example = Example->new(data => 123);

  my $b64digest = $example->b64digest('sha-1', 'execute');

  # "T+raai5I0suKC3VpiZ8bqt0WXE0"

=cut

$test->for('example', 2, 'b64digest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "T+raai5I0suKC3VpiZ8bqt0WXE0";

  $result
});

=example-3 b64digest

  package main;

  my $example = Example->new(data => 123);

  my $b64digest = $example->b64digest('sha-1', 'execute', '456');

  # "5Vf077AO11mZZfaQknfOtzfhzPc"

=cut

$test->for('example', 3, 'b64digest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "5Vf077AO11mZZfaQknfOtzfhzPc";

  $result
});

=method bindigest

The bindigest method returns a binary formatted digest of the object or return
value of a dispatched method call. The algorithm defaults to C<SHA-1>. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method.

=signature bindigest

  bindigest(Str $algo, Str $method, Any @args) (Str)

=metadata bindigest

{
  since => '0.01',
}

=example-1 bindigest

  package main;

  my $example = Example->new(data => 123);

  my $bindigest = $example->bindigest;

  # pack("H*","fcf148788471488b822cf72b6d6ca9c17554a4c6")

=cut

$test->for('example', 1, 'bindigest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq pack("H*","fcf148788471488b822cf72b6d6ca9c17554a4c6");

  $result
});

=example-2 bindigest

  package main;

  my $example = Example->new(data => 123);

  my $bindigest = $example->bindigest('sha-1', 'execute');

  # pack("H*","4feada6a2e48d2cb8a0b7569899f1baadd165c4d")

=cut

$test->for('example', 2, 'bindigest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq pack("H*","4feada6a2e48d2cb8a0b7569899f1baadd165c4d");

  $result
});

=example-3 bindigest

  package main;

  my $example = Example->new(data => 123);

  my $bindigest = $example->bindigest('sha-1', 'execute', '456');

  # pack("H*","e557f4efb00ed7599965f6909277ceb737e1ccf7")

=cut

$test->for('example', 3, 'bindigest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq pack("H*","e557f4efb00ed7599965f6909277ceb737e1ccf7");

  $result
});

=method hexdigest

The hexdigest method returns a ... formatted digest of the object or return
value of a dispatched method call. The algorithm defaults to C<SHA-1>. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method.

=signature hexdigest

  hexdigest(Str $algo, Str $method, Any @args) (Str)

=metadata hexdigest

{
  since => '0.01',
}

=example-1 hexdigest

  package main;

  my $example = Example->new(data => 123);

  my $hexdigest = $example->hexdigest;

  # "fcf148788471488b822cf72b6d6ca9c17554a4c6"

=cut

$test->for('example', 1, 'hexdigest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "fcf148788471488b822cf72b6d6ca9c17554a4c6";

  $result
});

=example-2 hexdigest

  package main;

  my $example = Example->new(data => 123);

  my $hexdigest = $example->hexdigest('sha-1', 'execute');

  # "4feada6a2e48d2cb8a0b7569899f1baadd165c4d"

=cut

$test->for('example', 2, 'hexdigest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "4feada6a2e48d2cb8a0b7569899f1baadd165c4d";

  $result
});

=example-3 hexdigest

  package main;

  my $example = Example->new(data => 123);

  my $hexdigest = $example->hexdigest('sha-1', 'execute', '456');

  # "e557f4efb00ed7599965f6909277ceb737e1ccf7"

=cut

$test->for('example', 3, 'hexdigest', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "e557f4efb00ed7599965f6909277ceb737e1ccf7";

  $result
});

# END

$test->render('lib/Venus/Role/Digestable.pod') if $ENV{RENDER};

ok 1 and done_testing;
