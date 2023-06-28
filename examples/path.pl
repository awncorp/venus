#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Path;

#
# Print the CWD
#

Venus::Path->new->say_string('absolute');
