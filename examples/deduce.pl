#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Type;

#
# Deduce and reify hierarchical values
#

Venus::Type->new({name => ['Ready', 'Robot'], version => 0.12, stable => !!1,})->say_pretty('deduce_deep');
