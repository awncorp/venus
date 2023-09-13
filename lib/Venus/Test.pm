package Venus::Test;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind';

with 'Venus::Role::Buildable';

use Test::More ();

use Exporter 'import';

our @EXPORT = 'test';

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

  return $self if !$self->file;

  for my $name (qw(name abstract tagline synopsis description)) {
    $self->error({throw => "error_on_$name"}) if !$self->data->count({
      name => $name,
      list => undef,
    });
  }

  return $self;
}

# FUNCTIONS

sub test {
  Venus::Test->new($_[0]);
}

# METHODS

sub collect {
  my ($self, $name, @args) = @_;

  my $method = "collect_data_for_$name";

  return $self->$method(@args);
}

sub collect_data_for_abstract {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'abstract');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_attribute {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('attribute', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_attributes {
  my ($self, $name) = @_;

  my ($find) = $self->data->find(undef, 'attributes');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_authors {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'authors');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_description {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'description');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_encoding {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'encoding');

  my $data = $find ? $find->{data} : [];

  @{$data} = (map {map uc, split /\r?\n+/} @{$data});

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_error {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('error', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_example {
  my ($self, $number, $name) = @_;

  my ($find) = $self->data->find("example-$number", $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_feature {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('feature', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_function {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('function', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_includes {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'includes');

  my $data = $find ? $find->{data} : [];

  @{$data} = grep !/^#/, grep /\w/, map {split/\n/} @{$data};

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_inherits {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'inherits');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_integrates {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'integrates');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_layout {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'layout');

  my $data = $find ? $find->{data} : [
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
  ];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_libraries {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'libraries');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_license {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'license');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_message {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('message', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_metadata {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('metadata', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_method {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('method', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_name {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'name');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_operator {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('operator', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_partials {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'partials');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_project {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'project');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_signature {
  my ($self, $name) = @_;

  my ($find) = $self->data->find('signature', $name);

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_synopsis {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'synopsis');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_tagline {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'tagline');

  my $data = $find ? $find->{data} : [];

  return wantarray ? (@{$data}) : $data;
}

sub collect_data_for_version {
  my ($self) = @_;

  my ($find) = $self->data->find(undef, 'version');

  my $data = $find ? $find->{data} : [];

  require Venus::Space;

  if (!@{$data} && (my ($name) = $self->collect('name'))) {
    @{$data} = (Venus::Space->new($name)->version) || ();
  }

  return wantarray ? (@{$data}) : $data;
}

sub diag {
  my ($self, @args) = @_;

  return $self->more('diag', $self->explain(@args));
}

sub data {
  my ($self) = @_;

  require Venus::Data;

  $self->{data} ||= Venus::Data->new($self->file);

  return $self->{data};
}

sub done {
  my ($self) = @_;

  return $self->more('done_testing');
}

sub eval {
  my ($self, $perl) = @_;

  local $@;

  my @result = CORE::eval(join("\n\n", "no warnings q(redefine);", $perl));

  my $dollarat = $@;

  die $dollarat if $dollarat;

  return wantarray ? (@result) : $result[0];
}

sub execute {
  my ($self, $name, @args) = @_;

  my $method = "execute_test_for_$name";

  return $self->$method(@args);
}

sub execute_test_for_abstract {
  my ($self, $code) = @_;

  my $data = $self->collect('abstract');

  my $result = $self->perform('abstract', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=abstract');

  return $result;
}

sub execute_test_for_attribute {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('attribute', $name);

  my $result = $self->perform('attribute', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=attribute $name");

  return $result;
}

sub execute_test_for_attributes {
  my ($self, $code) = @_;

  my $data = $self->collect('attributes');

  my $result = $self->perform('attributes', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=attributes');

  my ($package) = $self->collect('name');

  for my $line (@{$data}) {
    next if !$line;

    my ($name, $is, $pre, $isa, $def) = map { split /,\s*/ } split /:\s*/,
      $line, 2;

    $self->pass($package->can($name), "$package has $name");
    $self->pass((($is eq 'ro' || $is eq 'rw')
        && ($pre eq 'opt' || $pre eq 'req')
        && $isa), $line);
  }

  return $result;
}

sub execute_test_for_authors {
  my ($self, $code) = @_;

  my $data = $self->collect('authors');

  my $result = $self->perform('authors', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=authors');

  return $result;
}

sub execute_test_for_description {
  my ($self, $code) = @_;

  my $data = $self->collect('description');

  my $result = $self->perform('description', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=description');

  return $result;
}

sub execute_test_for_encoding {
  my ($self, $code) = @_;

  my $data = $self->collect('encoding');

  my $result = $self->perform('encoding', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=encoding');

  return $result;
}

sub execute_test_for_error {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('error', $name);

  my $result = $self->perform('error', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=error $name");

  return $result;
}

sub execute_test_for_example {
  my ($self, $number, $name, $code) = @_;

  my $data = $self->collect('example', $number, $name);

  my $text = join "\n\n", @{$data};

  my @includes;

  if ($text =~ /.*#\s*given:\s*synopsis/m) {
    my $line = $&;
    if ($line !~ /#.*#\s*given:\s*synopsis/) {
      push @includes, $self->collect('synopsis');
    }
  }

  for my $given ($text =~ /.*#\s*given:\s*example-((?:\d+)\s+(?:[\-\w]+))/gm) {
    my $line = $&;
    if ($line !~ /#.*#\s*given:\s*example-(?:\d+)\s+(?:[\-\w]+)/) {
      my ($number, $name) = split /\s+/, $given, 2;
      push @includes, $self->collect('example', $number, $name);
    }
  }

  $text =~ s/.*#\s*given:\s*.*\n\n*//g;
  $text = join "\n\n", @includes, $text;

  my $result = $self->perform('example', $number, $name, $data);

  $self->pass($result, "=example-$number $name");

  $result = $code->($self->try('eval', $text)) if $code;

  $self->pass($result, "=example-$number $name returns ok") if $code;

  return $result;
}

sub execute_test_for_feature {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('feature', $name);

  my $result = $self->perform('feature', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=feature $name");

  return $result;
}

sub execute_test_for_function {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('function', $name);

  my $result = $self->perform('function', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=function $name");

  return $result;
}

sub execute_test_for_includes {
  my ($self, $code) = @_;

  my $data = $self->collect('includes');

  my $result = $self->perform('includes', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=includes');

  return $result;
}

sub execute_test_for_inherits {
  my ($self, $code) = @_;

  my $data = $self->collect('inherits');

  my $result = $self->perform('inherits', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=inherits');

  return $result;
}

sub execute_test_for_integrates {
  my ($self, $code) = @_;

  my $data = $self->collect('integrates');

  my $result = $self->perform('integrates', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=integrates');

  return $result;
}

sub execute_test_for_layout {
  my ($self, $code) = @_;

  my $data = $self->collect('layout');

  my $result = $self->perform('layout', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=layout');

  return $result;
}

sub execute_test_for_libraries {
  my ($self, $code) = @_;

  my $data = $self->collect('libraries');

  my $result = $self->perform('libraries', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=libraries');

  return $result;
}

sub execute_test_for_license {
  my ($self, $code) = @_;

  my $data = $self->collect('license');

  my $result = $self->perform('license', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=license');

  return $result;
}

sub execute_test_for_message {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('message', $name);

  my $result = $self->perform('message', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=message $name");

  return $result;
}

sub execute_test_for_metadata {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('metadata', $name);

  my $result = $self->perform('metadata', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=metadata $name");

  return $result;
}

sub execute_test_for_method {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('method', $name);

  my $result = $self->perform('method', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=method $name");

  return $result;
}

sub execute_test_for_name {
  my ($self, $code) = @_;

  my $data = $self->collect('name');

  my $result = $self->perform('name', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=name');

  return $result;
}

sub execute_test_for_operator {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('operator', $name);

  my $result = $self->perform('operator', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=operator $name");

  return $result;
}

sub execute_test_for_partials {
  my ($self, $code) = @_;

  my $data = $self->collect('partials');

  my $result = $self->perform('partials', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=partials');

  return $result;
}

sub execute_test_for_project {
  my ($self, $code) = @_;

  my $data = $self->collect('project');

  my $result = $self->perform('project', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=project');

  return $result;
}

sub execute_test_for_signature {
  my ($self, $name, $code) = @_;

  my $data = $self->collect('signature', $name);

  my $result = $self->perform('signature', $name, $data);

  $result = $code->($data) if $code;

  $self->pass($result, "=signature $name");

  return $result;
}

sub execute_test_for_synopsis {
  my ($self, $code) = @_;

  my $data = $self->collect('synopsis');

  my $text = join "\n\n", @{$data};

  my @includes;

  for my $given ($text =~ /.*#\s*given:\s*example-((?:\d+)\s+(?:[\-\w]+))/gm) {
    my $line = $&;
    if ($line !~ /#.*#\s*given:\s*example-(?:\d+)\s+(?:[\-\w]+)/) {
      my ($number, $name) = split /\s+/, $given, 2;
      push @includes, $self->collect('example', $number, $name);
    }
  }

  $text =~ s/.*#\s*given:\s*.*\n\n*//g;
  $text = join "\n\n", @includes, $text;

  my $result = $self->perform('synopsis', $data);

  $self->pass($result, "=synopsis");

  $result = $code->($self->try('eval', $text)) if $code;

  $self->pass($result, "=synopsis returns ok") if $code;

  return $result;
}

sub execute_test_for_tagline {
  my ($self, $code) = @_;

  my $data = $self->collect('tagline');

  my $result = $self->perform('tagline', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=tagline');

  return $result;
}

sub execute_test_for_version {
  my ($self, $code) = @_;

  my $data = $self->collect('version');

  my $result = $self->perform('version', $data);

  $result = $code->($data) if $code;

  $self->pass($result, '=version');

  return $result;
}

sub explain {
  my ($self, @args) = @_;

  return join ' ', map {s/^\s+|\s+$//gr} map {$self->more('explain', $_)} @args;
}

sub fail {
  my ($self, $data, $desc) = @_;

  return $self->more('ok', ($data ? false : true), $desc) || $self->diag($data);
}

sub for {
  my ($self, $type, @args) = @_;

  my $name = join(
    ' ', map {ref($_) ? () : $_} $type, @args
  );

  $self->more('subtest', $name, sub {
    $self->execute($type, @args);
  });

  return $self;
}

sub like {
  my ($self, $this, $that, $desc) = @_;

  $that = qr/$that/ if ref $that ne 'Regexp';

  return $self->more('like', $this, $that, $desc);
}

sub more {
  my ($self, $name, @args) = @_;

  require Test::More;

  my $level = 1;

  local $Test::Builder::Level = $Test::Builder::Level + $level;

  for (my $i = 0; my @caller = caller($i); $i++) {
    $level += $i; last if $caller[1] =~ qr{@{[quotemeta($self->file)]}$};
  }

  return Test::More->can($name)->(@args);
}

sub okay {
  my ($self, $data, $desc) = @_;

  return $self->more('ok', ($data ? true : false), $desc);
}

sub okay_can {
  my ($self, $data, @args) = @_;

  return $self->more('can_ok', $data, @args);
}

sub okay_isa {
  my ($self, $data, $name) = @_;

  return $self->more('isa_ok', $data, $name);
}

sub pass {
  my ($self, $data, $desc) = @_;

  return $self->more('ok', ($data ? true : false), $desc) || $self->diag($data);
}

sub perform {
  my ($self, $name, @args) = @_;

  my $method = "perform_test_for_$name";

  return $self->$method(@args);
}

sub perform_test_for_abstract {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=abstract content');

  return $result;
}

sub perform_test_for_attribute {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=attribute $name content");

  return $result;
}

sub perform_test_for_attributes {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=attributes content');

  return $result;
}

sub perform_test_for_authors {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=authors content');

  return $result;
}

sub perform_test_for_description {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=description content');

  return $result;
}

sub perform_test_for_encoding {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=encoding content');

  return $result;
}

sub perform_test_for_error {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=error $name content");

  return $result;
}

sub perform_test_for_example {
  my ($self, $number, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=example-$number $name content");

  return $result;
}

sub perform_test_for_feature {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=feature $name content");

  return $result;
}

sub perform_test_for_function {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=function $name content");

  return $result;
}

sub perform_test_for_includes {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=includes content');

  return $result;
}

sub perform_test_for_inherits {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=inherits content');

  return $result;
}

sub perform_test_for_integrates {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=integrates content');

  return $result;
}

sub perform_test_for_layout {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=layout content');

  return $result;
}

sub perform_test_for_libraries {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=libraries content');

  return $result;
}

sub perform_test_for_license {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=license content');

  return $result;
}

sub perform_test_for_message {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=message $name content");

  return $result;
}

sub perform_test_for_metadata {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=metadata $name content");

  return $result;
}

sub perform_test_for_method {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=method $name content");

  return $result;
}

sub perform_test_for_name {
  my ($self, $data) = @_;

  my $text = join "\n", @{$data};

  my $result = length($text) ? true : false;

  $self->pass($result, '=name content');

  $self->pass(scalar(eval("require $text")), $self->explain('require', $text));

  return $result;
}

sub perform_test_for_operator {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=operator $name content");

  return $result;
}

sub perform_test_for_partials {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=partials content');

  return $result;
}

sub perform_test_for_project {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=project content');

  return $result;
}

sub perform_test_for_signature {
  my ($self, $name, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, "=signature $name content");

  return $result;
}

sub perform_test_for_synopsis {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=synopsis content');

  return $result;
}

sub perform_test_for_tagline {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=tagline content');

  return $result;
}

sub perform_test_for_version {
  my ($self, $data) = @_;

  my $result = length(join "\n", @{$data}) ? true : false;

  $self->pass($result, '=version content');

  return $result;
}

sub present {
  my ($self, $name, @args) = @_;

  my $method = "present_data_for_$name";

  return $self->$method(@args);
}

sub present_data_for_abstract {
  my ($self) = @_;

  my @data = $self->collect('abstract');

  return @data ? ($self->present_data_for_head1('abstract', @data)) : ();
}

sub present_data_for_attribute {
  my ($self, $name) = @_;

  return $self->present_data_for_attribute_type2($name);
}

sub present_data_for_attribute_type1 {
  my ($self, $name, $is, $pre, $isa, $def) = @_;

  my @output;

  $is = $is eq 'ro' ? 'read-only' : 'read-write';
  $pre = $pre eq 'req' ? 'required' : 'optional';

  push @output, "  $name($isa)\n";
  push @output, "This attribute is $is, accepts C<($isa)> values, ". (
    $def ? "is $pre, and defaults to $def." : "and is $pre."
  );

  return ($self->present_data_for_head2($name, @output));
}

sub present_data_for_attribute_type2 {
  my ($self, $name) = @_;

  my @output;

  my ($metadata) = $self->collect('metadata', $name);
  my ($signature) = $self->collect('signature', $name);

  push @output, ($signature, '') if $signature;

  my @data = $self->collect('attribute', $name);

  return () if !@data;

  push @output, join "\n\n", @data;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, join "\n\n", $self->present('example', $i, $name);
  }

  pop @output if $output[-1] eq '';

  return ($self->present_data_for_head2($name, @output));
}

sub present_data_for_attributes {
  my ($self, @args) = @_;

  my $method = $self->data->count({list => undef, name => 'attributes'})
    ? 'attributes_type1'
    : 'attributes_type2';

  return $self->present($method, @args);
}

sub present_data_for_attributes_type1 {
  my ($self) = @_;

  my @output;

  my @data = $self->collect('attributes');

  return () if !@data;

  for my $line (split /\r?\n/, join "\n", @data) {
    push @output, $self->present('attribute_type1', (
      map {split /,\s*/} split /:\s*/, $line, 2
    ));
  }

  return () if !@output;

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('attributes',
      'This package has the following attributes:');
  }

  return join "\n", @output;
}

sub present_data_for_attributes_type2 {
  my ($self) = @_;

  my @output;

  for my $list ($self->data->search({list => 'attribute'})) {
    push @output, $self->present('attribute_type2', $list->{name});
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('attributes',
      'This package has the following attributes:');
  }

  return join "\n", @output;
}

sub present_data_for_authors {
  my ($self) = @_;

  my @data = $self->collect('authors');

  return @data ? ($self->present_data_for_head1('authors', join "\n\n", @data)) : ();
}

sub present_data_for_description {
  my ($self) = @_;

  my @data = $self->collect('description');

  return @data ? ($self->present_data_for_head1('description', join "\n\n", @data)) : ();
}

sub present_data_for_encoding {
  my ($self) = @_;

  my ($name) = $self->collect('encoding');

  return () if !$name;

  return join("\n", "", "=encoding \U$name", "", "=cut");
}

sub present_data_for_error {
  my ($self, $name) = @_;

  my @output;

  my @data = $self->collect('error', $name);

  return () if !@data;

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->collect('example', $i, $name);
  }

  return (
    $self->present_data_for_over($self->present_data_for_item(
      "error: C<$name>",
      join "\n\n", @data, @output
    ))
  );
}

sub present_data_for_errors {
  my ($self) = @_;

  my @output;

  my $type = 'error';

  for my $name (
    sort map $$_{name},
      $self->data->search({list => $type})
  )
  {
    push @output, $self->present($type, $name);
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('errors',
      'This package may raise the following errors:');
  }

  return join "\n", @output;
}

sub present_data_for_example {
  my ($self, $number, $name) = @_;

  my @data = $self->collect('example', $number, $name);

  return @data
    ? (
    $self->present_data_for_over($self->present_data_for_item(
      "$name example $number", join "\n\n", @data)))
    : ();
}

sub present_data_for_feature {
  my ($self, $name) = @_;

  my @output;

  my ($signature) = $self->collect('signature', $name);

  push @output, ($signature, '') if $signature;

  my @data = $self->collect('feature', $name);

  return () if !@data;

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", $self->collect('example', $i, $name);
  }

  return (
    $self->present_data_for_over($self->present_data_for_item(
      $name, join "\n\n", @data, @output))
  );
}

sub present_data_for_features {
  my ($self) = @_;

  my @output;

  my $type = 'feature';

  for my $name (
    sort map $$_{name},
      $self->data->search({list => $type})
  )
  {
    push @output, $self->present($type, $name);
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('features',
      'This package provides the following features:');
  }

  return join "\n", @output;
}

sub present_data_for_function {
  my ($self, $name) = @_;

  my @output;

  my ($metadata) = $self->collect('metadata', $name);
  my ($signature) = $self->collect('signature', $name);

  push @output, ($signature, '') if $signature;

  my @data = $self->collect('function', $name);

  return () if !@data;

  push @output, join "\n\n", @data;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->present('example', $i, $name);
  }

  pop @output if $output[-1] eq '';

  return ($self->present_data_for_head2($name, @output));
}

sub present_data_for_functions {
  my ($self) = @_;

  my @output;

  my $type = 'function';

  for my $name (
    sort map /:\s*(\w+)$/,
    grep /^$type/,
    split /\r?\n/,
    join "\n\n", $self->collect('includes')
  )
  {
    push @output, $self->present($type, $name);
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('functions',
      'This package provides the following functions:');
  }

  return join "\n", @output;
}

sub present_data_for_head1 {
  my ($self, $name, @data) = @_;

  return join("\n", "", "=head1 \U$name", "", grep(defined, @data), "", "=cut");
}

sub present_data_for_head2 {
  my ($self, $name, @data) = @_;

  return join("\n", "", "=head2 \L$name", "", grep(defined, @data), "", "=cut");
}

sub present_data_for_includes {
  my ($self) = @_;

  return ();
}

sub present_data_for_inherits {
  my ($self) = @_;

  my @output = map +($self->present_data_for_link($_), ""), grep defined,
    split /\r?\n/, join "\n\n", $self->collect('inherits');

  return () if !@output;

  pop @output;

  return $self->present_data_for_head1('inherits',
    "This package inherits behaviors from:",
    "",
    @output,
  );
}

sub present_data_for_integrates {
  my ($self) = @_;

  my @output = map +($self->present_data_for_link($_), ""), grep defined,
    split /\r?\n/, join "\n\n", $self->collect('integrates');

  return () if !@output;

  pop @output;

  return $self->present_data_for_head1('integrates',
    "This package integrates behaviors from:",
    "",
    @output,
  );
}

sub present_data_for_item {
  my ($self, $name, $data) = @_;

  return ("=item $name\n", "$data\n");
}

sub present_data_for_layout {
  my ($self) = @_;

  return ();
}

sub present_data_for_libraries {
  my ($self) = @_;

  my @output = map +($self->present_data_for_link($_), ""), grep defined,
    split /\r?\n/, join "\n\n", $self->collect('libraries');

  return '' if !@output;

  pop @output;

  return $self->present_data_for_head1('libraries',
    "This package uses type constraints from:",
    "",
    @output,
  );
}

sub present_data_for_license {
  my ($self) = @_;

  my @data = $self->collect('license');

  return @data
    ? ($self->present_data_for_head1('license', join "\n\n", @data))
    : ();
}

sub present_data_for_link {
  my ($self, @data) = @_;

  return ("L<@{[join('|', @data)]}>");
}

sub present_data_for_message {
  my ($self, $name) = @_;

  my @output;

  my ($signature) = $self->collect('signature', $name);

  push @output, ($signature, '') if $signature;

  my @data = $self->collect('message', $name);

  return () if !@data;

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", join "\n\n",
      $self->collect('example', $i, $name);
  }

  return (
    $self->present_data_for_over($self->present_data_for_item(
      $name, join "\n\n", @data, @output))
  );
}

sub present_data_for_messages {
  my ($self) = @_;

  my @output;

  my $type = 'message';

  for my $name (
    sort map /:\s*(\w+)$/,
    grep /^$type/,
    split /\r?\n/,
    join "\n\n", $self->collect('includes')
  )
  {
    push @output, $self->present($type, $name);
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('messages',
      'This package provides the following messages:');
  }

  return join "\n", @output;
}

sub present_data_for_metadata {
  my ($self) = @_;

  return ();
}

sub present_data_for_method {
  my ($self, $name) = @_;

  my @output;

  my ($metadata) = $self->collect('metadata', $name);
  my ($signature) = $self->collect('signature', $name);

  push @output, ($signature, '') if $signature;

  my @data = $self->collect('method', $name);

  return () if !@data;

  push @output, join "\n\n", @data;

  if ($metadata) {
    local $@;
    if ($metadata = eval $metadata) {
      if (my $since = $metadata->{since}) {
        push @output, "", "I<Since C<$since>>";
      }
    }
  }

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, $self->present('example', $i, $name);
  }

  pop @output if $output[-1] eq '';

  return ($self->present_data_for_head2($name, @output));
}

sub present_data_for_methods {
  my ($self) = @_;

  my @output;

  my $type = 'method';

  for my $name (
    sort map /:\s*(\w+)$/,
    grep /^$type/,
    split /\r?\n/,
    join "\n\n", $self->collect('includes')
  )
  {
    push @output, $self->present($type, $name);
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('methods',
      'This package provides the following methods:');
  }

  return join "\n", @output;
}

sub present_data_for_name {
  my ($self) = @_;

  my $name = join ' - ', map $self->collect($_), 'name', 'tagline';

  return $name ? ($self->present_data_for_head1('name', $name)) : ();
}

sub present_data_for_operator {
  my ($self, $name) = @_;

  my @output;

  my @data = $self->collect('operator', $name);

  return () if !@data;

  my @results = $self->data->search({name => $name});

  for my $i (1..(int grep {($$_{list} || '') =~ /^example-\d+/} @results)) {
    push @output, "B<example $i>", join "\n\n",
      $self->collect('example', $i, $name);
  }

  return (
    $self->present_data_for_over($self->present_data_for_item(
      "operation: C<$name>",
      join "\n\n", @data, @output
    ))
  );
}

sub present_data_for_operators {
  my ($self) = @_;

  my @output;

  my $type = 'operator';

  for my $name (
    sort map $$_{name},
      $self->data->search({list => $type})
  )
  {
    push @output, $self->present($type, $name);
  }

  if (@output) {
    unshift @output,
      $self->present_data_for_head1('operators',
      'This package overloads the following operators:');
  }

  return join "\n", @output;
}

sub present_data_for_over {
  my ($self, @data) = @_;

  return join("\n", "", "=over 4", "", grep(defined, @data), "=back");
}

sub present_data_for_partial {
  my ($self, $data) = @_;

  my ($file, $method, @args) = @{$data};

  $method = 'present' if lc($method) eq 'pdml';

  my $test = $self->new($file);

  my @output;

  $self->pass((-f $file && (@output = ($test->$method(@args)))),
    "$file: $method: @args");

  return join "\n", @output;
}

sub present_data_for_partials {
  my ($self) = @_;

  my @output;

  push @output, $self->present('partial', $_)
    for map [split /\:\s*/], grep /\w/, grep !/^#/, split /\r?\n/, join "\n\n",
      $self->collect('partials');

  return join "\n", @output;
}

sub present_data_for_project {
  my ($self) = @_;

  my @data = $self->collect('project');

  return @data ? ($self->present_data_for_head1('project', join "\n\n", @data)) : ();
}

sub present_data_for_signature {
  my ($self) = @_;

  return ();
}

sub present_data_for_synopsis {
  my ($self) = @_;

  my @data = $self->collect('synopsis');

  return @data
    ? ($self->present_data_for_head1('synopsis', join "\n\n", @data))
    : ();
}

sub present_data_for_tagline {
  my ($self) = @_;

  my @data = $self->collect('tagline');

  return @data
    ? ($self->present_data_for_head1('tagline', join "\n\n", @data))
    : ();
}

sub present_data_for_version {
  my ($self) = @_;

  my @data = $self->collect('version');

  return @data
    ? ($self->present_data_for_head1('version', join "\n\n", @data))
    : ();
}

sub render {
  my ($self, $file) = @_;

  require Venus::Path;

  my $path = Venus::Path->new($file);

  $path->parent->mkdirs;

  my @layout = $self->collect('layout');

  my @output;

  for my $item (@layout) {
    push @output, grep {length} $self->present(split /:\s*/, $item);
  }

  $path->write(join "\n", @output);

  return $path;
}

sub same {
  my ($self, $this, $that, $desc) = @_;

  return $self->more('is_deeply', $this, $that, $desc);
}

sub skip {
  my ($self, $desc, @args) = @_;

  my ($bool) = @args ? @args : (true);

  $bool = (ref $bool eq 'CODE') ? $self->$bool : $bool;

  $self->more('plan', 'skip_all', $desc) if $bool;

  return $bool;
}

# ERRORS

sub error_on_abstract {
  my ($self, $data) = @_;

  my $message = 'Test file "{{file}}" missing abstract section';

  my $stash = {
    file => $self->file,
  };

  my $result = {
    name => 'on.abstract',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

sub error_on_description {
  my ($self, $data) = @_;

  my $message = 'Test file "{{file}}" missing description section';

  my $stash = {
    file => $self->file,
  };

  my $result = {
    name => 'on.description',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

sub error_on_name {
  my ($self, $data) = @_;

  my $message = 'Test file "{{file}}" missing name section';

  my $stash = {
    file => $self->file,
  };

  my $result = {
    name => 'on.name',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

sub error_on_synopsis {
  my ($self, $data) = @_;

  my $message = 'Test file "{{file}}" missing synopsis section';

  my $stash = {
    file => $self->file,
  };

  my $result = {
    name => 'on.synopsis',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

sub error_on_tagline {
  my ($self, $data) = @_;

  my $message = 'Test file "{{file}}" missing tagline section';

  my $stash = {
    file => $self->file,
  };

  my $result = {
    name => 'on.tagline',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

1;
