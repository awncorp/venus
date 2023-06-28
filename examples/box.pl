#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::String;

#
# Opt-in to autoboxing
#

Venus::String->new('hello world')->box->do('say')->lowercase->titlecase->do('say')->say('get');
