#!/usr/bin/env perl

use Venus::Date;

# iso8601 string, 2 days from the start of the month
Venus::Date->new->restart_month->add_days(2)->say('iso8601');
