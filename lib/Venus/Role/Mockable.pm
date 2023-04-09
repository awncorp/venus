package Venus::Role::Mockable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub mock {
  my ($self, $name, $code) = @_;

  no strict 'refs';
  no warnings 'redefine';

  my $class = ref $self || $self;

  my $orig = $class->can($name);

  *{"${class}::${name}"} = my $mock = $code->($orig);

  return $mock;
}

# EXPORTS

sub EXPORT {
  ['mock']
}

1;
