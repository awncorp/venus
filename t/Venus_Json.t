package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

if (require Venus::Json && not Venus::Json->new->package) {
  warn 'No suitable JSON library found';
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

method: config
method: decode
method: encode
method: explain
method: package

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Json;

  my $json = Venus::Json->new(
    value => { name => ['Ready', 'Robot'], version => 0.12, stable => \1, }
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
data.

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

engine: rw, opt, Object

=cut

$test->for('attributes');

=method config

The config method returns the L<JSON::PP> compatible JSON client.

=signature config

  config() (Object)

=metadata config

{
  since => '0.01',
}

=example-1 config

  # given: synopsis;

  my $config = $json->config;

  # bless({ ...  }, "...") # e.g. JSON::PP

  # $json->config->canonical->pretty;

=cut

$test->for('example', 1, 'config', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('JSON::XS') || $result->isa('JSON::PP');

  $result
});

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
  ok $result eq '{"name":["Ready","Robot"],"stable":true,"version":0.12}';

  $result
});

=method explain

The explain method returns the encoded JSON string and is used in
stringification operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $json->explain;

  # '{ "name": ["Ready", "Robot"], "stable": true, "version": 0.12 }'

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq '{"name":["Ready","Robot"],"stable":true,"version":0.12}';

  $result
});

=method package

The package method returns the package name of the first JSON client found.
Those clients (in this order) are L<JSON::XS>, and L<JSON::PP>. This package
does not support L<Cpanel::JSON::XS> because it does not support custom boolean
handlers.

=signature package

  package() (Str)

=metadata package

{
  since => '0.01',
}

=example-1 package

  # given: synopsis;

  my $package = $json->package;

  # "JSON::PP"

=cut

$test->for('example', 1, 'package', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "JSON::PP";

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