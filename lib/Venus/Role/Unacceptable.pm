package Venus::Role::Unacceptable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'raise';

# BUILDERS

sub BUILD {
  my ($self) = @_;

  my $class = ref $self || $self;
  my %attrs = map +($_, $_), $self->META->attrs;
  my @unknowns = sort grep !exists($attrs{$_}), keys %$self;

  raise 'Venus::Role::Unacceptable::Error', {
    name => 'on.build',
    '$stash' => {unknowns => [@unknowns]},
    message => "$class was passed unknown attribute(s): " . join ', ',
      map "'$_'", @unknowns,
  }
  if @unknowns;

  return $self;
}

1;
