#!/usr/bin/env perl

use Venus::Path;

# catch file open error
Venus::Path->new('/path/to/nowhere')->catch('open')->say('message');

# catch path error throw
Venus::Path->new('/path/to/nowhere')->throw->catch('error', {message => 'Missing file'})->say('message');
