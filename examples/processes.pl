#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Process;

#
# Launch 5 processes and report all PIDs
#

Venus::Process->new->do('works', 5, sub {warn $_})->do('waitall')->say('get');
