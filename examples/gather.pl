#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Gather;

#
# Gather and transform inputs
#

Venus::Gather->new
->when(sub{$_ eq 1})->then(sub{"one"})
->when(sub{$_ eq 2})->then(sub{"two"})
->none(sub{"?"})
->say('result', [@ARGV]);
