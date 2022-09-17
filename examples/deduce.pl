#!/usr/bin/env perl

use Venus::Type;

# deduce and reify hierarchical values
Venus::Type->new({ name => ['Ready', 'Robot'], version => 0.12, stable => !!1, })->say_pretty('deduce_deep');
