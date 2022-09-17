#!/usr/bin/env perl

use Venus::Hash;
use Venus::Array;

# map over items, and uppercase each
Venus::Array->new(['a'..'d'])->say('call', 'map', 'uppercase');

# map over items, and uppercase each
Venus::Hash->new({a=>'a',b=>'b',c=>'c',d=>'d'})->say('call', 'map', 'uppercase');
