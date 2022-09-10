package Venus::Test;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base', 'with';

base 'Venus::Data';

with 'Venus::Role::Buildable';

use Test::More;

use Exporter 'import';

our @EXPORT = 'test';

# EXPORTS

sub test {
  __PACKAGE__->new($_[0]);
}

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->SUPER::build_self($data);
  for my $item (qw(name abstract tagline synopsis description)) {
    if (!@{$self->find(undef, $item)}) {
      my $throw;
      $throw = $self->throw;
      $throw->name('on.build');
      $throw->message("Test missing pod section =$item");
      $throw->stash(section => $item);
      $throw->error;
    }
  }

  return $self;
};

# METHODS

sub data {
  my ($self, $name, @args) = @_;

  my $method = "data_for_$name";

  $self->throw->error if !$self->can($method);

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

sub data_for_attribute {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'attribute',
    name => $name,
  });

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

sub data_for_encoding {
  my ($self) = @_;

  my $data = $self->find(undef, 'encoding');

  $self->throw->error if !@$data;

  return (map {map uc, split /\n+/} @{$data->[0]{data}})[0];
}

sub data_for_example {
  my ($self, $number, $name) = @_;

  my $data = $self->search({
    list => "example-$number",
    name => quotemeta($name),
  });

  $self->throw->error if !@$data;

  return join "\n\n", @{$data->[0]{data}};
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

sub data_for_heading {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'heading',
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

sub data_for_layout {
  my ($self) = @_;

  my $data = $self->find(undef, 'layout');

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

sub encoding {
  my ($self, $name) = @_;

  return join("\n", "", "=encoding \U$name", "", "=cut");
}

sub eval {
  my ($self, $perl) = @_;

  local $@;

  my @result = CORE::eval(join("\n\n", "no warnings q(redefine);", $perl));

  my $dollarat = $@;

  die $dollarat if $dollarat;

  return wantarray ? (@result) : $result[0];
}

sub for {
  my ($self, $name, @args) = @_;

  my $result;

  my $method = "test_for_$name";

  $self->throw->error if !$self->can($method);

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

  $self->throw->error if !$self->can($method);

  wantarray ? ($self->$method(@args)) : $self->$method(@args);
}

sub pdml_for_abstract {
  my ($self) = @_;

  my $output;

  my $text = $self->text('abstract');

  return $text ? ($self->head1('abstract', $text)) : ();
}

sub pdml_for_attribute_type1 {
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

sub pdml_for_attribute_type2 {
  my ($self, $name) = @_;

  my @output;

  my $metadata = $self->text('metadata', $name);
  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('attribute', $name);

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

sub pdml_for_attributes {
  my ($self) = @_;

  my $method = $self->text('attributes')
    ? 'pdml_for_attributes_type1'
    : 'pdml_for_attributes_type2';

  return $self->$method;
}

sub pdml_for_attributes_type1 {
  my ($self) = @_;

  my @output;

  my $text = $self->text('attributes');

  return () if !$text;

  for my $line (split /\n/, $text) {
    push @output, $self->pdml('attribute_type1', (
      map { split /,\s*/ } split /:\s*/, $line, 2
    ));
  }

  return () if !@output;

  if (@output) {
    unshift @output, $self->head1('attributes',
      $self->safe('text', 'heading', 'attribute')
      || $self->safe('text', 'heading', 'attributes')
      || 'This package has the following attributes:',
    );
  }

  return join "\n", @output;
}

sub pdml_for_attributes_type2 {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'attribute'})) {
    push @output, $self->pdml('attribute_type2', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('attributes',
      $self->safe('text', 'heading', 'attribute')
      || $self->safe('text', 'heading', 'attributes')
      || 'This package has the following attributes:',
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

sub pdml_for_encoding {
  my ($self) = @_;

  my $output;

  my $text = $self->text('encoding');

  return $text ? ($self->encoding($text)) : ();
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
      $self->safe('text', 'heading', 'feature')
      || $self->safe('text', 'heading', 'features')
      || 'This package provides the following features:',
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
      $self->safe('text', 'heading', 'function')
      || $self->safe('text', 'heading', 'functions')
      || 'This package provides the following functions:',
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
      $self->safe('text', 'heading', 'method')
      || $self->safe('text', 'heading', 'methods')
      || 'This package provides the following methods:',
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
      $self->safe('text', 'heading', 'operator')
      || $self->safe('text', 'heading', 'operators')
      || 'This package overloads the following operators:',
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

  my @layout = (
    'encoding',
    'name',
    'abstract',
    'version',
    'synopsis',
    'description',
    'attributes: attribute',
    'inherits',
    'integrates',
    'libraries',
    'functions: function',
    'methods: method',
    'features: feature',
    'operators: operator',
    'authors',
    'license',
    'project',
  );

  if (@{$self->find(undef, 'layout')}) {
    @layout = (split /\n/, $self->text('layout'));
  }

  $path->write(join "\n", grep !!$_, map $self->show($_), @layout);

  return $path;
}

sub show {
  my ($self, $spec) = @_;

  my ($name, $list) = split /:\s*/, $spec;

  my $method = "pdml_for_$name";

  if ($self->can($method)) {
    return $self->pdml($name);
  }

  my $results = $self->search({$list ? (list => $list) : (name => $name)});

  $self->throw->error if !@$results;

  my @output;
  my $textual = 1;

  for my $result (@$results) {
    my @block;

    my $examples = 0;
    my $metadata = $self->text('metadata', $result->{name});
    my $signature = $self->text('signature', $result->{name});

    push @block, ($signature, '') if $signature;

    my $text = join "\n\n", @{$result->{data}};

    if (!$text) {
      next;
    }
    else {
      push @block, $text;
    }

    if ($metadata) {
      local $@;
      if ($metadata = eval $metadata) {
        if (my $since = $metadata->{since}) {
          push @block, "", "I<Since C<$since>>";
        }
      }
    }

    my @results = $self->search({name => $result->{name}});

    for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
      push @block, $self->pdml('example', $i, $result->{name});
      $examples++;
    }

    if ($signature || $metadata || $examples) {
      push @output, ($self->head2($result->{name}, @block));
      $textual = 0;
    }
    else {
      push @output, @block;
    }
  }

  if (@output) {
    if ($textual) {
      @output = $self->head1($name, join "\n\n", @output);
    }
    else {
      unshift @output, $self->head1($name,
        ($self->count({list => 'heading'})
          ? ($self->text('heading', $name) || $self->text('heading', $list))
          : "This package provides the following $name:"),
      );
    }
  }

  return join "\n", @output;
}

sub test_for_abstract {
  my ($self, $code) = @_;

  my $data = $self->data('abstract');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=abstract');

  return $result;
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

  my $result = $code->();

  ok($result, "=attributes");

  return $result;
}

sub test_for_attribute {
  my ($self, $name, $code) = @_;

  my $data = $self->data('attribute', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=attribute $name");

  my $package = $self->data('name');

  ok($package->can($name), "$package has $name");

  return $result;
}

sub test_for_authors {
  my ($self, $code) = @_;

  my $data = $self->data('author');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=author');

  return $result;
}

sub test_for_description {
  my ($self, $code) = @_;

  my $data = $self->data('description');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=description');

  return $result;
}

sub test_for_encoding {
  my ($self, $name, $code) = @_;

  my $data = $self->data('encoding');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=encoding");

  return $result;
}

sub test_for_example {
  my ($self, $number, $name, $code) = @_;

  my $data = $self->data('example', $number, $name);

  my @includes;

  if ($data =~ /# given: synopsis/) {
    push @includes, $self->data('synopsis');
  }

  for my $given ($data =~ /# given: example-((?:\d+) (?:[\-\w]+))/gm) {
    my ($number, $name) = split /\s+/, $given, 2;
    push @includes, $self->data('example', $number, $name);
  }

  $data =~ s/.*# given: .*\n\n*//g;

  $data = join "\n\n", @includes, $data;

  $code ||= sub{1};

  my $result = $code->($self->try('eval', $data));

  ok($data, "=example-$number $name");
  ok($result, "=example-$number $name returns ok");

  return $result;
}

sub test_for_feature {
  my ($self, $name, $code) = @_;

  my $data = $self->data('feature', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=feature $name");

  return $result;
}

sub test_for_function {
  my ($self, $name, $code) = @_;

  my $data = $self->data('function', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=function $name");

  return $result;
}

sub test_for_include {
  my ($self, $text) = @_;

  my ($type, $name) = @$text;

  my $blocks = [$self->search({ list => $type, name => $name })];

  ok(@$blocks, "=$type $name");

  return $blocks;
}

sub test_for_includes {
  my ($self, $code) = @_;

  my $data = $self->data('includes');

  $code ||= $self->can('test_for_include');

  ok($data, '=includes');

  my $results = [];

  push @$results, $self->$code($_)
    for map [split /\:\s*/], grep /\w/, grep !/^#/, split /\n/, $data;

  return $results;
}

sub test_for_inherits {
  my ($self, $code) = @_;

  my $data = $self->data('inherits');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=inherits");

  my $package = $self->data('name');

  ok($package->isa($_), "$package isa $_") for split /\n/, $data;

  return $result;
}

sub test_for_integrates {
  my ($self, $code) = @_;

  my $data = $self->data('integrates');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=integrates");

  my $package = $self->data('name');

  ok($package->can('does'), "$package has does");
  ok($package->does($_), "$package does $_") for split /\n/, $data;

  return $result;
}

sub test_for_libraries {
  my ($self, $name, $code) = @_;

  my $data = $self->data('libraries');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=libraries");
  ok(eval("require $_"), "$_ ok") for split /\n/, $data;

  return $result;
}

sub test_for_license {
  my ($self, $name, $code) = @_;

  my $data = $self->data('license');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=license");

  return $result;
}

sub test_for_method {
  my ($self, $name, $code) = @_;

  my $data = $self->data('method', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=method $name");

  my $package = $self->data('name');

  ok($package->can($name), "$package has $name");

  return $result;
}

sub test_for_name {
  my ($self, $code) = @_;

  my $data = $self->data('name');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, '=name');
  ok(eval("require $data"), $data);

  return $result;
}

sub test_for_operator {
  my ($self, $name, $code) = @_;

  my $data = $self->data('operator', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=operator $name");

  return $result;
}

sub test_for_project {
  my ($self, $name, $code) = @_;

  my $data = $self->data('project');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=project");

  return $result;
}

sub test_for_synopsis {
  my ($self, $code) = @_;

  my $data = $self->data('synopsis');

  my @includes;

  for my $given ($data =~ /# given: example-((?:\d+) (?:[\-\w]+))/gm) {
    my ($number, $name) = split /\s+/, $given, 2;
    push @includes, $self->data('example', $number, $name);
  }

  $data =~ s/.*# given: .*\n\n*//g;

  $data = join "\n\n", @includes, $data;

  $code ||= sub{$_[0]->result};

  my $result = $code->($self->try('eval', $data));

  ok($data, '=synopsis');
  ok($result, '=synopsis returns ok');

  return $result;
}

sub test_for_tagline {
  my ($self, $name, $code) = @_;

  my $data = $self->data('tagline');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=tagline");

  return $result;
}

sub test_for_version {
  my ($self, $name, $code) = @_;

  my $data = $self->data('version');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  ok($result, "=version");

  my $package = $self->data('name');

  ok(($package->VERSION // '') eq $data, "$data matched");

  return $result;
}

sub text {
  my ($self, $name, @args) = @_;

  my $method = "text_for_$name";

  $self->throw->error if !$self->can($method);

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

sub text_for_attribute {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'attribute', $name);

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

sub text_for_encoding {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'encoding');

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

sub text_for_heading {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'heading', $name);

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

sub text_for_layout {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'layout');

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

  if (!@$output) {
    my $name = $self->text_for_name;
    if (my $version = ($name->[0] =~ m/([:\w]+)/m)[0]->VERSION) {
      push @$output, $version;
    }
  }

  return $output;
}

1;
