#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Path;

#
# Catch file open error
#

Venus::Path->new('/path/to/nowhere')->catch('open')->say('message');

#
# Catch path error throw
#

Venus::Path->new('/path/to/nowhere')->throw->catch('error', {message => 'Missing file'})->say('message');
