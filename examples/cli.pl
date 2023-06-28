#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Cli;

#
# Easily create CLIs
#

Venus::Cli->new->set('opt', 'help', { help => 'Show help' })->say_string('help');
