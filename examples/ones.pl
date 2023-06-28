#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus;
use Venus::Type;

#
# Deduce number, string, scalarref, boolean, boolean
#

Venus::Type->new($_)->deduce->say for 1, "1", \1, !!1, true;
