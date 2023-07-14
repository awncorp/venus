package Venus;

use 5.018;

use strict;
use warnings;

# VERSION

our $VERSION = '3.18';

# AUTHORITY

our $AUTHORITY = 'cpan:AWNCORP';

# IMPORTS

sub import {
  my ($self, @args) = @_;

  my $target = caller;

  no strict 'refs';

  my %exports = (
    args => 1,
    array => 1,
    arrayref => 1,
    assert => 1,
    bool => 1,
    box => 1,
    call => 1,
    cast => 1,
    catch => 1,
    caught => 1,
    chain => 1,
    check => 1,
    clargs => 1,
    cli => 1,
    code => 1,
    config => 1,
    cop => 1,
    data => 1,
    date => 1,
    error => 1,
    false => 1,
    fault => 1,
    float => 1,
    gather => 1,
    hash => 1,
    hashref => 1,
    is_false => 1,
    is_true => 1,
    json => 1,
    list => 1,
    load => 1,
    log => 1,
    make => 1,
    match => 1,
    merge => 1,
    meta => 1,
    name => 1,
    number => 1,
    opts => 1,
    pairs => 1,
    path => 1,
    perl => 1,
    process => 1,
    proto => 1,
    raise => 1,
    random => 1,
    regexp => 1,
    replace => 1,
    render => 1,
    roll => 1,
    search => 1,
    space => 1,
    schema => 1,
    string => 1,
    syscall => 1,
    template => 1,
    test => 1,
    then => 1,
    throw => 1,
    true => 1,
    try => 1,
    type => 1,
    unpack => 1,
    vars => 1,
    venus => 1,
    work => 1,
    wrap => 1,
    yaml => 1,
  );

  @args = grep defined && !ref && /^[A-Za-z]/ && $exports{$_}, @args;

  my %seen;
  for my $name (grep !$seen{$_}++, @args, 'true', 'false') {
    *{"${target}::${name}"} = $self->can($name) if !$target->can($name);
  }

  return $self;
}

# HOOKS

sub _qx {
  my (@args) = @_;
  local $| = 1;
  local $SIG{__WARN__} = sub {};
  (do{local $_ = qx(@{[@args]}); chomp if $_; $_}, $?, ($? >> 8))
}

# FUNCTIONS

sub args ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Args;

  if (!$code) {
    return Venus::Args->new($data);
  }

  return Venus::Args->new($data)->$code(@args);
}

sub array ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Array;

  if (!$code) {
    return Venus::Array->new($data);
  }

  return Venus::Array->new($data)->$code(@args);
}

sub arrayref (@) {
  my (@args) = @_;

  return @args > 1
    ? ([@args])
    : ((ref $args[0] eq 'ARRAY') ? ($args[0]) : ([@args]));
}

sub assert ($$) {
  my ($data, $expr) = @_;

  require Venus::Assert;

  my $assert = Venus::Assert->new('name', 'assert(?, ?)')->expression($expr);

  return $assert->validate($data);
}

sub bool (;$) {
  my ($data) = @_;

  require Venus::Boolean;

  return Venus::Boolean->new($data);
}

sub box ($) {
  my ($data) = @_;

  require Venus::Box;

  my $box = Venus::Box->new($data);

  return $box;
}

sub call (@) {
  my ($data, @args) = @_;
  my $next = @args;
  if ($next && UNIVERSAL::isa($data, 'CODE')) {
    return $data->(@args);
  }
  my $code = shift(@args);
  if ($next && Scalar::Util::blessed($data)) {
    return $data->$code(@args) if UNIVERSAL::can($data, $code)
      || UNIVERSAL::can($data, 'AUTOLOAD');
    $next = 0;
  }
  if ($next && ref($data) eq 'SCALAR') {
    return $$data->$code(@args) if UNIVERSAL::can(load($$data)->package, $code);
    $next = 0;
  }
  if ($next && UNIVERSAL::can(load($data)->package, $code)) {
    no strict 'refs';
    return *{"${data}::${code}"}{"CODE"} ?
      &{"${data}::${code}"}(@args) : $data->$code(@args[1..$#args]);
  }
  if ($next && UNIVERSAL::can($data, 'AUTOLOAD')) {
    no strict 'refs';
    return &{"${data}::${code}"}(@args);
  }
  fault("Exception! call(@{[join(', ', map qq('$_'), @_)]}) failed.");
}

sub cast (;$$) {
  my ($data, $into) = (@_ ? (@_) : ($_));

  require Venus::Type;

  my $type = Venus::Type->new($data);

  return $into ? $type->cast($into) : $type->deduce;
}

sub catch (&) {
  my ($data) = @_;

  my $error;

  require Venus::Try;

  my @result = Venus::Try->new($data)->error(\$error)->result;

  return wantarray ? ($error ? ($error, undef) : ($error, @result)) : $error;
}

sub caught ($$;&) {
  my ($data, $type, $code) = @_;

  ($type, my($name)) = @$type if ref $type eq 'ARRAY';

  my $is_true = $data
    && UNIVERSAL::isa($data, $type)
    && UNIVERSAL::isa($data, 'Venus::Error')
    && (
      $data->name
        ? ($name ? $data->of($name) : true())
        : (!$name ? true() : false())
    );

  if ($is_true) {
    local $_ = $data;

    return $code ? $code->($data) : $data;
  }
  else {
    return undef;
  }
}

sub chain {
  my ($data, @args) = @_;

  return if !$data;

  for my $next (map +(ref($_) eq 'ARRAY' ? $_ : [$_]), @args) {
    $data = call($data, @$next);
  }

  return $data;
}

sub check ($$) {
  my ($data, $expr) = @_;

  require Venus::Assert;

  return Venus::Assert->new->expression($expr)->check($data);
}

sub clargs (@) {
  my (@args) = @_;

  my ($argv, $specs) = (@args > 1)
    ? (map arrayref($_), @args)
    : ([@ARGV], arrayref(@args));

  return (
    args($argv), opts($argv, 'reparse', $specs), vars({}),
  );
}

sub cli (;$) {
  my ($data) = @_;

  require Venus::Cli;

  my $cli = Venus::Cli->new($data || [@ARGV]);

  return $cli;
}

sub code ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Code;

  if (!$code) {
    return Venus::Code->new($data);
  }

  return Venus::Code->new($data)->$code(@args);
}

sub config ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Config;

  if (!$code) {
    return Venus::Config->new($data);
  }

  return Venus::Config->new($data)->$code(@args);
}

sub cop (@) {
  my ($data, @args) = @_;

  require Scalar::Util;

  ($data, $args[0]) = map {
    ref eq 'SCALAR' ? $$_ : Scalar::Util::blessed($_) ? ref($_) : $_
  } ($data, $args[0]);

  return space("$data")->cop(@args);
}

sub data ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Data;

  if (!$code) {
    return Venus::Data->new($data);
  }

  return Venus::Data->new($data)->$code(@args);
}

sub date ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Date;

  if (!$code) {
    return Venus::Date->new($data);
  }

  return Venus::Date->new($data)->$code(@args);
}

sub error (;$) {
  my ($data) = @_;

  $data //= {};
  $data->{context} //= (caller(1))[3];

  require Venus::Throw;

  return Venus::Throw->new->error($data);
}

sub false () {

  require Venus::False;

  return Venus::False->value;
}

sub fault (;$) {
  my ($data) = @_;

  require Venus::Fault;

  return Venus::Fault->new($data)->throw;
}

sub float ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Float;

  if (!$code) {
    return Venus::Float->new($data);
  }

  return Venus::Float->new($data)->$code(@args);
}

sub gather ($;&) {
  my ($data, $code) = @_;

  require Venus::Gather;

  my $match = Venus::Gather->new($data);

  return $match if !$code;

  local $_ = $match;

  my $returned = $code->($match, $data);

  $match->data($returned) if ref $returned eq 'HASH';

  return $match->result;
}

sub hash ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Hash;

  if (!$code) {
    return Venus::Hash->new($data);
  }

  return Venus::Hash->new($data)->$code(@args);
}

sub hashref (@) {
  my (@args) = @_;

  return @args > 1
    ? ({(scalar(@args) % 2) ? (@args, undef) : @args})
    : ((ref $args[0] eq 'HASH')
    ? ($args[0])
    : ({(scalar(@args) % 2) ? (@args, undef) : @args}));
}

sub is_false ($) {
  my ($data) = @_;

  require Venus::Boolean;

  return Venus::Boolean->new($data)->is_false;
}

sub is_true ($) {
  my ($data) = @_;

  require Venus::Boolean;

  return Venus::Boolean->new($data)->is_true;
}

sub json (;$$) {
  my ($code, $data) = @_;

  require Venus::Json;

  if (!$code) {
    return Venus::Json->new;
  }

  if (lc($code) eq 'decode') {
    return Venus::Json->new->decode($data);
  }

  if (lc($code) eq 'encode') {
    return Venus::Json->new(value => $data)->encode;
  }

  return fault(qq(Invalid "json" action "$code"));
}

sub list (@) {
  my (@args) = @_;

  return map {defined $_ ? (ref eq 'ARRAY' ? (@{$_}) : ($_)) : ($_)} @args;
}

sub load ($) {
  my ($data) = @_;

  return space($data)->do('load');
}

sub log (@) {
  my (@args) = @_;

  require Venus::Log;

  return Venus::Log->new->debug(@args);
}

sub make (@) {

  return if !@_;

  return call($_[0], 'new', @_);
}

sub match ($;&) {
  my ($data, $code) = @_;

  require Venus::Match;

  my $match = Venus::Match->new($data);

  return $match if !$code;

  local $_ = $match;

  my $returned = $code->($match, $data);

  $match->data($returned) if ref $returned eq 'HASH';

  return $match->result;
}

sub merge (@) {
  my (@args) = @_;

  require Venus::Hash;

  return Venus::Hash->new({})->merge(@args);
}

sub meta ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Meta;

  if (!$code) {
    return Venus::Meta->new(name => $data);
  }

  return Venus::Meta->new(name => $data)->$code(@args);
}

sub name ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Name;

  if (!$code) {
    return Venus::Name->new($data);
  }

  return Venus::Name->new($data)->$code(@args);
}

sub number ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Number;

  if (!$code) {
    return Venus::Number->new($data);
  }

  return Venus::Number->new($data)->$code(@args);
}

sub opts ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Opts;

  if (!$code) {
    return Venus::Opts->new($data);
  }

  return Venus::Opts->new($data)->$code(@args);
}

sub pairs (@) {
  my ($args) = @_;

  my $result = defined $args
    ? (
    ref $args eq 'ARRAY'
    ? ([map {[$_, $args->[$_]]} 0..$#{$args}])
    : (ref $args eq 'HASH' ? ([map {[$_, $args->{$_}]} sort keys %{$args}]) : ([])))
    : [];

  return wantarray ? @{$result} : $result;
}

sub path ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Path;

  if (!$code) {
    return Venus::Path->new($data);
  }

  return Venus::Path->new($data)->$code(@args);
}

sub perl (;$$) {
  my ($code, $data) = @_;

  require Venus::Dump;

  if (!$code) {
    return Venus::Dump->new;
  }

  if (lc($code) eq 'decode') {
    return Venus::Dump->new->decode($data);
  }

  if (lc($code) eq 'encode') {
    return Venus::Dump->new(value => $data)->encode;
  }

  return fault(qq(Invalid "perl" action "$code"));
}

sub process (;$@) {
  my ($code, @args) = @_;

  require Venus::Process;

  if (!$code) {
    return Venus::Process->new;
  }

  return Venus::Process->new->$code(@args);
}

sub proto ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Prototype;

  if (!$code) {
    return Venus::Prototype->new($data);
  }

  return Venus::Prototype->new($data)->$code(@args);
}

sub raise ($;$) {
  my ($self, $data) = @_;

  ($self, my $parent) = (@$self) if (ref($self) eq 'ARRAY');

  $data //= {};
  $data->{context} //= (caller(1))[3];

  $parent = 'Venus::Error' if !$parent;

  require Venus::Throw;

  return Venus::Throw->new(package => $self, parent => $parent)->error($data);
}

sub random (;$@) {
  my ($code, @args) = @_;

  require Venus::Random;

  state $random = Venus::Random->new;

  if (!$code) {
    return $random;
  }

  return $random->$code(@args);
}

sub regexp ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Regexp;

  if (!$code) {
    return Venus::Regexp->new($data);
  }

  return Venus::Regexp->new($data)->$code(@args);
}

sub render ($;$) {
  my ($data, $args) = @_;

  return template($data, 'render', undef, $args || {});
}

sub replace ($;$@) {
  my ($data, $code, @args) = @_;

  my @keys = qw(
    string
    regexp
    substr
  );

  my @data = (ref $data eq 'ARRAY' ? (map +(shift(@keys), $_), @{$data}) : $data);

  require Venus::Replace;

  if (!$code) {
    return Venus::Replace->new(@data);
  }

  return Venus::Replace->new(@data)->$code(@args);
}

sub roll (@) {

  return (@_[1,0,2..$#_]);
}

sub schema ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Schema;

  if (!$code) {
    return Venus::Schema->new($data);
  }

  return Venus::Schema->new($data)->$code(@args);
}

sub search ($;$@) {
  my ($data, $code, @args) = @_;

  my @keys = qw(
    string
    regexp
  );

  my @data = (ref $data eq 'ARRAY' ? (map +(shift(@keys), $_), @{$data}) : $data);

  require Venus::Search;

  if (!$code) {
    return Venus::Search->new(@data);
  }

  return Venus::Search->new(@data)->$code(@args);
}

sub space ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Space;

  if (!$code) {
    return Venus::Space->new($data);
  }

  return Venus::Space->new($data)->$code(@args);
}

sub string ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::String;

  if (!$code) {
    return Venus::String->new($data);
  }

  return Venus::String->new($data)->$code(@args);
}

sub syscall ($;@) {
  my (@args) = @_;

  require Venus::Os;

  for (my $i = 0; $i < @args; $i++) {
    if ($args[$i] =~ /^\|+$/) {
      next;
    }
    if ($args[$i] =~ /^\&+$/) {
      next;
    }
    if ($args[$i] =~ /^\w+$/) {
      next;
    }
    if ($args[$i] =~ /^[<>]+$/) {
      next;
    }
    if ($args[$i] =~ /^\d[<>&]+\d?$/) {
      next;
    }
    if ($args[$i] =~ /\$[A-Z]\w+/) {
      next;
    }
    if ($args[$i] =~ /^\$\((.*)\)$/) {
      next;
    }
    $args[$i] = Venus::Os->quote($args[$i]);
  }

  my ($data, $exit, $code) = (_qx(@args));

  return wantarray ? ($data, $code) : (($exit == 0) ? true() : false());
}

sub template ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Template;

  if (!$code) {
    return Venus::Template->new($data);
  }

  return Venus::Template->new($data)->$code(@args);
}

sub test ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Test;

  if (!$code) {
    return Venus::Test->new($data);
  }

  return Venus::Test->new($data)->$code(@args);
}

sub then (@) {

  return ($_[0], call(@_));
}

sub throw ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Throw;

  my $throw = Venus::Throw->new(context => (caller(1))[3])->do(
    frame => 1,
  );

  if (ref $data ne 'HASH') {
    $throw->package($data) if $data;
  }
  else {
    if (exists $data->{as}) {
      $throw->as($data->{as});
    }
    if (exists $data->{capture}) {
      $throw->capture(@{$data->{capture}});
    }
    if (exists $data->{context}) {
      $throw->context($data->{context});
    }
    if (exists $data->{error}) {
      $throw->error($data->{error});
    }
    if (exists $data->{frame}) {
      $throw->frame($data->{frame});
    }
    if (exists $data->{message}) {
      $throw->message($data->{message});
    }
    if (exists $data->{name}) {
      $throw->name($data->{name});
    }
    if (exists $data->{package}) {
      $throw->package($data->{package});
    }
    if (exists $data->{parent}) {
      $throw->parent($data->{parent});
    }
    if (exists $data->{stash}) {
      $throw->stash($_, $data->{stash}->{$_}) for keys %{$data->{stash}};
    }
    if (exists $data->{on}) {
      $throw->on($data->{on});
    }
  }

  return $throw if !$code;

  return $throw->$code(@args);
}

sub true () {

  require Venus::True;

  return Venus::True->value;
}

sub try ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Try;

  if (!$code) {
    return Venus::Try->new($data);
  }

  return Venus::Try->new($data)->$code(@args);
}

sub type ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Type;

  if (!$code) {
    return Venus::Type->new($data);
  }

  return Venus::Type->new($data)->$code(@args);
}

sub unpack (@) {
  my (@args) = @_;

  require Venus::Unpack;

  return Venus::Unpack->new->do('args', @args)->all;
}

sub vars ($;$@) {
  my ($data, $code, @args) = @_;

  require Venus::Vars;

  if (!$code) {
    return Venus::Vars->new($data);
  }

  return Venus::Vars->new($data)->$code(@args);
}

sub venus ($;@) {
  my ($name, @args) = @_;

  @args = ('new') if !@args;

  return chain(\space(join('/', 'Venus', $name))->package, @args);
}

sub work ($) {
  my ($data) = @_;

  require Venus::Process;

  return Venus::Process->new->do('work', $data);
}

sub wrap ($;$) {
  my ($data, $name) = @_;

  return if !@_;

  my $moniker = $name // $data =~ s/\W//gr;
  my $caller = caller(0);

  no strict 'refs';
  no warnings 'redefine';

  return *{"${caller}::${moniker}"} = sub {@_ ? make($data, @_) : $data};
}

sub yaml (;$$) {
  my ($code, $data) = @_;

  require Venus::Yaml;

  if (!$code) {
    return Venus::Yaml->new;
  }

  if (lc($code) eq 'decode') {
    return Venus::Yaml->new->decode($data);
  }

  if (lc($code) eq 'encode') {
    return Venus::Yaml->new(value => $data)->encode;
  }

  return fault(qq(Invalid "yaml" action "$code"));
}

1;