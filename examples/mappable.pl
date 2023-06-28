#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Hash;
use Venus::Array;

#
# Map over items, and uppercase each
#

Venus::Array->new(['a'..'d'])->say('call', 'map', 'uppercase');

#
# Map over items, and uppercase each
#

Venus::Hash->new({a=>'a',b=>'b',c=>'c',d=>'d'})->say('call', 'map', 'uppercase');
