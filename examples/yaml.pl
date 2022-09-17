#!/usr/bin/env perl

use Venus::Yaml;

# use available yaml lib for encoding
Venus::Yaml->new({name => ['Ready', 'Robot'], version => 0.12, stable => !!1})->say_string('encode');
