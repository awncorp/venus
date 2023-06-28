#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Data;

#
# Access content in the DATA token
#

Venus::Data->new($0)->text->say('search', {list => undef, name => 'greet'});

__DATA__

@@ greet

Hello World.

@@ cut
