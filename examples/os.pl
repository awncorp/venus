#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Os;

#
# Identify and report the current OS
#

Venus::Os->new->say('type');
