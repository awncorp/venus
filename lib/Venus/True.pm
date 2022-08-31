package Venus::True;

use 5.018;

use strict;
use warnings;

use Scalar::Util ();

state $true = Scalar::Util::dualvar(1, "1");

use overload (
  '!' => sub{!$true},
  'bool' => sub{$true},
  fallback => 1,
);

# METHODS

sub new {
  return bless({});
}

sub value {
  return $true;
}

1;
