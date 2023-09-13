package Venus::Assert;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Buildable';

use overload (
  '&{}' => sub{$_[0]->validator},
  fallback => 1,
);

# ATTRIBUTES

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

  $self->conditions;

  return $self;
}

# METHODS

sub accept {
  my ($self, $name, @args) = @_;

  return $self if !$name;

  $self->check->accept($name, @args);

  return $self;
}

sub check {
  my ($self, @args) = @_;

  require Venus::Check;

  $self->{check} = $args[0] if @args;

  $self->{check} ||= Venus::Check->new;

  return $self->{check};
}

sub clear {
  my ($self) = @_;

  $self->check->clear;
  $self->constraint->clear;
  $self->coercion->clear;

  return $self;
}

sub coerce {
  my ($self, $data) = @_;

  return $self->coercion->result($self->value($data));
}

sub coercion {
  my ($self, @args) = @_;

  require Venus::Coercion;

  $self->{coercion} = $args[0] if @args;

  $self->{coercion} ||= Venus::Coercion->new->do('check', $self->check);

  return $self->{coercion};
}

sub conditions {
  my ($self) = @_;

  return $self;
}

sub constraint {
  my ($self, @args) = @_;

  require Venus::Constraint;

  $self->{constraint} = $args[0] if @args;

  $self->{constraint} ||= Venus::Constraint->new->do('check', $self->check);

  return $self->{constraint};
}

sub ensure {
  my ($self, @code) = @_;

  $self->constraint->ensure(@code);

  return $self;
}

sub expression {
  my ($self, $data) = @_;

  return $self if !$data;

  $data =
  $data =~ s/\s*\n+\s*/ /gr =~ s/^\s+|\s+$//gr =~ s/\[\s+/[/gr =~ s/\s+\]/]/gr;

  $self->name($data) if !$self->name;

  my $parsed = $self->parse($data);

  $self->accept(
    @{$parsed} > 0
    ? ((ref $parsed->[0] eq 'ARRAY') ? @{$parsed->[0]} : @{$parsed})
    : @{$parsed}
  );

  return $self;
}

sub format {
  my ($self, @code) = @_;

  $self->coercion->format(@code);

  return $self;
}

sub match {
  my ($self, @args) = @_;

  require Venus::Coercion;
  my $match = Venus::Coercion->new->accept(@args);

  push @{$self->matches}, sub {
    my ($source, $value) = @_;
    local $_ = $value;
    return $match->result($value);
  };

  return $match;
}

sub matches {
  my ($self) = @_;

  my $matches = $self->{'matches'} ||= [];

  return wantarray ? (@{$matches}) : $matches;
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

sub render {
  my ($self, $into, $data) = @_;

  return _type_render($into, $data);
}

sub result {
  my ($self, $data) = @_;

  return $self->coerce($self->validate($self->value($data)));
}

sub valid {
  my ($self, $data) = @_;

  return $self->constraint->result($self->value($data));
}

sub validate {
  my ($self, $data) = @_;

  my $valid = $self->valid($data);

  return $data if $valid;

  my $error = $self->check->catch('result');

  my $received = $self->received($data);

  my $message = join("\n\n",
    'Type:',
    ($self->name || 'Unknown'),
    'Failure:',
    $error->message,
    'Received:',
    (defined $data ? ($received eq '' ? '""' : $received) : ('(undefined)')),
  );

  $error->message($message);

  return $error->throw;
}

sub validator {
  my ($self) = @_;

  return $self->defer('validate');
}

sub value {
  my ($self, $data) = @_;

  my $result = $data;

  for my $match ($self->matches) {
    $result = $match->($self, $result);
  }

  return $result;
}

# ROUTINES

sub _type_parse {
  my @items = _type_parse_pipes(@_);

  my $either = @items > 1;

  @items = map _type_parse_nested($_), @items;

  return wantarray && !$either ? (@items) : [$either ? ("either") : (), @items];
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
