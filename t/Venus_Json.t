package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

if (require Venus::Json && not Venus::Json->package) {
  diag 'No suitable JSON library found';
  goto SKIP;
}

my $test = test(__FILE__);

=name

Venus::Json

=cut

$test->for('name');

=tagline

Json Class

=cut

$test->for('tagline');

=abstract

Json Class for Perl 5

=cut

$test->for('abstract');

=includes

method: decode
method: encode

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Json;

  my $json = Venus::Json->new(
    value => { name => ['Ready', 'Robot'], version => 0.12, stable => !!1, }
  );

  # $json->encode;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for reading and writing L<JSON|https://json.org>
data. B<Note:> This package requires that a suitable JSON is installed,
currently either C<JSON::XS> C<3.0+>, C<JSON::PP> C<2.27105+>, or
C<Cpanel::JSON::XS> C<4.09+>.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Explainable

=cut

$test->for('integrates');

=attributes

decoder: rw, opt, CodeRef
encoder: rw, opt, CodeRef

=cut

$test->for('attributes');

=method decode

The decode method decodes the JSON string, sets the object value, and returns
the decoded value.

=signature decode

  decode(Str $json) (Any)

=metadata decode

{
  since => '0.01',
}

=example-1 decode

  # given: synopsis;

  my $decode = $json->decode('{"codename":["Ready","Robot"],"stable":true}');

  # { codename => ["Ready", "Robot"], stable => 1 }

=cut

$test->for('example', 1, 'decode', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { codename => ["Ready", "Robot"], stable => 1 };

  $result
});

=method encode

The encode method encodes the objects value as a JSON string and returns the
encoded string.

=signature encode

  encode() (Str)

=metadata encode

{
  since => '0.01',
}

=example-1 encode

  # given: synopsis;

  my $encode = $json->encode;

  # '{ "name": ["Ready", "Robot"], "stable": true, "version": 0.12 }'

=cut

$test->for('example', 1, 'encode', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  $result =~ s/[\n\s]//g;
  ok $result eq '{"name":["Ready","Robot"],"stable":true,"version":0.12}';

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

SKIP:
$test->render('lib/Venus/Json.pod') if $ENV{RENDER};

ok 1 and done_testing;