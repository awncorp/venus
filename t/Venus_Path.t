package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);
my $fsds = qr/[:\\\/\.]+/;

=name

Venus::Path

=cut

$test->for('name');

=tagline

Path Class

=cut

$test->for('tagline');

=abstract

Path Class for Perl 5

=cut

$test->for('abstract');

=includes

method: absolute
method: basename
method: child
method: chmod
method: chown
method: children
method: default
method: directories
method: exists
method: explain
method: extension
method: find
method: files
method: glob
method: is_absolute
method: is_directory
method: is_file
method: is_relative
method: lines
method: lineage
method: open
method: mkcall
method: mkdir
method: mkdirs
method: mkfile
method: name
method: parent
method: parents
method: parts
method: read
method: relative
method: rmdir
method: rmdirs
method: rmfiles
method: root
method: seek
method: sibling
method: siblings
method: test
method: unlink
method: write

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/planets');

  # my $planets = $path->files;
  # my $mercury = $path->child('mercury');
  # my $content = $mercury->read;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for working with file system paths.

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

=method absolute

The absolute method returns a path object where the value (path) is absolute.

=signature absolute

  absolute() (Path)

=metadata absolute

{
  since => '0.01',
}

=example-1 absolute

  # given: synopsis;

  $path = $path->absolute;

  # bless({ value => "/path/to/t/data/planets" }, "Venus::Path")

=cut

$test->for('example', 1, 'absolute', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{t${fsds}data${fsds}planets};

  $result
});

=method basename

The basename method returns the path base name.

=signature basename

  basename() (Str)

=metadata basename

{
  since => '0.01',
}

=example-1 basename

  # given: synopsis;

  my $basename = $path->basename;

  # planets

=cut

$test->for('example', 1, 'basename', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'planets';

  $result
});

=method child

The child method returns a path object representing the child path provided.

=signature child

  child(Str $path) (Path)

=metadata child

{
  since => '0.01',
}

=example-1 child

  # given: synopsis;

  $path = $path->child('earth');

  # bless({ value => "t/data/planets/earth" }, "Venus::Path")

=cut

$test->for('example', 1, 'child', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{t${fsds}data${fsds}planets${fsds}earth};

  $result
});

=method chmod

The chmod method changes the file permissions of the file or directory.

=signature chmod

  chmod(Str $mode) (Path)

=metadata chmod

{
  since => '0.01',
}

=example-1 chmod

  # given: synopsis;

  $path = $path->chmod(0755);

  # bless({ value => "t/data/planets" }, "Venus::Path")

=cut

$test->for('example', 1, 'chmod', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{t${fsds}data${fsds}planets};

  $result
});

=method chown

The chown method changes the group and/or owner or the file or directory.

=signature chown

  chown(Str @args) (Path)

=metadata chown

{
  since => '0.01',
}

=example-1 chown

  # given: synopsis;

  $path = $path->chown(-1, -1);

  # bless({ value => "t/data/planets" }, "Venus::Path")

=cut

$test->for('example', 1, 'chown', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{t${fsds}data${fsds}planets};

  $result
});

=method children

The children method returns the files and directories under the path. This
method can return a list of values in list-context.

=signature children

  children() (ArrayRef[Path])

=metadata children

{
  since => '0.01',
}

=example-1 children

  # given: synopsis;

  my $children = $path->children;

  # [
  #   bless({ value => "t/data/planets/ceres" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/earth" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/eris" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/haumea" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/jupiter" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/makemake" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mars" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mercury" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/neptune" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/planet9" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/pluto" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/saturn" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/uranus" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/venus" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'children', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 14;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}planets${fsds}ceres};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}planets${fsds}earth};

  ok $result->[2]->isa('Venus::Path');
  ok $result->[2] =~ m{t${fsds}data${fsds}planets${fsds}eris};

  ok $result->[3]->isa('Venus::Path');
  ok $result->[3] =~ m{t${fsds}data${fsds}planets${fsds}haumea};

  ok $result->[4]->isa('Venus::Path');
  ok $result->[4] =~ m{t${fsds}data${fsds}planets${fsds}jupiter};

  ok $result->[5]->isa('Venus::Path');
  ok $result->[5] =~ m{t${fsds}data${fsds}planets${fsds}makemake};

  ok $result->[6]->isa('Venus::Path');
  ok $result->[6] =~ m{t${fsds}data${fsds}planets${fsds}mars};

  ok $result->[7]->isa('Venus::Path');
  ok $result->[7] =~ m{t${fsds}data${fsds}planets${fsds}mercury};

  ok $result->[8]->isa('Venus::Path');
  ok $result->[8] =~ m{t${fsds}data${fsds}planets${fsds}neptune};

  ok $result->[9]->isa('Venus::Path');
  ok $result->[9] =~ m{t${fsds}data${fsds}planets${fsds}planet9};

  ok $result->[10]->isa('Venus::Path');
  ok $result->[10] =~ m{t${fsds}data${fsds}planets${fsds}pluto};

  ok $result->[11]->isa('Venus::Path');
  ok $result->[11] =~ m{t${fsds}data${fsds}planets${fsds}saturn};

  ok $result->[12]->isa('Venus::Path');
  ok $result->[12] =~ m{t${fsds}data${fsds}planets${fsds}uranus};

  ok $result->[13]->isa('Venus::Path');
  ok $result->[13] =~ m{t${fsds}data${fsds}planets${fsds}venus};

  $result
});

=method default

The default method returns the default value, i.e. C<$ENV{PWD}>.

=signature default

  default() (Str)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $path->default;

  # $ENV{PWD}

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=method directories

The directories method returns a list of children under the path which are
directories. This method can return a list of values in list-context.

=signature directories

  directories() (ArrayRef[Path])

=metadata directories

{
  since => '0.01',
}

=example-1 directories

  # given: synopsis;

  my $directories = $path->directories;

  # []

=cut

$test->for('example', 1, 'directories', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=method exists

The exists method returns truthy or falsy if the path exists.

=signature exists

  exists() (Bool)

=metadata exists

{
  since => '0.01',
}

=example-1 exists

  # given: synopsis;

  my $exists = $path->exists;

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

  my $exists = $path->child('random')->exists;

  # 0

=cut

$test->for('example', 2, 'exists', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method explain

The explain method returns the path string and is used in stringification
operations.

=signature explain

  explain() (Str)

=metadata explain

{
  since => '0.01',
}

=example-1 explain

  # given: synopsis;

  my $explain = $path->explain;

  # t/data/planets

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{t${fsds}data${fsds}planets};

  $result
});

=method extension

The extension method returns a new path object using the extension name
provided. If no argument is provided this method returns the extension for the
path represented by the invocant, otherwise returns undefined.

=signature extension

  extension(Str $name) (Str | Path)

=metadata extension

{
  since => '2.55',
}

=cut

=example-1 extension

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/Venus_Path.t');

  my $extension = $path->extension;

  # "t"

=cut

$test->for('example', 1, 'extension', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "t";

  $result
});

=example-2 extension

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/mercury');

  my $extension = $path->extension('txt');

  # bless({ value => "t/data/mercury.txt"}, "Venus::Path")

=cut

$test->for('example', 2, 'extension', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Path';
  ok $result =~ m{t${fsds}data${fsds}mercury\.txt};

  $result
});

=example-3 extension

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data');

  my $extension = $path->extension;

  # undef

=cut

$test->for('example', 3, 'extension', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-4 extension

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data');

  my $extension = $path->extension('txt');

  # bless({ value => "t/data.txt"}, "Venus::Path")

=cut

$test->for('example', 4, 'extension', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Path';
  ok $result =~ m{t${fsds}data\.txt};

  $result
});

=method find

The find method does a recursive depth-first search and returns a list of paths
found, matching the expression provided, which defaults to C<*>. This method
can return a list of values in list-context.

=signature find

  find(Str | Regexp $expr) (ArrayRef[Path])

=metadata find

{
  since => '0.01',
}

=example-1 find

  # given: synopsis;

  my $find = $path->find;

  # [
  #   bless({ value => "t/data/planets/ceres" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/earth" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/eris" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/haumea" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/jupiter" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/makemake" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mars" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mercury" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/neptune" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/planet9" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/pluto" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/saturn" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/uranus" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/venus" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 14;

  ok $result->[0]->isa('Venus::Path');
  like $result->[0], qr{t${fsds}data${fsds}planets${fsds}ceres};

  ok $result->[1]->isa('Venus::Path');
  like $result->[1], qr{t${fsds}data${fsds}planets${fsds}earth};

  ok $result->[2]->isa('Venus::Path');
  like $result->[2], qr{t${fsds}data${fsds}planets${fsds}eris};

  ok $result->[3]->isa('Venus::Path');
  like $result->[3], qr{t${fsds}data${fsds}planets${fsds}haumea};

  ok $result->[4]->isa('Venus::Path');
  like $result->[4], qr{t${fsds}data${fsds}planets${fsds}jupiter};

  ok $result->[5]->isa('Venus::Path');
  like $result->[5], qr{t${fsds}data${fsds}planets${fsds}makemake};

  ok $result->[6]->isa('Venus::Path');
  like $result->[6], qr{t${fsds}data${fsds}planets${fsds}mars};

  ok $result->[7]->isa('Venus::Path');
  like $result->[7], qr{t${fsds}data${fsds}planets${fsds}mercury};

  ok $result->[8]->isa('Venus::Path');
  like $result->[8], qr{t${fsds}data${fsds}planets${fsds}neptune};

  ok $result->[9]->isa('Venus::Path');
  like $result->[9], qr{t${fsds}data${fsds}planets${fsds}planet9};

  ok $result->[10]->isa('Venus::Path');
  like $result->[10], qr{t${fsds}data${fsds}planets${fsds}pluto};

  ok $result->[11]->isa('Venus::Path');
  like $result->[11], qr{t${fsds}data${fsds}planets${fsds}saturn};

  ok $result->[12]->isa('Venus::Path');
  like $result->[12], qr{t${fsds}data${fsds}planets${fsds}uranus};

  ok $result->[13]->isa('Venus::Path');
  like $result->[13], qr{t${fsds}data${fsds}planets${fsds}venus};

  $result
});

=example-2 find

  # given: synopsis;

  my $find = $path->find('[:\/\\\.]+m[^:\/\\\.]*$');

  # [
  #   bless({ value => "t/data/planets/makemake" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mars" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mercury" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 2, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 3;

  ok $result->[0]->isa('Venus::Path');
  like $result->[0], qr{t${fsds}data${fsds}planets${fsds}makemake};

  ok $result->[1]->isa('Venus::Path');
  like $result->[1], qr{t${fsds}data${fsds}planets${fsds}mars};

  ok $result->[2]->isa('Venus::Path');
  like $result->[2], qr{t${fsds}data${fsds}planets${fsds}mercury};

  $result
});

=example-3 find

  # given: synopsis;

  my $find = $path->find('earth');

  # [
  #   bless({ value => "t/data/planets/earth" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 3, 'find', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 1;

  ok $result->[0]->isa('Venus::Path');
  like $result->[0], qr{t${fsds}data${fsds}planets${fsds}earth};

  $result
});

=method files

The files method returns a list of children under the path which are files.
This method can return a list of values in list-context.

=signature files

  files() (ArrayRef[Path])

=metadata files

{
  since => '0.01',
}

=example-1 files

  # given: synopsis;

  my $files = $path->files;

  # [
  #   bless({ value => "t/data/planets/ceres" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/earth" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/eris" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/haumea" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/jupiter" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/makemake" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mars" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mercury" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/neptune" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/planet9" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/pluto" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/saturn" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/uranus" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/venus" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'files', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 14;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}planets${fsds}ceres};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}planets${fsds}earth};

  ok $result->[2]->isa('Venus::Path');
  ok $result->[2] =~ m{t${fsds}data${fsds}planets${fsds}eris};

  ok $result->[3]->isa('Venus::Path');
  ok $result->[3] =~ m{t${fsds}data${fsds}planets${fsds}haumea};

  ok $result->[4]->isa('Venus::Path');
  ok $result->[4] =~ m{t${fsds}data${fsds}planets${fsds}jupiter};

  ok $result->[5]->isa('Venus::Path');
  ok $result->[5] =~ m{t${fsds}data${fsds}planets${fsds}makemake};

  ok $result->[6]->isa('Venus::Path');
  ok $result->[6] =~ m{t${fsds}data${fsds}planets${fsds}mars};

  ok $result->[7]->isa('Venus::Path');
  ok $result->[7] =~ m{t${fsds}data${fsds}planets${fsds}mercury};

  ok $result->[8]->isa('Venus::Path');
  ok $result->[8] =~ m{t${fsds}data${fsds}planets${fsds}neptune};

  ok $result->[9]->isa('Venus::Path');
  ok $result->[9] =~ m{t${fsds}data${fsds}planets${fsds}planet9};

  ok $result->[10]->isa('Venus::Path');
  ok $result->[10] =~ m{t${fsds}data${fsds}planets${fsds}pluto};

  ok $result->[11]->isa('Venus::Path');
  ok $result->[11] =~ m{t${fsds}data${fsds}planets${fsds}saturn};

  ok $result->[12]->isa('Venus::Path');
  ok $result->[12] =~ m{t${fsds}data${fsds}planets${fsds}uranus};

  ok $result->[13]->isa('Venus::Path');
  ok $result->[13] =~ m{t${fsds}data${fsds}planets${fsds}venus};

  $result
});

=method glob

The glob method returns the files and directories under the path matching the
expression provided, which defaults to C<*>. This method can return a list of
values in list-context.

=signature glob

  glob(Str | Regexp $expr) (ArrayRef[Path])

=metadata glob

{
  since => '0.01',
}

=example-1 glob

  # given: synopsis;

  my $glob = $path->glob;

  # [
  #   bless({ value => "t/data/planets/ceres" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/earth" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/eris" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/haumea" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/jupiter" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/makemake" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mars" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/mercury" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/neptune" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/planet9" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/pluto" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/saturn" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/uranus" }, "Venus::Path"),
  #   bless({ value => "t/data/planets/venus" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'glob', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 14;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}planets${fsds}ceres};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}planets${fsds}earth};

  ok $result->[2]->isa('Venus::Path');
  ok $result->[2] =~ m{t${fsds}data${fsds}planets${fsds}eris};

  ok $result->[3]->isa('Venus::Path');
  ok $result->[3] =~ m{t${fsds}data${fsds}planets${fsds}haumea};

  ok $result->[4]->isa('Venus::Path');
  ok $result->[4] =~ m{t${fsds}data${fsds}planets${fsds}jupiter};

  ok $result->[5]->isa('Venus::Path');
  ok $result->[5] =~ m{t${fsds}data${fsds}planets${fsds}makemake};

  ok $result->[6]->isa('Venus::Path');
  ok $result->[6] =~ m{t${fsds}data${fsds}planets${fsds}mars};

  ok $result->[7]->isa('Venus::Path');
  ok $result->[7] =~ m{t${fsds}data${fsds}planets${fsds}mercury};

  ok $result->[8]->isa('Venus::Path');
  ok $result->[8] =~ m{t${fsds}data${fsds}planets${fsds}neptune};

  ok $result->[9]->isa('Venus::Path');
  ok $result->[9] =~ m{t${fsds}data${fsds}planets${fsds}planet9};

  ok $result->[10]->isa('Venus::Path');
  ok $result->[10] =~ m{t${fsds}data${fsds}planets${fsds}pluto};

  ok $result->[11]->isa('Venus::Path');
  ok $result->[11] =~ m{t${fsds}data${fsds}planets${fsds}saturn};

  ok $result->[12]->isa('Venus::Path');
  ok $result->[12] =~ m{t${fsds}data${fsds}planets${fsds}uranus};

  ok $result->[13]->isa('Venus::Path');
  ok $result->[13] =~ m{t${fsds}data${fsds}planets${fsds}venus};

  $result
});

=method is_absolute

The is_absolute method returns truthy or falsy is the path is absolute.

=signature is_absolute

  is_absolute() (Bool)

=metadata is_absolute

{
  since => '0.01',
}

=example-1 is_absolute

  # given: synopsis;

  my $is_absolute = $path->is_absolute;

  # 0

=cut

$test->for('example', 1, 'is_absolute', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method is_directory

The is_directory method returns truthy or falsy is the path is a directory.

=signature is_directory

  is_directory() (Bool)

=metadata is_directory

{
  since => '0.01',
}

=example-1 is_directory

  # given: synopsis;

  my $is_directory = $path->is_directory;

  # 1

=cut

$test->for('example', 1, 'is_directory', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method is_file

The is_file method returns truthy or falsy is the path is a file.

=signature is_file

  is_file() (Bool)

=metadata is_file

{
  since => '0.01',
}

=example-1 is_file

  # given: synopsis;

  my $is_file = $path->is_file;

  # 0

=cut

$test->for('example', 1, 'is_file', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=method is_relative

The is_relative method returns truthy or falsy is the path is relative.

=signature is_relative

  is_relative() (Bool)

=metadata is_relative

{
  since => '0.01',
}

=example-1 is_relative

  # given: synopsis;

  my $is_relative = $path->is_relative;

  # 1

=cut

$test->for('example', 1, 'is_relative', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method lines

The lines method returns the list of lines from the underlying file. By default
the file contents are separated by newline.

=signature lines

  lines(Str|Regexp $separator, Str $binmode) (ArrayRef[Str])

=metadata lines

{
  since => '1.23',
}

=example-1 lines

  # given: synopsis;

  my $lines = $path->child('mercury')->lines;

  # ['mercury']

=cut

$test->for('example', 1, 'lines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ['mercury'];

  $result
});

=example-2 lines

  # given: synopsis;

  my $lines = $path->child('planet9')->lines($^O =~ /win32/i ? "\n" : "\r\n");

  # ['planet', 'nine']

=cut

$test->for('example', 2, 'lines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  is_deeply $result, ['planet', 'nine'];

  $result
});

=method lineage

The lineage method returns the list of parent paths up to the root path. This
method can return a list of values in list-context.

=signature lineage

  lineage() (ArrayRef[Path])

=metadata lineage

{
  since => '0.01',
}

=example-1 lineage

  # given: synopsis;

  my $lineage = $path->lineage;

  # [
  #   bless({ value => "t/data/planets" }, "Venus::Path"),
  #   bless({ value => "t/data" }, "Venus::Path"),
  #   bless({ value => "t" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'lineage', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result;
  ok @$result == 3;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}planets$};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data$};

  ok $result->[2]->isa('Venus::Path');
  ok $result->[2] =~ m{t$};

  $result
});

=method open

The open method creates and returns an open filehandle.

=signature open

  open(Any @data) (FileHandle)

=metadata open

{
  since => '0.01',
}

=example-1 open

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/planets/earth');

  my $fh = $path->open;

  # bless(..., "IO::File");

=cut

$test->for('example', 1, 'open', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('IO::File');

  $result
});

=example-2 open

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/planets/earth');

  my $fh = $path->open('<');

  # bless(..., "IO::File");

=cut

$test->for('example', 2, 'open', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('IO::File');

  $result
});

=example-3 open

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/planets/earth');

  my $fh = $path->open('>');

  # bless(..., "IO::File");

=cut

$test->for('example', 3, 'open', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('IO::File');

  $result
});

=example-4 open

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  my $fh = $path->open('>');

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 4, 'open', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method mkcall

The mkcall method returns the result of executing the path as an executable. In
list context returns the call output and exit code.

=signature mkcall

  mkcall(Any @data) (Any)

=metadata mkcall

{
  since => '0.01',
}

=example-1 mkcall

  package main;

  use Venus::Path;

  my $path = Venus::Path->new($^X);

  my $output = $path->mkcall('--help');

  # Usage: perl ...

=cut

$test->for('example', 1, 'mkcall', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{\w+};

  $result
});

=example-2 mkcall

  package main;

  use Venus::Path;

  my $path = Venus::Path->new($^X);

  my ($call_output, $exit_code) = $path->mkcall('t/data/sun --heat-death');

  # ("", 256)

=cut

$test->for('example', 2, 'mkcall', sub {
  my ($tryable) = @_;
  ok my @result = ($tryable->result);
  is_deeply [@result], ['', 256];

  !$result[0]
});

=example-3 mkcall

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('.help');

  my $output = $path->mkcall;

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 3, 'mkcall', sub {
  plan skip_all => 'skip Path#mkcall on win32' if $^O =~ /win32/i;
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->safe('result');
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method mkdir

The mkdir method makes the path as a directory.

=signature mkdir

  mkdir(Maybe[Str] $mode) (Path)

=metadata mkdir

{
  since => '0.01',
}

=example-1 mkdir

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/systems');

  $path = $path->mkdir;

  # bless({ value => "t/data/systems" }, "Venus::Path")

=cut

rmdir 't/data/systems';
$test->for('example', 1, 'mkdir', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->exists;

  rmdir 't/data/systems';
  $result
});

=example-2 mkdir

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  $path = $path->mkdir;

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'mkdir', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method mkdirs

The mkdirs method creates parent directories and returns the list of created
directories. This method can return a list of values in list-context.

=signature mkdirs

  mkdirs(Maybe[Str] $mode) (ArrayRef[Path])

=metadata mkdirs

{
  since => '0.01',
}

=example-1 mkdirs

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/systems');

  my $mkdirs = $path->mkdirs;

  # [
  #   bless({ value => "t/data/systems" }, "Venus::Path")
  # ]

=cut

rmdir 't/data/systems';
$test->for('example', 1, 'mkdirs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 1;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}systems$};

  rmdir 't/data/systems';
  $result
});

=example-2 mkdirs

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/systems/solar');

  my $mkdirs = $path->mkdirs;

  # [
  #   bless({ value => "t/data/systems" }, "Venus::Path"),
  #   bless({ value => "t/data/systems/solar" }, "Venus::Path"),
  # ]

=cut

rmdir 't/data/systems/solar';
rmdir 't/data/systems';
$test->for('example', 2, 'mkdirs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}systems$};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}systems${fsds}solar$};

  rmdir 't/data/systems/solar';
  rmdir 't/data/systems';
  $result
});

=method mkfile

The mkfile method makes the path as an empty file.

=signature mkfile

  mkfile() (Path)

=metadata mkfile

{
  since => '0.01',
}

=example-1 mkfile

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/moon');

  $path = $path->mkfile;

  # bless({ value => "t/data/moon" }, "Venus::Path")

=cut

$test->for('example', 1, 'mkfile', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->exists;

  $result
});

=example-2 mkfile

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  $path = $path->mkfile;

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'mkfile', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method name

The name method returns the path as an absolute path.

=signature name

  name() (Str)

=metadata name

{
  since => '0.01',
}

=example-1 name

  # given: synopsis;

  my $name = $path->name;

  # /path/to/t/data/planets

=cut

$test->for('example', 1, 'name', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{.+t${fsds}data${fsds}planets$};

  $result
});

=method parent

The parent method returns a path object representing the parent directory.

=signature parent

  parent() (Path)

=metadata parent

{
  since => '0.01',
}

=example-1 parent

  # given: synopsis;

  my $parent = $path->parent;

  # bless({ value => "t/data" }, "Venus::Path")

=cut

$test->for('example', 1, 'parent', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{t${fsds}data$};

  $result
});

=method parents

The parents method returns is a list of parent directories. This method can
return a list of values in list-context.

=signature parents

  parents() (ArrayRef[Path])

=metadata parents

{
  since => '0.01',
}

=example-1 parents

  # given: synopsis;

  my $parents = $path->parents;

  # [
  #   bless({ value => "t/data" }, "Venus::Path"),
  #   bless({ value => "t" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'parents', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data$};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t$};

  $result
});

=method parts

The parts method returns an arrayref of path parts.

=signature parts

  parts() (ArrayRef[Str])

=metadata parts

{
  since => '0.01',
}

=example-1 parts

  # given: synopsis;

  my $parts = $path->parts;

  # ["t", "data", "planets"]

=cut

$test->for('example', 1, 'parts', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["t", "data", "planets"];

  $result
});

=method read

The read method reads the file and returns its contents.

=signature read

  read(Str $binmode) (Str)

=metadata read

{
  since => '0.01',
}

=example-1 read

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/planets/mars');

  my $content = $path->read;

=cut

$test->for('example', 1, 'read', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result =~ m{mars};

  $result
});

=example-2 read

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  my $content = $path->read;

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'read', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method relative

The relative method returns a path object representing a relative path
(relative to the path provided).

=signature relative

  relative(Str $root) (Path)

=metadata relative

{
  since => '0.01',
}

=example-1 relative

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/t/data/planets/mars');

  my $relative = $path->relative('/path');

  # bless({ value => "to/t/data/planets/mars" }, "Venus::Path")

=cut

$test->for('example', 1, 'relative', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{to${fsds}t${fsds}data${fsds}planets${fsds}mars$};

  $result
});

=example-2 relative

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/t/data/planets/mars');

  my $relative = $path->relative('/path/to/t');

  # bless({ value => "data/planets/mars" }, "Venus::Path")

=cut

$test->for('example', 2, 'relative', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{data${fsds}planets${fsds}mars$};

  $result
});

=method rmdir

The rmdir method removes the directory and returns a path object representing
the deleted directory.

=signature rmdir

  rmdir() (Path)

=metadata rmdir

{
  since => '0.01',
}

=example-1 rmdir

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/stars');

  my $rmdir = $path->mkdir->rmdir;

  # bless({ value => "t/data/stars" }, "Venus::Path")

=cut

$test->for('example', 1, 'rmdir', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');

  $result
});

=example-2 rmdir

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  my $rmdir = $path->mkdir->rmdir;

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'rmdir', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method rmdirs

The rmdirs method removes that path and its child files and directories and
returns all paths removed. This method can return a list of values in
list-context.

=signature rmdirs

  rmdirs() (ArrayRef[Path])

=metadata rmdirs

{
  since => '0.01',
}

=example-1 rmdirs

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/stars');

  $path->child('dwarfs')->mkdirs;

  my $rmdirs = $path->rmdirs;

  # [
  #   bless({ value => "t/data/stars/dwarfs" }, "Venus::Path"),
  #   bless({ value => "t/data/stars" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'rmdirs', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}stars${fsds}dwarfs$};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}stars$};

  $result
});

=method rmfiles

The rmfiles method recursively removes files under the path and returns the
paths removed. This method does not remove the directories found. This method
can return a list of values in list-context.

=signature rmfiles

  rmfiles() (ArrayRef[Path])

=metadata rmfiles

{
  since => '0.01',
}

=example-1 rmfiles

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/stars')->mkdir;

  $path->child('sirius')->mkfile;
  $path->child('canopus')->mkfile;
  $path->child('arcturus')->mkfile;
  $path->child('vega')->mkfile;
  $path->child('capella')->mkfile;

  my $rmfiles = $path->rmfiles;

  # [
  #   bless({ value => "t/data/stars/arcturus" }, "Venus::Path"),
  #   bless({ value => "t/data/stars/canopus" }, "Venus::Path"),
  #   bless({ value => "t/data/stars/capella" }, "Venus::Path"),
  #   bless({ value => "t/data/stars/sirius" }, "Venus::Path"),
  #   bless({ value => "t/data/stars/vega" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'rmfiles', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 5;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}stars${fsds}arcturus$};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}stars${fsds}canopus$};

  ok $result->[2]->isa('Venus::Path');
  ok $result->[2] =~ m{t${fsds}data${fsds}stars${fsds}capella$};

  ok $result->[3]->isa('Venus::Path');
  ok $result->[3] =~ m{t${fsds}data${fsds}stars${fsds}sirius$};

  ok $result->[4]->isa('Venus::Path');
  ok $result->[4] =~ m{t${fsds}data${fsds}stars${fsds}vega$};

  rmdir 't/data/stars';
  $result
});

=method root

The root method performs a search up the file system heirarchy returns the
first path (i.e. absolute path) matching the file test specification and base
path expression provided. The file test specification is the same passed to
L</test>. If no path matches are found this method returns underfined.

=signature root

  root(Str $spec, Str $base) (Maybe[Path])

=metadata root

{
  since => '2.32',
}

=example-1 root

  # given: synopsis;

  my $root = $path->root('d', 't');

  # bless({ value => "/path/to/t/../" }, "Venus::Path")

=cut

$test->for('example', 1, 'root', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->child('t')->test('d');

  $result
});

=example-2 root

  # given: synopsis;

  my $root = $path->root('f', 't');

  # undef

=cut

$test->for('example', 2, 'root', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method seek

The seek method performs a search down the file system heirarchy returns the
first path (i.e. absolute path) matching the file test specification and base
path expression provided. The file test specification is the same passed to
L</test>. If no path matches are found this method returns underfined.

=signature seek

  seek(Str $spec, Str $base) (Maybe[Path])

=metadata seek

{
  since => '2.32',
}

=example-1 seek

  # given: synopsis;

  $path = Venus::Path->new('t');

  my $seek = $path->seek('f', 'earth');

  # bless({ value => "/path/to/t/data/planets/earth" }, "Venus::Path")

=cut

$test->for('example', 1, 'seek', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{t${fsds}data${fsds}planets${fsds}earth};

  $result
});

=example-2 seek

  # given: synopsis;

  $path = Venus::Path->new('t');

  my $seek = $path->seek('f', 'europa');

  # undef

=cut

$test->for('example', 2, 'seek', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok !defined $result;

  !$result
});

=method sibling

The sibling method returns a path object representing the sibling path provided.

=signature sibling

  sibling(Str $path) (Path)

=metadata sibling

{
  since => '0.01',
}

=example-1 sibling

  # given: synopsis;

  my $sibling = $path->sibling('galaxies');

  # bless({ value => "t/data/galaxies" }, "Venus::Path")

=cut

$test->for('example', 1, 'sibling', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{t${fsds}data${fsds}galaxies$};

  $result
});

=method siblings

The siblings method returns all sibling files and directories for the current
path. This method can return a list of values in list-context.

=signature siblings

  siblings() (ArrayRef[Path])

=metadata siblings

{
  since => '0.01',
}

=example-1 siblings

  # given: synopsis;

  my $siblings = $path->siblings;

  # [
  #   bless({ value => "t/data/moon" }, "Venus::Path"),
  #   bless({ value => "t/data/sun" }, "Venus::Path"),
  # ]

=cut

$test->for('example', 1, 'siblings', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  ok $result->[0]->isa('Venus::Path');
  ok $result->[0] =~ m{t${fsds}data${fsds}moon$};

  ok $result->[1]->isa('Venus::Path');
  ok $result->[1] =~ m{t${fsds}data${fsds}sections$};

  ok $result->[2]->isa('Venus::Path');
  ok $result->[2] =~ m{t${fsds}data${fsds}sun$};

  $result
});

=method test

The test method evaluates the current path against the stackable file test
operators provided.

=signature test

  test(Str $expr) (Bool)

=metadata test

{
  since => '0.01',
}

=example-1 test

  # given: synopsis;

  my $test = $path->test;

  # -e $path

  # 1

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 test

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/sun');

  my $test = $path->test('efs');

  # -e -f -s $path

  # 1

=cut

$test->for('example', 2, 'test', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method unlink

The unlink method removes the file and returns a path object representing the
removed file.

=signature unlink

  unlink() (Path)

=metadata unlink

{
  since => '0.01',
}

=example-1 unlink

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/asteroid')->mkfile;

  my $unlink = $path->unlink;

  # bless({ value => "t/data/asteroid" }, "Venus::Path")

=cut

$test->for('example', 1, 'unlink', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{t${fsds}data${fsds}asteroid$};

  $result
});

=example-2 unlink

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  my $unlink = $path->unlink;

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'unlink', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=method write

The write method write the data provided to the file.

=signature write

  write(Str $data, Str $binmode) (Path)

=metadata write

{
  since => '0.01',
}

=example-1 write

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('t/data/asteroid');

  my $write = $path->write('asteroid');

=cut

$test->for('example', 1, 'write', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result =~ m{t${fsds}data${fsds}asteroid$};
  ok $result->read =~ m{asteroid};

  unlink $result;
  $result
});

=example-2 write

  package main;

  use Venus::Path;

  my $path = Venus::Path->new('/path/to/xyz');

  my $write = $path->write('nothing');

  # Exception! Venus::Path::Error (isa Venus::Error)

=cut

$test->for('example', 2, 'write', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->error(\my $error)->result;
  ok $error->isa('Venus::Path::Error');
  ok $error->isa('Venus::Error');

  $result
});

=operator (.)

This package overloads the C<.> operator.

=cut

$test->for('operator', '(.)');

=example-1 (.)

  # given: synopsis;

  my $result = $path . '/earth';

  # "t/data/planets/earth"

=cut

$test->for('example', 1, '(.)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "t/data/planets/earth";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $path eq 't/data/planets';

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

  my $result = $path ne 't/data/planets/';

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

  my $result = 't/data/planets' =~ $path;

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

  my $result = "$path";

  # "t/data/planets"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 't/data/planets';

  $result
});

=example-2 ("")

  # given: synopsis;

  my $mercury = $path->child('mercury');

  my $result = "$path, $path";

  # "t/data/planets, t/data/planets"

=cut

$test->for('example', 2, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 't/data/planets, t/data/planets';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $path ~~ 't/data/planets';

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

$test->render('lib/Venus/Path.pod') if $ENV{RENDER};

ok 1 and done_testing;