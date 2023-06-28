#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Match;

#
# Match and return expressions
#

Venus::Match->new
->when(sub{defined && $_ < 5})->then(sub{"< 5"})
->when(sub{defined && $_ > 5})->then(sub{"> 5"})
->none(sub{"?"})
->say('result', @ARGV);
