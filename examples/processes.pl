#!/usr/bin/env perl

use Venus::Process;

# launch 5 processes and report all PIDs
Venus::Process->new->do('works', 5, sub {warn $_})->do('waitall')->say('get');
