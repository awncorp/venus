package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Config

=cut

$test->for('name');

=tagline

Config Class

=cut

$test->for('tagline');

=abstract

Config Class for Perl 5

=cut

$test->for('abstract');

=includes

method: edit_file
method: read_file
method: read_json
method: read_json_file
method: read_perl
method: read_perl_file
method: read_yaml
method: read_yaml_file
method: write_file
method: write_json
method: write_json_file
method: write_perl
method: write_perl_file
method: write_yaml
method: write_yaml_file

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Config;

  my $config = Venus::Config->new;

  # $config = $config->read_file('app.pl');

  # "..."

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');

  $result
});

=description

This package provides methods for loading Perl, YAML, and JSON configuration
files, and fetching configuration information.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable
Venus::Role::Valuable

=cut

$test->for('integrates');

=method edit_file

The edit_file method does an in-place edit, i.e. it loads a Perl, YAML, or JSON
configuration file, passes the decoded data to the method or callback provided,
and writes the results of the method or callback to the file.

=signature edit_file

  edit_file(string $file, string | coderef $code) (Venus::Config)

=metadata edit_file

{
  since => '3.10',
}

=cut

=example-1 edit_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->edit_file('t/conf/edit.perl', sub {
    my ($self, $data) = @_;

    $data->{edited} = 1;

    return $data;
  });

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'edit_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  ok $result->value;
  my $data = {name => 'test', edited => 1};
  is_deeply $result->value, $data;
  my $read = Venus::Config->read_file('t/conf/edit.perl')->value;
  is_deeply $read, $data;
  Venus::Config->edit_file('t/conf/edit.perl', sub {
    my ($self, $data) = @_;
    delete $data->{edited};
    return $data;
  });

  $result
});

=method read_file

The read_file method load a Perl, YAML, or JSON configuration file, based on
the file extension, and returns a new L<Venus::Config> object.

=signature read_file

  read_file(string $path) (Venus::Config)

=metadata read_file

{
  since => '2.91',
}

=example-1 read_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->read_file('t/conf/read.perl');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  ok $result->value;
  ok exists $result->value->{'$metadata'};
  ok exists $result->value->{'$services'};

  $result
});

=example-2 read_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->read_file('t/conf/read.json');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 2, 'read_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    ok exists $result->value->{'$metadata'};
    ok exists $result->value->{'$services'};
  }

  $result
});

=example-3 read_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->read_file('t/conf/read.yaml');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 3, 'read_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    ok exists $result->value->{'$metadata'};
    ok exists $result->value->{'$services'};
  }

  $result
});

=method read_json

The read_json method returns a new L<Venus::Config> object based on the JSON
string provided.

=signature read_json

  read_json(string $data) (Venus::Config)

=metadata read_json

{
  since => '2.91',
}

=example-1 read_json

  # given: synopsis

  package main;

  $config = $config->read_json(q(
  {
    "$metadata": {
      "tmplog": "/tmp/log"
    },
    "$services": {
      "log": { "package": "Venus/Path", "argument": { "$metadata": "tmplog" } }
    }
  }
  ));

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_json', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $value = $result->value;
    ok exists $value->{'$services'};
    ok exists $value->{'$metadata'};
  }

  $result
});

=method read_json_file

The read_json_file method uses L<Venus::Path> to return a new L<Venus::Config>
object based on the file provided.

=signature read_json_file

  read_json_file(string $file) (Venus::Config)

=metadata read_json_file

{
  since => '2.91',
}

=example-1 read_json_file

  # given: synopsis

  package main;

  $config = $config->read_json_file('t/conf/read.json');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_json_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $value = $result->value;
    ok exists $value->{'$services'};
    ok exists $value->{'$metadata'};
  }

  $result
});

=method read_perl

The read_perl method returns a new L<Venus::Config> object based on the Perl
string provided.

=signature read_perl

  read_perl(string $data) (Venus::Config)

=metadata read_perl

{
  since => '2.91',
}

=example-1 read_perl

  # given: synopsis

  package main;

  $config = $config->read_perl(q(
  {
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  }
  ));

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_perl', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $value = $result->value;
  ok exists $value->{'$services'};
  ok exists $value->{'$metadata'};

  $result
});

=method read_perl_file

The read_perl_file method uses L<Venus::Path> to return a new L<Venus::Config>
object based on the file provided.

=signature read_perl_file

  read_perl_file(string $file) (Venus::Config)

=metadata read_perl_file

{
  since => '2.91',
}

=example-1 read_perl_file

  # given: synopsis

  package main;

  $config = $config->read_perl_file('t/conf/read.perl');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_perl_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  ok $result->isa('Venus::Config');
  my $value = $result->value;
  ok exists $value->{'$services'};
  ok exists $value->{'$metadata'};

  $result
});

=method read_yaml

The read_yaml method returns a new L<Venus::Config> object based on the YAML
string provided.

=signature read_yaml

  read_yaml(string $data) (Venus::Config)

=metadata read_yaml

{
  since => '2.91',
}

=example-1 read_yaml

  # given: synopsis

  package main;

  $config = $config->read_yaml(q(
  '$metadata':
    tmplog: /tmp/log
  '$services':
    log:
      package: "Venus/Path"
      argument:
        '$metadata': tmplog
  ));

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_yaml', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $value = $result->value;
    ok exists $value->{'$services'};
    ok exists $value->{'$metadata'};
  }

  $result
});

=method read_yaml_file

The read_yaml_file method uses L<Venus::Path> to return a new L<Venus::Config>
object based on the YAML string provided.

=signature read_yaml_file

  read_yaml_file(string $file) (Venus::Config)

=metadata read_yaml_file

{
  since => '2.91',
}

=example-1 read_yaml_file

  # given: synopsis

  package main;

  $config = $config->read_yaml_file('t/conf/read.yaml');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'read_yaml_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $value = $result->value;
    ok exists $value->{'$services'};
    ok exists $value->{'$metadata'};
  }

  $result
});

=method write_file

The write_file method saves a Perl, YAML, or JSON configuration file, based on
the file extension, and returns a new L<Venus::Config> object.

=signature write_file

  write_file(string $path) (Venus::Config)

=metadata write_file

{
  since => '2.91',
}

=example-1 write_file

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus/Path", argument => { value => "." } }
    }
  });

  $config = $config->write_file('t/conf/write.perl');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'write_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  ok $result->value;
  $result = $result->read_file('t/conf/write.perl');
  ok exists $result->value->{'$services'};

  $result
});

=example-2 write_file

  # given: synopsis

  my $value = $config->value({
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  });

  $config = $config->write_file('t/conf/write.json');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 2, 'write_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    $result = $result->read_file('t/conf/write.json');
    ok exists $result->value->{'$metadata'};
    ok exists $result->value->{'$services'};
  }

  $result
});

=example-3 write_file

  # given: synopsis

  my $value = $config->value({
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  });

  $config = $config->write_file('t/conf/write.yaml');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 3, 'write_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    $result = $result->read_file('t/conf/write.yaml');
    ok exists $result->value->{'$metadata'};
    ok exists $result->value->{'$services'};
  }

  $result
});

=method write_json

The write_json method returns a JSON encoded string based on the L</value> held
by the underlying L<Venus::Config> object.

=signature write_json

  write_json() (string)

=metadata write_json

{
  since => '2.91',
}

=example-1 write_json

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus::Path" },
    },
  });

  my $json = $config->write_json;

  # '{ "$services":{ "log":{ "package":"Venus::Path" } } }'

=cut

$test->for('example', 1, 'write_json', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    $result = $tryable->result;
    $result =~ s/[\n\s]//g;
    is $result, '{"$services":{"log":{"package":"Venus::Path"}}}';
  }

  $result
});

=method write_json_file

The write_json_file method saves a JSON configuration file and returns a new
L<Venus::Config> object.

=signature write_json_file

  write_json_file(string $path) (Venus::Config)

=metadata write_json_file

{
  since => '2.91',
}

=example-1 write_json_file

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus/Path", argument => { value => "." } }
    }
  });

  $config = $config->write_json_file('t/conf/write.json');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'write_json_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    $result = $result->read_file('t/conf/write.json');
    ok exists $result->value->{'$services'};
  }

  $result
});

=method write_perl

The write_perl method returns a FILE encoded string based on the L</value> held
by the underlying L<Venus::Config> object.

=signature write_perl

  write_perl() (string)

=metadata write_perl

{
  since => '2.91',
}

=example-1 write_perl

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus::Path" },
    },
  });

  my $perl = $config->write_perl;

  # '{ "\$services" => { log => { package => "Venus::Path" } } }'

=cut

$test->for('example', 1, 'write_perl', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  $result =~ s/[\n\s]//g;
  is $result, '{"\$services"=>{log=>{package=>"Venus::Path"}}}';

  $result
});

=method write_perl_file

The write_perl_file method saves a Perl configuration file and returns a new
L<Venus::Config> object.

=signature write_perl_file

  write_perl_file(string $path) (Venus::Config)

=metadata write_perl_file

{
  since => '2.91',
}

=example-1 write_perl_file

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus/Path", argument => { value => "." } }
    }
  });

  $config = $config->write_perl_file('t/conf/write.perl');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'write_perl_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  ok $result->value;
  $result = $result->read_file('t/conf/write.perl');
  ok exists $result->value->{'$services'};

  $result
});

=method write_yaml

The write_yaml method returns a FILE encoded string based on the L</value> held
by the underlying L<Venus::Config> object.

=signature write_yaml

  write_yaml() (string)

=metadata write_yaml

{
  since => '2.91',
}

=example-1 write_yaml

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus::Path" },
    },
  });

  my $yaml = $config->write_yaml;

  # '---\n$services:\n\s\slog:\n\s\s\s\spackage:\sVenus::Path'

=cut

$test->for('example', 1, 'write_yaml', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    $result = $tryable->result;
    $result =~ s/[\n\s]//g;
    is $result, '---$services:log:package:Venus::Path';
  }

  $result
});

=method write_yaml_file

The write_yaml_file method saves a YAML configuration file and returns a new
L<Venus::Config> object.

=signature write_yaml_file

  write_yaml_file(string $path) (Venus::Config)

=metadata write_yaml_file

{
  since => '2.91',
}

=example-1 write_yaml_file

  # given: synopsis

  my $value = $config->value({
    '$services' => {
      log => { package => "Venus/Path", argument => { value => "." } }
    }
  });

  $config = $config->write_yaml_file('t/conf/write.yaml');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'write_yaml_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found' if $ENV{VENUS_DEBUG};
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    $result = $result->read_file('t/conf/write.yaml');
    ok exists $result->value->{'$services'};
  }

  $result
});

=partials

t/Venus.t: present: authors
t/Venus.t: present: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Config.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
