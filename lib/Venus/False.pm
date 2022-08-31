package Venus::False;

use 5.018;

use strict;
use warnings;

use Scalar::Util ();

state $false = Scalar::Util::dualvar(0, "0");

use overload (
  '!' => sub{!$false},
  'bool' => sub{$false},
  fallback => 1,
);

# METHODS

sub new {
  return bless({});
}

sub value {
  return $false;
}

1;
