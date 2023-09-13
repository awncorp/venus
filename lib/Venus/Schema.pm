package Venus::Schema;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base';

base 'Venus::Kind::Utility';

# ATTRIBUTES

attr 'definition';

# BUILDERS

sub build_args {
  my ($self, $data) = @_;

  if (keys %$data == 1 && exists $data->{definition}) {
    return $data;
  }
  return {
    definition => $data,
  };
}

# METHODS

sub assert {
  my ($self) = @_;

  require Venus::Assert;

  my $assert = Venus::Assert->new;

  return $assert->expression($assert->render('hashkeys', $self->definition));
}

sub check {
  my ($self, $data) = @_;

  my $assert = $self->assert;

  return $assert->valid($data);
}

sub deduce {
  my ($self, $data) = @_;

  require Venus::Type;

  my $assert = $self->assert;

  return Venus::Type->new($assert->validate($data))->deduce_deep;
}

sub error {
  my ($self, $data) = @_;

  my $error = $self->catch('validate', $data);

  die $error if $error && !$error->isa('Venus::Check::Error');

  return $error;
}

sub validate {
  my ($self, $data) = @_;

  my $assert = $self->assert;

  return $assert->validate($data);
}

1;
