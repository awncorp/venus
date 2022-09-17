#!/usr/bin/env perl

use Venus::String;

# opt-in autoboxing
Venus::String->new('hello world')->box->do('say')->lowercase->titlecase->do('say')->say('get');
