package Test::Venus;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Data';

with 'Venus::Role::Buildable';

use Test::More;

use Exporter 'import';

our @EXPORT = 'test';

# EXPORTS

sub test {
  __PACKAGE__->new($_[0]);
}

# MODIFIERS

around build_self => sub {
  my ($orig, $self, $data) = @_;

  $self->$orig($data);

  for my $item (qw(name abstract tagline synopsis description)) {
    @{$self->find(undef, $item)} || $self->throw->error({
      message => "Test missing pod section =$item",
    });
  }

  return $self;
};

# METHODS

sub data {
  my ($self, $name, @args) = @_;

  my $method = "data_for_$name";

  wantarray ? ($self->$method(@args)) : $self->$method(@args);
}

sub data_for_abstract {
  my ($self) = @_;

  my $data = $self->find(undef, 'abstract');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_attributes {
  my ($self) = @_;

  my $data = $self->find(undef, 'attributes');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_authors {
  my ($self) = @_;

  my $data = $self->find(undef, 'authors');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_description {
  my ($self) = @_;

  my $data = $self->find(undef, 'description');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_example {
  my ($self, $number, $name) = @_;

  my $data = $self->search({
    list => "example-$number",
    name => quotemeta($name),
  });

  $self->throw->error if !@$data;

  my $example = join "\n\n", @{$data->[0]{data}};

  my @includes;

  if ($example =~ /# given: synopsis/) {
    push @includes, $self->data('synopsis');
  }

  if (my ($number, $name) = $example =~ /# given: example-(\d+) (\w+)/) {
    push @includes, $self->data('example', $number, $name);
  }

  $example =~ s/.*# given: .*//g;

  return join "\n\n", @includes, $example;
}

sub data_for_feature {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'feature',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_function {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'function',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_includes {
  my ($self) = @_;

  my $data = $self->find(undef, 'includes');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_inherits {
  my ($self) = @_;

  my $data = $self->find(undef, 'inherits');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_integrates {
  my ($self) = @_;

  my $data = $self->find(undef, 'integrates');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_libraries {
  my ($self) = @_;

  my $data = $self->find(undef, 'libraries');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_license {
  my ($self) = @_;

  my $data = $self->find(undef, 'license');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_metadata {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'metadata',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_method {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'method',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_name {
  my ($self) = @_;

  my $data = $self->find(undef, 'name');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_operator {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'operator',
    name => quotemeta($name),
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_project {
  my ($self) = @_;

  my $data = $self->find(undef, 'project');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_signature {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'signature',
    name => $name,
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_synopsis {
  my ($self) = @_;

  my $data = $self->find(undef, 'synopsis');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_tagline {
  my ($self) = @_;

  my $data = $self->find(undef, 'tagline');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_version {
  my ($self) = @_;

  my $data = $self->find(undef, 'version');

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub default {
  my ($self) = @_;

  return '';
}

sub eval {
  my ($self, $perl) = @_;

  local $@;

  my @result = CORE::eval($perl);

  die $@ if $@;

  return wantarray ? (@result) : $result[0];
}

sub for {
  my ($self, $name, @args) = @_;

  my $result;

  my $method = "test_for_$name";

  subtest(join(' ', $method, grep !ref, @args), sub {
    $result = $self->$method(@args);
  });

  return $result;
}

sub head1 {
  my ($self, $name, @data) = @_;

  return join("\n", "", "=head1 \U$name", "", grep(defined, @data), "", "=cut");
}

sub head2 {
  my ($self, $name, @data) = @_;

  return join("\n", "", "=head2 \L$name", "", grep(defined, @data), "", "=cut");
}

sub item {
  my ($self, $name, $data) = @_;

  return ("=item $name\n", "$data\n");
}

sub link {
  my ($self, @data) = @_;

  return ("L<@{[join('|', @data)]}>");
}

sub over {
  my ($self, @data) = @_;

  return join("\n", "", "=over 4", "", grep(defined, @data), "=back");
}

sub pdml {
  my ($self, $name, @args) = @_;

  my $method = "pdml_for_$name";

  wantarray ? ($self->$method(@args)) : $self->$method(@args);
}

sub pdml_for_abstract {
  my ($self) = @_;

  my $output;

  my $text = $self->text('abstract');

  return $text ? ($self->head1('abstract', $text)) : ();
}

sub pdml_for_attribute {
  my ($self, $name, $is, $pre, $isa, $def) = @_;

  my @output;

  $is = $is eq 'ro' ? 'read-only' : 'read-write';
  $pre = $pre eq 'req' ? 'required' : 'optional';

  push @output, "  $name($isa)\n";
  push @output, "This attribute is $is, accepts C<($isa)> values, ". (
    $def ? "is $pre, and defaults to $def." : "and is $pre."
  );

  return ($self->head2($name, @output));
}

sub pdml_for_attributes {
  my ($self) = @_;

  my @output;

  my $text = $self->text('attributes');

  return () if !$text;

  for my $line (split /\n/, $text) {
    push @output, $self->pdml('attribute', (
      map { split /,\s*/ } split /:\s*/, $line, 2
    ));
  }

  return () if !@output;

  if (@output) {
    unshift @output, $self->head1('attributes',
      "This package has the following attributes:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_authors {
  my ($self) = @_;

  my $output;

  my $text = $self->text('authors');

  return $text ? ($self->head1('authors', $text)) : ();
}

sub pdml_for_description {
  my ($self) = @_;

  my $output;

  my $text = $self->text('description');

  return $text ? ($self->head1('description', $text)) : ();
}

sub pdml_for_example {
  my ($self, $number, $name) = @_;

  my @output;

  my $text = $self->text('example', $number, $name);

  return $text ? ($self->over($self->item("$name example $number", $text))) : ();
}

sub pdml_for_feature {
  my ($self, $name) = @_;

  my @output;

  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('feature', $name);

  return () if !$text;

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->text('example', $i, $name);
  }

  return ($self->over($self->item($name, join "\n\n", $text, @output)));
}

sub pdml_for_features {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'feature'})) {
    push @output, $self->pdml('feature', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('features',
      "This package provides the following features:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_function {
  my ($self, $name) = @_;

  my @output;

  my $metadata = $self->text('metadata', $name);
  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('function', $name);

  return () if !$text;

  push @output, $text;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->pdml('example', $i, $name),
  }

  return ($self->head2($name, @output));
}

sub pdml_for_functions {
  my ($self) = @_;

  my @output;

  my $type = 'function';
  my $text = $self->text('includes');

  for my $name (sort map /:\s*(\w+)$/, grep /^$type/, split /\n/, $text) {
    push @output, $self->pdml($type, $name);
  }

  if (@output) {
    unshift @output, $self->head1('functions',
      "This package provides the following functions:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_include {
  my ($self) = @_;

  my $output;

  my $text = $self->text('include');

  return $output;
}

sub pdml_for_includes {
  my ($self) = @_;

  my $output;

  my $text = $self->text('includes');

  return $output;
}

sub pdml_for_inherits {
  my ($self) = @_;

  my $text = $self->text('inherits');

  my @output = map +($self->link($_), ""), grep defined,
    split /\n/, $self->text('inherits');

  return '' if !@output;

  pop @output;

  return $self->head1('inherits',
    "This package inherits behaviors from:",
    "",
    @output,
  );
}

sub pdml_for_integrates {
  my ($self) = @_;

  my $text = $self->text('integrates');

  my @output = map +($self->link($_), ""), grep defined,
    split /\n/, $self->text('integrates');

  return '' if !@output;

  pop @output;

  return $self->head1('integrates',
    "This package integrates behaviors from:",
    "",
    @output,
  );
}

sub pdml_for_libraries {
  my ($self) = @_;

  my $text = $self->text('libraries');

  my @output = map +($self->link($_), ""), grep defined,
    split /\n/, $self->text('libraries');

  return '' if !@output;

  pop @output;

  return $self->head1('libraries',
    "This package uses type constraints from:",
    "",
    @output,
  );
}

sub pdml_for_license {
  my ($self) = @_;

  my $output;

  my $text = $self->text('license');

  return $text ? ($self->head1('license', $text)) : ();
}

sub pdml_for_method {
  my ($self, $name) = @_;

  my @output;

  my $metadata = $self->text('metadata', $name);
  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('method', $name);

  return () if !$text;

  push @output, $text;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->pdml('example', $i, $name),
  }

  return ($self->head2($name, @output));
}

sub pdml_for_methods {
  my ($self) = @_;

  my @output;

  my $type = 'method';
  my $text = $self->text('includes');

  for my $name (sort map /:\s*(\w+)$/, grep /^$type/, split /\n/, $text) {
    push @output, $self->pdml($type, $name);
  }

  if (@output) {
    unshift @output, $self->head1('methods',
      "This package provides the following methods:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_name {
  my ($self) = @_;

  my $output;

  my $name = join ' - ', map $self->text($_), 'name', 'tagline';

  return $name ? ($self->head1('name', $name)) : ();
}

sub pdml_for_operator {
  my ($self, $name) = @_;

  my @output;

  my $text = $self->text('operator', $name);

  return () if !$text;

  my @results = $self->search({name => quotemeta($name)});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->text('example', $i, $name);
  }

  return ($self->over($self->item("operation: C<$name>", join "\n\n", $text, @output)));
}

sub pdml_for_operators {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'operator'})) {
    push @output, $self->pdml('operator', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('operators',
      "This package overloads the following operators:",
    );
  }

  return join "\n", @output;
}

sub pdml_for_project {
  my ($self) = @_;

  my $output;

  my $text = $self->text('project');

  return $text ? ($self->head1('project', $text)) : ();
}

sub pdml_for_synopsis {
  my ($self) = @_;

  my $output;

  my $text = $self->text('synopsis');

  return $text ? ($self->head1('synopsis', $text)) : ();
}

sub pdml_for_tagline {
  my ($self) = @_;

  my $output;

  my $text = $self->text('tagline');

  return $text ? ($self->head1('tagline', $text)) : ();
}

sub pdml_for_version {
  my ($self) = @_;

  my $output;

  my $text = $self->text('version');

  return $text ? ($self->head1('version', $text)) : ();
}

sub render {
  my ($self, $file) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($file);

  $path->parent->mkdirs;

  $path->write(join "\n", grep !!$_, map $self->pdml($_), qw(
    name
    abstract
    version
    synopsis
    description
    attributes
    inherits
    integrates
    libraries
    functions
    methods
    features
    operators
    authors
    license
    project
  ));

  return $path;
}

sub test_for_abstract {
  my ($self, $code) = @_;

  my $data = $self->data('abstract');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), '=abstract');

  return;
}

sub test_for_attributes {
  my ($self, $code) = @_;

  my $data = $self->data('attributes');
  my $package = $self->data('name');

  $code ||= sub {
    for my $line (split /\n/, $data) {
      my ($name, $is, $pre, $isa, $def) = map { split /,\s*/ } split /:\s*/,
        $line, 2;
      ok($package->can($name), "$package has $name");
      ok((($is eq 'ro' || $is eq 'rw')
      && ($pre eq 'opt' || $pre eq 'req')
      && $isa), $line);
    }
    $data
  };

  ok($code->(), "=attributes");

  return;
}

sub test_for_authors {
  my ($self, $code) = @_;

  my $data = $self->data('author');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), '=author');

  return;
}

sub test_for_description {
  my ($self, $code) = @_;

  my $data = $self->data('description');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), '=description');

  return;
}

sub test_for_example {
  my ($self, $number, $name, $code) = @_;

  my $data = $self->data('example', $number, $name);

  $code ||= sub{1};

  ok($data, "=example-$number $name");
  ok($code->($self->try('eval', $data)), "=example-$number $name returns ok");

  return;
}

sub test_for_feature {
  my ($self, $name, $code) = @_;

  my $data = $self->data('feature', $name);

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=feature $name");

  return;
}

sub test_for_function {
  my ($self, $name, $code) = @_;

  my $data = $self->data('function', $name);

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=function $name");

  return;
}

sub test_for_include {
  my ($self, $text) = @_;

  my ($type, $name) = @$text;

  my @blocks = $self->search({
    list => $type,
    name => $name,
  });

  ok(@blocks, "=$type $name");

  return;
}

sub test_for_includes {
  my ($self, $code) = @_;

  my $data = $self->data('includes');

  $code ||= $self->can('test_for_include');

  ok($data, '=includes');

  $self->$code($_) for map [split /\:\s*/], split /\n/, $data;

  return;
}

sub test_for_inherits {
  my ($self, $code) = @_;

  my $data = $self->data('inherits');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=inherits");

  my $package = $self->data('name');

  ok($package->isa($_), "$package isa $_") for split /\n/, $data;

  return;
}

sub test_for_integrates {
  my ($self, $code) = @_;

  my $data = $self->data('integrates');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=integrates");

  my $package = $self->data('name');

  require Role::Tiny;

  ok(Role::Tiny::does_role($package, $_), "$package does $_")
    for split /\n/, $data;

  return;
}

sub test_for_libraries {
  my ($self, $name, $code) = @_;

  my $data = $self->data('libraries');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=libraries");
  ok(eval("require $_"), "$_ ok") for split /\n/, $data;

  return;
}

sub test_for_license {
  my ($self, $name, $code) = @_;

  my $data = $self->data('license');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=license");

  return;
}

sub test_for_method {
  my ($self, $name, $code) = @_;

  my $data = $self->data('method', $name);

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=method $name");

  my $package = $self->data('name');

  ok($package->can($name), "$package has $name");

  return;
}

sub test_for_name {
  my ($self, $code) = @_;

  my $data = $self->data('name');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), '=name');
  ok(eval("require $data"), $data);

  return;
}

sub test_for_operator {
  my ($self, $name, $code) = @_;

  my $data = $self->data('operator', $name);

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=operator $name");

  return;
}

sub test_for_project {
  my ($self, $name, $code) = @_;

  my $data = $self->data('project');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=project");

  return;
}

sub test_for_synopsis {
  my ($self, $code) = @_;

  my $data = $self->data('synopsis');

  $code ||= sub{$_[0]->result};

  ok($data, '=synopsis');
  ok($code->($self->try('eval', $data)), '=synopsis returns ok');

  return;
}

sub test_for_tagline {
  my ($self, $name, $code) = @_;

  my $data = $self->data('tagline');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=tagline");

  return;
}

sub test_for_version {
  my ($self, $name, $code) = @_;

  my $data = $self->data('version');

  $code ||= sub {
    length($data) > 1;
  };

  ok($code->(), "=version");

  my $package = $self->data('name');

  ok(($package->VERSION // '') eq $data, "$data matched");

  return;
}

sub text {
  my ($self, $name, @args) = @_;

  my $method = "text_for_$name";

  my $result = $self->$method(@args);

  return join "\n", @$result;
}

sub text_for_abstract {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'abstract');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_attributes {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'attributes');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_authors {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'authors');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_description {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'description');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_example {
  my ($self, $number, $name) = @_;

  my $output = [];

  my $data = $self->search({
    list => "example-$number",
    name => quotemeta($name),
  });

  push @$output, join "\n\n", @{$data->[0]{data}} if @$data;

  return $output;
}

sub text_for_feature {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'feature', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_function {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'function', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_include {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'include');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_includes {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'includes');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_inherits {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'inherits');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_integrates {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'integrates');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_libraries {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'libraries');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_license {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'license');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_metadata {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'metadata', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_method {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'method', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_name {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'name');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_operator {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'operator', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_project {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'project');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_signature {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'signature', $name);

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_synopsis {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'synopsis');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_tagline {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'tagline');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_version {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'version');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

1;
