package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Test

=cut

$test->for('name');

=tagline

Test Automation

=cut

$test->for('tagline');

=abstract

Test Automation for Perl 5

=cut

$test->for('abstract');

=includes

function: test
method: data
method: for
method: pdml
method: render
method: text

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Test;

  my $test = test 't/Venus_Test.t';

  # $test->for('name');

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
Venus::Role::Catchable
Venus::Role::Throwable
Venus::Role::Tryable

=cut

$test->for('integrates');

=function test

The test function is exported automatically and returns a L<Venus::Test> object
for the test file given.

=signature test

  test(Str $file) (Test)

=metadata test

{
  since => '0.09',
}

=example-1 test

  package main;

  use Venus::Test;

  my $test = test 't/Venus_Test.t';

  # bless( { ..., 'value' => 't/Venus_Test.t' }, 'Venus::Test' )

=cut

$test->for('example', 1, 'test', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->okay($result->isa('Venus::Test'));

  $result
});

=method data

The data method attempts to find and return the POD content based on the name
provided. If the content cannot be found an exception is raised.

=signature data

  data(Str $name, Any @args) (Str)

=metadata data

{
  since => '0.09',
}

=example-1 data

  # given: synopsis

  my $data = $test->data('name');

  # Venus::Test

=cut

$test->for('example', 1, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->same($result, 'Venus::Test');

  $result
});

=example-2 data

  # given: synopsis

  my $data = $test->data('unknown');

  # Exception!

=cut

$test->for('example', 2, 'data', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  $test->pass($result->isa('Venus::Test::Error'));

  $result
});

=method for

The for method attempts to find the POD content based on the name provided and
executes the corresponding predefined test, optionally accepting a callback
which, if provided, will be passes a L<Venus::Try> object containing the
POD-driven test. The callback, if provided, must always return a true value.
B<Note:> All automated tests disable the I<"redefine"> class of warnings to
prevent warnings when redeclaring packages in examples.

=signature for

  for(Str $name | CodeRef $code, Any @args) Any

=metadata for

{
  since => '0.09',
}

=example-1 for

  # given: synopsis

  my $data = $test->for('name');

  # Venus::Test

=cut

=example-2 for

  # given: synopsis

  my $data = $test->for('synosis');

  # true

=cut

=example-3 for

  # given: synopsis

  my $data = $test->for('example', 1, 'data', sub {
    my ($tryable) = @_;
    my $result = $tryable->result;
    ok length($result) > 1;

    $result
  });

  # Venus::Test

=cut

$test->for('example', 3, 'for', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->same($result, 'Venus::Test');

  $result
});

=method pdml

The pdml method attempts to find the POD content based on the name provided and
return a POD string for use in documentation.

=signature pdml

  pdml(Str $name | CodeRef $code, Any @args) Str

=metadata pdml

{
  since => '0.09',
}

=example-1 pdml

  # given: synopsis

  my $pdml = $test->pdml('name');

  # =head1 NAME
  #
  # Venus::Test - Test Automation
  #
  # =cut

=cut

$test->for('example', 1, 'pdml', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->like($result, '=head1 NAME');
  $test->like($result, 'Venus::Test - Test Automation');
  $test->like($result, '=cut');

  $result
});

=example-2 pdml

  # given: synopsis

  my $pdml = $test->pdml('synopsis');

  # =head1 SYNOPSIS
  #
  # package main;
  #
  # use Venus::Test;
  #
  # my $test = test 't/Venus_Test.t';
  #
  # # $test->for('name');
  #
  # =cut

=cut

$test->for('example', 2, 'pdml', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->like($result, '=head1 SYNOPSIS');
  $test->like($result, 'package main;');
  $test->like($result, 'use Venus::Test;');
  $test->like($result, 'my \$test = test \'t/Venus_Test.t\';');
  $test->like($result, '# \$test\->for\(\'name\'\);');
  $test->like($result, '=cut');

  $result
});

=example-3 pdml

  # given: synopsis

  my $pdml = $test->pdml('example', 1, 'data');

  # =over 4
  #
  # =item data example 1
  #
  #   # given: synopsis
  #
  #   my $data = $test->data(\'name\');
  #
  #   # Venus::Test
  #
  # =back

=cut

$test->for('example', 3, 'pdml', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->like($result, '=over 4');
  $test->like($result, '=item data example 1');
  $test->like($result, '# given: synopsis');
  $test->like($result, 'my \$data = \$test\->data\(\'name\'\);');
  $test->like($result, '# Venus::Test');
  $test->like($result, '=back');

  $result
});

=method render

The render method returns a string representation of a valid POD document.

=signature render

  render(Str $file) Path

=metadata render

{
  since => '0.09',
}

=example-1 render

  # given: synopsis

  my $path = $test->render('t/Test_Venus.pod');

  # =over 4
  #
  # =item data example 1
  #
  #   # given: synopsis
  #
  #   my $data = $test->data(\'name\');
  #
  #   # Venus::Test
  #
  # =back

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->pass($result->isa('Venus::Path'));
  $result->unlink;

  $result
});

=method text

The text method attempts to find and return the POD content based on the name
provided. If the content cannot be found an empty string is returned. If the
POD block is not recognized, an exception is raised.

=signature text

  text(Str $name, Any @args) (Str)

=metadata text

{
  since => '0.09',
}

=example-1 text

  # given: synopsis

  my $text = $test->text('name');

  # Venus::Test

=cut

$test->for('example', 1, 'text', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->same($result, 'Venus::Test');

  $result
});

=example-2 text

  # given: synopsis

  my $text = $test->text('includes');

  # function: test
  # method: data
  # method: for
  # method: pdml
  # method: render
  # method: text

=cut

$test->for('example', 2, 'text', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  $test->like($result, 'function: test');
  $test->like($result, 'method: data');
  $test->like($result, 'method: for');
  $test->like($result, 'method: pdml');
  $test->like($result, 'method: render');
  $test->like($result, 'method: text');

  $result
});

=example-3 text

  # given: synopsis

  my $text = $test->text('attributes');

  # ''

=cut

$test->for('example', 3, 'text', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;

  $test->fail($result);

  !$result
});

=example-4 text

  # given: synopsis

  my $text = $test->text('unknown');

  # Exception!

=cut

$test->for('example', 4, 'text', sub {
  my ($tryable) = @_;
  my $result = $tryable->error->result;
  $test->pass($result->isa('Venus::Test::Error'));

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Test.pod') if $ENV{RENDER};

$test->done;
