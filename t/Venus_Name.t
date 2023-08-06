package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Name

=cut

$test->for('name');

=tagline

Name Class

=cut

$test->for('tagline');

=abstract

Name Class for Perl 5

=cut

$test->for('abstract');

=includes

method: default
method: dist
method: explain
method: file
method: format
method: label
method: lookslike_a_file
method: lookslike_a_label
method: lookslike_a_package
method: lookslike_a_path
method: lookslike_a_pragma
method: package
method: path

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Name;

  my $name = Venus::Name->new('Foo/Bar');

  # $name->package;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for parsing and formatting package namespace
strings.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Explainable
Venus::Role::Valuable

=cut

$test->for('integrates');

=method default

The default method returns the default value, i.e. C<'Venus'>.

=signature default

  default() (Str)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $name->default;

  # "Venus"

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Venus";

  $result
});

=method dist

The dist method returns a package distribution representation of the name.

=signature dist

  dist() (Str)

=metadata dist

{
  since => '0.01',
}

=example-1 dist

  # given: synopsis;

  my $dist = $name->dist;

  # "Foo-Bar"

=cut

$test->for('example', 1, 'dist', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Foo-Bar";

  $result
});

=method explain

The explain method returns the package name and is used in stringification
operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $name->explain;

  # "Foo/Bar"

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Foo/Bar";

  $result
});

=method file

The file method returns a file representation of the name.

=signature file

  file() (Str)

=metadata file

{
  since => '0.01',
}

=example-1 file

  # given: synopsis;

  my $file = $name->file;

  # "foo__bar"

=cut

$test->for('example', 1, 'file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "foo__bar";

  $result
});

=method format

The format method calls the specified method passing the result to the core
L</sprintf> function with itself as an argument. This method supports
dispatching, i.e. providing a method name and arguments whose return value will
be acted on by this method.

=signature format

  format(Str $method, Str $format) (Str)

=metadata format

{
  since => '0.01',
}

=example-1 format

  # given: synopsis;

  my $format = $name->format('file', '%s.t');

  # "foo__bar.t"

=cut

$test->for('example', 1, 'format', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "foo__bar.t";

  $result
});

=method label

The label method returns a label (or constant) representation of the name.

=signature label

  label() (Str)

=metadata label

{
  since => '0.01',
}

=example-1 label

  # given: synopsis;

  my $label = $name->label;

  # "Foo_Bar"

=cut

$test->for('example', 1, 'label', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Foo_Bar";

  $result
});

=method lookslike_a_file

The lookslike_a_file method returns truthy if its state resembles a filename.

=signature lookslike_a_file

  lookslike_a_file() (Str)

=metadata lookslike_a_file

{
  since => '0.01',
}

=example-1 lookslike_a_file

  # given: synopsis;

  my $lookslike_a_file = $name->lookslike_a_file;

  # ""

=cut

$test->for('example', 1, 'lookslike_a_file', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method lookslike_a_label

The lookslike_a_label method returns truthy if its state resembles a label (or
constant).

=signature lookslike_a_label

  lookslike_a_label() (Str)

=metadata lookslike_a_label

{
  since => '0.01',
}

=example-1 lookslike_a_label

  # given: synopsis;

  my $lookslike_a_label = $name->lookslike_a_label;

  # ""

=cut

$test->for('example', 1, 'lookslike_a_label', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method lookslike_a_package

The lookslike_a_package method returns truthy if its state resembles a package
name.

=signature lookslike_a_package

  lookslike_a_package() (Str)

=metadata lookslike_a_package

{
  since => '0.01',
}

=example-1 lookslike_a_package

  # given: synopsis;

  my $lookslike_a_package = $name->lookslike_a_package;

  # ""

=cut

$test->for('example', 1, 'lookslike_a_package', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method lookslike_a_path

The lookslike_a_path method returns truthy if its state resembles a file path.

=signature lookslike_a_path

  lookslike_a_path() (Str)

=metadata lookslike_a_path

{
  since => '0.01',
}

=example-1 lookslike_a_path

  # given: synopsis;

  my $lookslike_a_path = $name->lookslike_a_path;

  # 1

=cut

$test->for('example', 1, 'lookslike_a_path', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=method lookslike_a_pragma

The lookslike_a_pragma method returns truthy if its state resembles a pragma.

=signature lookslike_a_pragma

  lookslike_a_pragma() (Str)

=metadata lookslike_a_pragma

{
  since => '0.01',
}

=example-1 lookslike_a_pragma

  # given: synopsis;

  my $lookslike_a_pragma = $name->lookslike_a_pragma;

  # ""

=cut

$test->for('example', 1, 'lookslike_a_pragma', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=method package

The package method returns a package name representation of the name given.

=signature package

  package() (Str)

=metadata package

{
  since => '0.01',
}

=example-1 package

  # given: synopsis;

  my $package = $name->package;

  # "Foo::Bar"

=cut

$test->for('example', 1, 'package', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Foo::Bar";

  $result
});

=method path

The path method returns a path representation of the name.

=signature path

  path() (Str)

=metadata path

{
  since => '0.01',
}

=example-1 path

  # given: synopsis;

  my $path = $name->path;

  # "Foo/Bar"

=cut

$test->for('example', 1, 'path', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Foo/Bar";

  $result
});

=operator (.)

This package overloads the C<.> operator.

=cut

$test->for('operator', '(.)');

=example-1 (.)

  # given: synopsis;

  my $package = $name . 'Baz';

  # "Foo::BarBaz"

=cut

$test->for('example', 1, '(.)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Foo/BarBaz";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  $name eq 'Foo/Bar';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (eq)

  package main;

  use Venus::Name;

  my $name1 = Venus::Name->new('Foo\Bar');
  my $name2 = Venus::Name->new('Foo\Bar');

  $name1 eq $name2;

  # 1

=cut

$test->for('example', 2, '(eq)', sub {
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

  $name ne 'Foo\Bar';

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (ne)

  package main;

  use Venus::Name;

  my $name1 = Venus::Name->new('FooBar');
  my $name2 = Venus::Name->new('Foo_Bar');

  $name1 ne $name2;

  # 1

=cut

$test->for('example', 2, '(ne)', sub {
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

  "Foo/Bar" =~ qr/$name/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$name";

  # "Foo/Bar"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo/Bar';

  $result
});

=example-2 ("")

  # given: synopsis;

  my $result = "$name, $name";

  # "Foo/Bar, Foo/Bar"

=cut

$test->for('example', 2, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'Foo/Bar, Foo/Bar';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $name ~~ 'Foo/Bar';

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Name.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;