#!/usr/bin/env perl

use Venus::Random;

# generate 100 random characters
Venus::Random->new->say('collect', 100, 'character');
