package Venus::Assert;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

use Venus::Match;
use Venus::Type;

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

use overload (
  '&{}' => sub{$_[0]->validator},
  fallback => 1,
);

# ATTRIBUTES

attr 'expects';
attr 'message';
attr 'name';

# BUILDERS

sub build_arg {
  my ($self, $name) = @_;

  return {
    name => $name,
  };
}

sub build_self {
  my ($self, $data) = @_;

  my $name = 'Unknown';
  my $message = 'Type assertion (%s) failed: received (%s), expected (%s)';

  $self->name($name) if !$self->name;
  $self->message($message) if !$self->message;
  $self->expects([]) if !$self->expects;
  $self->conditions;

  return $self;
}

# METHODS

sub any {
  my ($self) = @_;

  $self->constraints->when(sub{true})->then(sub{true});

  return $self;
}

sub accept {
  my ($self, $name, @args) = @_;

  if (!$name) {
    return $self;
  }
  if ($self->can($name)) {
    return $self->$name(@args);
  }
  else {
    return $self->identity($name, @args);
  }
}

sub array {
  my ($self, @code) = @_;

  $self->constraint('array', @code ? @code : sub{true});

  return $self;
}

sub arrayref {
  my ($self, @code) = @_;

  return $self->array(@code);
}

sub attributes {
  my ($self, @pairs) = @_;

  $self->object(sub{
    my $check = 0;
    my $value = $_->value;
    return false if @pairs % 2;
    for (my $i = 0; $i < @pairs;) {
      my ($key, $data) = (map $pairs[$_], $i++, $i++);
      my ($match, @args) = (ref $data) ? (@{$data}) : ($data);
      $check++ if $value->can($key)
        && $self->new->do($match, @args)->check($value->$key);
    }
    ((@pairs / 2) == $check) ? true : false
  });

  return $self;
}

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->expression('string');

  return $assert;
}

sub boolean {
  my ($self, @code) = @_;

  $self->constraint('boolean', @code ? @code : sub{true});

  return $self;
}

sub check {
  my ($self, $data) = @_;

  my $value = Venus::Type->new(value => $data);

  my @args = (value => $value, on_none => sub{false});

  return $self->constraints->renew(@args)->result;
}

sub checker {
  my ($self, $data) = @_;

  $self->expression($data) if $data;

  return $self->defer('check');
}

sub clear {
  my ($self) = @_;

  $self->constraints->clear;
  $self->coercions->clear;

  return $self;
}

sub code {
  my ($self, @code) = @_;

  $self->constraint('code', @code ? @code : sub{true});

  return $self;
}

sub coderef {
  my ($self, @code) = @_;

  return $self->code(@code);
}

sub coerce {
  my ($self, $data) = @_;

  my $value = Venus::Type->new(value => $data);

  my @args = (value => $value, on_none => sub{$data});

  return $self->coercions->renew(@args)->result;
}

sub coercion {
  my ($self, $type, $code) = @_;

  $self->coercions->when('coded', $type)->then($code);

  return $self;
}

sub coercions {
  my ($self) = @_;

  my $match = Venus::Match->new;

  return $self->{coercions} ||= $match if ref $self;

  return $match;
}

sub conditions {
  my ($self) = @_;

  return $self;
}

sub constraint {
  my ($self, $type, $code) = @_;

  $self->constraints->when('coded', $type)->then($code);

  return $self;
}

sub constraints {
  my ($self) = @_;

  my $match = Venus::Match->new;

  return $self->{constraints} ||= $match if ref $self;

  return $match;
}

sub consumes {
  my ($self, $role) = @_;

  my $where = $self->constraint('object', sub{true})->constraints->where;

  $where->when(sub{$_->value->DOES($role)})->then(sub{true});

  return $self;
}

sub defined {
  my ($self, @code) = @_;

  $self->constraints->when(sub{CORE::defined($_->value)})
    ->then(@code ? @code : sub{true});

  return $self;
}

sub either {
  my ($self, @data) = @_;

  for (my $i = 0; $i < @data; $i++) {
    my ($match, @args) = (ref $data[$i]) ? (@{$data[$i]}) : ($data[$i]);
    $self->accept($match, @args);
  }

  return $self;
}

sub enum {
  my ($self, @data) = @_;

  for my $item (@data) {
    $self->constraints->when(sub{CORE::defined($_->value) && $_->value eq $item})
      ->then(sub{true});
  }

  return $self;
}

sub expression {
  my ($self, $data) = @_;

  return $self if !$data;

  $data =
  $data =~ s/\s*\n+\s*/ /gr =~ s/^\s+|\s+$//gr =~ s/\[\s+/[/gr =~ s/\s+\]/]/gr;

  $self->expects([$data]);

  my @parsed = $self->parse($data);

  $self->either(@parsed);

  return $self;
}

sub float {
  my ($self, @code) = @_;

  $self->constraint('float', @code ? @code : sub{true});

  return $self;
}

sub format {
  my ($self, $name, @code) = @_;

  if (!$name) {
    return $self;
  }
  if (lc($name) eq 'array') {
    return $self->coercion('array', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'boolean') {
    return $self->coercion('boolean', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'code') {
    return $self->coercion('code', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'float') {
    return $self->coercion('float', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'hash') {
    return $self->coercion('hash', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'number') {
    return $self->coercion('number', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'object') {
    return $self->coercion('object', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'regexp') {
    return $self->coercion('regexp', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'scalar') {
    return $self->coercion('scalar', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'string') {
    return $self->coercion('string', @code ? (@code) : sub{$_->value});
  }
  elsif (lc($name) eq 'undef') {
    return $self->coercion('undef', @code ? (@code) : sub{$_->value});
  }
  else {
    return $self->coercion('object', sub {
      UNIVERSAL::isa($_->value, $name)
        ? (@code ? $code[0]->($_->value) : $_->value)
        : $_->value;
    });
  }
}

sub hash {
  my ($self, @code) = @_;

  $self->constraint('hash', @code ? @code : sub{true});

  return $self;
}

sub hashkeys {
  my ($self, @pairs) = @_;

  $self->constraints->when(sub{
    CORE::defined($_->value) && UNIVERSAL::isa($_->value, 'HASH')
      && (keys %{$_->value}) > 0
  })->then(sub{
    my $check = 0;
    my $value = $_->value;
    return false if @pairs % 2;
    for (my $i = 0; $i < @pairs;) {
      my ($key, $data) = (map $pairs[$_], $i++, $i++);
      my ($match, @args) = (ref $data) ? (@{$data}) : ($data);
      $check++ if $self->new->do($match, @args)->check($value->{$key});
    }
    ((@pairs / 2) == $check) ? true : false
  });

  return $self;
}

sub hashref {
  my ($self, @code) = @_;

  return $self->hash(@code);
}

sub identity {
  my ($self, $name) = @_;

  $self->constraint('object', sub {$_->value->isa($name) ? true : false});

  return $self;
}

sub inherits {
  my ($self, $name) = @_;

  $self->constraint('object', sub {$_->value->isa($name) ? true : false});

  return $self;
}

sub integrates {
  my ($self, $name) = @_;

  $self->constraint('object', sub {
    $_->value->can('does') ? ($_->value->does($name) ? true : false) : false
  });

  return $self;
}

sub maybe {
  my ($self, $match, @args) = @_;

  $self->$match(@args) if $match;
  $self->undef;

  return $self;
}

sub number {
  my ($self, @code) = @_;

  $self->constraint('number', @code ? @code : sub{true});

  return $self;
}

sub object {
  my ($self, @code) = @_;

  $self->constraint('object', @code ? @code : sub{true});

  return $self;
}

sub package {
  my ($self) = @_;

  my $where = $self->constraint('string', sub{true})->constraints->where;

  $where->when(sub{$_->value =~ /^[A-Z](?:(?:\w|::)*[a-zA-Z0-9])?$/})->then(sub{
    require Venus::Space;

    Venus::Space->new($_->value)->loaded
  });

  return $self;
}

sub parse {
  my ($self, $expr) = @_;

  $expr ||= '';

  $expr =
  $expr =~ s/\s*\n+\s*/ /gr =~ s/^\s+|\s+$//gr =~ s/\[\s+/[/gr =~ s/\s+\]/]/gr;

  return _type_parse($expr);
}

sub received {
  my ($self, $data) = @_;

  require Scalar::Util;

  if (!defined $data) {
    return '';
  }

  my $blessed = Scalar::Util::blessed($data);
  my $isvenus = $blessed && $data->isa('Venus::Core') && $data->can('does');

  if (!$blessed && !ref $data) {
    return $data;
  }
  if ($blessed && ref($data) eq 'Regexp') {
    return "$data";
  }
  if ($isvenus && $data->does('Venus::Role::Explainable')) {
    return $self->dump(sub{$data->explain});
  }
  if ($isvenus && $data->does('Venus::Role::Valuable')) {
    return $self->dump(sub{$data->value});
  }
  if ($isvenus && $data->does('Venus::Role::Dumpable')) {
    return $data->dump;
  }
  if ($blessed && overload::Method($data, '""')) {
    return "$data";
  }
  if ($blessed && $data->can('as_string')) {
    return $data->as_string;
  }
  if ($blessed && $data->can('to_string')) {
    return $data->to_string;
  }
  if ($blessed && $data->isa('Venus::Kind')) {
    return $data->stringified;
  }
  else {
    return $self->dump(sub{$data});
  }
}

sub reference {
  my ($self, @code) = @_;

  $self->constraints
    ->when(sub{CORE::defined($_->value) && ref($_->value)})
    ->then(@code ? @code : sub{true});

  return $self;
}

sub regexp {
  my ($self, @code) = @_;

  $self->constraint('regexp', @code ? @code : sub{true});

  return $self;
}

sub render {
  my ($self, $into, $data) = @_;

  return _type_render($into, $data);
}

sub routines {
  my ($self, @data) = @_;

  $self->object->constraints->then(sub{
    my $value = $_->value;
    (@data == grep $value->can($_), @data) ? true : false
  });

  return $self;
}

sub scalar {
  my ($self, @code) = @_;

  $self->constraint('scalar', @code ? @code : sub{true});

  return $self;
}

sub scalarref {
  my ($self, @code) = @_;

  return $self->scalar(@code);
}

sub string {
  my ($self, @code) = @_;

  $self->constraint('string', @code ? @code : sub{true});

  return $self;
}

sub tuple {
  my ($self, @data) = @_;

  $self->constraints->when(sub{
    CORE::defined($_->value) && CORE::ref($_->value) eq 'ARRAY'
      && @data == @{$_->value}
  })->then(sub{
    my $check = 0;
    my $value = $_->value;
    return false if @data != @$value;
    for (my $i = 0; $i < @data; $i++) {
      my ($match, @args) = (ref $data[$i]) ? (@{$data[$i]}) : ($data[$i]);
      $check++ if $self->new->do($match, @args)->check($value->[$i]);
    }
    (@data == $check) ? true : false
  });

  return $self;
}

sub undef {
  my ($self, @code) = @_;

  $self->constraint('undef', @code ? @code : sub{true});

  return $self;
}

sub validate {
  my ($self, $data) = @_;

  my $valid = $self->check($data);

  return $data if $valid;

  require Scalar::Util;

  my $identity = lc(Venus::Type->new(value => $data)->identify);
  my $expected = (join ' OR ', @{$self->expects}) || 'indescribable constraints';
  my $message = sprintf($self->message, $self->name, $identity, $expected);

  $self->throw('error_on_validate', $data)->error;

  return;
}

sub validator {
  my ($self, $data) = @_;

  $self->expression($data) if $data;

  return $self->defer('validate');
}

sub value {
  my ($self, @code) = @_;

  $self->constraints
    ->when(sub{CORE::defined($_->value) && !ref($_->value)})
    ->then(@code ? @code : sub{true});

  return $self;
}

sub within {
  my ($self, $type, @next) = @_;

  if (!$type) {
    return $self;
  }

  my $where = $self->new;

  if (lc($type) eq 'hash' || lc($type) eq 'hashref') {
    $self->constraints->when(sub{
      CORE::defined($_->value) && UNIVERSAL::isa($_->value, 'HASH')
        && (keys %{$_->value}) > 0
    })->then(sub{
      my $value = $_->value;
      UNIVERSAL::isa($value, 'HASH')
        && CORE::values(%$value) == grep $where->check($_), CORE::values(%$value)
    });
  }
  elsif (lc($type) eq 'array' || lc($type) eq 'arrayref') {
    $self->constraints->when(sub{
      CORE::defined($_->value) && UNIVERSAL::isa($_->value, 'ARRAY')
        && @{$_->value} > 0
    })->then(sub{
      my $value = $_->value;
      UNIVERSAL::isa($value, 'ARRAY')
        && @$value == grep $where->check($_), @$value
    });
  }
  else {
    $self->throw('error_on_within', $type, @next)->error;
  }

  $where->accept(map +(ref($_) ? @$_ : $_), $next[0]) if @next;

  return $where;
}

sub yesno {
  my ($self, @code) = @_;

  $self->constraints->when(sub{
    CORE::defined($_->value) && $_->value =~ /^(?:1|y(?:es)?|0|n(?:o)?)$/i
  })->then(@code ? @code : sub{true});

  return $self;
}

# ERRORS

sub error_on_validate {
  my ($self, $data) = @_;

  require Venus::Type;

  my $legend = {
    array => 'arrayref',
    code => 'coderef',
    hash => 'hashref',
    regexp => 'regexpref',
    scalar => 'scalarref',
    scalar => 'scalarref',
  };

  my $identity = Venus::Type->new(value => $data)->identify;
     $identity = $legend->{lc($identity)} || lc($identity);

  my $expected = (join ' OR ', @{$self->expects}) || 'indescribable constraints';

  my $message = sprintf($self->message, $self->name, $identity, $expected);
     $message .= "\n\nReceived:\n\n\"@{[$self->received($data)]}\"\n\n";

  return {
    name => 'on.validate',
    message => $message,
    stash => {
      identity => $identity,
      variable => $data,
    },
  };
}

sub error_on_within {
  my ($self, $type, @args) = @_;

  return {
    name => 'on.within',
    message => "Invalid type (\"$type\") provided to the \"within\" method",
    stash => {
      self => $self,
      type => $type,
      args => [@args],
    },
  };
}

# ROUTINES

sub _type_parse {
  my @items = _type_parse_pipes(@_);

  my $either = @items > 1;

  @items = map _type_parse_nested($_), @items;

  return wantarray && !$either ? @items : [$either ? ("either") : (), @items];
}

sub _type_parse_lists {
  my @items = @_;

  my $r0 = '[\"\'\[\]]';
  my $r1 = '[^\"\'\[\]]';
  my $r2 = _type_subexpr_type_2();
  my $r3 = _type_subexpr_delimiter();

  return (
    grep length,
      map {split/,\s*(?=(?:$r1*$r0$r1*$r0)*$r1*$)(${r2}(?:${r3}[^,]*)?)?/}
        @items
  );
}

sub _type_parse_nested {
  my ($expr) = @_;

  return ($expr) if $expr !~ _type_regexp(_type_subexpr_type_2());

  my @items = ($expr);

  @items = ($expr =~ /^(\w+)\s*\[\s*(.*)\s*\]+$/g);

  @items = map _type_parse_lists($_), @items;

  @items = map +(
    $_ =~ qr/^@{[_type_subexpr_type_2()]},.*$/ ? _type_parse_lists($_) : $_
  ),
  @items;

  @items = map {s/^["']+|["']+$//gr} @items;

  @items = map _type_parse($_), @items;

  return (@items > 1 ? [@items] : @items);
}

sub _type_parse_pipes {
  my ($expr) = @_;

  my @items;

  # i.e. tuple[number, string] | tuple[string, number]
  if
  (
    _type_regexp_eval(
      $expr, _type_regexp(_type_subexpr_type_2(), _type_subexpr_type_2())
    )
  )
  {
    @items = map _type_parse_tuples($_),
      _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_2(), _type_subexpr_type_2()));
  }
  # i.e. string | tuple[number, string]
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_1(), _type_subexpr_type_2()))
  )
  {
    @items = map _type_parse_tuples($_),
      _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_1(), _type_subexpr_type_2()));
  }
  # i.e. tuple[number, string] | string
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_2(), _type_subexpr_type_1()))
  )
  {
    @items = map _type_parse_tuples($_),
      _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_2(), _type_subexpr_type_1()));
  }
  # special condition: i.e. tuple[number, string]
  elsif
  (
    _type_regexp_eval($expr, _type_regexp(_type_subexpr_type_2()))
  )
  {
    @items = ($expr);
  }
  # i.e. "..." | tuple[number, string]
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_3(), _type_subexpr_type_2()))
  )
  {
    @items = _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_3(), _type_subexpr_type_2()));
    @items = (_type_parse_pipes($items[0]), _type_parse_tuples($items[1]));
  }
  # i.e. tuple[number, string] | "..."
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_2(), _type_subexpr_type_3()))
  )
  {
    @items = _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_2(), _type_subexpr_type_3()));
    @items = (_type_parse_tuples($items[0]), _type_parse_pipes($items[1]));
  }
  # i.e. Package::Name | "..."
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_4(), _type_subexpr_type_3()))
  )
  {
    @items = _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_4(), _type_subexpr_type_3()));
    @items = ($items[0], _type_parse_pipes($items[1]));
  }
  # i.e. "..." | Package::Name
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_3(), _type_subexpr_type_4()))
  )
  {
    @items = _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_3(), _type_subexpr_type_4()));
    @items = (_type_parse_pipes($items[0]), $items[1]);
  }
  # i.e. string | "..."
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_1(), _type_subexpr_type_3()))
  )
  {
    @items = _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_1(), _type_subexpr_type_3()));
    @items = ($items[0], _type_parse_pipes($items[1]));
  }
  # i.e. "..." | string
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_3(), _type_subexpr_type_1()))
  )
  {
    @items = _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_3(), _type_subexpr_type_1()));
    @items = (_type_parse_pipes($items[0]), $items[1]);
  }
  # i.e. "..." | "..."
  elsif
  (
    _type_regexp_eval($expr,
      _type_regexp(_type_subexpr_type_3(), _type_subexpr_type_3()))
  )
  {
    @items = map _type_parse_pipes($_),
      _type_regexp_eval($expr,
      _type_regexp_groups(_type_subexpr_type_3(), _type_subexpr_type_3()));
  }
  else {
    @items = ($expr);
  }

  return (@items);
}

sub _type_parse_tuples {
  map +(scalar(_type_regexp_eval($_,
    _type_regexp(_type_subexpr_type_2(), _type_subexpr_type_2())))
      ? (_type_parse_pipes($_))
      : ($_)), @_
}

sub _type_regexp {
  qr/^@{[_type_regexp_joined(@_)]}$/
}

sub _type_regexp_eval {
  map {s/^\s+|\s+$//gr} ($_[0] =~ $_[1])
}

sub _type_regexp_groups {
  qr/^@{[_type_regexp_joined(_type_subexpr_groups(@_))]}$/
}

sub _type_regexp_joined {
  join(_type_subexpr_delimiter(), @_)
}

sub _type_render {
  my ($into, $data) = @_;

  if (ref $data eq 'HASH') {
    $data = join ', ', map +(qq("$_"), _type_render($into, $$data{$_})),
      sort keys %{$data};
    $data = "$into\[$data\]";
  }

  if (ref $data eq 'ARRAY') {
    $data = join ', ', map +(/^\w+$/ ? qq("$_") : $_), @{$data};
    $data = "$into\[$data\]";
  }

  return $data;
}

sub _type_subexpr_delimiter {
  '\s*\|\s*'
}

sub _type_subexpr_groups {
  map "($_)", @_
}

sub _type_subexpr_type_1 {
  '\w+'
}

sub _type_subexpr_type_2 {
  '\w+\s*\[.*\]+'
}

sub _type_subexpr_type_3 {
  '.*'
}

sub _type_subexpr_type_4 {
  '[A-Za-z][:\^\w]+\w*'
}

1;
