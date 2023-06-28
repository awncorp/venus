#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Yaml;

#
# Use available YAML lib for encoding
#

Venus::Yaml->new({name => ['Ready', 'Robot'], version => 0.12, stable => !!1})->say_string('encode');
