package Venus::Atom;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Sealed';

use overload (
  '""' => sub{$_[0]->get // ''},
  '~~' => sub{$_[0]->get // ''},
  'eq' => sub{($_[0]->get // '') eq "$_[1]"},
  'ne' => sub{($_[0]->get // '') ne "$_[1]"},
  'qr' => sub{qr/@{[quotemeta($_[0])]}/},
  fallback => 1,
);

# METHODS

sub __get {
  my ($self, $init, $data) = @_;

  return $init->{value};
}

sub __set {
  my ($self, $init, $data, $value) = @_;

  if (ref $value || !defined $value || $value eq '') {
    return undef;
  }

  return $init->{value} = $value if !exists $init->{value};

  return $self->error({throw => 'error_on_set', value => $value});
}

# ERRORS

sub error_on_set {
  my ($self, $data) = @_;

  my $message = 'Can\'t re-set atom value to "{{value}}"';

  my $stash = {
    value => $data->{value},
  };

  my $result = {
    name => 'on.set',
    raise => true,
    stash => $stash,
    message => $message,
  };

  return $result;
}

1;
