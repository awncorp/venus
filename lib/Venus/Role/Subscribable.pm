package Venus::Role::Subscribable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub name {
  my ($name) = @_;

  $name = lc $name =~ s/\W+/_/gr if $name;

  return $name;
}

sub publish {
  my ($self, $name, @args) = @_;

  $name = name($name) or return $self;

  &$_(@args) for @{subscriptions($self)->{$name}};

  return $self;
}

sub subscribe {
  my ($self, $name, $code) = @_;

  $name = name($name) or return $self;

  push @{subscriptions($self)->{$name}}, $code;

  return $self;
}

sub subscribers {
  my ($self, $name) = @_;

  $name = name($name) or return 0;

  if (exists subscriptions($self)->{$name}) {
    return 0+@{subscriptions($self)->{$name}};
  }
  else {
    return 0;
  }
}

sub subscriptions {
  my ($self) = @_;

  return $self->{'$subscriptions'} ||= {};
}

sub unsubscribe {
  my ($self, $name, $code) = @_;

  $name = name($name) or return $self;

  if ($code) {
    subscriptions($self)->{$name} = [
      grep { $code ne $_ } @{subscriptions($self)->{$name}}
    ];
  }
  else {
    delete subscriptions($self)->{$name};
  }

  delete subscriptions($self)->{$name} if !$self->subscribers($name);

  return $self;
}

# EXPORTS

sub EXPORT {
  ['publish', 'subscribe', 'subscribers', 'unsubscribe']
}

1;
