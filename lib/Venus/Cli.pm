package Venus::Cli;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Stashable';

require POSIX;

# ATTRIBUTES

attr 'data';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    data => $data,
  };
}

sub build_self {
  my ($self, $data) = @_;

  $self->{data} ||= [@ARGV];

  return $self;
}

# HOOKS

sub _exit {
  POSIX::_exit(shift);
}

sub _print {
  do {local $| = 1; CORE::print(@_, "\n")}
}

sub _prompt {
  do {local $\ = ''; local $_ = <STDIN>; chomp; $_}
}

# METHODS

sub arg {
  my ($self, $name) = @_;

  return undef if !$name;

  my @values;

  my $data = $self->get('arg', $name) or return undef;
  my $_default = $data->{default};
  my $_help = $data->{help};
  my $_label = $data->{label};
  my $_name = $data->{name};
  my $_prompt = $data->{prompt};
  my $_range = $data->{range};
  my $_required = $data->{required};
  my $_type = $data->{type};

  require Venus::Array;
  require Venus::Unpack;

  # value
  @values = @{Venus::Array->new($self->parser->unused)->range($_range // 0)};

  # prompt
  if ($_prompt && (!@values || !defined $values[0])) {
    @values = (do{_print join ': ', $_label || $_name, $_prompt; _prompt}); _print;
  }

  # default
  if (defined $_default
    && (!@values || !defined $values[0] || $values[0] eq '')
    && exists $data->{default})
  {
    @values = ($_default);
  }

  my %type_map = (
    boolean => 'number',
    float => 'float',
    number => 'number',
    string => 'string',
    yesno => 'yesno',
  );

  # type
  if ($_type) {
    my ($caught, @values) = Venus::Unpack->new(args => [@values])->all->catch(
      'validate', $type_map{$_type}
    );
    if ($caught) {
      my $throw;
      my $error = join ': ', 'Invalid argument', $name, $caught->message;
      $throw = $self->throw;
      $throw->name('on.arg');
      $throw->message($error);
      $throw->stash(name => $_name);
      $throw->stash(type => $_type);
      $throw->error;
    }
  }

  # return boolean values
  @values = map +(lc($_type) eq 'boolean' ? ($_ ? true : false) : $_), @values
    if $_type;

  # returns
  return wantarray ? (@values) : [@values];
}

sub cmd {
  my ($self, $name) = @_;

  return undef if !$name;

  my $data = $self->get('cmd', $name) or return undef;

  my ($caught, $value) = $self->catch('arg', $data->{arg});

  if ($caught) {
    my $throw;
    $throw = $self->throw;
    $throw->name('on.cmd');
    $throw->message($caught->message);
    $throw->stash($_ => $caught->stash($_)) for keys %{$caught->stash};
    $throw->error;
  }

  return ($value eq $name) ? true : false;
}

sub exit {
  my ($self, $code, $method, @args) = @_;

  $self->$method(@args) if $method;

  $code ||= 0;

  _exit($code);
}

sub fail {
  my ($self, $method, @args) = @_;

  return $self->exit(1, $method, @args);
}

sub get {
  my ($self, $key, $name) = @_;

  return undef if !$key;

  my $method = "get_${key}";

  return $self->$method($name);
}

sub get_arg {
  my ($self, $name) = @_;

  return $self->store('arg', $name);
}

sub get_arg_default {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'default');
}

sub get_arg_help {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'help');
}

sub get_arg_label {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'label');
}

sub get_arg_name {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'name');
}

sub get_arg_prompt {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'prompt');
}

sub get_arg_range {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'range');
}

sub get_arg_required {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'required');
}

sub get_arg_type {
  my ($self, $name) = @_;

  return $self->store('arg', $name, 'type');
}

sub get_cmd {
  my ($self, $name) = @_;

  return $self->store('cmd', $name);
}

sub get_cmd_arg {
  my ($self, $name) = @_;

  return $self->store('cmd', $name, 'arg');
}

sub get_cmd_help {
  my ($self, $name) = @_;

  return $self->store('cmd', $name, 'help');
}

sub get_cmd_label {
  my ($self, $name) = @_;

  return $self->store('cmd', $name, 'label');
}

sub get_cmd_name {
  my ($self, $name) = @_;

  return $self->store('cmd', $name, 'name');
}

sub get_opt {
  my ($self, $name) = @_;

  return $self->store('opt', $name);
}

sub get_opt_alias {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'alias');
}

sub get_opt_default {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'default');
}

sub get_opt_help {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'help');
}

sub get_opt_label {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'label');
}

sub get_opt_multi {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'multi') ? true : false;
}

sub get_opt_name {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'name');
}

sub get_opt_prompt {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'prompt');
}

sub get_opt_required {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'required');
}

sub get_opt_type {
  my ($self, $name) = @_;

  return $self->store('opt', $name, 'type');
}

sub get_str {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'value');
}

sub get_str_arg {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'arg');
}

sub get_str_author {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'author');
}

sub get_str_description {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'description');
}

sub get_str_footer {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'footer');
}

sub get_str_header {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'header');
}

sub get_str_name {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'name');
}

sub get_str_opt {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'opt');
}

sub get_str_opts {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'opts');
}

sub get_str_version {
  my ($self, $name) = @_;

  return $self->store('str', $name, 'version');
}

sub help {
  my ($self) = @_;

  my @output = ($self->help_usage);

  # description
  if (my $description = $self->help_description) {
    push @output, $description;
  }

  # header
  if (my $header = $self->help_header) {
    push @output, $header;
  }

  # arguments
  if (my $arguments = $self->help_arguments) {
    push @output, $arguments;
  }

  # options
  if (my $options = $self->help_options) {
    push @output, $options;
  }

  # commands
  if (my $commands = $self->help_commands) {
    push @output, $commands;
  }

  # footer
  if (my $footer = $self->help_footer) {
    push @output, $footer;
  }

  return join("\n\n", @output);
}

sub help_arg {
  my ($self, $name) = @_;

  my @result;

  my $data = $self->get('arg', $name) or return ();

  my $_help = $data->{help};
  my $_name = $data->{name};
  my $_range = $data->{range};
  my $_required = $data->{required};
  my $_type = $data->{type};
  my $_multi = $_range && $_range =~ /:/;

  my $note = $_name;

  if ($_multi) {
    $note = "$note, ...";
  }

  push @result, [
    '', $note
  ];

  if ($_help) {
    push @result, [
      _wrap_text(4, 80, [split / /, $_help])
    ];
  }

  if ($_required) {
    push @result, [
      '', '', '(required)'
    ];
  }
  else {
    push @result, [
      '', '', '(optional)'
    ];
  }

  if ($_type) {
    push @result, [
      '', '', "($_type)"
    ];
  }

  return join("\n", map join('  ', @{$_}), @result);
}

sub help_args {
  my ($self) = @_;

  my @result;

  my $order = $self->store('arg_order') || {};

  for my $index (sort keys %{$order}) {
    push @result, $self->help_arg($order->{$index});
  }

  return join("\n\n", @result);
}

sub help_arguments {
  my ($self) = @_;

  my $arguments = $self->help_args or return ();

  return join "\n\n", "Arguments:", $arguments;
}

sub help_author {
  my ($self) = @_;

  return $self->str('author') || ();
}

sub help_cmd {
  my ($self, $name) = @_;

  my @result;

  my $data = $self->get('cmd', $name) or return ();

  my $_help = $data->{help};
  my $_name = $data->{name};

  my $arg = $self->get('arg', $data->{arg})  || {};

  my $_range = $arg->{range};
  my $_required = $arg->{required};
  my $_type = $arg->{type};
  my $_multi = $_range && $_range =~ /:/;

  my $note = $_name;

  if ($_multi) {
    $note = "$note, ...";
  }

  push @result, [
    '', $note
  ];

  if ($_help) {
    push @result, [
      _wrap_text(4, 80, [split / /, $_help])
    ];
  }

  if ($arg->{name}) {
    push @result, [
      '', '', sprintf("(%s)", $arg->{name})
    ];
  }

  return join("\n", map join('  ', @{$_}), @result);
}

sub help_cmds {
  my ($self) = @_;

  my @result;

  my $order = $self->store('cmd_order') || {};

  for my $index (sort keys %{$order}) {
    push @result, $self->help_cmd($order->{$index});
  }

  return join("\n\n", @result);
}

sub help_commands {
  my ($self) = @_;

  my $commands = $self->help_cmds or return ();

  return join "\n\n", "Commands:", $commands;
}

sub help_description {
  my ($self) = @_;

  my $description = $self->str('description') or return ();

  return join "\n", map _wrap_text(0, 80, [split / /, $_]), split /\n/, $description;
}

sub help_footer {
  my ($self) = @_;

  my $footer = $self->str('footer') or return ();

  return join "\n", map _wrap_text(0, 80, [split / /, $_]), split /\n/, $footer;
}

sub help_header {
  my ($self) = @_;

  my $header = $self->str('header') or return ();

  return join "\n", map _wrap_text(0, 80, [split / /, $_]), split /\n/, $header;
}

sub help_name {
  my ($self) = @_;

  return $self->str('name') || 'application';
}

sub help_opt {
  my ($self, $name) = @_;

  my @result;

  my $data = $self->get('opt', $name) or return ();

  my $_alias = $data->{alias};
  my $_help = $data->{help};
  my $_multi = $data->{multi};
  my $_name = $data->{name};
  my $_required = $data->{required};
  my $_type = $data->{type};

  my $note = "--$_name";

  my %type_map = (
    boolean => undef,
    float => 'float',
    number => 'number',
    string => 'string',
    yesno => 'yesno',
  );

  $note = "$note=<$_name>" if $_type && $type_map{$_type};

  if ($_alias) {
    $note = join(', ',
      (map "-$_", (ref $_alias eq 'ARRAY' ? sort @{$_alias} : $_alias)), $note);
  }

  if ($_multi) {
    $note = "$note, ...";
  }

  push @result, [
    '', $note
  ];

  if ($_help) {
    push @result, [
      _wrap_text(4, 80, [split / /, $_help])
    ];
  }

  if ($_required) {
    push @result, [
      '', '', '(required)'
    ];
  }
  else {
    push @result, [
      '', '', '(optional)'
    ];
  }

  if ($_type) {
    push @result, [
      '', '', "($_type)"
    ];
  }

  return join("\n", map join('  ', @{$_}), @result);
}

sub help_options {
  my ($self) = @_;

  my $options = $self->help_opts or return ();

  return join "\n\n", "Options:", $options;
}

sub help_opts {
  my ($self) = @_;

  my @result;

  my $order = $self->store('opt_order') || {};

  for my $index (sort keys %{$order}) {
    push @result, $self->help_opt($order->{$index});
  }

  return join("\n\n", @result);
}

sub help_usage {
  my ($self) = @_;

  my @result;

  my $name = $self->help_name;

  if (my $has_args = $self->get('arg')) {
    my $has_multi = keys(%{$has_args}) > 1 ? 1 : 0;
    my $has_required = 0;

    for my $data (values(%{$has_args})) {
      my $_range = $data->{range};
      my $_required = $data->{required};
      my $_multi = $_range && $_range =~ /:/;

      $has_multi = 1 if $_multi;
      $has_required = 1 if $_required;
    }

    my $token = '<argument>';

    $token = "$token, ..." if $has_multi;
    $token = "[$token]" if !$has_required;

    push @result, $token;
  }

  if (my $has_opts = $self->get('opt')) {
    my $has_multi = keys(%{$has_opts}) > 1 ? 1 : 0;
    my $has_required = 0;

    for my $data (values(%{$has_opts})) {
      my $_range = $data->{range};
      my $_required = $data->{required};
      my $_multi = $_range && $_range =~ /:/;

      $has_multi = 1 if $_multi;
      $has_required = 1 if $_required;
    }

    my $token = '<option>';

    $token = "$token, ..." if $has_multi;
    $token = "[$token]" if !$has_required;

    push @result, $token;
  }

  return join ' ', 'Usage:', $self->help_name, @result;
}

sub help_version {
  my ($self) = @_;

  return $self->str('version') || ();
}

sub okay {
  my ($self, $method, @args) = @_;

  return $self->exit(0, $method, @args);
}

sub opt {
  my ($self, $name) = @_;

  return undef if !$name;

  my @values;

  my $data = $self->get('opt', $name) or return undef;
  my $_default = $data->{default};
  my $_help = $data->{help};
  my $_label = $data->{label};
  my $_multi = $data->{multi};
  my $_name = $data->{name};
  my $_prompt = $data->{prompt};
  my $_required = $data->{required};
  my $_type = $data->{type};

  require Venus::Array;
  require Venus::Unpack;

  my $parsed = $self->parser->get($name);

  # value
  @values = ref $parsed eq 'ARRAY' ? @{$parsed} : $parsed;

  # prompt
  if ($_prompt && (!@values || !defined $values[0])) {
    @values = (do{_print join ': ', $_label || $_name, $_prompt; _prompt}); _print;
  }

  # default
  if (defined $_default
    && (!@values || !defined $values[0] || $values[0] eq '')
    && exists $data->{default})
  {
    @values = ($_default);
  }

  my %type_map = (
    boolean => 'number',
    float => 'float',
    number => 'number',
    string => 'string',
    yesno => 'yesno',
  );

  # type
  if ($_type) {
    my ($caught, @values) = Venus::Unpack->new(args => [@values])->all->catch(
      'validate', $type_map{$_type}
    );
    if ($caught) {
      my $throw;
      my $error = join ': ', 'Invalid option', $name, $caught->message;
      $throw = $self->throw;
      $throw->name('on.opt');
      $throw->message($error);
      $throw->stash(name => $_name);
      $throw->stash(type => $_type);
      $throw->error;
    }
  }

  # return boolean values
  @values = map +(lc($_type) eq 'boolean' ? ($_ ? true : false) : $_), @values
    if $_type;

  # returns
  return wantarray ? (@values) : [@values];
}

sub parsed {
  my ($self) = @_;

  my $data = {};

  my $args = $self->store('arg') || {};

  for my $key (keys %{$args}) {
    my @values = $self->arg($key);
    $data->{$key} = @values > 1 ? [@values] : $values[0];
  }

  my $opts = $self->store('opt') || {};

  for my $key (keys %{$opts}) {
    my @values = $self->opt($key);
    $data->{$key} = @values > 1 ? [@values] : $values[0];
  }

  return $data;
}

sub parser {
  my ($self) = @_;

  require Venus::Opts;

  return Venus::Opts->new(value => $self->data, specs => $self->spec);
}

sub set {
  my ($self, $key, $name, $data) = @_;

  return undef if !$key;

  my $method = "set_${key}";

  return $self->$method($name, $data);
}

sub set_arg {
  my ($self, $name, $data) = @_;

  $self->set_arg_name($name, $name);

  do{my $method = "set_arg_$_"; $self->$method($name, $data->{$_})}
    for keys %{$data};

  my $store = $self->store;

  $store->{arg_order} ||= {};

  my $index = keys %{$store->{arg_order}} || 0;

  $store->{arg_order}->{$index} = $name;

  return $self;
}

sub set_arg_default {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'default', @args);
}

sub set_arg_help {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'help', @args);
}

sub set_arg_label {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'label', @args);
}

sub set_arg_name {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'name', @args);
}

sub set_arg_prompt {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'prompt', @args);
}

sub set_arg_range {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'range', @args);
}

sub set_arg_required {
  my ($self, $name, @args) = @_;

  return $self->store('arg', $name, 'required', @args);
}

sub set_arg_type {
  my ($self, $name, @args) = @_;

  my %type_map = (
    boolean => 'boolean',
    flag => 'boolean',
    float => 'float',
    number => 'number',
    string => 'string',
    yesno => 'yesno',
  );

  return $self->store('arg', $name, 'type', map +($type_map{$_} || 'boolean'),
    @args);
}

sub set_cmd {
  my ($self, $name, $data) = @_;

  $self->set_cmd_name($name, $name);

  $self->store('cmd', $name, $_, $data->{$_}) for keys %{$data};

  my $store = $self->store;

  $store->{cmd_order} ||= {};

  my $index = keys %{$store->{cmd_order}} || 0;

  $store->{cmd_order}->{$index} = $name;

  return $self;
}

sub set_cmd_arg {
  my ($self, $name, @args) = @_;

  return $self->store('cmd', $name, 'arg', @args);
}

sub set_cmd_help {
  my ($self, $name, @args) = @_;

  return $self->store('cmd', $name, 'help', @args);
}

sub set_cmd_label {
  my ($self, $name, @args) = @_;

  return $self->store('cmd', $name, 'label', @args);
}

sub set_cmd_name {
  my ($self, $name, @args) = @_;

  return $self->store('cmd', $name, 'name', @args);
}

sub set_opt {
  my ($self, $name, $data) = @_;

  $self->set_opt_name($name, $name);

  do{my $method = "set_opt_$_"; $self->$method($name, $data->{$_})}
    for keys %{$data};

  my $store = $self->store;

  $store->{opt_order} ||= {};

  my $index = keys %{$store->{opt_order}} || 0;

  $store->{opt_order}->{$index} = $name;

  return $self;
}

sub set_opt_alias {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'alias', @args);
}

sub set_opt_default {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'default', @args);
}

sub set_opt_help {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'help', @args);
}

sub set_opt_label {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'label', @args);
}

sub set_opt_multi {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'multi', @args ? true : false);
}

sub set_opt_name {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'name', @args);
}

sub set_opt_prompt {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'prompt', @args);
}

sub set_opt_required {
  my ($self, $name, @args) = @_;

  return $self->store('opt', $name, 'required', @args);
}

sub set_opt_type {
  my ($self, $name, @args) = @_;

  my %type_map = (
    boolean => 'boolean',
    flag => 'boolean',
    float => 'float',
    number => 'number',
    string => 'string',
    yesno => 'yesno',
  );

  return $self->store('opt', $name, 'type', map +($type_map{$_} || 'boolean'),
    @args);
}

sub set_str {
  my ($self, $name, $data) = @_;

  $self->store('str', $name, 'value', $data);

  return $self;
}

sub set_str_arg {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'arg', @args);
}

sub set_str_author {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'author', @args);
}

sub set_str_description {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'description', @args);
}

sub set_str_footer {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'footer', @args);
}

sub set_str_header {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'header', @args);
}

sub set_str_name {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'name', @args);
}

sub set_str_opt {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'opt', @args);
}

sub set_str_opts {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'opts', @args);
}

sub set_str_version {
  my ($self, $name, @args) = @_;

  return $self->store('str', $name, 'version', @args);
}

sub spec {
  my ($self) = @_;

  my $result = [];

  my $order = $self->store('opt_order') || {};

  for my $index (sort keys %{$order}) {
    my $item = $self->store('opt', $order->{$index}) or next;
    my $_alias = $item->{alias};
    my $_multi = $item->{multi};
    my $_name = $item->{name};
    my $_type = $item->{type};

    my $note = "$_name";

    if ($_alias) {
      $note = join('|', $note,
        (ref $_alias eq 'ARRAY' ? sort @{$_alias} : $_alias));
    }

    my %type_map = (
      boolean => undef,
      float => 'f',
      number => 'i',
      string => 's',
      yesno => 's',
    );

    $note = join '=', $note, ($type_map{$_type} || ()) if $_type;
    $note = "$note\@" if $_multi;

    push @{$result}, $note;
  }

  return $result;
}

sub store {
  my ($self, $key, $name, @args) = @_;

  my $config = $self->stash->{config} ||= {};

  return $config if !$key;

  return $config->{$key} if !$name;

  return ((exists $config->{$key})
      && (exists $config->{$key}->{$name}))
    ? $config->{$key}->{$name}
    : undef
    if !@args;

  my ($prop, @data) = @args;

  return ((exists $config->{$key})
      && (exists $config->{$key}->{$name})
      && (exists $config->{$key}->{$name}->{$prop}))
    ? $config->{$key}->{$name}->{$prop}
    : undef
    if !@data;

  $config->{$key} ||= {};

  $config->{$key}->{$name} ||= {};

  $config->{$key}->{$name}->{$prop} = $data[0];

  return $self;
}

sub str {
  my ($self, $name) = @_;

  return undef if !$name;

  return $self->get_str($name);
}

# ROUTINES

sub _wrap_text {
  my ($indent, $length, $parts) = @_;

  my @results;
  my $size = 0;
  my $index = 0;

  for my $part (@{$results[$index]}) {
    $size += length($part) + 1 + $indent;
  }
  for my $part (@{$parts}) {
    if (($size + length($part) + 1 + $indent) > $length) {
      $index += 1;
      $size = length($part);
      $results[$index] = [];
    }
    else {
      $size += length($part) + 1;
    }
    push @{$results[$index]}, $part;
  }

  return join "\n",
    map {($indent ? (" " x $indent) : '') . join " ", @{$_}} @results;
}

1;
