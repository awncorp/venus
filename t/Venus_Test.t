package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;
use Venus;

my $test = test(__FILE__);

=name

Venus::Test

=cut

$test->for('name');

=tagline

Test Class

=cut

$test->for('tagline');

=abstract

Test Class for Perl 5

=cut

$test->for('abstract');

=includes

function: test

method: collect
method: collect_data_for_abstract
method: collect_data_for_attribute
method: collect_data_for_authors
method: collect_data_for_description
method: collect_data_for_encoding
method: collect_data_for_error
method: collect_data_for_example
method: collect_data_for_feature
method: collect_data_for_function
method: collect_data_for_includes
method: collect_data_for_inherits
method: collect_data_for_integrates
method: collect_data_for_layout
method: collect_data_for_libraries
method: collect_data_for_license
method: collect_data_for_message
method: collect_data_for_metadata
method: collect_data_for_method
method: collect_data_for_name
method: collect_data_for_operator
method: collect_data_for_partials
method: collect_data_for_project
method: collect_data_for_signature
method: collect_data_for_synopsis
method: collect_data_for_tagline
method: collect_data_for_version
method: data
method: done
method: execute
method: execute_test_for_abstract
method: execute_test_for_attribute
method: execute_test_for_authors
method: execute_test_for_description
method: execute_test_for_encoding
method: execute_test_for_error
method: execute_test_for_example
method: execute_test_for_feature
method: execute_test_for_function
method: execute_test_for_includes
method: execute_test_for_inherits
method: execute_test_for_integrates
method: execute_test_for_layout
method: execute_test_for_libraries
method: execute_test_for_license
method: execute_test_for_message
method: execute_test_for_metadata
method: execute_test_for_method
method: execute_test_for_name
method: execute_test_for_operator
method: explain
method: fail
method: for
method: like
method: more
method: okay
method: okay_can
method: okay_isa
method: pass
method: perform
method: perform_test_for_abstract
method: perform_test_for_attribute
method: perform_test_for_authors
method: perform_test_for_description
method: perform_test_for_encoding
method: perform_test_for_error
method: perform_test_for_example
method: perform_test_for_feature
method: perform_test_for_function
method: perform_test_for_includes
method: perform_test_for_inherits
method: perform_test_for_integrates
method: perform_test_for_layout
method: perform_test_for_libraries
method: perform_test_for_license
method: perform_test_for_message
method: perform_test_for_metadata
method: perform_test_for_method
method: perform_test_for_name
method: perform_test_for_operator
method: perform_test_for_partials
method: perform_test_for_project
method: perform_test_for_signature
method: perform_test_for_synopsis
method: perform_test_for_tagline
method: perform_test_for_version
method: present
method: present_data_for_abstract
method: present_data_for_attribute
method: present_data_for_authors
method: present_data_for_description
method: present_data_for_encoding
method: present_data_for_error
method: present_data_for_example
method: present_data_for_feature
method: present_data_for_function
method: present_data_for_includes
method: present_data_for_inherits
method: present_data_for_integrates
method: present_data_for_layout
method: present_data_for_libraries
method: present_data_for_license
method: present_data_for_message
method: present_data_for_metadata
method: present_data_for_method
method: present_data_for_name
method: present_data_for_operator
method: render
method: same
method: skip

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Test;

  my $test = Venus::Test->new('t/Venus_Test.t');

  # $test->for('name');

  # $test->for('tagline');

  # $test->for('abstract');

  # $test->for('synopsis');

  # $test->done;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->okay($result->isa('Venus::Test'));

  $result
});

=description

This package aims to provide a standard for documenting L<Venus> derived
software projects, a framework writing tests, test automation, and
documentation generation.

=cut

$test->for('description');

=inherits

Venus::Kind

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable

=cut

$test->for('integrates');

=attribute file

The file attribute is read-write, accepts C<(string)> values, and is required.

=signature file

  file(string $data) (string)

=metadata file

{
  since => '3.55',
}

=cut

=example-1 file

  # given: synopsis

  package main;

  my $set_file = $test->file("t/Venus_Test.t");

  # "t/Venus_Test.t"

=cut

$test->for('example', 1, 'file', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, "t/Venus_Test.t";

  $result
});

=example-2 file

  # given: synopsis

  # given: example-1 file

  package main;

  my $get_file = $test->file;

  # "t/Venus_Test.t"

=cut

$test->for('example', 2, 'file', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, "t/Venus_Test.t";

  $result
});

=function test

The test function is exported automatically and returns a L<Venus::Test> object
for the test file given.

=signature test

  test(string $file) (Venus::Test)

=metadata test

{
  since => '0.09',
}

=example-1 test

  package main;

  use Venus::Test;

  my $test = test 't/Venus_Test.t';

  # bless(..., "Venus::Test")

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->okay_isa($result, 'Venus::Test');

  $result
});

=method collect

The collect method dispatches to the C<collect_data_for_${name}> method
indictated by the first argument and returns the result. Returns an arrayref in
scalar context, and a list in list context.

=signature collect

  collect(string $name, any @args) (any)

=metadata collect

{
  since => '3.55',
}

=cut

=example-1 collect

  # given: synopsis

  package main;

  my ($collect) = $test->collect('name');

  # "Venus::Test"

=cut

$test->for('example', 1, 'collect', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, "Venus::Test";

  $result
});

=example-2 collect

  # given: synopsis

  package main;

  my $collect = $test->collect('name');

  # ["Venus::Test"]

=cut

$test->for('example', 2, 'collect', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Venus::Test"];

  $result
});

=method collect_data_for_abstract

The collect_data_for_abstract method uses L</data> to fetch data for the C<abstract>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_abstract

  collect_data_for_abstract() (arrayref)

=metadata collect_data_for_abstract

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_abstract

  # =abstract
  #
  # Example Test Documentation
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_abstract = $test->collect_data_for_abstract;

  # ["Example Test Documentation"]

=cut

$test->for('example', 1, 'collect_data_for_abstract', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Example Test Documentation"];

  $result
});

=example-2 collect_data_for_abstract

  # =abstract
  #
  # Example Test Documentation
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_abstract) = $test->collect_data_for_abstract;

  # "Example Test Documentation"

=cut

$test->for('example', 2, 'collect_data_for_abstract', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Example Test Documentation";

  $result
});

=method collect_data_for_attribute

The collect_data_for_attribute method uses L</data> to fetch data for the
C<attribute $name> section and returns the data. Returns an arrayref in scalar
context, and a list in list context.

=signature collect_data_for_attribute

  collect_data_for_attribute(string $name) (arrayref)

=metadata collect_data_for_attribute

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_attribute

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_attribute = $test->collect_data_for_attribute('name');

  # ["The name attribute is read-write, optional, and holds a string."]

=cut

$test->for('example', 1, 'collect_data_for_attribute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["The name attribute is read-write, optional, and holds a string."];

  $result
});

=example-2 collect_data_for_attribute

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_attribute) = $test->collect_data_for_attribute('name');

  # "The name attribute is read-write, optional, and holds a string."

=cut

$test->for('example', 2, 'collect_data_for_attribute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "The name attribute is read-write, optional, and holds a string.";

  $result
});

=method collect_data_for_authors

The collect_data_for_authors method uses L</data> to fetch data for the
C<authors> section and returns the data. Returns an arrayref in scalar context,
and a list in list context.

=signature collect_data_for_authors

  collect_data_for_authors() (arrayref)

=metadata collect_data_for_authors

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_authors

  # =authors
  #
  # Awncorp, C<awncorp@cpan.org>
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_authors = $test->collect_data_for_authors;

  # ["Awncorp, C<awncorp@cpan.org>"]

=cut

$test->for('example', 1, 'collect_data_for_authors', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Awncorp, C<awncorp\@cpan.org>"];

  $result
});

=example-2 collect_data_for_authors

  # =authors
  #
  # Awncorp, C<awncorp@cpan.org>
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_authors) = $test->collect_data_for_authors;

  # "Awncorp, C<awncorp@cpan.org>"

=cut

$test->for('example', 2, 'collect_data_for_authors', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Awncorp, C<awncorp\@cpan.org>";

  $result
});

=method collect_data_for_description

The collect_data_for_description method uses L</data> to fetch data for the C<description>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_description

  collect_data_for_description() (arrayref)

=metadata collect_data_for_description

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_description

  # =description
  #
  # This package provides an example class.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_description = $test->collect_data_for_description;

  # ["This package provides an example class."]

=cut

$test->for('example', 1, 'collect_data_for_description', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["This package provides an example class."];

  $result
});

=example-2 collect_data_for_description

  # =description
  #
  # This package provides an example class.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_description) = $test->collect_data_for_description;

  # "This package provides an example class."

=cut

$test->for('example', 2, 'collect_data_for_description', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "This package provides an example class.";

  $result
});

=method collect_data_for_encoding

The collect_data_for_encoding method uses L</data> to fetch data for the C<encoding>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_encoding

  collect_data_for_encoding() (arrayref)

=metadata collect_data_for_encoding

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_encoding

  # =encoding
  #
  # utf8
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_encoding = $test->collect_data_for_encoding;

  # ["UTF8"]

=cut

$test->for('example', 1, 'collect_data_for_encoding', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["UTF8"];

  $result
});

=example-2 collect_data_for_encoding

  # =encoding
  #
  # utf8
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_encoding) = $test->collect_data_for_encoding;

  # "UTF8"

=cut

$test->for('example', 2, 'collect_data_for_encoding', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "UTF8";

  $result
});

=method collect_data_for_error

The collect_data_for_error method uses L</data> to fetch data for the C<error
$name> section and returns the data. Returns an arrayref in scalar context, and
a list in list context.

=signature collect_data_for_error

  collect_data_for_error(string $name) (arrayref)

=metadata collect_data_for_error

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_error

  # =error error_on_unknown
  #
  # This package may raise an error_on_unknown error.
  #
  # =cut
  #
  # =example-1 error_on_unknown
  #
  #   # given: synopsis
  #
  #   my $error = $example->catch('error', {
  #     with => 'error_on_unknown',
  #   });
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_error = $test->collect_data_for_error('error_on_unknown');

  # ["This package may raise an error_on_unknown error."]

=cut

$test->for('example', 1, 'collect_data_for_error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["This package may raise an error_on_unknown error."];

  $result
});

=example-2 collect_data_for_error

  # =error error_on_unknown
  #
  # This package may raise an error_on_unknown error.
  #
  # =cut
  #
  # =example-1 error_on_unknown
  #
  #   # given: synopsis
  #
  #   my $error = $example->catch('error', {
  #     with => 'error_on_unknown',
  #   });
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_error) = $test->collect_data_for_error('error_on_unknown');

  # "This package may raise an error_on_unknown error."

=cut

$test->for('example', 2, 'collect_data_for_error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "This package may raise an error_on_unknown error.";

  $result
});

=method collect_data_for_example

The collect_data_for_example method uses L</data> to fetch data for the
C<example-$number $name> section and returns the data. Returns an arrayref in
scalar context, and a list in list context.

=signature collect_data_for_example

  collect_data_for_example(number $numberm string $name) (arrayref)

=metadata collect_data_for_example

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_example

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_example = $test->collect_data_for_example(1, 'name');

  # ['  # given: synopsis', '  my $name = $example->name;', '  # "..."']

=cut

$test->for('example', 1, 'collect_data_for_example', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ['  # given: synopsis', '  my $name = $example->name;', '  # "..."'];

  $result
});

=example-2 collect_data_for_example

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my @collect_data_for_example = $test->collect_data_for_example(1, 'name');

  # ('  # given: synopsis', '  my $name = $example->name;', '  # "..."')

=cut

$test->for('example', 2, 'collect_data_for_example', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, ['  # given: synopsis', '  my $name = $example->name;', '  # "..."'];

  @result
});

=method collect_data_for_feature

The collect_data_for_feature method uses L</data> to fetch data for the
C<feature $name> section and returns the data. Returns an arrayref in scalar
context, and a list in list context.

=signature collect_data_for_feature

  collect_data_for_feature(string $name) (arrayref)

=metadata collect_data_for_feature

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_feature

  # =feature noop
  #
  # This package is no particularly useful features.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_feature = $test->collect_data_for_feature('noop');

  # ["This package is no particularly useful features."]

=cut

$test->for('example', 1, 'collect_data_for_feature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["This package is no particularly useful features."];

  $result
});

=example-2 collect_data_for_feature

  # =feature noop
  #
  # This package is no particularly useful features.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_feature) = $test->collect_data_for_feature('noop');

  # "This package is no particularly useful features."

=cut

$test->for('example', 2, 'collect_data_for_feature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "This package is no particularly useful features.";

  $result
});

=method collect_data_for_function

The collect_data_for_function method uses L</data> to fetch data for the
C<function $name> section and returns the data. Returns an arrayref in scalar
context, and a list in list context.

=signature collect_data_for_function

  collect_data_for_function(string $name) (arrayref)

=metadata collect_data_for_function

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_function

  # =function eg
  #
  # The eg function returns a new instance of Example.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $example = eg();
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_function = $test->collect_data_for_function('eg');

  # ["The eg function returns a new instance of Example."]

=cut

$test->for('example', 1, 'collect_data_for_function', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["The eg function returns a new instance of Example."];

  $result
});

=example-2 collect_data_for_function

  # =function eg
  #
  # The eg function returns a new instance of Example.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $example = eg();
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_function) = $test->collect_data_for_function('eg');

  # "The eg function returns a new instance of Example."

=cut

$test->for('example', 2, 'collect_data_for_function', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "The eg function returns a new instance of Example.";

  $result
});

=method collect_data_for_includes

The collect_data_for_includes method uses L</data> to fetch data for the
C<includes> section and returns the data. Returns an arrayref in scalar
context, and a list in list context.

=signature collect_data_for_includes

  collect_data_for_includes() (arrayref)

=metadata collect_data_for_includes

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_includes

  # =includes
  #
  # function: eg
  #
  # method: prepare
  # method: execute
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_includes = $test->collect_data_for_includes;

  # ["function: eg", "method: prepare", "method: execute"]

=cut

$test->for('example', 1, 'collect_data_for_includes', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["function: eg", "method: prepare", "method: execute"];

  $result
});

=example-2 collect_data_for_includes

  # =includes
  #
  # function: eg
  #
  # method: prepare
  # method: execute
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my @collect_data_for_includes = $test->collect_data_for_includes;

  # ("function: eg", "method: prepare", "method: execute")

=cut

$test->for('example', 2, 'collect_data_for_includes', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, ["function: eg", "method: prepare", "method: execute"];

  @result
});

=method collect_data_for_inherits

The collect_data_for_inherits method uses L</data> to fetch data for the C<inherits>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_inherits

  collect_data_for_inherits() (arrayref)

=metadata collect_data_for_inherits

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_inherits

  # =inherits
  #
  # Venus::Core::Class
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_inherits = $test->collect_data_for_inherits;

  # ["Venus::Core::Class"]

=cut

$test->for('example', 1, 'collect_data_for_inherits', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Venus::Core::Class"];

  $result
});

=example-2 collect_data_for_inherits

  # =inherits
  #
  # Venus::Core::Class
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_inherits) = $test->collect_data_for_inherits;

  # "Venus::Core::Class"

=cut

$test->for('example', 2, 'collect_data_for_inherits', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Venus::Core::Class";

  $result
});

=method collect_data_for_integrates

The collect_data_for_integrates method uses L</data> to fetch data for the C<integrates>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_integrates

  collect_data_for_integrates() (arrayref)

=metadata collect_data_for_integrates

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_integrates

  # =integrates
  #
  # Venus::Role::Catchable
  # Venus::Role::Throwable
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_integrates = $test->collect_data_for_integrates;

  # ["Venus::Role::Catchable\nVenus::Role::Throwable"]

=cut

$test->for('example', 1, 'collect_data_for_integrates', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Venus::Role::Catchable\nVenus::Role::Throwable"];

  $result
});

=example-2 collect_data_for_integrates

  # =integrates
  #
  # Venus::Role::Catchable
  # Venus::Role::Throwable
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_integrates) = $test->collect_data_for_integrates;

  # "Venus::Role::Catchable\nVenus::Role::Throwable"

=cut

$test->for('example', 2, 'collect_data_for_integrates', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Venus::Role::Catchable\nVenus::Role::Throwable";

  $result
});

=method collect_data_for_layout

The collect_data_for_layout method uses L</data> to fetch data for the C<layout>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_layout

  collect_data_for_layout() (arrayref)

=metadata collect_data_for_layout

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_layout

  # =layout
  #
  # encoding
  # name
  # synopsis
  # description
  # attributes: attribute
  # authors
  # license
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_layout = $test->collect_data_for_layout;

  # ["encoding\nname\nsynopsis\ndescription\nattributes: attribute\nauthors\nlicense"]

=cut

$test->for('example', 1, 'collect_data_for_layout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["encoding\nname\nsynopsis\ndescription\nattributes: attribute\nauthors\nlicense"];

  $result
});

=example-2 collect_data_for_layout

  # =layout
  #
  # encoding
  # name
  # synopsis
  # description
  # attributes: attribute
  # authors
  # license
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_layout) = $test->collect_data_for_layout;

  # "encoding\nname\nsynopsis\ndescription\nattributes: attribute\nauthors\nlicense"

=cut

$test->for('example', 2, 'collect_data_for_layout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "encoding\nname\nsynopsis\ndescription\nattributes: attribute\nauthors\nlicense";

  $result
});

=method collect_data_for_libraries

The collect_data_for_libraries method uses L</data> to fetch data for the C<libraries>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_libraries

  collect_data_for_libraries() (arrayref)

=metadata collect_data_for_libraries

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_libraries

  # =libraries
  #
  # Venus::Check
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_libraries = $test->collect_data_for_libraries;

  # ["Venus::Check"]

=cut

$test->for('example', 1, 'collect_data_for_libraries', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Venus::Check"];

  $result
});

=example-2 collect_data_for_libraries

  # =libraries
  #
  # Venus::Check
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_libraries) = $test->collect_data_for_libraries;

  # "Venus::Check"

=cut

$test->for('example', 2, 'collect_data_for_libraries', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Venus::Check";

  $result
});

=method collect_data_for_license

The collect_data_for_license method uses L</data> to fetch data for the C<license>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_license

  collect_data_for_license() (arrayref)

=metadata collect_data_for_license

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_license

  # =license
  #
  # No license granted.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_license = $test->collect_data_for_license;

  # ["No license granted."]

=cut

$test->for('example', 1, 'collect_data_for_license', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["No license granted."];

  $result
});

=example-2 collect_data_for_license

  # =license
  #
  # No license granted.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_license) = $test->collect_data_for_license;

  # "No license granted."

=cut

$test->for('example', 2, 'collect_data_for_license', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "No license granted.";

  $result
});

=method collect_data_for_message

The collect_data_for_message method uses L</data> to fetch data for the
C<message $name> section and returns the data. Returns an arrayref in scalar
context, and a list in list context.

=signature collect_data_for_message

  collect_data_for_message(string $name) (arrayref)

=metadata collect_data_for_message

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_message

  # =message accept
  #
  # The accept message represents acceptance.
  #
  # =cut
  #
  # =example-1 accept
  #
  #   # given: synopsis
  #
  #   my $accept = $example->accept;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_message = $test->collect_data_for_message('accept');

  # ["The accept message represents acceptance."]

=cut

$test->for('example', 1, 'collect_data_for_message', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["The accept message represents acceptance."];

  $result
});

=example-2 collect_data_for_message

  # =message accept
  #
  # The accept message represents acceptance.
  #
  # =cut
  #
  # =example-1 accept
  #
  #   # given: synopsis
  #
  #   my $accept = $example->accept;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_message) = $test->collect_data_for_message('accept');

  # "The accept message represents acceptance."

=cut

$test->for('example', 2, 'collect_data_for_message', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "The accept message represents acceptance.";

  $result
});

=method collect_data_for_metadata

The collect_data_for_metadata method uses L</data> to fetch data for the C<metadata $name>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_metadata

  collect_data_for_metadata(string $name) (arrayref)

=metadata collect_data_for_metadata

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_metadata

  # =method prepare
  #
  # The prepare method prepares for execution.
  #
  # =cut
  #
  # =metadata prepare
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 prepare
  #
  #   # given: synopsis
  #
  #   my $prepare = $example->prepare;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_metadata = $test->collect_data_for_metadata('prepare');

  # ["{since => 1.2.3}"]

=cut

$test->for('example', 1, 'collect_data_for_metadata', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ['{since => "1.2.3"}'];

  $result
});

=example-2 collect_data_for_metadata

  # =method prepare
  #
  # The prepare method prepares for execution.
  #
  # =cut
  #
  # =metadata prepare
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 prepare
  #
  #   # given: synopsis
  #
  #   my $prepare = $example->prepare;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_metadata) = $test->collect_data_for_metadata('prepare');

  # "{since => 1.2.3}"

=cut

$test->for('example', 2, 'collect_data_for_metadata', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, '{since => "1.2.3"}';

  $result
});

=method collect_data_for_method

The collect_data_for_method method uses L</data> to fetch data for the C<method $name>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_method

  collect_data_for_method(string $name) (arrayref)

=metadata collect_data_for_method

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_method

  # =method execute
  #
  # The execute method executes the logic.
  #
  # =cut
  #
  # =metadata execute
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 execute
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_method = $test->collect_data_for_method('execute');

  # ["The execute method executes the logic."]

=cut

$test->for('example', 1, 'collect_data_for_method', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["The execute method executes the logic."];

  $result
});

=example-2 collect_data_for_method

  # =method execute
  #
  # The execute method executes the logic.
  #
  # =cut
  #
  # =metadata execute
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 execute
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_method) = $test->collect_data_for_method('execute');

  # "The execute method executes the logic."

=cut

$test->for('example', 2, 'collect_data_for_method', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "The execute method executes the logic.";

  $result
});

=method collect_data_for_name

The collect_data_for_name method uses L</data> to fetch data for the C<name>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_name

  collect_data_for_name() (arrayref)

=metadata collect_data_for_name

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_name

  # =name

  # Example

  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_name = $test->collect_data_for_name;

  # ["Example"]

=cut

$test->for('example', 1, 'collect_data_for_name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Example"];

  $result
});

=example-2 collect_data_for_name

  # =name

  # Example

  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_name) = $test->collect_data_for_name;

  # "Example"

=cut

$test->for('example', 2, 'collect_data_for_name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Example";

  $result
});

=method collect_data_for_operator

The collect_data_for_operator method uses L</data> to fetch data for the C<operator $name>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_operator

  collect_data_for_operator(string $name) (arrayref)

=metadata collect_data_for_operator

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_operator

  # =operator ("")
  #
  # This package overloads the C<""> operator.
  #
  # =cut
  #
  # =example-1 ("")
  #
  #   # given: synopsis
  #
  #   my $string = "$example";
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_operator = $test->collect_data_for_operator('("")');

  # ['This package overloads the C<""> operator.']

=cut

$test->for('example', 1, 'collect_data_for_operator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ['This package overloads the C<""> operator.'];

  $result
});

=example-2 collect_data_for_operator

  # =operator ("")
  #
  # This package overloads the C<""> operator.
  #
  # =cut
  #
  # =example-1 ("")
  #
  #   # given: synopsis
  #
  #   my $string = "$example";
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_operator) = $test->collect_data_for_operator('("")');

  # 'This package overloads the C<""> operator.'

=cut

$test->for('example', 2, 'collect_data_for_operator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, 'This package overloads the C<""> operator.';

  $result
});

=method collect_data_for_partials

The collect_data_for_partials method uses L</data> to fetch data for the C<partials>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_partials

  collect_data_for_partials() (arrayref)

=metadata collect_data_for_partials

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_partials

  # =partials
  #
  # t/path/to/other.t: present: authors
  # t/path/to/other.t: present: license
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_partials = $test->collect_data_for_partials;

  # ["t/path/to/other.t: present: authors\nt/path/to/other.t: present: license"]

=cut

$test->for('example', 1, 'collect_data_for_partials', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["t/path/to/other.t: present: authors\nt/path/to/other.t: present: license"];

  $result
});

=example-2 collect_data_for_partials

  # =partials
  #
  # t/path/to/other.t: present: authors
  # t/path/to/other.t: present: license
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_partials) = $test->collect_data_for_partials;

  # "t/path/to/other.t: present: authors\nt/path/to/other.t: present: license"

=cut

$test->for('example', 2, 'collect_data_for_partials', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "t/path/to/other.t: present: authors\nt/path/to/other.t: present: license";

  $result
});

=method collect_data_for_project

The collect_data_for_project method uses L</data> to fetch data for the C<project>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_project

  collect_data_for_project() (arrayref)

=metadata collect_data_for_project

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_project

  # =project
  #
  # https://github.com/awncorp/example
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_project = $test->collect_data_for_project;

  # ["https://github.com/awncorp/example"]

=cut

$test->for('example', 1, 'collect_data_for_project', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["https://github.com/awncorp/example"];

  $result
});

=example-2 collect_data_for_project

  # =project
  #
  # https://github.com/awncorp/example
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_project) = $test->collect_data_for_project;

  # "https://github.com/awncorp/example"

=cut

$test->for('example', 2, 'collect_data_for_project', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "https://github.com/awncorp/example";

  $result
});

=method collect_data_for_signature

The collect_data_for_signature method uses L</data> to fetch data for the C<signature $name>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_signature

  collect_data_for_signature(string $name) (arrayref)

=metadata collect_data_for_signature

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_signature

  # =method execute
  #
  # The execute method executes the logic.
  #
  # =cut
  #
  # =signature execute
  #
  #   execute() (boolean)
  #
  # =cut
  #
  # =metadata execute
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 execute
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_signature = $test->collect_data_for_signature('execute');

  # ["  execute() (boolean)"]

=cut

$test->for('example', 1, 'collect_data_for_signature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["  execute() (boolean)"];

  $result
});

=example-2 collect_data_for_signature

  # =method execute
  #
  # The execute method executes the logic.
  #
  # =cut
  #
  # =signature execute
  #
  #   execute() (boolean)
  #
  # =cut
  #
  # =metadata execute
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 execute
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_signature) = $test->collect_data_for_signature('execute');

  # "  execute() (boolean)"

=cut

$test->for('example', 2, 'collect_data_for_signature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "  execute() (boolean)";

  $result
});

=method collect_data_for_synopsis

The collect_data_for_synopsis method uses L</data> to fetch data for the C<synopsis>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_synopsis

  collect_data_for_synopsis() (arrayref)

=metadata collect_data_for_synopsis

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_synopsis

  # =synopsis
  #
  #   use Example;
  #
  #   my $example = Example->new;
  #
  #   # bless(..., "Example")
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_synopsis = $test->collect_data_for_synopsis;

  # ['  use Example;', '  my $example = Example->new;', '  # bless(..., "Example")']

=cut

$test->for('example', 1, 'collect_data_for_synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ['  use Example;', '  my $example = Example->new;',  '  # bless(..., "Example")'];

  $result
});

=example-2 collect_data_for_synopsis

  # =synopsis
  #
  #   use Example;
  #
  #   my $example = Example->new;
  #
  #   # bless(..., "Example")
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my @collect_data_for_synopsis = $test->collect_data_for_synopsis;

  # ('  use Example;', '  my $example = Example->new;', '  # bless(..., "Example")')

=cut

$test->for('example', 2, 'collect_data_for_synopsis', sub {
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply \@result, ['  use Example;', '  my $example = Example->new;', '  # bless(..., "Example")'];

  @result
});

=method collect_data_for_tagline

The collect_data_for_tagline method uses L</data> to fetch data for the C<tagline>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_tagline

  collect_data_for_tagline() (arrayref)

=metadata collect_data_for_tagline

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_tagline

  # =tagline
  #
  # Example Class
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_tagline = $test->collect_data_for_tagline;

  # ["Example Class"]

=cut

$test->for('example', 1, 'collect_data_for_tagline', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["Example Class"];

  $result
});

=example-2 collect_data_for_tagline

  # =tagline
  #
  # Example Class
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_tagline) = $test->collect_data_for_tagline;

  # "Example Class"

=cut

$test->for('example', 2, 'collect_data_for_tagline', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "Example Class";

  $result
});

=method collect_data_for_version

The collect_data_for_version method uses L</data> to fetch data for the C<version>
section and returns the data. Returns an arrayref in scalar context, and a list
in list context.

=signature collect_data_for_version

  collect_data_for_version() (arrayref)

=metadata collect_data_for_version

{
  since => '3.55',
}

=cut

=example-1 collect_data_for_version

  # =version
  #
  # 1.2.3
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $collect_data_for_version = $test->collect_data_for_version;

  # ["1.2.3"]

=cut

$test->for('example', 1, 'collect_data_for_version', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, ["1.2.3"];

  $result
});

=example-2 collect_data_for_version

  # =version
  #
  # 1.2.3
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my ($collect_data_for_version) = $test->collect_data_for_version;

  # "1.2.3"

=cut

$test->for('example', 2, 'collect_data_for_version', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is_deeply $result, "1.2.3";

  $result
});

=method data

The data method returns a L<Venus::Data> object using L</file> for parsing the
test specification.

=signature data

  data() (Venus::Data)

=metadata data

{
  since => '3.55',
}

=cut

=example-1 data

  # given: synopsis

  package main;

  my $data = $test->data;

  # bless(..., "Venus::Data")

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Data";

  $result
});

=method done

The done method dispatches to the L<Test::More/done_testing> operation and
returns the result.

=signature done

  done() (any)

=metadata done

{
  since => '3.55',
}

=cut

=example-1 done

  # given: synopsis

  package main;

  my $done = $test->done;

  # true

=cut

$test->for('example', 1, 'done', sub {
  my ($tryable) = @_;
  require Venus::Space;
  my $space = Venus::Space->new('Test::More');
  my $call = 0;
  my $orig = $space->swap('done_testing', sub {$call++});
  my $result = $tryable->result;
  is $result, 0;
  is $call, 1;
  $space->routine('done_testing', $orig);

  !$result
});

=method execute

The execute method dispatches to the C<execute_data_for_${name}> method
indictated by the first argument and returns the result. Returns an arrayref in
scalar context, and a list in list context.

=signature execute

  execute(string $name, any @args) (boolean)

=metadata execute

{
  since => '3.55',
}

=cut

=example-1 execute

  # given: synopsis

  package main;

  my $execute = $test->execute('name');

  # true

=cut

$test->for('example', 1, 'execute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=example-2 execute

  # given: synopsis

  package main;

  my $execute = $test->execute('name', sub {
    my ($data) = @_;

    my $result = $data->[0] eq 'Venus::Test' ? true : false;

    $self->pass($result, 'name set as Venus::Test');

    return $result;
  });

  # true

=cut

$test->for('example', 2, 'execute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_abstract

The execute_test_for_abstract method tests a documentation block for the C<abstract> section and returns the result.

=signature execute_test_for_abstract

  execute_test_for_abstract() (arrayref)

=metadata execute_test_for_abstract

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_abstract

  # =abstract
  #
  # Example Test Documentation
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_abstract = $test->execute_test_for_abstract;

  # true

=cut

$test->for('example', 1, 'execute_test_for_abstract', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_attribute

The execute_test_for_attribute method tests a documentation block for the C<attribute $name> section and returns the result.

=signature execute_test_for_attribute

  execute_test_for_attribute(string $name) (arrayref)

=metadata execute_test_for_attribute

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_attribute

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_attribute = $test->execute_test_for_attribute('name');

  # true

=cut

$test->for('example', 1, 'execute_test_for_attribute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_authors

The execute_test_for_authors method tests a documentation block for the C<authors> section and returns the result.

=signature execute_test_for_authors

  execute_test_for_authors() (arrayref)

=metadata execute_test_for_authors

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_authors

  # =authors
  #
  # Awncorp, C<awncorp@cpan.org>
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_authors = $test->execute_test_for_authors;

  # true

=cut

$test->for('example', 1, 'execute_test_for_authors', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_description

The execute_test_for_description method tests a documentation block for the C<description> section and returns the result.

=signature execute_test_for_description

  execute_test_for_description() (arrayref)

=metadata execute_test_for_description

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_description

  # =description
  #
  # This package provides an example class.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_description = $test->execute_test_for_description;

  # true

=cut

$test->for('example', 1, 'execute_test_for_description', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_encoding

The execute_test_for_encoding method tests a documentation block for the C<encoding> section and returns the result.

=signature execute_test_for_encoding

  execute_test_for_encoding() (arrayref)

=metadata execute_test_for_encoding

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_encoding

  # =encoding
  #
  # utf8
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_encoding = $test->execute_test_for_encoding;

  # true

=cut

$test->for('example', 1, 'execute_test_for_encoding', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_error

The execute_test_for_error method tests a documentation block for the C<error $name> section and returns the result.

=signature execute_test_for_error

  execute_test_for_error(string $name) (arrayref)

=metadata execute_test_for_error

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_error

  # =error error_on_unknown
  #
  # This package may raise an error_on_unknown error.
  #
  # =cut
  #
  # =example-1 error_on_unknown
  #
  #   # given: synopsis
  #
  #   my $error = $example->catch('error', {
  #     with => 'error_on_unknown',
  #   });
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_error = $test->execute_test_for_error('error_on_unknown');

  # true

=cut

$test->for('example', 1, 'execute_test_for_error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_example

The execute_test_for_example method tests a documentation block for the C<example-$number $name> section and returns the result.

=signature execute_test_for_example

  execute_test_for_example(number $numberm string $name) (arrayref)

=metadata execute_test_for_example

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_example

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_example = $test->execute_test_for_example(1, 'name');

  # true

=cut

$test->for('example', 1, 'execute_test_for_example', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_feature

The execute_test_for_feature method tests a documentation block for the C<feature $name> section and returns the result.

=signature execute_test_for_feature

  execute_test_for_feature(string $name) (arrayref)

=metadata execute_test_for_feature

{
  since => '3.55',
}

=example-1 execute_test_for_feature

  # =feature noop
  #
  # This package is no particularly useful features.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_feature = $test->execute_test_for_feature('noop');

  # true

=cut

$test->for('example', 1, 'execute_test_for_feature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_function

The execute_test_for_function method tests a documentation block for the C<function $name> section and returns the result.

=signature execute_test_for_function

  execute_test_for_function(string $name) (arrayref)

=metadata execute_test_for_function

{
  since => '3.55',
}

=example-1 execute_test_for_function

  # =function eg
  #
  # The eg function returns a new instance of Example.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $example = eg();
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_function = $test->execute_test_for_function('eg');

  # true

=cut

$test->for('example', 1, 'execute_test_for_function', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_includes

The execute_test_for_includes method tests a documentation block for the C<includes> section and returns the result.

=signature execute_test_for_includes

  execute_test_for_includes() (arrayref)

=metadata execute_test_for_includes

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_includes

  # =includes
  #
  # function: eg
  #
  # method: prepare
  # method: execute
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_includes = $test->execute_test_for_includes;

  # true

=cut

$test->for('example', 1, 'execute_test_for_includes', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_inherits

The execute_test_for_inherits method tests a documentation block for the C<inherits> section and returns the result.

=signature execute_test_for_inherits

  execute_test_for_inherits() (arrayref)

=metadata execute_test_for_inherits

{
  since => '3.55',
}

=example-1 execute_test_for_inherits

  # =inherits
  #
  # Venus::Core::Class
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_inherits = $test->execute_test_for_inherits;

  # true

=cut

$test->for('example', 1, 'execute_test_for_inherits', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_integrates

The execute_test_for_integrates method tests a documentation block for the C<integrates> section and returns the result.

=signature execute_test_for_integrates

  execute_test_for_integrates() (arrayref)

=metadata execute_test_for_integrates

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_integrates

  # =integrates
  #
  # Venus::Role::Catchable
  # Venus::Role::Throwable
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_integrates = $test->execute_test_for_integrates;

  # true

=cut

$test->for('example', 1, 'execute_test_for_integrates', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_layout

The execute_test_for_layout method tests a documentation block for the C<layout> section and returns the result.

=signature execute_test_for_layout

  execute_test_for_layout() (arrayref)

=metadata execute_test_for_layout

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_layout

  # =layout
  #
  # encoding
  # name
  # synopsis
  # description
  # attributes: attribute
  # authors
  # license
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_layout = $test->execute_test_for_layout;

  # true

=cut

$test->for('example', 1, 'execute_test_for_layout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_libraries

The execute_test_for_libraries method tests a documentation block for the C<libraries> section and returns the result.

=signature execute_test_for_libraries

  execute_test_for_libraries() (arrayref)

=metadata execute_test_for_libraries

{
  since => '3.55',
}

=example-1 execute_test_for_libraries

  # =libraries
  #
  # Venus::Check
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_libraries = $test->execute_test_for_libraries;

  # true

=cut

$test->for('example', 1, 'execute_test_for_libraries', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_license

The execute_test_for_license method tests a documentation block for the C<license> section and returns the result.

=signature execute_test_for_license

  execute_test_for_license() (arrayref)

=metadata execute_test_for_license

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_license

  # =license
  #
  # No license granted.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_license = $test->execute_test_for_license;

  # true

=cut

$test->for('example', 1, 'execute_test_for_license', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_message

The execute_test_for_message method tests a documentation block for the C<message $name> section and returns the result.

=signature execute_test_for_message

  execute_test_for_message(string $name) (arrayref)

=metadata execute_test_for_message

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_message

  # =message accept
  #
  # The accept message represents acceptance.
  #
  # =cut
  #
  # =example-1 accept
  #
  #   # given: synopsis
  #
  #   my $accept = $example->accept;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_message = $test->execute_test_for_message('accept');

  # true

=cut

$test->for('example', 1, 'execute_test_for_message', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_metadata

The execute_test_for_metadata method tests a documentation block for the C<metadata $name> section and returns the result.

=signature execute_test_for_metadata

  execute_test_for_metadata(string $name) (arrayref)

=metadata execute_test_for_metadata

{
  since => '3.55',
}

=example-1 execute_test_for_metadata

  # =method prepare
  #
  # The prepare method prepares for execution.
  #
  # =cut
  #
  # =metadata prepare
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 prepare
  #
  #   # given: synopsis
  #
  #   my $prepare = $example->prepare;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_metadata = $test->execute_test_for_metadata('prepare');

  # true

=cut

$test->for('example', 1, 'execute_test_for_metadata', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_method

The execute_test_for_method method tests a documentation block for the C<method $name> section and returns the result.

=signature execute_test_for_method

  execute_test_for_method(string $name) (arrayref)

=metadata execute_test_for_method

{
  since => '3.55',
}

=example-1 execute_test_for_method

  # =method execute
  #
  # The execute method executes the logic.
  #
  # =cut
  #
  # =metadata execute
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 execute
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_method = $test->execute_test_for_method('execute');

  # true

=cut

$test->for('example', 1, 'execute_test_for_method', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method execute_test_for_name

The execute_test_for_name method tests a documentation block for the C<name> section and returns the result.

=signature execute_test_for_name

  execute_test_for_name() (arrayref)

=metadata execute_test_for_name

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_name

  # =name

  # Example

  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_name = $test->execute_test_for_name;

  # true

=cut

$test->for('example', 1, 'execute_test_for_name', sub {
  true;
});

=method execute_test_for_operator

The execute_test_for_operator method tests a documentation block for the C<operator $name> section and returns the result.

=signature execute_test_for_operator

  execute_test_for_operator(string $name) (arrayref)

=metadata execute_test_for_operator

{
  since => '3.55',
}

=cut

=example-1 execute_test_for_operator

  # =operator ("")
  #
  # This package overloads the C<""> operator.
  #
  # =cut
  #
  # =example-1 ("")
  #
  #   # given: synopsis
  #
  #   my $string = "$example";
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $execute_test_for_operator = $test->execute_test_for_operator('("")');

  # true

=cut

$test->for('example', 1, 'execute_test_for_operator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method explain

The explain method dispatches to the L<Test::More/explain> operation and
returns the result.

=signature explain

  explain(any @args) (any)

=metadata explain

{
  since => '3.55',
}

=cut

=example-1 explain

  # given: synopsis

  package main;

  my $explain = $test->explain(123.456);

  # "123.456"

=cut

$test->for('example', 1, 'explain', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "123.456";

  $result
});

=method fail

The fail method dispatches to the L<Test::More/ok> operation expecting the
first argument to be falsy and returns the result.

=signature fail

  fail(any $data, string $description) (any)

=metadata fail

{
  since => '3.55',
}

=cut

=example-1 fail

  # given: synopsis

  package main;

  my $fail = $test->fail(0, 'example-1 fail passed');

  # true

=cut

$test->for('example', 1, 'fail', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method for

The for method dispatches to the L</execute> method using the arguments
provided within a L<subtest|Test::More/subtest> and returns the invocant.

=signature for

  for(any @args) (Venus::Test)

=metadata for

{
  since => '3.55',
}

=cut

=example-1 for

  # given: synopsis

  package main;

  my $for = $test->for('name');

  # bless(..., "Venus::Test")

=cut

$test->for('example', 1, 'for', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Test";

  $result
});

=example-2 for

  # given: synopsis

  package main;

  my $for = $test->for('synopsis');

  # bless(..., "Venus::Test")

=cut

$test->for('example', 2, 'for', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Test";

  $result
});

=example-3 for

  # given: synopsis

  package main;

  my $for = $test->for('synopsis', sub{
    my ($tryable) = @_;
    return $tryable->result;
  });

  # bless(..., "Venus::Test")

=cut

$test->for('example', 3, 'for', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Test";

  $result
});

=example-4 for

  # given: synopsis

  package main;

  my $for = $test->for('example', 1, 'test', sub {
    my ($tryable) = @_;
    return $tryable->result;
  });

  # bless(..., "Venus::Test")

=cut

$test->for('example', 4, 'for', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Test";

  $result
});

=method like

The like method dispatches to the L<Test::More/like> operation and returns the
result.

=signature like

  like(string $data, string | Venus::Regexp $match, string $description) (any)

=metadata like

{
  since => '3.55',
}

=cut

=example-1 like

  # given: synopsis

  package main;

  my $like = $test->like('hello world', 'world', 'example-1 like passed');

  # true

=cut

$test->for('example', 1, 'like', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=example-2 like

  # given: synopsis

  package main;

  my $like = $test->like('hello world', qr/world/, 'example-1 like passed');

  # true

=cut

$test->for('example', 2, 'like', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method more

The more method dispatches to the L<Test::More> method specified by the first
argument and returns its result.

=signature more

  more(any @args) (Venus::Test)

=metadata more

{
  since => '3.55',
}

=cut

=example-1 more

  # given: synopsis

  package main;

  my $more = $test->more('ok', true);

  # true

=cut

$test->for('example', 1, 'more', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method okay

The okay method dispatches to the L<Test::More/ok> operation and returns the
result.

=signature okay

  okay(any $data, string $description) (any)

=metadata okay

{
  since => '3.55',
}

=cut

=example-1 okay

  # given: synopsis

  package main;

  my $okay = $test->okay(1, 'example-1 okay passed');

  # true

=cut

$test->for('example', 1, 'okay', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=example-2 okay

  # given: synopsis

  package main;

  my $okay = $test->okay(!0, 'example-1 okay passed');

  # true

=cut

$test->for('example', 2, 'okay', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method okay_can

The okay_can method dispatches to the L<Test::More/can_ok> operation and
returns the result.

=signature okay_can

  okay_can(string $name, string @args) (any)

=metadata okay_can

{
  since => '3.55',
}

=cut

=example-1 okay_can

  # given: synopsis

  package main;

  my $okay_can = $test->okay_can('Venus::Test', 'diag');

  # true

=cut

$test->for('example', 1, 'okay_can', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method okay_isa

The okay_isa method dispatches to the L<Test::More/isa_ok> operation and
returns the result.

=signature okay_isa

  okay_isa(string $name, string $base) (any)

=metadata okay_isa

{
  since => '3.55',
}

=cut

=example-1 okay_isa

  # given: synopsis

  package main;

  my $okay_isa = $test->okay_isa('Venus::Test', 'Venus::Kind');

  # true

=cut

$test->for('example', 1, 'okay_isa', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method pass

The pass method dispatches to the L<Test::More/ok> operation expecting the
first argument to be truthy and returns the result.

=signature pass

  pass(any $data, string $description) (any)

=metadata pass

{
  since => '3.55',
}

=cut

=example-1 pass

  # given: synopsis

  package main;

  my $fail = $test->pass(1, 'example-1 pass passed');

  # true

=cut

$test->for('example', 1, 'pass', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method perform

The perform method dispatches to the C<perform_data_for_${name}> method
indictated by the first argument and returns the result. Returns an arrayref in
scalar context, and a list in list context.

=signature perform

  perform(string $name, any @args) (boolean)

=metadata perform

{
  since => '3.55',
}

=cut

=example-1 perform

  # given: synopsis

  package main;

  my $data = $test->collect('name');

  my $perform = $test->perform('name', $data);

  # true

=cut

$test->for('example', 1, 'perform', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  $result
});

=method perform_test_for_abstract

The perform_data_for_abstract method performs an overridable test for the C<abstract> section and returns truthy or falsy.

=signature perform_test_for_abstract

  perform_test_for_abstract(arrayref $data) (boolean)

=metadata perform_test_for_abstract

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_abstract

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_abstract {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=abstract content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_abstract;

  my $perform_test_for_abstract = $test->perform_test_for_abstract(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_abstract', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_attribute

The perform_data_for_attribute method performs an overridable test for the C<attribute $name> section and returns truthy or falsy.

=signature perform_test_for_attribute

  perform_test_for_attribute(string $name, arrayref $data) (boolean)

=metadata perform_test_for_attribute

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_attribute

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_attribute {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=attribute $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_attribute('name');

  my $perform_test_for_attribute = $test->perform_test_for_attribute(
    'name', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_attribute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_authors

The perform_data_for_authors method performs an overridable test for the C<authors> section and returns truthy or falsy.

=signature perform_test_for_authors

  perform_test_for_authors(arrayref $data) (boolean)

=metadata perform_test_for_authors

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_authors

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_authors {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=authors content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_authors;

  my $perform_test_for_authors = $test->perform_test_for_authors(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_authors', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_description

The perform_data_for_description method performs an overridable test for the C<description> section and returns truthy or falsy.

=signature perform_test_for_description

  perform_test_for_description(arrayref $data) (boolean)

=metadata perform_test_for_description

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_description

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_description {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=description content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_description;

  my $perform_test_for_description = $test->perform_test_for_description(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_description', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_encoding

The perform_data_for_encoding method performs an overridable test for the C<encoding> section and returns truthy or falsy.

=signature perform_test_for_encoding

  perform_test_for_encoding(arrayref $data) (boolean)

=metadata perform_test_for_encoding

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_encoding

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_encoding {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=encoding content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_encoding;

  my $perform_test_for_encoding = $test->perform_test_for_encoding(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_encoding', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_error

The perform_data_for_error method performs an overridable test for the C<error $name> section and returns truthy or falsy.

=signature perform_test_for_error

  perform_test_for_error(arrayref $data) (boolean)

=metadata perform_test_for_error

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_error

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_error {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=error $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_error('error_on_unknown');

  my $perform_test_for_error = $test->perform_test_for_error(
    'error_on_unknown', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_example

The perform_data_for_example method performs an overridable test for the C<example-$number $name> section and returns truthy or falsy.

=signature perform_test_for_example

  perform_test_for_example(arrayref $data) (boolean)

=metadata perform_test_for_example

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_example

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_example {
    my ($self, $number, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=example-$number $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_example(1, 'execute');

  my $perform_test_for_example = $test->perform_test_for_example(
    1, 'execute', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_example', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_feature

The perform_data_for_feature method performs an overridable test for the C<feature $name> section and returns truthy or falsy.

=signature perform_test_for_feature

  perform_test_for_feature(arrayref $data) (boolean)

=metadata perform_test_for_feature

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_feature

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_feature {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=feature $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_feature('noop');

  my $perform_test_for_feature = $test->perform_test_for_feature(
    'noop', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_feature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_function

The perform_data_for_function method performs an overridable test for the C<function $name> section and returns truthy or falsy.

=signature perform_test_for_function

  perform_test_for_function(arrayref $data) (boolean)

=metadata perform_test_for_function

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_function

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_function {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=function $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_function('eg');

  my $perform_test_for_function = $test->perform_test_for_function(
    'eg', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_function', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_includes

The perform_data_for_includes method performs an overridable test for the C<includes> section and returns truthy or falsy.

=signature perform_test_for_includes

  perform_test_for_includes(arrayref $data) (boolean)

=metadata perform_test_for_includes

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_includes

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_includes {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=includes content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_includes;

  my $perform_test_for_includes = $test->perform_test_for_includes(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_includes', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_inherits

The perform_data_for_inherits method performs an overridable test for the C<inherits> section and returns truthy or falsy.

=signature perform_test_for_inherits

  perform_test_for_inherits(arrayref $data) (boolean)

=metadata perform_test_for_inherits

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_inherits

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_inherits {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=inherits content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_inherits;

  my $perform_test_for_inherits = $test->perform_test_for_inherits(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_inherits', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_integrates

The perform_data_for_integrates method performs an overridable test for the C<integrates> section and returns truthy or falsy.

=signature perform_test_for_integrates

  perform_test_for_integrates(arrayref $data) (boolean)

=metadata perform_test_for_integrates

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_integrates

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_integrates {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=integrates content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_integrates;

  my $perform_test_for_integrates = $test->perform_test_for_integrates(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_integrates', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_layout

The perform_data_for_layout method performs an overridable test for the C<layout> section and returns truthy or falsy.

=signature perform_test_for_layout

  perform_test_for_layout(arrayref $data) (boolean)

=metadata perform_test_for_layout

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_layout

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_layout {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=layout content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_layout;

  my $perform_test_for_layout = $test->perform_test_for_layout(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_layout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_libraries

The perform_data_for_libraries method performs an overridable test for the C<libraries> section and returns truthy or falsy.

=signature perform_test_for_libraries

  perform_test_for_libraries(arrayref $data) (boolean)

=metadata perform_test_for_libraries

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_libraries

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_libraries {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=libraries content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_libraries;

  my $perform_test_for_libraries = $test->perform_test_for_libraries(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_libraries', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_license

The perform_data_for_license method performs an overridable test for the C<license> section and returns truthy or falsy.

=signature perform_test_for_license

  perform_test_for_license(arrayref $data) (boolean)

=metadata perform_test_for_license

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_license

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_license {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=license content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_license;

  my $perform_test_for_license = $test->perform_test_for_license(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_license', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_message

The perform_data_for_message method performs an overridable test for the C<message $name> section and returns truthy or falsy.

=signature perform_test_for_message

  perform_test_for_message(arrayref $data) (boolean)

=metadata perform_test_for_message

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_message

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_message {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=message $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_message('accept');

  my $perform_test_for_message = $test->perform_test_for_message(
    'accept', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_message', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_metadata

The perform_data_for_metadata method performs an overridable test for the C<metadata $name> section and returns truthy or falsy.

=signature perform_test_for_metadata

  perform_test_for_metadata(arrayref $data) (boolean)

=metadata perform_test_for_metadata

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_metadata

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_metadata {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=metadata $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_metadata('execute');

  my $perform_test_for_metadata = $test->perform_test_for_metadata(
    'execute', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_metadata', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_method

The perform_data_for_method method performs an overridable test for the C<method $name> section and returns truthy or falsy.

=signature perform_test_for_method

  perform_test_for_method(arrayref $data) (boolean)

=metadata perform_test_for_method

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_method

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_method {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=method $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_method('execute');

  my $perform_test_for_method = $test->perform_test_for_method(
    'execute', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_method', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_name

The perform_data_for_name method performs an overridable test for the C<name> section and returns truthy or falsy.

=signature perform_test_for_name

  perform_test_for_name(arrayref $data) (boolean)

=metadata perform_test_for_name

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_name

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_name {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_name;

  my $perform_test_for_name = $test->perform_test_for_name(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_operator

The perform_data_for_operator method performs an overridable test for the C<operator $name> section and returns truthy or falsy.

=signature perform_test_for_operator

  perform_test_for_operator(arrayref $data) (boolean)

=metadata perform_test_for_operator

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_operator

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_operator {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=operator $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_operator('("")');

  my $perform_test_for_operator = $test->perform_test_for_operator(
    '("")', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_operator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_partials

The perform_data_for_partials method performs an overridable test for the C<partials> section and returns truthy or falsy.

=signature perform_test_for_partials

  perform_test_for_partials(arrayref $data) (boolean)

=metadata perform_test_for_partials

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_partials

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_partials {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=partials content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_partials;

  my $perform_test_for_partials = $test->perform_test_for_partials(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_partials', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_project

The perform_data_for_project method performs an overridable test for the C<project> section and returns truthy or falsy.

=signature perform_test_for_project

  perform_test_for_project(arrayref $data) (boolean)

=metadata perform_test_for_project

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_project

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_project {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=project content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_project;

  my $perform_test_for_project = $test->perform_test_for_project(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_project', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_signature

The perform_data_for_signature method performs an overridable test for the C<signature $name> section and returns truthy or falsy.

=signature perform_test_for_signature

  perform_test_for_signature(arrayref $data) (boolean)

=metadata perform_test_for_signature

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_signature

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_signature {
    my ($self, $name, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=signature $name content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_signature('execute');

  my $perform_test_for_signature = $test->perform_test_for_signature(
    'execute', $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_signature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_synopsis

The perform_data_for_synopsis method performs an overridable test for the C<synopsis> section and returns truthy or falsy.

=signature perform_test_for_synopsis

  perform_test_for_synopsis(arrayref $data) (boolean)

=metadata perform_test_for_synopsis

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_synopsis

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_synopsis {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=synopsis content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_synopsis;

  my $perform_test_for_synopsis = $test->perform_test_for_synopsis(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_tagline

The perform_data_for_tagline method performs an overridable test for the C<tagline> section and returns truthy or falsy.

=signature perform_test_for_tagline

  perform_test_for_tagline(arrayref $data) (boolean)

=metadata perform_test_for_tagline

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_tagline

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_tagline {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=tagline content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_tagline;

  my $perform_test_for_tagline = $test->perform_test_for_tagline(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_tagline', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method perform_test_for_version

The perform_data_for_version method performs an overridable test for the C<version> section and returns truthy or falsy.

=signature perform_test_for_version

  perform_test_for_version(arrayref $data) (boolean)

=metadata perform_test_for_version

{
  since => '3.55',
}

=cut

=example-1 perform_test_for_version

  package Example::Test;

  use Venus::Class 'base';

  base 'Venus::Test';

  sub perform_test_for_version {
    my ($self, $data) = @_;

    my $result = length(join "\n", @{$data}) ? true : false;

    $self->pass($result, "=version content");

    return $result;
  }

  package main;

  my $test = Example::Test->new('t/path/pod/example');

  my $data = $test->collect_data_for_version;

  my $perform_test_for_version = $test->perform_test_for_version(
    $data,
  );

  # true

=cut

$test->for('example', 1, 'perform_test_for_version', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, true;

  require Venus::Space;
  Venus::Space->new('Example::Test')->unload;

  $result
});

=method present

The present method dispatches to the C<present_data_for_${name}> method
indictated by the first argument and returns the result. Returns an arrayref in
scalar context, and a list in list context.

=signature present

  present(string $name, any @args) (string)

=metadata present

{
  since => '3.55',
}

=cut

=example-1 present

  # given: synopsis

  package main;

  my $present = $test->present('name');

  # =head1 NAME
  #
  # Venus::Test - Test Class
  #
  # =cut

=cut

$test->for('example', 1, 'present', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 NAME

Venus::Test - Test Class

=cut';

  $result
});

=method present_data_for_abstract

The present_data_for_abstract method builds a documentation block for the C<abstract> section and returns it as a string.

=signature present_data_for_abstract

  present_data_for_abstract() (arrayref)

=metadata present_data_for_abstract

{
  since => '3.55',
}

=cut

=example-1 present_data_for_abstract

  # =abstract
  #
  # Example Test Documentation
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_abstract = $test->present_data_for_abstract;

  # =head1 ABSTRACT
  #
  # Example Test Documentation
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_abstract', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 ABSTRACT

Example Test Documentation

=cut';

  $result
});

=method present_data_for_attribute

The present_data_for_attribute method builds a documentation block for the C<attribute $name> section and returns it as a string.

=signature present_data_for_attribute

  present_data_for_attribute(string $name) (arrayref)

=metadata present_data_for_attribute

{
  since => '3.55',
}

=cut

=example-1 present_data_for_attribute

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_attribute = $test->present_data_for_attribute('name');

  # =head2 name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =over 4
  #
  # =item name example 1
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =back
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_attribute', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head2 name

The name attribute is read-write, optional, and holds a string.

=over 4

=item name example 1

  # given: synopsis

  my $name = $example->name;

  # "..."

=back

=cut';

  $result
});

=method present_data_for_authors

The present_data_for_authors method builds a documentation block for the C<authors> section and returns it as a string.

=signature present_data_for_authors

  present_data_for_authors() (arrayref)

=metadata present_data_for_authors

{
  since => '3.55',
}

=cut

=example-1 present_data_for_authors

  # =authors
  #
  # Awncorp, C<awncorp@cpan.org>
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_authors = $test->present_data_for_authors;

  # =head1 AUTHORS
  #
  # Awncorp, C<awncorp@cpan.org>
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_authors', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 AUTHORS

Awncorp, C<awncorp@cpan.org>

=cut';

  $result
});

=method present_data_for_description

The present_data_for_description method builds a documentation block for the C<description> section and returns it as a string.

=signature present_data_for_description

  present_data_for_description() (arrayref)

=metadata present_data_for_description

{
  since => '3.55',
}

=cut

=example-1 present_data_for_description

  # =description
  #
  # This package provides an example class.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_description = $test->present_data_for_description;

  # =head1 DESCRIPTION
  #
  # This package provides an example class.
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_description', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 DESCRIPTION

This package provides an example class.

=cut';

  $result
});

=method present_data_for_encoding

The present_data_for_encoding method builds a documentation block for the C<encoding> section and returns it as a string.

=signature present_data_for_encoding

  present_data_for_encoding() (arrayref)

=metadata present_data_for_encoding

{
  since => '3.55',
}

=cut

=example-1 present_data_for_encoding

  # =encoding
  #
  # utf8
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_encoding = $test->present_data_for_encoding;

  # =encoding UTF8
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_encoding', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=encoding UTF8

=cut';

  $result
});

=method present_data_for_error

The present_data_for_error method builds a documentation block for the C<error $name> section and returns it as a string.

=signature present_data_for_error

  present_data_for_error(string $name) (arrayref)

=metadata present_data_for_error

{
  since => '3.55',
}

=cut

=example-1 present_data_for_error

  # =error error_on_unknown
  #
  # This package may raise an error_on_unknown error.
  #
  # =cut
  #
  # =example-1 error_on_unknown
  #
  #   # given: synopsis
  #
  #   my $error = $example->catch('error', {
  #     with => 'error_on_unknown',
  #   });
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_error = $test->present_data_for_error('error_on_unknown');

  # =over 4
  #
  # =item error: C<error_on_unknown>
  #
  # This package may raise an error_on_unknown error.
  #
  # B<example 1>
  #
  #   # given: synopsis
  #
  #   my $error = $example->catch('error', {
  #     with => 'error_on_unknown',
  #   });
  #
  #   # "..."
  #
  # =back

=cut

$test->for('example', 1, 'present_data_for_error', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, q|
=over 4

=item error: C<error_on_unknown>

This package may raise an error_on_unknown error.

B<example 1>

  # given: synopsis

  my $error = $example->catch('error', {
    with => 'error_on_unknown',
  });

  # "..."

=back|;

  $result
});

=method present_data_for_example

The present_data_for_example method builds a documentation block for the C<example-$number $name> section and returns it as a string.

=signature present_data_for_example

  present_data_for_example(number $numberm string $name) (arrayref)

=metadata present_data_for_example

{
  since => '3.55',
}

=cut

=example-1 present_data_for_example

  # =attribute name
  #
  # The name attribute is read-write, optional, and holds a string.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_example = $test->present_data_for_example(1, 'name');

  # =over 4
  #
  # =item name example 1
  #
  #   # given: synopsis
  #
  #   my $name = $example->name;
  #
  #   # "..."
  #
  # =back

=cut

$test->for('example', 1, 'present_data_for_example', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, q|
=over 4

=item name example 1

  # given: synopsis

  my $name = $example->name;

  # "..."

=back|;

  $result
});

=method present_data_for_feature

The present_data_for_feature method builds a documentation block for the C<feature $name> section and returns it as a string.

=signature present_data_for_feature

  present_data_for_feature(string $name) (arrayref)

=metadata present_data_for_feature

{
  since => '3.55',
}

=example-1 present_data_for_feature

  # =feature noop
  #
  # This package is no particularly useful features.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_feature = $test->present_data_for_feature('noop');

  # =over 4
  #
  # =item noop
  #
  # This package is no particularly useful features.
  #
  # =back

=cut

$test->for('example', 1, 'present_data_for_feature', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=over 4

=item noop

This package is no particularly useful features.

=back';

  $result
});

=method present_data_for_function

The present_data_for_function method builds a documentation block for the C<function $name> section and returns it as a string.

=signature present_data_for_function

  present_data_for_function(string $name) (arrayref)

=metadata present_data_for_function

{
  since => '3.55',
}

=example-1 present_data_for_function

  # =function eg
  #
  # The eg function returns a new instance of Example.
  #
  # =cut
  #
  # =example-1 name
  #
  #   # given: synopsis
  #
  #   my $example = eg();
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_function = $test->present_data_for_function('eg');

  # =head2 eg
  #
  # The eg function returns a new instance of Example.
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_function', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head2 eg

The eg function returns a new instance of Example.

=cut';

  $result
});

=method present_data_for_includes

The present_data_for_includes method builds a documentation block for the C<includes> section and returns it as a string.

=signature present_data_for_includes

  present_data_for_includes() (arrayref)

=metadata present_data_for_includes

{
  since => '3.55',
}

=cut

=example-1 present_data_for_includes

  # =includes
  #
  # function: eg
  #
  # method: prepare
  # method: execute
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_includes = $test->present_data_for_includes;

  # undef

=cut

$test->for('example', 1, 'present_data_for_includes', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=method present_data_for_inherits

The present_data_for_inherits method builds a documentation block for the C<inherits> section and returns it as a string.

=signature present_data_for_inherits

  present_data_for_inherits() (arrayref)

=metadata present_data_for_inherits

{
  since => '3.55',
}

=example-1 present_data_for_inherits

  # =inherits
  #
  # Venus::Core::Class
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_inherits = $test->present_data_for_inherits;

  # =head1 INHERITS
  #
  # This package inherits behaviors from:
  #
  # L<Venus::Core::Class>
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_inherits', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 INHERITS

This package inherits behaviors from:

L<Venus::Core::Class>

=cut';

  $result
});

=method present_data_for_integrates

The present_data_for_integrates method builds a documentation block for the C<integrates> section and returns it as a string.

=signature present_data_for_integrates

  present_data_for_integrates() (arrayref)

=metadata present_data_for_integrates

{
  since => '3.55',
}

=cut

=example-1 present_data_for_integrates

  # =integrates
  #
  # Venus::Role::Catchable
  # Venus::Role::Throwable
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_integrates = $test->present_data_for_integrates;

  # =head1 INTEGRATES
  #
  # This package integrates behaviors from:
  #
  # L<Venus::Role::Catchable>
  #
  # L<Venus::Role::Throwable>
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_integrates', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 INTEGRATES

This package integrates behaviors from:

L<Venus::Role::Catchable>

L<Venus::Role::Throwable>

=cut';

  $result
});

=method present_data_for_layout

The present_data_for_layout method builds a documentation block for the C<layout> section and returns it as a string.

=signature present_data_for_layout

  present_data_for_layout() (arrayref)

=metadata present_data_for_layout

{
  since => '3.55',
}

=cut

=example-1 present_data_for_layout

  # =layout
  #
  # encoding
  # name
  # synopsis
  # description
  # attributes: attribute
  # authors
  # license
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_layout = $test->present_data_for_layout;

  # undef

=cut

$test->for('example', 1, 'present_data_for_layout', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=method present_data_for_libraries

The present_data_for_libraries method builds a documentation block for the C<libraries> section and returns it as a string.

=signature present_data_for_libraries

  present_data_for_libraries() (arrayref)

=metadata present_data_for_libraries

{
  since => '3.55',
}

=example-1 present_data_for_libraries

  # =libraries
  #
  # Venus::Check
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_libraries = $test->present_data_for_libraries;

  # =head1 LIBRARIES
  #
  # This package uses type constraints from:
  #
  # L<Venus::Check>
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_libraries', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 LIBRARIES

This package uses type constraints from:

L<Venus::Check>

=cut';

  $result
});

=method present_data_for_license

The present_data_for_license method builds a documentation block for the C<license> section and returns it as a string.

=signature present_data_for_license

  present_data_for_license() (arrayref)

=metadata present_data_for_license

{
  since => '3.55',
}

=cut

=example-1 present_data_for_license

  # =license
  #
  # No license granted.
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_license = $test->present_data_for_license;

  # =head1 LICENSE
  #
  # No license granted.
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_license', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 LICENSE

No license granted.

=cut';

  $result
});

=method present_data_for_message

The present_data_for_message method builds a documentation block for the C<message $name> section and returns it as a string.

=signature present_data_for_message

  present_data_for_message(string $name) (arrayref)

=metadata present_data_for_message

{
  since => '3.55',
}

=cut

=example-1 present_data_for_message

  # =message accept
  #
  # The accept message represents acceptance.
  #
  # =cut
  #
  # =example-1 accept
  #
  #   # given: synopsis
  #
  #   my $accept = $example->accept;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_message = $test->present_data_for_message('accept');

  # =over 4
  #
  # =item accept
  #
  # The accept message represents acceptance.
  #
  # B<example 1>
  #
  #   # given: synopsis
  #
  #   my $accept = $example->accept;
  #
  #   # "..."
  #
  # =back

=cut

$test->for('example', 1, 'present_data_for_message', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=over 4

=item accept

The accept message represents acceptance.

B<example 1>

  # given: synopsis

  my $accept = $example->accept;

  # "..."

=back';

  $result
});

=method present_data_for_metadata

The present_data_for_metadata method builds a documentation block for the C<metadata $name> section and returns it as a string.

=signature present_data_for_metadata

  present_data_for_metadata(string $name) (arrayref)

=metadata present_data_for_metadata

{
  since => '3.55',
}

=example-1 present_data_for_metadata

  # =method prepare
  #
  # The prepare method prepares for execution.
  #
  # =cut
  #
  # =metadata prepare
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 prepare
  #
  #   # given: synopsis
  #
  #   my $prepare = $example->prepare;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_metadata = $test->present_data_for_metadata('prepare');

  # undef

=cut

$test->for('example', 1, 'present_data_for_metadata', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;
  is $result, undef;

  !$result
});

=method present_data_for_method

The present_data_for_method method builds a documentation block for the C<method $name> section and returns it as a string.

=signature present_data_for_method

  present_data_for_method(string $name) (arrayref)

=metadata present_data_for_method

{
  since => '3.55',
}

=example-1 present_data_for_method

  # =method execute
  #
  # The execute method executes the logic.
  #
  # =cut
  #
  # =metadata execute
  #
  # {since => 1.2.3}
  #
  # =cut
  #
  # =example-1 execute
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_method = $test->present_data_for_method('execute');

  # =head2 execute
  #
  #   execute() (boolean)
  #
  # The execute method executes the logic.
  #
  # I<Since C<1.2.3>>
  #
  # =over 4
  #
  # =item execute example 1
  #
  #   # given: synopsis
  #
  #   my $execute = $example->execute;
  #
  #   # "..."
  #
  # =back
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_method', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head2 execute

  execute() (boolean)

The execute method executes the logic.

I<Since C<1.2.3>>

=over 4

=item execute example 1

  # given: synopsis

  my $execute = $example->execute;

  # "..."

=back

=cut';

  $result
});

=method present_data_for_name

The present_data_for_name method builds a documentation block for the C<name> section and returns it as a string.

=signature present_data_for_name

  present_data_for_name() (arrayref)

=metadata present_data_for_name

{
  since => '3.55',
}

=cut

=example-1 present_data_for_name

  # =name

  # Example

  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_name = $test->present_data_for_name;

  # =head1 NAME
  #
  # Example - Example Class
  #
  # =cut

=cut

$test->for('example', 1, 'present_data_for_name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=head1 NAME

Example - Example Class

=cut';

  $result
});

=method present_data_for_operator

The present_data_for_operator method builds a documentation block for the C<operator $name> section and returns it as a string.

=signature present_data_for_operator

  present_data_for_operator(string $name) (arrayref)

=metadata present_data_for_operator

{
  since => '3.55',
}

=cut

=example-1 present_data_for_operator

  # =operator ("")
  #
  # This package overloads the C<""> operator.
  #
  # =cut
  #
  # =example-1 ("")
  #
  #   # given: synopsis
  #
  #   my $string = "$example";
  #
  #   # "..."
  #
  # =cut

  package main;

  use Venus::Test 'test';

  my $test = test 't/path/pod/example';

  my $present_data_for_operator = $test->present_data_for_operator('("")');

  # =over 4
  #
  # =item operation: C<("")>
  #
  # This package overloads the C<""> operator.
  #
  # B<example 1>
  #
  #   # given: synopsis
  #
  #   my $string = "$example";
  #
  #   # "..."
  #
  # =back

=cut

$test->for('example', 1, 'present_data_for_operator', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  is $result, '
=over 4

=item operation: C<("")>

This package overloads the C<""> operator.

B<example 1>

  # given: synopsis

  my $string = "$example";

  # "..."

=back';

  $result
});

=method render

The render method reads the test specification and generates L<perlpod>
documentation and returns a L<Venus::Path> object for the filename provided.

=signature render

  render(string $file) (Venus::Path)

=metadata render

{
  since => '3.55',
}

=cut

=example-1 render

  # given: synopsis

  package main;

  my $path = $test->render('t/path/pod/test');

  # bless(..., "Venus::Path")

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok defined $result;
  isa_ok $result, "Venus::Path";
  ok -f $result->absolute;
  my $lines = $result->read;
  like $lines, qr/=head1 NAME/;
  like $lines, qr/Venus::Test - Test Class/;
  like $lines, qr/=head1 ABSTRACT/;
  like $lines, qr/Test Class for Perl 5/;
  like $lines, qr/=head1 SYNOPSIS/;
  like $lines, qr/=head1 DESCRIPTION/;
  like $lines, qr/=head1 INHERITS/;
  like $lines, qr/=head1 INTEGRATES/;
  like $lines, qr/=head1 FUNCTIONS/;
  like $lines, qr/=head1 METHODS/;
  like $lines, qr/=head2 data/;
  like $lines, qr/=item data example 1/;
  like $lines, qr/=head2 for/;
  like $lines, qr/=item for example 1/;
  like $lines, qr/=item for example 2/;
  like $lines, qr/=item for example 3/;
  like $lines, qr/=item for example 4/;
  like $lines, qr/=head1 AUTHORS/;
  like $lines, qr/=head1 LICENSE/;

  $result
});

=method same

The same method dispatches to the L<Test::More/is_deeply> operation and returns
the result.

=signature same

  same(any $data1, any $data2, string $description) (any)

=metadata same

{
  since => '3.55',
}

=cut

=example-1 same

  # given: synopsis

  package main;

  my $same = $test->same({1..4}, {1..4}, 'example-1 same passed');

  # true

=cut

$test->for('example', 1, 'same', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, true;

  $result
});

=method skip

The skip method dispatches to the L<Test::More/skip> operation with the
C<plan_all> option and returns the result.

=signature skip

  skip(string $description, boolean | coderef $value) (any)

=metadata skip

{
  since => '3.55',
}

=cut

=example-1 skip

  # given: synopsis

  package main;

  my $skip = $test->skip('Unsupported', !0);

  # true

=cut

$test->for('example', 1, 'skip', sub {
  my ($tryable) = @_;
  require Venus::Space;
  my $space = Venus::Space->new('Test::More');
  my $call = 0;
  my $orig = $space->swap('plan', sub {$call++});
  my $result = $tryable->result;
  is $result, 1;
  is $call, 1;
  $space->routine('skip', $orig);

  $result
});

=example-2 skip

  # given: synopsis

  package main;

  my $skip = $test->skip('Unsupported', sub{!0});

  # true

=cut

$test->for('example', 2, 'skip', sub {
  my ($tryable) = @_;
  require Venus::Space;
  my $space = Venus::Space->new('Test::More');
  my $call = 0;
  my $orig = $space->swap('plan', sub {$call++});
  my $result = $tryable->result;
  is $result, 1;
  is $call, 1;
  $space->routine('skip', $orig);

  $result
});

=feature spec

  # [required]

  =name
  =abstract
  =tagline
  =synopsis
  =description

  # [optional]

  =includes
  =libraries
  =inherits
  =integrates

  # [optional; repeatable]

  =attribute $name
  =signature $name
  =example-$number $name # [repeatable]

  # [optional; repeatable]

  =function $name
  =signature $name
  =example-$number $name # [repeatable]

  # [optional; repeatable]

  =message $name
  =signature $name
  =example-$number $name # [repeatable]

  # [optional; repeatable]

  =method $name
  =signature $name
  =example-$number $name # [repeatable]

  # [optional; repeatable]

  =routine $name
  =signature $name
  =example-$number $name # [repeatable]

  # [optional; repeatable]

  =feature $name
  =example $name

  # [optional; repeatable]

  =error $name
  =example $name

  # [optional; repeatable]

  =operator $name
  =example $name

  # [optional]

  =partials
  =authors
  =license
  =project

The specification is designed to accommodate typical package declarations. It
is used by the parser to provide the content used in test automation and
document generation. B<Note:> When code blocks are evaluated, the
I<"redefined"> warnings are now automatically disabled.

=cut

=feature spec-abstract

  =abstract

  Example Test Documentation

  =cut

  $test->for('abstract');

The C<abstract> block should contain a subtitle describing the package. This is
tested for existence.

=cut

=feature spec-attribute

  =attribute name

  The name attribute is read-write, optional, and holds a string.

  =example-1 name

    # given: synopsis

    my $name = $example->name;

    # "..."

  =cut

  $test->for('attribute', 'name');

  $test->for('example', 1, 'name', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

Describing an attribute requires at least three blocks, i.e. C<attribute
$name>, C<signature $name>, and C<example-$number $name>. The C<attribute>
block should contain a description of the attribute and its purpose. The
C<signature> block should contain a routine signature in the form of
C<$signature : $return_type>, where C<$signature> is a valid typed signature
and C<$return_type> is any valid L<Venus::Check> expression. The
C<example-$number> block is a repeatable block, and at least one block must
exist when documenting an attribute. The C<example-$number> block should
contain valid Perl code and return a value. The block may contain a "magic"
comment in the form of C<given: synopsis> or C<given: example-$number $name>
which if present will include the given code example(s) with the evaluation of
the current block. Each attribute is tested and must be recognized to exist.

=cut

=feature spec-authors

  =authors

  Awncorp, C<awncorp@cpan.org>

  =cut

  $test->for('authors');

The C<authors> block should contain text describing the authors of the package.

=cut

=feature spec-description

  =description

  This package provides an example class.

  =cut

  $test->for('description');

The C<description> block should contain a description of the package and it's
behaviors.

=cut

=feature spec-encoding

  =encoding

  utf8

  =cut

  $test->for('encoding');

The C<encoding> block should contain the appropriate L<encoding|perlpod/encoding-encodingname>.

=cut

=feature spec-error

  =error error_on_unknown

  This package may raise an error_on_unknown error.

  =example-1 error_on_unknown

    # given: synopsis

    my $error = $example->error;

    # "..."

  =cut

  $test->for('error', 'error_on_unknown');

  $test->for('example', 1, 'error_on_unknown', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

The C<error $name> block should contain a description of the error the package
may raise, and can include an C<example-$number $name> block to ensure the
error is raised and caught.

=cut

=feature spec-example

  =example-1 name

    # given: synopsis

    my $name = $example->name;

    # "..."

  =cut

  $test->for('example', 1, 'name', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

The C<example-$number $name> block should contain valid Perl code and return a
value. The block may contain a "magic" comment in the form of C<given:
synopsis> or C<given: example-$number $name> which if present will include the
given code example(s) with the evaluation of the current block.

=cut

=feature spec-feature

  =feature noop

  This package is no particularly useful features.

  =example-1 noop

    # given: synopsis

    my $feature = $example->feature;

    # "..."

  =cut

  $test->for('feature');

  $test->for('example', 1, 'noop', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

The C<feature $name> block should contain a description of the feature(s) the
package enables, and can include an C<example-$number $name> block to ensure
the feature described works as expected.

=cut

=feature spec-function

  =function eg

  The eg function returns a new instance of Example.

  =example-1 eg

    # given: synopsis

    my $example = eg();

    # "..."

  =cut

  $test->for('function', 'eg');

  $test->for('example', 1, 'eg', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

Describing a function requires at least three blocks, i.e. C<function $name>,
C<signature $name>, and C<example-$number $name>. The C<function> block should
contain a description of the function and its purpose. The C<signature> block
should contain a routine signature in the form of C<$signature : $return_type>,
where C<$signature> is a valid typed signature and C<$return_type> is any valid
L<Venus::Check> expression. The C<example-$number> block is a repeatable block,
and at least one block must exist when documenting an attribute. The
C<example-$number> block should contain valid Perl code and return a value. The
block may contain a "magic" comment in the form of C<given: synopsis> or
C<given: example-$number $name> which if present will include the given code
example(s) with the evaluation of the current block. Each attribute is tested
and must be recognized to exist.

=cut

=feature spec-includes

  =includes

  function: eg

  method: prepare
  method: execute

  =cut

  $test->for('includes');

The C<includes> block should contain a list of C<function>, C<method>, and/or
C<routine> names in the format of C<$type: $name>. Empty (or commented out)
lines are ignored. Each function, method, and/or routine is tested to be
documented properly, i.e. has the requisite counterparts (e.g. signature and at
least one example block). Also, the package must recognize that each exists.

=cut

=feature spec-inherits

  =inherits

  Venus::Core::Class

  =cut

  $test->for('inherits');

The C<inherits> block should contain a list of parent packages. These packages
are tested for loadability.

=cut

=feature spec-integrates

  =integrates

  Venus::Role::Catchable
  Venus::Role::Throwable

  =cut

  $test->for('integrates');

The C<integrates> block should contain a list of packages that are involved in
the behavior of the main package. These packages are not automatically tested.

=cut

=feature spec-layout

  =layout

  encoding
  name
  synopsis
  description
  attributes: attribute
  authors
  license

  =cut

  $test->for('layout');

The C<layout> block should contain a list blocks to render using L</render>, in
the order they should be rendered.

=cut

=feature spec-libraries

  =libraries

  Venus::Check

  =cut

  $test->for('libraries');

The C<libraries> block should contain a list of packages, each describing how
particular type names used within function and method signatures will be
validated. These packages are tested for loadability.

=cut

=feature spec-license

  =license

  No license granted.

  =cut

  $test->for('license');

The C<license> block should contain a link and/or description of the license
governing the package.

=cut

=feature spec-message

  =message accept

  The accept message represents acceptance.

  =example-1 accept

    # given: synopsis

    my $accept = $example->accept;

    # "..."

  =cut

  $test->for('message', 'accept');

  $test->for('example', 1, 'accept', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

Describing a message requires at least three blocks, i.e. C<message $name>,
C<signature $name>, and C<example-$number $name>. The C<message> block should
contain a description of the message and its purpose. The C<signature> block
should contain a routine signature in the form of C<$signature : $return_type>,
where C<$signature> is a valid typed signature and C<$return_type> is any valid
L<Venus::Check> expression. The C<example-$number> block is a repeatable block,
and at least one block must exist when documenting an attribute. The
C<example-$number> block should contain valid Perl code and return a value. The
block may contain a "magic" comment in the form of C<given: synopsis> or
C<given: example-$number $name> which if present will include the given code
example(s) with the evaluation of the current block. Each attribute is tested
and must be recognized to exist.

=cut

=feature spec-metadata

  =metadata prepare

  {since => "1.2.3"}

  =cut

  $test->for('metadata', 'prepare');

The C<metadata $name> block should contain a stringified hashref containing Perl data
structures used in the rendering of the package's documentation.

=cut

=feature spec-method

  =method prepare

  The prepare method prepares for execution.

  =example-1 prepare

    # given: synopsis

    my $prepare = $example->prepare;

    # "..."

  =cut

  $test->for('method', 'prepare');

  $test->for('example', 1, 'prepare', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

Describing a method requires at least three blocks, i.e. C<method $name>,
C<signature $name>, and C<example-$number $name>. The C<method> block should
contain a description of the method and its purpose. The C<signature> block
should contain a routine signature in the form of C<$signature : $return_type>,
where C<$signature> is a valid typed signature and C<$return_type> is any valid
L<Venus::Check> expression. The C<example-$number> block is a repeatable block,
and at least one block must exist when documenting an attribute. The
C<example-$number> block should contain valid Perl code and return a value. The
block may contain a "magic" comment in the form of C<given: synopsis> or
C<given: example-$number $name> which if present will include the given code
example(s) with the evaluation of the current block. Each attribute is tested
and must be recognized to exist.

=cut

=feature spec-name

  =name

  Example

  =cut

  $test->for('name');

The C<name> block should contain the package name. This is tested for
loadability.

=cut

=feature spec-operator

  =operator ("")

  This package overloads the C<""> operator.

  =example-1 ("")

    # given: synopsis

    my $string = "$example";

    # "..."

  =cut

  $test->for('operator', '("")');

  $test->for('example', 1, '("")', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

The C<operator $name> block should contain a description of the overloaded
operation the package performs, and can include an C<example-$number $name>
block to ensure the operation is functioning properly.

=cut

=feature spec-partials

  =partials

  t/path/to/other.t: present: authors
  t/path/to/other.t: present: license

  =cut

  $test->for('partials');

The C<partials> block should contain references to other marked-up test files
in the form of C<$file: $method: $section>, which will call the C<$method> on a
L<Venus::Test> instance for the C<$file> and include the results in-place as
part of the rendering of the current file.

=cut

=feature spec-project

  =project

  https://github.com/awncorp/example

  =cut

  $test->for('project');

The C<project> block should contain a description and/or links for the
package's project.

=cut

=feature spec-signature

  =signature prepare

    prepare() (boolean)

  =cut

  $test->for('signature', 'prepare');

The C<signature $name> block should contain a routine signature in the form of
C<$signature : $return_type>, where C<$signature> is a valid typed signature
and C<$return_type> is any valid L<Venus::Check> expression.

=cut

=feature spec-synopsis

  =synopsis

    use Example;

    my $example = Example->new;

    # bless(..., "Example")

  =cut

  $test->for('synopsis', sub {
    my ($tryable) = @_;
    $tryable->result;
  });

The C<synopsis> block should contain the normative usage of the package. This
is tested for existence. This block should be written in a way that allows it
to be evaled successfully and should return a value.

=cut

=feature spec-tagline

  =tagline

  Example Class

  =cut

  $test->for('tagline');

The C<tagline> block should contain a 2-5 word description of the package,
which will be prepended to the name as a full description of the package.

=cut

=feature spec-version

  =version

  1.2.3

  =cut

  $test->for('version');

The C<version> block should contain a valid version number for the package.

=cut

=feature test-for

  # ...

  $test->for('name');

This framework provides a set of automated subtests based on the package
specification, but not everything can be automated so it also provides you with
powerful hooks into the framework for manual testing.

  # ...

  $test->for('synopsis', sub {
    my ($tryable) = @_;

    my $result = $tryable->result;

    # must return truthy to continue
    $result;
  });

The code examples documented can be automatically evaluated (evaled) and
returned using a callback you provide for further testing. Because the code
examples are returned as L<Venus::Try> objects this makes capturing and testing
exceptions simple, for example:

  # ...

  $test->for('synopsis', sub {
    my ($tryable) = @_;

    # catch exception thrown by the synopsis
    $tryable->catch('Path::Find::Error', sub {
      return $_[0];
    });

    # test the exception
    my $result = $tryable->result;
    ok $result->isa('Path::Find::Error'), 'exception caught';

    # must return truthy to continue
    $result;
  });

Additionally, another manual testing hook (with some automation) is the
C<example> method. This hook evaluates (evals) a given example and returns the
result as a L<Venus::Try> object. The first argument is the example ID (or
number), for example:

  # ...

  $test->for('example', 1, 'children', sub {
    my ($tryable) = @_;

    my $result = $tryable->result;

    # must return truthy to continue
    $result;
  });

Finally, the lesser-used but useful manual testing hook is the C<feature>
method. This hook evaluates (evals) a documented feature and returns the result
as a L<Venus::Try> object, for example:

  # ...

  $test->for('feature', 'export-path-make', sub {
    my ($tryable) = @_;

    ok my $result = $tryable->result, 'result ok';

    # must return truthy to continue
    $result;
  });

The test automation and documentation generation enabled through this framework
makes it easy to maintain source/test/documentation parity. This also increases
reusability and reduces the need for complicated state and test setup.

=cut

=error error_on_abstract

This package may raise an error_on_abstract exception.

=cut

$test->for('error', 'error_on_abstract');

=example-1 error_on_abstract

  # given: synopsis;

  my $input = {
    throw => 'error_on_abstract',
  };

  my $error = $test->catch('error', $input);

  # my $name = $error->name;

  # "on_abstract"

  # my $message = $error->render;

  # "Test file \"t/Venus_Test.t\" missing abstract section"

  # my $file = $error->stash('file');

  # "t/Venus_Test.t"

=cut

$test->for('example', 1, 'error_on_abstract', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_abstract";
  my $message = $result->render;
  like $message, qr/Test file .*Venus_Test.* abstract section/;
  my $file = $result->stash('file');
  like $file, qr/Venus_Test/;

  $result
});

=error error_on_description

This package may raise an error_on_description exception.

=cut

$test->for('error', 'error_on_description');

=example-1 error_on_description

  # given: synopsis;

  my $input = {
    throw => 'error_on_description',
  };

  my $error = $test->catch('error', $input);

  # my $name = $error->name;

  # "on_description"

  # my $message = $error->render;

  # "Test file \"t/Venus_Test.t\" missing description section"

  # my $file = $error->stash('file');

  # "t/Venus_Test.t"

=cut

$test->for('example', 1, 'error_on_description', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_description";
  my $message = $result->render;
  like $message, qr/Test file .*Venus_Test.* description section/;
  my $file = $result->stash('file');
  like $file, qr/Venus_Test/;

  $result
});

=error error_on_name

This package may raise an error_on_name exception.

=cut

$test->for('error', 'error_on_name');

=example-1 error_on_name

  # given: synopsis;

  my $input = {
    throw => 'error_on_name',
  };

  my $error = $test->catch('error', $input);

  # my $name = $error->name;

  # "on_name"

  # my $message = $error->render;

  # "Test file \"t/Venus_Test.t\" missing name section"

  # my $file = $error->stash('file');

  # "t/Venus_Test.t"

=cut

$test->for('example', 1, 'error_on_name', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_name";
  my $message = $result->render;
  like $message, qr/Test file .*Venus_Test.* name section/;
  my $file = $result->stash('file');
  like $file, qr/Venus_Test/;

  $result
});

=error error_on_synopsis

This package may raise an error_on_synopsis exception.

=cut

$test->for('error', 'error_on_synopsis');

=example-1 error_on_synopsis

  # given: synopsis;

  my $input = {
    throw => 'error_on_synopsis',
  };

  my $error = $test->catch('error', $input);

  # my $name = $error->name;

  # "on_synopsis"

  # my $message = $error->render;

  # "Test file \"t/Venus_Test.t\" missing synopsis section"

  # my $file = $error->stash('file');

  # "t/Venus_Test.t"

=cut

$test->for('example', 1, 'error_on_synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_synopsis";
  my $message = $result->render;
  like $message, qr/Test file .*Venus_Test.* synopsis section/;
  my $file = $result->stash('file');
  like $file, qr/Venus_Test/;

  $result
});

=error error_on_tagline

This package may raise an error_on_tagline exception.

=cut

$test->for('error', 'error_on_tagline');

=example-1 error_on_tagline

  # given: synopsis;

  my $input = {
    throw => 'error_on_tagline',
  };

  my $error = $test->catch('error', $input);

  # my $name = $error->name;

  # "on_tagline"

  # my $message = $error->render;

  # "Test file \"t/Venus_Test.t\" missing tagline section"

  # my $file = $error->stash('file');

  # "t/Venus_Test.t"

=cut

$test->for('example', 1, 'error_on_tagline', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  isa_ok $result, 'Venus::Error';
  my $name = $result->name;
  is $name, "on_tagline";
  my $message = $result->render;
  like $message, qr/Test file .*Venus_Test.* tagline section/;
  my $file = $result->stash('file');
  like $file, qr/Venus_Test/;

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Test.pod') if $ENV{VENUS_RENDER};

$test->done;
