package Venus::Role::Dumpable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub dump {
  my ($self, $method, @args) = @_;

  require Data::Dumper;

  no warnings 'once';

  local $Data::Dumper::Indent = 0;
  local $Data::Dumper::Purity = 0;
  local $Data::Dumper::Quotekeys = 0;
  local $Data::Dumper::Deepcopy = 1;
  local $Data::Dumper::Deparse = 1;
  local $Data::Dumper::Sortkeys = 1;
  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Useqq = 1;

  local $_ = $self;

  my $data = Data::Dumper->Dump([
    $method ? scalar($self->$method(@args)) : $self
  ]);

  $data =~ s/^"|"$//g;

  return $data;
}

sub dump_pretty {
  my ($self, $method, @args) = @_;

  require Data::Dumper;

  no warnings 'once';

  local $Data::Dumper::Indent = 2;
  local $Data::Dumper::Trailingcomma = 0;
  local $Data::Dumper::Purity = 0;
  local $Data::Dumper::Pad = '';
  local $Data::Dumper::Varname = 'VAR';
  local $Data::Dumper::Useqq = 0;
  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Freezer = '';
  local $Data::Dumper::Toaster = '';
  local $Data::Dumper::Deepcopy = 1;
  local $Data::Dumper::Quotekeys = 0;
  local $Data::Dumper::Bless = 'bless';
  local $Data::Dumper::Pair = ' => ';
  local $Data::Dumper::Maxdepth = 0;
  local $Data::Dumper::Maxrecurse = 1000;
  local $Data::Dumper::Useperl = 0;
  local $Data::Dumper::Sortkeys = 1;
  local $Data::Dumper::Deparse = 1;
  local $Data::Dumper::Sparseseen = 0;

  local $_ = $self;

  my $data = Data::Dumper->Dump([
    $method ? scalar($self->$method(@args)) : $self
  ]);

  $data =~ s/^'|'$//g;

  chomp $data;

  return $data;
}

# EXPORTS

sub EXPORT {
  ['dump', 'dump_pretty']
}

1;
