package Venus::Meta;

use 5.018;

use strict;
use warnings;

use Venus;

use base 'Venus::Core';

# METHODS

sub attr {
  my ($self, $name) = @_;

  return 0 if !$name;

  my $data = {map +($_,$_), @{$self->attrs}};

  return $data->{$name} ? true : false;
}

sub attrs {
  my ($self) = @_;

  if ($self->{attrs}) {
    return $self->{attrs};
  }

  my $name = $self->{name};
  my @attrs = attrs_resolver($name);

  for my $base (@{$self->bases}) {
    push @attrs, attrs_resolver($base);
  }

  for my $role (@{$self->roles}) {
    push @attrs, attrs_resolver($role);
  }

  my %seen;
  return $self->{attrs} ||= [grep !$seen{$_}++, @attrs];
}

sub attrs_resolver {
  my ($name) = @_;

  no strict 'refs';
  no warnings 'once';

  if (${"${name}::META"} && $${"${name}::META"}{ATTR}) {
    return (sort {
      $${"${name}::META"}{ATTR}{$a}[0] <=> $${"${name}::META"}{ATTR}{$b}[0]
    } keys %{$${"${name}::META"}{ATTR}});
  }
  else {
    return ();
  }
}

sub base {
  my ($self, $name) = @_;

  return 0 if !$name;

  my $data = {map +($_,$_), @{$self->bases}};

  return $data->{$name} ? true : false;
}

sub bases {
  my ($self) = @_;

  if ($self->{bases}) {
    return $self->{bases};
  }

  my $name = $self->{name};
  my @bases = bases_resolver($name);

  for my $base (@bases) {
    push @bases, bases_resolver($base);
  }

  my %seen;
  return $self->{bases} ||= [grep !$seen{$_}++, @bases];
}

sub bases_resolver {
  my ($name) = @_;

  no strict 'refs';

  return (@{"${name}::ISA"});
}

sub data {
  my ($self) = @_;

  my $name = $self->{name};

  no strict 'refs';

  return ${"${name}::META"};
}


sub find {
  my ($self, $type, $name) = @_;

  return if !$type;
  return if !$name;

  my $configs;

  for my $source (qw(roles bases mixins self)) {
    $configs = $self->search($source, $type, $name);
    last if @$configs;
  }

  return $configs->[0];
}

sub local {
  my ($self, $type) = @_;

  return if !$type;

  my $name = $self->{name};

  no strict 'refs';

  return if !int grep $type eq $_, qw(attrs bases mixins roles subs);

  my $function = "${type}_resolver";

  return [&{"${function}"}($name)];
}

sub mixin {
  my ($self, $name) = @_;

  return 0 if !$name;

  my $data = {map +($_,$_), @{$self->mixins}};

  return $data->{$name} ? true : false;
}

sub mixins {
  my ($self) = @_;

  if ($self->{mixins}) {
    return $self->{mixins};
  }

  my $name = $self->{name};
  my @mixins = mixins_resolver($name);

  for my $mixin (@mixins) {
    push @mixins, mixins_resolver($mixin);
  }

  for my $base (@{$self->bases}) {
    push @mixins, mixins_resolver($base);
  }

  my %seen;
  return $self->{mixins} ||= [grep !$seen{$_}++, @mixins];
}

sub mixins_resolver {
  my ($name) = @_;

  no strict 'refs';

  if (${"${name}::META"} && $${"${name}::META"}{MIXIN}) {
    return (map +($_, mixins_resolver($_)), sort {
      $${"${name}::META"}{MIXIN}{$a}[0] <=> $${"${name}::META"}{MIXIN}{$b}[0]
    } keys %{$${"${name}::META"}{MIXIN}});
  }
  else {
    return ();
  }
}

sub new {
  my ($self, @args) = @_;

  return $self->BLESS(@args);
}

sub role {
  my ($self, $name) = @_;

  return 0 if !$name;

  my $data = {map +($_,$_), @{$self->roles}};

  return $data->{$name} ? true : false;
}

sub roles {
  my ($self) = @_;

  if ($self->{roles}) {
    return $self->{roles};
  }

  my $name = $self->{name};
  my @roles = roles_resolver($name);

  for my $role (@roles) {
    push @roles, roles_resolver($role);
  }

  for my $base (@{$self->bases}) {
    push @roles, roles_resolver($base);
  }

  my %seen;
  return $self->{roles} ||= [grep !$seen{$_}++, @roles];
}

sub roles_resolver {
  my ($name) = @_;

  no strict 'refs';
  no warnings 'once';

  if (${"${name}::META"} && $${"${name}::META"}{ROLE}) {
    return (map +($_, roles_resolver($_)), sort {
      $${"${name}::META"}{ROLE}{$a}[0] <=> $${"${name}::META"}{ROLE}{$b}[0]
    } keys %{$${"${name}::META"}{ROLE}});
  }
  else {
    return ();
  }
}

sub search {
  my ($self, $from, $type, $name) = @_;

  return if !$from;
  return if !$type;
  return if !$name;

  no strict 'refs';

  my @configs;
  my @sources;

  if (lc($from) eq 'bases') {
    @sources = bases_resolver($self->{name});
  }
  elsif (lc($from) eq 'roles') {
    @sources = roles_resolver($self->{name});
  }
  elsif (lc($from) eq 'mixins') {
    @sources = mixins_resolver($self->{name});
  }
  else {
    @sources = ($self->{name});
  }

  for my $source (@sources) {
    if (lc($type) eq 'sub') {
      if (*{"${source}::${name}"}{"CODE"}) {
        push @configs, [$source, [1, [*{"${source}::${name}"}{"CODE"}]]];
      }
    }
    else {
      if ($${"${source}::META"}{uc($type)}{$name}) {
        push @configs, [$source, $${"${source}::META"}{uc($type)}{$name}];
      }
    }
  }

  return [@configs];
}

sub sub {
  my ($self, $name) = @_;

  return 0 if !$name;

  my $data = {map +($_,$_), @{$self->subs}};

  return $data->{$name} ? true : false;
}

sub subs {
  my ($self) = @_;

  if ($self->{subs}) {
    return $self->{subs};
  }

  my $name = $self->{name};
  my @subs = subs_resolver($name);

  for my $base (@{$self->bases}) {
    push @subs, subs_resolver($base);
  }

  my %seen;
  return $self->{subs} ||= [grep !$seen{$_}++, @subs];
}

sub subs_resolver {
  my ($name) = @_;

  no strict 'refs';

  return (
    grep *{"${name}::$_"}{"CODE"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${name}::"}
  );
}

1;
