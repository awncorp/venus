#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Number;

#
# perform smart-match equality
#

Venus::Number->new(0)->say('is_true', @$_) for (
  # e.g. 0 ~~ ''
  ['eq', ''],
  # e.g. 0 eq ''
  ['tv', ''],
  # e.g. 0 ~~ bless{}
  ['eq', bless{}],
  # e.g. 0 ~~ Venus::Number->new
  ['eq', Venus::Number->new],
  # e.g. 0 eq Venus::Number->new
  ['tv', Venus::Number->new],
  # e.g. 0 eq Venus::Number->new(0)
  ['tv', Venus::Number->new(0)],
  # e.g. 0 eq Venus::Number->new(1)
  ['tv', Venus::Number->new(1)],
);
