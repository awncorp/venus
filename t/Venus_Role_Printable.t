package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Role::Printable

=cut

$test->for('name');

=tagline

Printable Role

=cut

$test->for('tagline');

=abstract

Printable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: print
method: print_json
method: print_pretty
method: print_string
method: print_yaml
method: say
method: say_json
method: say_pretty
method: say_string
method: say_yaml

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Dumpable';
  with 'Venus::Role::Printable';

  attr 'test';

  sub execute {
    return [@_];
  }

  sub printer {
    return [@_];
  }

  package main;

  my $example = Example->new(test => 123);

  # $example->say;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Printable');

  $result
});

=description

This package provides a mechanism for outputting (printing) objects or the
return value of a dispatched method call to STDOUT.

=cut

$test->for('description');

=method print

The print method prints a stringified representation of the underlying data.

=signature print

  print(Any @data) (Any)

=metadata print

{
  since => '0.01',
}

=example-1 print

  package main;

  my $example = Example->new(test => 123);

  my $print = $example->print;

  # bless({test => 123}, 'Example')

  # 1

=cut

$test->for('example', 1, 'print', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=example-2 print

  package main;

  my $example = Example->new(test => 123);

  my $print = $example->print('execute', 1, 2, 3);

  # [bless({test => 123}, 'Example'),1,2,3]

  # 1

=cut

$test->for('example', 2, 'print', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method print_json

The print_json method prints a JSON representation of the underlying data. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method.

=signature print_json

  print_json(Str | CodeRef $method, Any @args) (Any)

=metadata print_json

{
  since => '2.91',
}

=example-1 print_json

  package main;

  my $example = Example->new(test => 123);

  my $print_json = $example->print_json;

  # "{\"test\": 123}"

=cut

$test->for('example', 1, 'print_json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=example-2 print_json

  package main;

  my $example = Example->new(test => 123);

  my $print_json = $example->print_json('execute');

  # "[{\"test\": 123}]"

=cut

$test->for('example', 2, 'print_json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method print_pretty

The print_pretty method prints a stringified human-readable representation of
the underlying data.

=signature print_pretty

  print_pretty(Any @data) (Any)

=metadata print_pretty

{
  since => '0.01',
}

=example-1 print_pretty

  package main;

  my $example = Example->new(test => 123);

  my $print_pretty = $example->print_pretty;

  # bless({ test => 123 }, 'Example')

  # 1

=cut

$test->for('example', 1, 'print_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=example-2 print_pretty

  package main;

  my $example = Example->new(test => 123);

  my $print_pretty = $example->print_pretty('execute', 1, 2, 3);

  # [
  #   bless({ test => 123 }, 'Example'),
  #   1,
  #   2,
  #   3
  # ]

  # 1

=cut

$test->for('example', 2, 'print_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method print_string

The print_string method prints a string representation of the underlying data
without using a dump. This method supports dispatching, i.e. providing a
method name and arguments whose return value will be acted on by this method.

=signature print_string

  print_string(Str | CodeRef $method, Any @args) (Any)

=metadata print_string

{
  since => '0.09',
}

=example-1 print_string

  package main;

  my $example = Example->new(test => 123);

  my $print_string = $example->print_string;

  # 'Example'

  # 1

=cut

$test->for('example', 1, 'print_string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method print_yaml

The print_yaml method prints a YAML representation of the underlying data. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method.

=signature print_yaml

  print_yaml(Str | CodeRef $method, Any @args) (Any)

=metadata print_yaml

{
  since => '2.91',
}

=example-1 print_yaml

  package main;

  my $example = Example->new(test => 123);

  my $print_yaml = $example->print_yaml;

  # "---\ntest: 123"

=cut

$test->for('example', 1, 'print_yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=example-2 print_yaml

  package main;

  my $example = Example->new(test => 123);

  my $print_yaml = $example->print_yaml('execute');

  # "---\n- test: 123"

=cut

$test->for('example', 2, 'print_yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 2;

  $result
});

=method say

The say method prints a stringified representation of the underlying data, with
a trailing newline.

=signature say

  say(Any @data) (Any)

=metadata say

{
  since => '0.01',
}

=example-1 say

  package main;

  my $example = Example->new(test => 123);

  my $say = $example->say;

  # bless({test => 123}, 'Example')\n

  # 1

=cut

$test->for('example', 1, 'say', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=example-2 say

  package main;

  my $example = Example->new(test => 123);

  my $say = $example->say;

  # [bless({test => 123}, 'Example'),1,2,3]\n

  # 1

=cut

$test->for('example', 2, 'say', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=method say_json

The say_json method prints a JSON representation of the underlying data. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method, with a trailing newline.

=signature say_json

  say_json(Str | CodeRef $method, Any @args) (Any)

=metadata say_json

{
  since => '2.91',
}

=example-1 say_json

  package main;

  my $example = Example->new(test => 123);

  my $say_json = $example->say_json;

  # "{\"test\": 123}\n"

=cut

$test->for('example', 1, 'say_json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=example-2 say_json

  package main;

  my $example = Example->new(test => 123);

  my $say_json = $example->say_json('execute');

  # "[{\"test\": 123}]\n"

=cut

$test->for('example', 2, 'say_json', sub {
  if (require Venus::Json && not Venus::Json->package) {
    plan skip_all => 'No suitable JSON library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=method say_pretty

The say_pretty method prints a stringified human-readable representation of the
underlying data, with a trailing newline.

=signature say_pretty

  say_pretty(Any @data) (Any)

=metadata say_pretty

{
  since => '0.01',
}

=example-1 say_pretty

  package main;

  my $example = Example->new(test => 123);

  my $say_pretty = $example->say_pretty;

  # bless({ test => 123 }, 'Example')\n

  # 1

=cut

$test->for('example', 1, 'say_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=example-2 say_pretty

  package main;

  my $example = Example->new(test => 123);

  my $say_pretty = $example->say_pretty;

  # [
  #   bless({ test => 123 }, 'Example'),
  #   1,
  #   2,
  #   3
  # ]\n

  # 1

=cut

$test->for('example', 2, 'say_pretty', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=method say_string

The say_string method prints a string representation of the underlying data
without using a dump, with a trailing newline. This method supports
dispatching, i.e. providing a method name and arguments whose return value will
be acted on by this method.

=signature say_string

  say_string(Str | CodeRef $method, Any @args) (Any)

=metadata say_string

{
  since => '0.09',
}

=example-1 say_string

  package main;

  my $example = Example->new(test => 123);

  my $say_string = $example->say_string;

  # "Example\n"

  # 1

=cut

$test->for('example', 1, 'say_string', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=method say_yaml

The say_yaml method prints a YAML representation of the underlying data. This
method supports dispatching, i.e. providing a method name and arguments whose
return value will be acted on by this method, with a trailing newline.

=signature say_yaml

  say_yaml(Str | CodeRef $method, Any @args) (Any)

=metadata say_yaml

{
  since => '2.91',
}

=example-1 say_yaml

  package main;

  my $example = Example->new(test => 123);

  my $say_yaml = $example->say_yaml;

  # "---\ntest: 123\n"

=cut

$test->for('example', 1, 'say_yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=example-2 say_yaml

  package main;

  my $example = Example->new(test => 123);

  my $say_yaml = $example->say_yaml('execute');

  # "---\n- test: 123\n"

=cut

$test->for('example', 2, 'say_yaml', sub {
  if (require Venus::Yaml && not Venus::Yaml->package) {
    plan skip_all => 'No suitable YAML library found';
  }
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok @$result == 3;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Printable.pod') if $ENV{RENDER};

ok 1 and done_testing;