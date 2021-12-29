package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::Opts

=cut

$test->for('name');

=tagline

Opts Class

=cut

$test->for('tagline');

=abstract

Opts Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default
method: exists
method: get
method: parse
method: name
method: set
method: unnamed

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Opts;

  my $opts = Venus::Opts->new(
    value => ['--resource', 'users', '--help'],
    specs => ['resource|r=s', 'help|h'],
    named => { method => 'resource' } # optional
  );

  # $opts->method; # $resource
  # $opts->get('resource'); # $resource

  # $opts->help; # $help
  # $opts->get('help'); # $help

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Opts');

  is $result->method, 'users';
  is $result->help, 1;

  $result
});

=description

This package provides methods for handling command-line arguments.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Proxyable

=cut

$test->for('integrates');

=attributes

named: rw, opt, HashRef, C<{}>
parsed: rw, opt, HashRef, C<{}>
specs: rw, opt, ArrayRef, C<[]>
warns: rw, opt, ArrayRef, C<[]>

=cut

$test->for('attributes');

=method default

The default method returns the default value, i.e. C<[@ARGV]>.

=signature default

  default() (ArrayRef)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $opts->default;

  # []

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok ref($result) eq 'ARRAY';

  $result
});

=method exists

The exists method takes a name or index and returns truthy if an associated
value exists.

=signature exists

  exists(Str $key) (Bool)

=metadata exists

{
  since => '0.01',
}

=example-1 exists

  # given: synopsis;

  my $exists = $opts->exists('resource');

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

  my $exists = $opts->exists('method');

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

  my $exists = $opts->exists('resources');

  # undef

=cut

$test->for('example', 3, 'exists', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method get

The get method takes a name or index and returns the associated value.

=signature get

  get(Str $key) (Any)

=metadata get

{
  since => '0.01',
}

=example-1 get

  # given: synopsis;

  my $get = $opts->get('resource');

  # "users"

=cut

$test->for('example', 1, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "users";

  $result
});

=example-2 get

  # given: synopsis;

  my $get = $opts->get('method');

  # "users"

=cut

$test->for('example', 2, 'get', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "users";

  $result
});

=example-3 get

  # given: synopsis;

  my $get = $opts->get('resources');

  # undef

=cut

$test->for('example', 3, 'get', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method parse

The parse method optionally takes additional L<Getopt::Long> parser
configuration options and retuns the options found based on the object C<args>
and C<spec> values.

=signature parse

  parse(ArrayRef $args) (Opts)

=metadata parse

{
  since => '0.01',
}

=example-1 parse

  # given: synopsis;

  my $parse = $opts->parse;

  # { help => 1, resource => "users" }

=cut

$test->for('example', 1, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { help => 1, resource => "users" };

  $result
});

=example-2 parse

  # given: synopsis;

  my $parse = $opts->parse(['bundling']);

  # { help => 1, resource => "users" }

=cut

$test->for('example', 2, 'parse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { help => 1, resource => "users" };

  $result
});

=method name

The name method takes a name or index and returns index if the the associated
value exists.

=signature name

  name(Str $key) (Str | Undef)

=metadata name

{
  since => '0.01',
}

=example-1 name

  # given: synopsis;

  my $name = $opts->name('resource');

  # "resource"

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "resource";

  $result
});

=example-2 name

  # given: synopsis;

  my $name = $opts->name('method');

  # "resource"

=cut

$test->for('example', 2, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "resource";

  $result
});

=example-3 name

  # given: synopsis;

  my $name = $opts->name('resources');

  # undef

=cut

$test->for('example', 3, 'name', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method set

The set method takes a name or index and sets the value provided if the
associated argument exists.

=signature set

  set(Str $key, Any $data) (Any)

=metadata set

{
  since => '0.01',
}

=example-1 set

  # given: synopsis;

  my $set = $opts->set('method', 'people');

  # "people"

=cut

$test->for('example', 1, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "people";

  $result
});

=example-2 set

  # given: synopsis;

  my $set = $opts->set('resource', 'people');

  # "people"

=cut

$test->for('example', 2, 'set', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "people";

  $result
});

=example-3 set

  # given: synopsis;

  my $set = $opts->set('resources', 'people');

  # undef

=cut

$test->for('example', 3, 'set', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method unnamed

The unnamed method returns an arrayref of values which have not been named
using the C<named> attribute.

=signature unnamed

  unnamed() (ArrayRef)

=metadata unnamed

{
  since => '0.01',
}

=example-1 unnamed

  # given: synopsis;

  my $unnamed = $opts->unnamed;

  # [1]

=cut

$test->for('example', 1, 'unnamed', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [1];

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

$test->render('lib/Venus/Opts.pod') if $ENV{RENDER};

ok 1 and done_testing;