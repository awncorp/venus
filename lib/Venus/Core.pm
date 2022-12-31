package Venus::Core;

use 5.018;

use strict;
use warnings;

# METHODS

sub ARGS {
  my ($self, @args) = @_;

  return (!@args)
    ? ($self->DATA)
    : ((@args == 1 && ref($args[0]) eq 'HASH')
    ? (!%{$args[0]} ? $self->DATA : {%{$args[0]}})
    : (@args % 2 ? {@args, undef} : {@args}));
}

sub ATTR {
  my ($self, $attr, @args) = @_;

  no strict 'refs';
  no warnings 'redefine';

  *{"@{[$self->NAME]}::$attr"} = sub {$_[0]->ITEM($attr, @_[1..$#_])}
    if !$self->can($attr);

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{ATTR}})) + 1;

  $${"@{[$self->NAME]}::META"}{ATTR}{$attr} = [$index, [$attr, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub AUDIT {
  my ($self) = @_;

  return $self;
}

sub BASE {
  my ($self, $base, @args) = @_;

  no strict 'refs';

  if (!grep !/\A[^:]+::\z/, keys(%{"${base}::"})) {
    local $@; eval "require $base"; do{require Venus; Venus::fault($@)} if $@;
  }

  @{"@{[$self->NAME]}::ISA"} = (
    $base, (grep +($_ ne $base), @{"@{[$self->NAME]}::ISA"})
  );

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{BASE}})) + 1;

  $${"@{[$self->NAME]}::META"}{BASE}{$base} = [$index, [$base, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub BLESS {
  my ($self, @args) = @_;

  my $name = $self->NAME;
  my $data = $self->DATA($self->ARGS($self->BUILDARGS(@args)));
  my $anew = bless($data, $name);

  no strict 'refs';

  $anew->BUILD($data);

  # FYI, every call to "new" calls "BUILD" which dispatches to each "BUILD"
  # defined in each attached role.

  # If one (or more) roles use reflection (i.e. calls "META") to introspect the
  # package's configuration, that could cause a performance problem given that
  # the Venus::Meta class uses recursion to introspect all superclasses and
  # roles in order to determine and present aggregate lists of package members.

  # The solution to this is to cache the associated Venus::Meta object which
  # itself caches the results of its recursive lookups. The cache is stored on
  # the subclass (i.e. on the calling package) the cache wil go away whenever
  # the package does, e.g. Venus::Space#unload.

  ${"${name}::@{[$self->METAOBJECT]}"} ||= Venus::Meta->new(name => $name)
    if $name ne 'Venus::Meta';

  return $anew;
}

sub BUILD {
  my ($self) = @_;

  return $self;
}

sub BUILDARGS {
  my ($self, @args) = @_;

  return (@args);
}

sub DATA {
  my ($self, $data) = @_;

  return $data ? {%$data} : {};
}

sub DESTROY {
  my ($self) = @_;

  return;
}

sub DOES {
  my ($self, $role) = @_;

  return if !$role;

  return $self->META->role($role);
}

sub EXPORT {
  my ($self, $into) = @_;

  return [];
}

sub FROM {
  my ($self, $base) = @_;

  $self->BASE($base);

  $base->AUDIT($self->NAME) if $base->can('AUDIT');

  no warnings 'redefine';

  $base->IMPORT($self->NAME);

  return $self;
}

sub IMPORT {
  my ($self, $into) = @_;

  return $self;
}

sub ITEM {
  my ($self, $name, @args) = @_;

  return undef if !$name;
  return $self->{$name} if !@args;
  return $self->{$name} = $args[0];
}

sub META {
  my ($self) = @_;

  no strict 'refs';

  require Venus::Meta;

  my $name = $self->NAME;

  return ${"${name}::@{[$self->METAOBJECT]}"}
    || Venus::Meta->new(name => $name);
}

sub METAOBJECT {
  my ($self) = @_;

  return 'METAOBJECT';
}

sub MIXIN {
  my ($self, $mixin, @args) = @_;

  no strict 'refs';

  if (!grep !/\A[^:]+::\z/, keys(%{"${mixin}::"})) {
    local $@; eval "require $mixin"; do{require Venus; Venus::fault($@)} if $@;
  }

  no warnings 'redefine';

  $mixin->IMPORT($self->NAME);

  no strict 'refs';

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{MIXIN}})) + 1;

  $${"@{[$self->NAME]}::META"}{MIXIN}{$mixin} = [$index, [$mixin, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub NAME {
  my ($self) = @_;

  return ref $self || $self;
}

sub ROLE {
  my ($self, $role, @args) = @_;

  no strict 'refs';

  if (!grep !/\A[^:]+::\z/, keys(%{"${role}::"})) {
    local $@; eval "require $role"; do{require Venus; Venus::fault($@)} if $@;
  }

  no warnings 'redefine';

  $role->IMPORT($self->NAME);

  no strict 'refs';

  my $index = int(keys(%{$${"@{[$self->NAME]}::META"}{ROLE}})) + 1;

  $${"@{[$self->NAME]}::META"}{ROLE}{$role} = [$index, [$role, @args]];

  ${"@{[$self->NAME]}::@{[$self->METAOBJECT]}"} = undef;

  return $self;
}

sub SUBS {
  my ($self) = @_;

  no strict 'refs';

  return [
    sort grep *{"@{[$self->NAME]}::$_"}{"CODE"},
    grep /^[_a-zA-Z]\w*$/, keys %{"@{[$self->NAME]}::"}
  ];
}

sub TEST {
  my ($self, $role) = @_;

  $self->ROLE($role);

  $role->AUDIT($self->NAME) if $role->can('AUDIT');

  return $self;
}

1;
