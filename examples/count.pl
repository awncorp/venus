#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Path;
use Venus::Space;

#
# Count the lines in the files of packages
#

Venus::Path->new(Venus::Space->new($_)->do('say', 'package')->locate)->box->lines->say('count') for qw(
  Venus::Array
  Venus::Hash
  Venus::Number
  Venus::String
);
