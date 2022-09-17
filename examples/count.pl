#!/usr/bin/env perl

use Venus::Path;
use Venus::Space;

# line count of packages
Venus::Path->new(Venus::Space->new($_)->do('say', 'package')->locate)->box->lines->say('count') for qw(
  Venus::Array
  Venus::Hash
  Venus::Number
  Venus::String
);
