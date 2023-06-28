#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Random;

#
# Generate 100 random characters
#

Venus::Random->new->say('collect', 100, 'character');
