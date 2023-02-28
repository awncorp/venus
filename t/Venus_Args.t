package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Args

=cut

$test->for('name');

=tagline

Args Class

=cut

$test->for('tagline');

=abstract

Args Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default
method: exists
method: get
method: indexed
method: name
method: set
method: unnamed

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Args;

  my $args = Venus::Args->new(
    named => { flag => 0, command => 1 }, # optional
    value => ['--help', 'execute'],
  );

  # $args->flag; # $ARGV[0]
  # $args->get(0); # $ARGV[0]
  # $args->get(1); # $ARGV[1]
  # $args->action; # $ARGV[1]
  # $args->exists(0); # exists $ARGV[0]
  # $args->exists('flag'); # exists $ARGV[0]
  # $args->get('flag'); # $ARGV[0]

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Args');
  is $result->flag, '--help';
  is $result->command, 'execute';

  $result
});

=description

This package provides methods for accessing C<@ARGS> items.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Proxyable
Venus::Role::Valuable

=cut

$test->for('integrates');

=attributes

named: rw, opt, HashRef, C<{}>

=cut

$test->for('attributes');

=method default

The default method returns the default value, i.e. C<@ARGV>.

=signature default

  default() (ArrayRef)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $args->default;

  # [@ARGV]

  # ["--help", "execute"]

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref($result) eq 'ARRAY';

  $result
});

=method exists

The exists method returns truthy or falsy if an index or alias value exists.

=signature exists

  exists(Str $key) (Bool)

=metadata exists

{
  since => '0.01',
}

=example-1 exists

  # given: synopsis;

  my $exists = $args->exists(0);

  # 1

=cut

$test->for('example', 1, 'exists', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 exists

  # given: synopsis;

  my $exists = $args->exists('flag');

  # 1

=cut

$test->for('example', 2, 'exists', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-3 exists

  # given: synopsis;

  my $exists = $args->exists(2);

  # undef

=cut

$test->for('example', 3, 'exists', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method get

The get method returns the value of the index or alias.

=signature get

  get(Str $key) (Any)

=metadata get

{
  since => '0.01',
}

=example-1 get

  # given: synopsis;

  my $get = $args->get(0);

  # "--help"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "--help";

  $result
});

=example-2 get

  # given: synopsis;

  my $get = $args->get('flag');

  # "--help"

=cut

$test->for('example', 2, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "--help";

  $result
});

=example-3 get

  # given: synopsis;

  my $get = $args->get(2);

  # undef

=cut

$test->for('example', 3, 'get', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method indexed

The indexed method returns a set of indices and values.

=signature indexed

  indexed() (HashRef)

=metadata indexed

{
  since => '0.01',
}

=example-1 indexed

  # given: synopsis;

  my $indexed = $args->indexed;

  # { "0" => "--help", "1" => "execute" }

=cut

$test->for('example', 1, 'indexed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { "0" => "--help", "1" => "execute" };

  $result
});

=method name

The name method resolves and returns the index for an index or alias, and
returns undefined if not found.

=signature name

  name(Str $key) (Str | Undef)

=metadata name

{
  since => '0.01',
}

=example-1 name

  # given: synopsis;

  my $name = $args->name('flag');

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method set

The set method sets and returns the value of an index or alias.

=signature set

  set(Str $key, Any $data) (Any)

=metadata set

{
  since => '0.01',
}

=example-1 set

  # given: synopsis;

  my $set = $args->set(0, '-?');

  # "-?"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "-?";

  $result
});

=example-2 set

  # given: synopsis;

  my $set = $args->set('flag', '-?');

  # "-?"

=cut

$test->for('example', 2, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "-?";

  $result
});

=example-3 set

  # given: synopsis;

  my $set = $args->set('verbose', 1);

  # undef

=cut

$test->for('example', 3, 'set', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method unnamed

The unnamed method returns a list of unaliases indices.

=signature unnamed

  unnamed() (ArrayRef)

=metadata unnamed

{
  since => '0.01',
}

=example-1 unnamed

  package main;

  use Venus::Args;

  my $args = Venus::Args->new(
    named => { flag => 0, command => 1 },
    value => ['--help', 'execute', '--format', 'markdown'],
  );

  my $unnamed = $args->unnamed;

  # ["--format", "markdown"]

=cut

$test->for('example', 1, 'unnamed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["--format", "markdown"];

  $result
});

=example-2 unnamed

  package main;

  use Venus::Args;

  my $args = Venus::Args->new(
    named => { command => 1 },
    value => ['execute', 'phase-1', '--format', 'markdown'],
  );

  my $unnamed = $args->unnamed;

  # ["execute", "--format", "markdown"]

=cut

$test->for('example', 2, 'unnamed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["execute", "--format", "markdown"];

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Args.pod') if $ENV{RENDER};

ok 1 and done_testing;