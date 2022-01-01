package Venus::Yaml;

use 5.014;

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
    message => 'No suitable YAML package',
  });

  # YAML::XS
  if ($package eq 'YAML::XS') {
    $self->decoder(sub {
      my ($text) = @_;
      local $YAML::XS::Boolean = 'JSON::PP';
      YAML::XS::Load($text);
    });
    $self->encoder(sub {
      my ($data) = @_;
      local $YAML::XS::Boolean = 'JSON::PP';
      YAML::XS::Dump($data);
    });
  }

  # YAML::PP::LibYAML
  if ($package eq 'YAML::PP::LibYAML') {
    $self->decoder(sub {
      my ($text) = @_;
      YAML::PP->new(boolean => 'JSON::PP')->load_string($text);
    });
    $self->encoder(sub {
      my ($data) = @_;
      YAML::PP->new(boolean => 'JSON::PP')->dump_string($data);
    });
  }

  # YAML::PP
  if ($package eq 'YAML::PP') {
    $self->decoder(sub {
      my ($text) = @_;
      YAML::PP->new(boolean => 'JSON::PP')->load_string($text);
    });
    $self->encoder(sub {
      my ($data) = @_;
      YAML::PP->new(boolean => 'JSON::PP')->dump_string($data);
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
    'YAML::XS' => '0.67',
    'YAML::PP::LibYAML' => '0.004',
    'YAML::PP' => '0.023',
  );
  for my $package (qw(YAML::XS YAML::PP::LibYAML YAML::PP)) {
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
