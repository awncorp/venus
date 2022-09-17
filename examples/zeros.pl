#!/usr/bin/env perl

use Venus;
use Venus::Type;

# deduce number, string, scalarref, boolean, boolean
Venus::Type->new($_)->deduce->say for 0, "0", \0, !!0, false;
