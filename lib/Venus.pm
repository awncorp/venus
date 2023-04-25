package Venus;

use 5.018;

use strict;
use warnings;

# VERSION

our $VERSION = '2.50';

# AUTHORITY

our $AUTHORITY = 'cpan:AWNCORP';

# IMPORTS

sub import {
  my ($self, @args) = @_;

  my $target = caller;

  no strict 'refs';

  my %exports = (
    args => 1,
    assert => 1,
    box => 1,
    call => 1,
    cast => 1,
    catch => 1,
    caught => 1,
    chain => 1,
    check => 1,
    cop => 1,
    error => 1,
    false => 1,
    fault => 1,
    json => 1,
    load => 1,
    log => 1,
    make => 1,
    merge => 1,
    perl => 1,
    raise => 1,
    roll => 1,
    space => 1,
    then => 1,
    true => 1,
    unpack => 1,
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

# FUNCTIONS

sub args (@) {
  my (@args) = @_;

  return (!@args)
    ? ({})
    : ((@args == 1 && ref($args[0]) eq 'HASH')
    ? (!%{$args[0]} ? {} : {%{$args[0]}})
    : (@args % 2 ? {@args, undef} : {@args}));
}

sub assert ($$) {
  my ($data, $expr) = @_;

  require Venus::Assert;

  my $assert = Venus::Assert->new('name', 'assert(?, ?)')->expression($expr);

  return $assert->validate($data);
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

sub cop (@) {
  my ($data, @args) = @_;

  require Scalar::Util;

  ($data, $args[0]) = map {
    ref eq 'SCALAR' ? $$_ : Scalar::Util::blessed($_) ? ref($_) : $_
  } ($data, $args[0]);

  return space("$data")->cop(@args);
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

sub json ($;$) {
  my ($code, $data) = @_;

  require Venus::Json;

  if (lc($code) eq 'decode') {
    return Venus::Json->new->decode($data);
  }

  if (lc($code) eq 'encode') {
    return Venus::Json->new($data)->encode;
  }

  return undef;
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

sub merge (@) {
  my (@args) = @_;

  require Venus::Hash;

  return Venus::Hash->new({})->merge(@args);
}

sub perl ($;$) {
  my ($code, $data) = @_;

  require Venus::Dump;

  if (lc($code) eq 'decode') {
    return Venus::Dump->new->decode($data);
  }

  if (lc($code) eq 'encode') {
    return Venus::Dump->new($data)->encode;
  }

  return undef;
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

sub roll (@) {

  return (@_[1,0,2..$#_]);
}

sub space ($) {
  my ($data) = @_;

  require Venus::Space;

  return Venus::Space->new($data);
}

sub then (@) {

  return ($_[0], call(@_));
}

sub true () {

  require Venus::True;

  return Venus::True->value;
}

sub unpack (@) {
  my (@args) = @_;

  require Venus::Unpack;

  return Venus::Unpack->new->do('args', @args)->all;
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

sub yaml ($;$) {
  my ($code, $data) = @_;

  require Venus::Yaml;

  if (lc($code) eq 'decode') {
    return Venus::Yaml->new->decode($data);
  }

  if (lc($code) eq 'encode') {
    return Venus::Yaml->new($data)->encode;
  }

  return undef;
}

1;