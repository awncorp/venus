package Venus::Role::Catchable;

use 5.018;

use strict;
use warnings;

use Moo::Role;

with 'Venus::Role::Tryable';

# METHODS

sub catch {
  my ($self, $method, @args) = @_;

  my @result = $self->try($method, @args)->error(\my $error)->result;

  return wantarray ? ($error ? ($error, undef) : ($error, @result)) : $error;
}

1;
