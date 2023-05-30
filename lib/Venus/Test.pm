package Venus::Test;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind';

with 'Venus::Role::Buildable';
with 'Venus::Role::Throwable';
with 'Venus::Role::Tryable';
with 'Venus::Role::Catchable';

use Test::More ();

use Exporter 'import';

our @EXPORT = 'test';

# EXPORTS

sub test {
  Venus::Test->new($_[0]);
}

# ATTRIBUTES

attr 'file';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    file => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  for my $item (qw(name abstract tagline synopsis description)) {
    $self->error("on.build_self.$item") if !@{$self->find(undef, $item)};
  }

  return $self;
};

# METHODS

sub desc {
  my ($self, @args) = @_;

  return join ' ',
    map {s/^\s+|\s+$//gr} map {Test::More->can('explain')->($_)} @args;
}

sub done {
  my ($self) = @_;

  return Test::More->can('done_testing')->();
}

sub dump {
  my ($self, @args) = @_;

  return Test::More->can('diag')->(Test::More->can('explain')->(@args));
}

sub encoding {
  my ($self, $name) = @_;

  return join("\n", "", "=encoding \U$name", "", "=cut");
}

sub error {
  my ($self, $name, $text, @args) = @_;

  my $throw;

  $throw = $self->throw;
  $throw->name($name);
  $throw->message($text) if $text;
  $throw->stash(@args) if @args;
  $throw->error;

  return;
}

sub eval {
  my ($self, $perl) = @_;

  local $@;

  my @result = CORE::eval(join("\n\n", "no warnings q(redefine);", $perl));

  my $dollarat = $@;

  die $dollarat if $dollarat;

  return wantarray ? (@result) : $result[0];
}

sub fail {
  my ($self, $data, $desc) = @_;

  return $self->proxy('ok', !!!$data, $desc) || $self->dump($data);
}

sub find {
  my ($self, @args) = @_;

  return $self->spec->find(@args);
}

sub for {
  my ($self, $name, @args) = @_;

  my $result;

  my $method = "test_for_$name";

  $self->error("on.for.$name") if !$self->can($method);

  $self->proxy('subtest', join(' ', map {ref($_) ? () : $_} $method, @args), sub {
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

sub like {
  my ($self, $this, $that, $desc) = @_;

  $that = qr/$that/ if ref $that ne 'Regexp';

  return $self->proxy('like', $this, $that, $desc);
}

sub link {
  my ($self, @data) = @_;

  return ("L<@{[join('|', @data)]}>");
}

sub okay {
  my ($self, $data, $desc) = @_;

  return $self->proxy('ok', !!$data, $desc);
}

sub over {
  my ($self, @data) = @_;

  return join("\n", "", "=over 4", "", grep(defined, @data), "=back");
}

sub pass {
  my ($self, $data, $desc) = @_;

  return $self->proxy('ok', !!$data, $desc) || $self->dump($data);
}

sub proxy {
  my ($self, $name, @args) = @_;

  my $level = 1;
  my $regexp = qr{@{[quotemeta($self->file)]}$};

  for (my $i = 0; my @caller = caller($i); $i++) {
    $level += $i; last if $caller[1] =~ $regexp;
  }

  local $Test::Builder::Level = $Test::Builder::Level + $level;

  return Test::More->can($name)->(@args);
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
    'messages: message',
    'features: feature',
    'errors: error',
    'operators: operator',
    'partials',
    'authors',
    'license',
    'project',
  );

  if (@{$self->find(undef, 'layout')}) {
    @layout = (split /\r?\n/, $self->text('layout'));
  }

  $path->write(join "\n", grep !!$_, map $self->show($_), @layout);

  return $path;
}

sub same {
  my ($self, $this, $that, $desc) = @_;

  return $self->proxy('is_deeply', $this, $that, $desc);
}

sub search {
  my ($self, @args) = @_;

  return $self->spec->search(@args);
}

sub show {
  my ($self, $spec) = @_;

  my ($name, $list) = split /:\s*/, $spec;

  my $method = "pdml_for_$name";

  if ($self->can($method)) {
    return $self->pdml($name);
  }

  my $results = $self->search({$list ? (list => $list) : (name => $name)});

  $self->error("on.show.$name") if !@$results && !grep $name eq $_, qw(
    messages
  );

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

sub spec {
  my ($self) = @_;

  require Venus::Data;

  $self->{data} ||= Venus::Data->new($self->file);

  return $self->{data};
}

sub data {
  my ($self, $name, @args) = @_;

  my $method = "data_for_$name";

  $self->error("on.data.$name") if !$self->can($method);

  wantarray ? ($self->$method(@args)) : $self->$method(@args);
}

sub data_for_abstract {
  my ($self) = @_;

  my $data = $self->find(undef, 'abstract');

  $self->error('on.data.for.abstract') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_attribute {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'attribute',
    name => $name,
  });

  $self->error('on.data.for.attribute') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_attributes {
  my ($self) = @_;

  my $data = $self->find(undef, 'attributes');

  $self->error('on.data.for.attributes') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_authors {
  my ($self) = @_;

  my $data = $self->find(undef, 'authors');

  $self->error('on.data.for.authors') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_description {
  my ($self) = @_;

  my $data = $self->find(undef, 'description');

  $self->error('on.data.for.description') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_encoding {
  my ($self) = @_;

  my $data = $self->find(undef, 'encoding');

  $self->error('on.data.for.encoding') if !@$data;

  return (map {map uc, split /\r?\n+/} @{$data->[0]{data}})[0];
}

sub data_for_error {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'error',
    name => $name,
  });

  $self->error('on.data.for.error') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_example {
  my ($self, $number, $name) = @_;

  my $data = $self->search({
    list => "example-$number",
    name => $name,
  });

  $self->error('on.data.for.example') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_feature {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'feature',
    name => $name,
  });

  $self->error('on.data.for.feature') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_function {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'function',
    name => $name,
  });

  $self->error('on.data.for.function') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_heading {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'heading',
    name => $name,
  });

  $self->error('on.data.for.heading') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_includes {
  my ($self) = @_;

  my $data = $self->find(undef, 'includes');

  $self->error('on.data.for.includes') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_inherits {
  my ($self) = @_;

  my $data = $self->find(undef, 'inherits');

  $self->error('on.data.for.inherits') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_integrates {
  my ($self) = @_;

  my $data = $self->find(undef, 'integrates');

  $self->error('on.data.for.integrates') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_layout {
  my ($self) = @_;

  my $data = $self->find(undef, 'layout');

  $self->error('on.data.for.layout') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_libraries {
  my ($self) = @_;

  my $data = $self->find(undef, 'libraries');

  $self->error('on.data.for.libraries') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_license {
  my ($self) = @_;

  my $data = $self->find(undef, 'license');

  $self->error('on.data.for.license') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_message {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'message',
    name => $name,
  });

  $self->error('on.data.for.message') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_metadata {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'metadata',
    name => $name,
  });

  $self->error('on.data.for.metadata') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_method {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'method',
    name => $name,
  });

  $self->error('on.data.for.method') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_name {
  my ($self) = @_;

  my $data = $self->find(undef, 'name');

  $self->error('on.data.for.name') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_operator {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'operator',
    name => $name,
  });

  $self->error('on.data.for.operator') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_partials {
  my ($self) = @_;

  my $data = $self->find(undef, 'partials');

  $self->error('on.data.for.partials') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_project {
  my ($self) = @_;

  my $data = $self->find(undef, 'project');

  $self->error('on.data.for.project') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_signature {
  my ($self, $name) = @_;

  my $data = $self->search({
    list => 'signature',
    name => $name,
  });

  $self->error('on.data.for.signature') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_synopsis {
  my ($self) = @_;

  my $data = $self->find(undef, 'synopsis');

  $self->error('on.data.for.synopsis') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_tagline {
  my ($self) = @_;

  my $data = $self->find(undef, 'tagline');

  $self->error('on.data.for.tagline') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub data_for_version {
  my ($self) = @_;

  my $data = $self->find(undef, 'version');

  $self->error('on.data.for.version') if !@$data;

  return join "\n\n", @{$data->[0]{data}};
}

sub pdml {
  my ($self, $name, @args) = @_;

  my $method = "pdml_for_$name";

  $self->error('on.pdml') if !$self->can($method);

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

  for my $line (split /\r?\n/, $text) {
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

sub pdml_for_error {
  my ($self, $name) = @_;

  my @output;

  my $text = $self->text('error', $name);

  return () if !$text;

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->text('example', $i, $name);
  }

  return ($self->over($self->item("error: C<$name>", join "\n\n", $text, @output)));
}

sub pdml_for_errors {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'error'})) {
    push @output, $self->pdml('error', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('errors',
      $self->safe('text', 'heading', 'error')
      || $self->safe('text', 'heading', 'errors')
      || 'This package may raise the following errors:',
    );
  }

  return join "\n", @output;
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

  for my $name (sort map /:\s*(\w+)$/, grep /^$type/, split /\r?\n/, $text) {
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
    split /\r?\n/, $self->text('inherits');

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
    split /\r?\n/, $self->text('integrates');

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
    split /\r?\n/, $self->text('libraries');

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

sub pdml_for_message {
  my ($self, $name) = @_;

  my @output;

  my $signature = $self->text('signature', $name);

  push @output, ($signature, '') if $signature;

  my $text = $self->text('message', $name);

  return () if !$text;

  my @results = $self->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->text('example', $i, $name);
  }

  return ($self->over($self->item($name, join "\n\n", $text, @output)));
}

sub pdml_for_messages {
  my ($self) = @_;

  my @output;

  for my $list ($self->search({list => 'message'})) {
    push @output, $self->pdml('message', $list->{name});
  }

  if (@output) {
    unshift @output, $self->head1('messages',
      $self->safe('text', 'heading', 'message')
      || $self->safe('text', 'heading', 'messages')
      || 'This package provides the following messages:',
    );
  }

  return join "\n", @output;
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

  for my $name (sort map /:\s*(\w+)$/, grep /^$type/, split /\r?\n/, $text) {
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

  my @results = $self->search({name => $name});

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

sub pdml_for_partials {
  my ($self) = @_;

  my $output;

  my $text = $self->text('partials');

  return $text ? ($text) : ();
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

sub test_for_abstract {
  my ($self, $code) = @_;

  my $data = $self->data('abstract');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, '=abstract');

  return $result;
}

sub test_for_attribute {
  my ($self, $name, $code) = @_;

  my $data = $self->data('attribute', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=attribute $name");

  my $package = $self->data('name');

  $self->pass($package->can($name), "$package has $name");

  return $result;
}

sub test_for_attributes {
  my ($self, $code) = @_;

  my $data = $self->data('attributes');
  my $package = $self->data('name');

  $code ||= sub {
    for my $line (split /\r?\n/, $data) {
      my ($name, $is, $pre, $isa, $def) = map { split /,\s*/ } split /:\s*/,
        $line, 2;
      $self->pass($package->can($name), "$package has $name");
      $self->pass((($is eq 'ro' || $is eq 'rw')
      && ($pre eq 'opt' || $pre eq 'req')
      && $isa), $line);
    }
    $data
  };

  my $result = $code->();

  $self->pass($result, "=attributes");

  return $result;
}

sub test_for_authors {
  my ($self, $code) = @_;

  my $data = $self->data('authors');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, '=authors');

  return $result;
}

sub test_for_description {
  my ($self, $code) = @_;

  my $data = $self->data('description');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, '=description');

  return $result;
}

sub test_for_encoding {
  my ($self, $name, $code) = @_;

  my $data = $self->data('encoding');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=encoding");

  return $result;
}

sub test_for_error {
  my ($self, $name, $code) = @_;

  my $data = $self->data('error', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=error $name");

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

  for my $attest ($data =~ /#\s*attest:\s*\w+:\s*[^\s]+,\s*.*/gm) {
    my ($method, $left, $right) = $attest =~ /attest:\s*(\w+):\s*([^\s]+),\s*(.*)/;
    my $snippet = qq($left = do { $self->pass($left->$method($right), "@{[quotemeta($&)]}"); $left };);
    $data =~ s/@{[quotemeta($attest)]}/$snippet/;
  }

  $code ||= sub{1};

  my $result = $code->($self->try('eval', $data));

  $self->pass($data, "=example-$number $name");
  $self->pass($result, "=example-$number $name returns ok");

  return $result;
}

sub test_for_feature {
  my ($self, $name, $code) = @_;

  my $data = $self->data('feature', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=feature $name");

  return $result;
}

sub test_for_function {
  my ($self, $name, $code) = @_;

  my $data = $self->data('function', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=function $name");

  return $result;
}

sub test_for_include {
  my ($self, $text) = @_;

  my ($type, $name) = @$text;

  my $blocks = [$self->search({ list => $type, name => $name })];

  $self->pass(scalar(@$blocks), "=$type $name");

  return $blocks;
}

sub test_for_includes {
  my ($self, $code) = @_;

  my $data = $self->data('includes');

  $code ||= $self->can('test_for_include');

  $self->pass($data, "=includes");

  my $results = [];

  push @$results, $self->$code($_)
    for map [split /\:\s*/], grep /\w/, grep !/^#/, split /\r?\n/, $data;

  return $results;
}

sub test_for_inherits {
  my ($self, $code) = @_;

  my $data = $self->data('inherits');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=inherits");

  my $package = $self->data('name');

  $self->pass($package->isa($_), "$package isa $_") for split /\r?\n/, $data;

  return $result;
}

sub test_for_integrates {
  my ($self, $code) = @_;

  my $data = $self->data('integrates');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=integrates");

  my $package = $self->data('name');

  $self->pass($package->can('does'), "$package has does");
  $self->pass($package->does($_), "$package does $_") for split /\r?\n/, $data;

  return $result;
}

sub test_for_libraries {
  my ($self, $name, $code) = @_;

  my $data = $self->data('libraries');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=libraries");
  $self->pass(scalar(eval("require $_")), "$_ ok") for split /\r?\n/, $data;

  return $result;
}

sub test_for_license {
  my ($self, $name, $code) = @_;

  my $data = $self->data('license');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=license");

  return $result;
}

sub test_for_message {
  my ($self, $name, $code) = @_;

  my $data = $self->data('message', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=message $name");

  return $result;
}

sub test_for_method {
  my ($self, $name, $code) = @_;

  my $data = $self->data('method', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=method $name");

  my $package = $self->data('name');

  $self->pass($package->can($name), "$package has $name");

  return $result;
}

sub test_for_name {
  my ($self, $code) = @_;

  my $data = $self->data('name');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, $self->desc('=name'));
  $self->pass(scalar(eval("require $data")), $self->desc('require', $data));

  return $result;
}

sub test_for_operator {
  my ($self, $name, $code) = @_;

  my $data = $self->data('operator', $name);

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=operator $name");

  return $result;
}

sub test_for_partial {
  my ($self, $text) = @_;

  my ($file, $method, @args) = @$text;

  my $test = $self->class->new($file);

  my $content;

  $self->pass((-f $file && ($content = $test->$method(@args))),
    "$file: $method: @args");

  return $content;
}

sub test_for_partials {
  my ($self, $code) = @_;

  my $data = $self->data('partials');

  $code ||= $self->can('test_for_partial');

  $self->pass($data, '=partials');

  my $results = [];

  push @$results, $self->$code($_)
    for map [split /\:\s*/], grep /\w/, grep !/^#/, split /\r?\n/, $data;

  return $results;
}

sub test_for_project {
  my ($self, $name, $code) = @_;

  my $data = $self->data('project');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=project");

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

  for my $attest ($data =~ /#\s*attest:\s*\w+:\s*[^\s]+,\s*.*/gm) {
    my ($method, $left, $right) = $attest =~ /attest:\s*(\w+):\s*([^\s]+),\s*(.*)/;
    my $snippet = qq($left = do { $self->pass($left->$method($right), "@{[quotemeta($&)]}"); $left };);
    $data =~ s/@{[quotemeta($attest)]}/$snippet/;
  }

  $code ||= sub{$_[0]->result};

  my $result = $code->($self->try('eval', $data));

  $self->pass($data, "=synopsis");
  $self->pass($result, "=synopsis returns ok");

  return $result;
}

sub test_for_tagline {
  my ($self, $name, $code) = @_;

  my $data = $self->data('tagline');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=tagline");

  return $result;
}

sub test_for_version {
  my ($self, $name, $code) = @_;

  my $data = $self->data('version');

  $code ||= sub {
    length($data) > 1;
  };

  my $result = $code->();

  $self->pass($result, "=version");

  my $package = $self->data('name');

  $self->pass(($package->VERSION // '') eq $data, "$data matched");

  return $result;
}

sub text {
  my ($self, $name, @args) = @_;

  my $method = "text_for_$name";

  $self->error("on.text.$name") if !$self->can($method);

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

sub text_for_attribute {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'attribute', $name);

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

sub text_for_encoding {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'encoding');

  my $output = [];

  if (!$error) {
    push @$output, $result;
  }

  return $output;
}

sub text_for_error {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'error', $name);

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
    name => $name,
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

sub text_for_message {
  my ($self, $name) = @_;

  my ($error, $result) = $self->catch('data', 'message', $name);

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

sub text_for_partial {
  my ($self, $text) = @_;

  my ($file, $method, @args) = @$text;

  my $test = $self->class->new($file);

  return [$test->$method(@args)];
}

sub text_for_partials {
  my ($self) = @_;

  my ($error, $result) = $self->catch('data', 'partials');

  my $output = [];

  if (!$error) {
    push @$output, $self->text('partial', $_)
      for map [split /\:\s*/], grep /\w/, grep !/^#/, split /\r?\n/, $result;
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
