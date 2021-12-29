package Venus::Role::Mappable;

use 5.014;

use strict;
use warnings;

use Moo::Role;

requires 'all';
requires 'any';
requires 'count';
requires 'delete';
requires 'each';
requires 'empty';
requires 'exists';
requires 'grep';
requires 'iterator';
requires 'keys';
requires 'map';
requires 'none';
requires 'one';
requires 'pairs';
requires 'random';
requires 'reverse';
requires 'slice';

1;
