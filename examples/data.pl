#!/usr/bin/env perl

use Venus::Data;

# access content in the DATA token
Venus::Data->new($0)->text->say('search', {list => undef, name => 'greet'});

__DATA__

@@ greet

Hello World.

@@ cut
