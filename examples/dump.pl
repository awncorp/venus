#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Dump;

#
# Dump Perl data structure as string
#

Venus::Dump->new({name => ['Ready', 'Robot'], version => 0.12, stable => !!1})->say_string('encode');
