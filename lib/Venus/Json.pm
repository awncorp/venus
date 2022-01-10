package Venus::Json;

use 5.018;

use strict;
use warnings;

use Moo;

extends 'Venus::Kind::Utility';

with 'Venus::Role::Accessible';
with 'Venus::Role::Explainable';

# ATTRIBUTES

has decoder => (
  is => 'rw',
);

has encoder => (
  is => 'rw',
);

# BUILDERS

sub build_self {
  my ($self, $data) = @_;

  return $self->config;
}

# METHODS

sub config {
  my ($self, $package) = @_;

  $package ||= $self->package or $self->throw->error({
    message => 'No suitable JSON package',
  });

  $package = $package->new
    ->canonical
    ->allow_nonref
    ->allow_unknown
    ->allow_blessed
    ->convert_blessed
    ->pretty;

  if ($package->can('escape_slash')) {
    $package->escape_slash;
  }

  # Cpanel::JSON::XS
  if ($package->isa('Cpanel::JSON::XS')) {
    $self->decoder(sub {
      my ($text) = @_;
      $package->decode($text);
    });
    $self->encoder(sub {
      my ($data) = @_;
      $package->encode($data);
    });
  }

  # JSON::XS
  if ($package->isa('JSON::XS')) {
    $self->decoder(sub {
      my ($text) = @_;
      $package->decode($text);
    });
    $self->encoder(sub {
      my ($data) = @_;
      $package->encode($data);
    });
  }

  # JSON::PP
  if ($package->isa('JSON::PP')) {
    $self->decoder(sub {
      my ($text) = @_;
      $package->decode($text);
    });
    $self->encoder(sub {
      my ($data) = @_;
      $package->encode($data);
    });
  }

  return $self;
}

sub decode {
  my ($self, $data) = @_;

  # double-traversing the data structure due to lack of serialization hooks
  return $self->set(FROM_BOOL($self->decoder->($data)));
}

sub encode {
  my ($self) = @_;

  # double-traversing the data structure due to lack of serialization hooks
  return $self->encoder->(TO_BOOL($self->get));
}

sub explain {
  my ($self) = @_;

  return $self->encode;
}

sub package {
  my ($self) = @_;

  state $engine;

  return $engine if defined $engine;

  my %packages = (
    'JSON::XS' => '3.0',
    'JSON::PP' => '2.27105',
    'Cpanel::JSON::XS' => '4.09',
  );
  for my $package (qw(Cpanel::JSON::XS JSON::XS JSON::PP)) {
    my $criteria = "require $package; $package->VERSION($packages{$package})";
    if (do {local $@; eval "$criteria"; $@}) {
      next;
    }
    else {
      $engine = $package;
      last;
    }
  }

  return $engine;
}

sub FROM_BOOL {
  my ($value) = @_;

  require Venus::Boolean;

  if (ref($value) eq 'HASH') {
    for my $key (keys %$value) {
      $value->{$key} = FROM_BOOL($value->{$key});
    }
    return $value;
  }

  if (ref($value) eq 'ARRAY') {
    for my $key (keys @$value) {
      $value->[$key] = FROM_BOOL($value->[$key]);
    }
    return $value;
  }

  return Venus::Boolean::TO_BOOL(Venus::Boolean::FROM_BOOL($value));
}

sub TO_BOOL {
  my ($value) = @_;

  require Venus::Boolean;

  if (ref($value) eq 'HASH') {
    $value = {
      %$value
    };
    for my $key (keys %$value) {
      $value->{$key} = TO_BOOL($value->{$key});
    }
    return $value;
  }

  if (ref($value) eq 'ARRAY') {
    $value = [
      @$value
    ];
    for my $key (keys @$value) {
      $value->[$key] = TO_BOOL($value->[$key]);
    }
    return $value;
  }

  return Venus::Boolean::TO_BOOL_OBJ($value);
}

1;
