package main;

use 5.014;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

if (require Venus::Yaml && not Venus::Yaml->package) {
  diag 'No suitable YAML library found';
  goto SKIP;
}

my $test = test(__FILE__);

=name

Venus::Yaml

=cut

$test->for('name');

=tagline

Yaml Class

=cut

$test->for('tagline');

=abstract

Yaml Class for Perl 5

=cut

$test->for('abstract');

=includes

method: decode
method: encode

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Yaml;

  my $yaml = Venus::Yaml->new(
    value => { name => ['Ready', 'Robot'], version => 0.12, stable => !!1, }
  );

  # $yaml->encode;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Yaml');

  $result
});

=description

This package provides methods for reading and writing L<YAML|https://yaml.org>
data. B<Note:> This package requires that a suitable YAML is installed,
currently either C<YAML::XS> C<0.67+>, C<YAML::PP::LibYAML> C<0.004+>, or
C<YAML::PP> C<0.23+>.

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

The decode method decodes the YAML string, sets the object value, and returns
the decoded value.

=signature decode

  decode(Str $yaml) (Any)

=metadata decode

{
  since => '0.01',
}

=example-1 decode

  # given: synopsis;

  my $decode = $yaml->decode("codename: ['Ready','Robot']\nstable: true");

  # { codename => ["Ready", "Robot"], stable => 1 }

=cut

$test->for('example', 1, 'decode', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, { codename => ["Ready", "Robot"], stable => 1 };

  $result
});

=method encode

The encode method encodes the objects value as a YAML string and returns the
encoded string.

=signature encode

  encode() (Str)

=metadata encode

{
  since => '0.01',
}

=example-1 encode

  # given: synopsis;

  my $encode = $yaml->encode;

  # "---\nname:\n- Ready\n- Robot\nstable: true\nversion: 0.12\n"

=cut

$test->for('example', 1, 'encode', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "---\nname:\n- Ready\n- Robot\nstable: true\nversion: 0.12\n";

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

$test->render('lib/Venus/Yaml.pod') if $ENV{RENDER};

SKIP:
ok 1 and done_testing;
