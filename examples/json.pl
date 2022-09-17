#!/usr/bin/env perl

use Venus::Json;

# use available json lib for encoding
Venus::Json->new({name => ['Ready', 'Robot'], version => 0.12, stable => !!1})->say_string('encode');
