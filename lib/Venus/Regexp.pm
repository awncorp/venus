package Venus::Regexp;

use 5.018;

use strict;
use warnings;

use Venus::Class 'base';

base 'Venus::Kind::Value';

use overload (
  'eq' => sub{"$_[0]" eq "$_[1]"},
  'ne' => sub{"$_[0]" ne "$_[1]"},
  'qr' => sub{$_[0]->value},
  fallback => 1,
);

# METHODS

sub assertion {
  my ($self) = @_;

  my $assert = $self->SUPER::assertion;

  $assert->clear->regexp;

  return $assert;
}

sub comparer {
  my ($self) = @_;

  return 'stringified';
}

sub default {
  return qr//;
}

sub replace {
  my ($self, $string, $substr, $flags) = @_;

  require Venus::Replace;

  my $replace = Venus::Replace->new(
    regexp => $self->get,
    string => $string // '',
    substr => $substr // '',
    flags => $flags // '',
  );

  return $replace->do('evaluate');
}

sub search {
  my ($self, $string) = @_;

  require Venus::Search;

  my $search = Venus::Search->new(
    regexp => $self->get,
    string => $string // '',
  );

  return $search->do('evaluate');
}

1;
