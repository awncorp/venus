package Venus::Role::Throwable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub error {
  my ($self, $data) = @_;

  my @args = $data;

  unshift @args, delete $data->{throw} if $data->{throw};

  @_ = ($self, @args);

  goto $self->can('throw');
}

sub throw {
  my ($self, $data, @args) = @_;

  require Venus::Throw;

  my $throw = Venus::Throw->new(context => (caller(1))[3])->do(
    frame => 1,
  );

  if (!$data) {
    return $throw->do(
      'package', join('::', map ucfirst, ref($self), 'error')
    );
  }
  if (ref $data ne 'HASH') {
    if ($data =~ /^\w+$/ && $self->can($data)) {
      $data = $self->$data(@args);
    }
    else {
      return $throw->do(
        'package', $data,
      );
    }
  }

  if (exists $data->{as}) {
    $throw->as($data->{as});
  }
  if (exists $data->{capture}) {
    $throw->capture(@{$data->{capture}});
  }
  if (exists $data->{context}) {
    $throw->context($data->{context});
  }
  if (exists $data->{error}) {
    $throw->error($data->{error});
  }
  if (exists $data->{frame}) {
    $throw->frame($data->{frame});
  }
  if (exists $data->{message}) {
    $throw->message($data->{message});
  }
  if (exists $data->{name}) {
    $throw->name($data->{name});
  }
  if (exists $data->{package}) {
    $throw->package($data->{package});
  }
  else {
    $throw->package(join('::', map ucfirst, ref($self), 'error'));
  }
  if (exists $data->{parent}) {
    $throw->parent($data->{parent});
  }
  if (exists $data->{stash}) {
    $throw->stash($_, $data->{stash}->{$_}) for keys %{$data->{stash}};
  }
  if (exists $data->{on}) {
    $throw->on($data->{on});
  }
  if (exists $data->{raise}) {
    @_ = ($throw);
    goto $throw->can('error');
  }

  return $throw;
}

# EXPORTS

sub EXPORT {
  ['error', 'throw']
}

1;
