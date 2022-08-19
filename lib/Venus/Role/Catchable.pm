package Venus::Role::Catchable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# AUDITS

sub AUDIT {
  my ($self, $from) = @_;

  if (!$from->does('Venus::Role::Tryable')) {
    die "${self} requires ${from} to consume Venus::Role::Tryable";
  }

  return $self;
}

# METHODS

sub catch {
  my ($self, $method, @args) = @_;

  my @result = $self->try($method, @args)->error(\my $error)->result;

  return wantarray ? ($error ? ($error, undef) : ($error, @result)) : $error;
}

# EXPORTS

sub EXPORT {
  ['catch']
}

1;
