#!/usr/bin/env perl

use Venus::Number;

# e.g. 0 ~~ ''
Venus::Number->new(0)->say('reify', 'eq', ''); # DMMT and DWIM

# e.g. 0 eq ''
Venus::Number->new(0)->say('reify', 'tv', ''); # TYPE and VALUE

# e.g. 0 ~~ bless{}
Venus::Number->new(0)->say('reify', 'eq', bless{}); # DMMT and DWIM

# e.g. 0 ~~ Venus::Number->new
Venus::Number->new(0)->say('reify', 'eq', Venus::Number->new); # SAME

# e.g. 0 eq Venus::Number->new
Venus::Number->new(0)->say('reify', 'tv', Venus::Number->new); # SAME

# e.g. 0 eq Venus::Number->new(0)
Venus::Number->new(0)->say('reify', 'tv', Venus::Number->new(0)); # SAME

# e.g. 0 eq Venus::Number->new
Venus::Number->new(0)->say('reify', 'tv', Venus::Number->new(1)); # NOPE
