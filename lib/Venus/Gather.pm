package Venus::Gather;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Valuable';
with 'Venus::Role::Buildable';
with 'Venus::Role::Accessible';

use Scalar::Util ();

# ATTRIBUTES

attr 'on_none';
attr 'on_only';
attr 'on_then';
attr 'on_when';

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  $self->on_none(sub{}) if !$self->on_none;
  $self->on_only(sub{1}) if !$self->on_only;
  $self->on_then([]) if !$self->on_then;
  $self->on_when([]) if !$self->on_when;

  return $self;
}

# METHODS

sub clear {
  my ($self) = @_;

  $self->on_none(sub{});
  $self->on_only(sub{1});
  $self->on_then([]);
  $self->on_when([]);

  return $self;
}

sub data {
  my ($self, $data) = @_;

  while(my($key, $value) = each(%$data)) {
    $self->just($key)->then($value);
  }

  return $self;
}

sub expr {
  my ($self, $topic) = @_;

  $self->when(sub{
    my $value = $_[0];

    if (!defined $value) {
      return false;
    }
    if (Scalar::Util::blessed($value) && !overload::Overloaded($value)) {
      return false;
    }
    if (!Scalar::Util::blessed($value) && ref($value)) {
      return false;
    }
    if (ref($topic) eq 'Regexp' && "$value" =~ qr/$topic/) {
      return true;
    }
    elsif ("$value" eq "$topic") {
      return true;
    }
    else {
      return false;
    }
  });

  return $self;
}

sub just {
  my ($self, $topic) = @_;

  $self->when(sub{
    my $value = $_[0];

    if (!defined $value) {
      return false;
    }
    if (Scalar::Util::blessed($value) && !overload::Overloaded($value)) {
      return false;
    }
    if (!Scalar::Util::blessed($value) && ref($value)) {
      return false;
    }
    if ("$value" eq "$topic") {
      return true;
    }
    else {
      return false;
    }
  });

  return $self;
}

sub none {
  my ($self, $code) = @_;

  $self->on_none(UNIVERSAL::isa($code, 'CODE') ? $code : sub{$code});

  return $self;
}

sub only {
  my ($self, $code) = @_;

  $self->on_only($code);

  return $self;
}

sub result {
  my ($self, $data) = @_;

  $self->value(ref $data eq 'ARRAY' ? $data : [$data]) if $data;

  my $value = $self->value;
  my $result = [];
  my $matched = 0;

  local $_ = $value;
  return wantarray ? ($result, $matched) : $result if !$self->on_only->($value);

  for my $item (@$value) {
    local $_ = $item;
    for (my $i = 0; $i < @{$self->on_when}; $i++) {
      if ($self->on_when->[$i]->($item)) {
        push @$result, $self->on_then->[$i]->($item);
        $matched++;
        last;
      }
    }
  }

  if (!@$result) {
    local $_ = $value;
    my @return = ($self->on_none->($value));
    push @$result,
      ((@return == 1 && ref($return[0]) eq 'ARRAY') ? @{$return[0]} : @return);
  }

  return wantarray ? ($result, $matched) : $result;
}

sub skip {
  my ($self) = @_;

  $self->then(sub{return ()});

  return $self;
}

sub take {
  my ($self) = @_;

  $self->then(sub{return (@_)});

  return $self;
}

sub test {
  my ($self) = @_;

  my $matched = 0;

  my $value = $self->value;

  local $_ = $value;
  return $matched if !$self->on_only->($value);

  for my $item (@$value) {
    local $_ = $item;
    for (my $i = 0; $i < @{$self->on_when}; $i++) {
      if ($self->on_when->[$i]->($item)) {
        $matched++;
        last;
      }
    }
  }

  return $matched;
}

sub then {
  my ($self, $code) = @_;

  my $next = $#{$self->on_when};

  $self->on_then->[$next] = UNIVERSAL::isa($code, 'CODE') ? $code : sub{$code};

  return $self;
}

sub when {
  my ($self, $code, @args) = @_;

  my $next = (@{$self->on_when}-$#{$self->on_then}) > 1 ? -1 : @{$self->on_when};

  $self->on_when->[$next] = sub {
    (local $_ = $_[0])->$code(@args);
  };

  return $self;
}

sub where {
  my ($self) = @_;

  my $where = $self->new;

  $self->then(sub{@{scalar($where->result(@_))}});

  return $where;
}

1;
