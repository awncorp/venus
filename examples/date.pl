#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Date;

#
# ISO8601 string, 2 days from the start of the month
#

Venus::Date->new->restart_month->add_days(2)->say('iso8601');
