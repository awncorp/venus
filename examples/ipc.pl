#!/usr/bin/env perl

use 5.018;

use strict;
use warnings;

use Venus::Process;

#
# Launch 5 processes, pool, and communicate
#

my $parent = Venus::Process->new;

$parent->works(5, sub {
  my ($process) = @_;
  $process->join('team')->pool(5, 5)->send($process->ppid, {
    from => $process->pid, said => "hello",
  });
});

$parent->join('team')->sync(5, 5)->say_json('recvall');
