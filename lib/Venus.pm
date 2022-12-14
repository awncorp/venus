package Venus;

use 5.018;

use strict;
use warnings;

# VERSION

our $VERSION = '1.66';

# AUTHORITY

our $AUTHORITY = 'cpan:AWNCORP';

# IMPORTS

sub import {
  my ($self, @args) = @_;

  my $target = caller;

  no strict 'refs';

  my %exports = (
    cast => 1,
    catch => 1,
    error => 1,
    false => 1,
    raise => 1,
    true => 1,
  );

  @args = grep defined && !ref && /^[A-Za-z]/ && $exports{$_}, @args;

  my %seen;
  for my $name (grep !$seen{$_}++, @args, 'true', 'false') {
    *{"${target}::${name}"} = $self->can($name) if !$target->can($name);
  }

  return $self;
}

# FUNCTIONS

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

sub raise ($;$) {
  my ($self, $data) = @_;

  ($self, my $parent) = (@$self) if (ref($self) eq 'ARRAY');

  $data //= {};
  $data->{context} //= (caller(1))[3];

  $parent = 'Venus::Error' if !$parent;

  require Venus::Throw;

  return Venus::Throw->new(package => $self, parent => $parent)->error($data);
}

sub true () {
  require Venus::True;

  return Venus::True->value;
}

1;