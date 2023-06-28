#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Json;

#
# Use available JSON lib for encoding
#

Venus::Json->new({name => ['Ready', 'Robot'], version => 0.12, stable => !!1})->say_string('encode');
