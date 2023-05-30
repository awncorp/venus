package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;
use Venus::Os;
use Venus::Path;

my $test = test(__FILE__);
my $fsds = qr/[:\\\/\.]+/;

no warnings 'once';

$Venus::Os::TYPES{$^O} = 'linux';

=name

Venus::Os

=cut

$test->for('name');

=tagline

OS Class

=cut

$test->for('tagline');

=abstract

OS Class for Perl 5

=cut

$test->for('abstract');

=includes

method: call
method: find
method: is_bsd
method: is_cyg
method: is_dos
method: is_lin
method: is_mac
method: is_non
method: is_sun
method: is_vms
method: is_win
method: name
method: paths
method: type
method: where
method: which

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Os;

  my $os = Venus::Os->new;

  # bless({...}, 'Venus::Os')

  # my $name = $os->name;

  # "linux"

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result->isa('Venus::Os');
  is $result->name, 'linux';

  $result
});

=description

This package provides methods for determining the current operating system, as
well as finding and executing files.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=method call

The call method attempts to find the path to the program specified via
L</which> and dispatches to L<Venus::Path/mkcall> and returns the result. Any
exception throw is supressed and will return undefined if encountered.

=signature call

  call(Str $name, Str @args) (Any)

=metadata call

{
  since => '2.80',
}

=cut

=example-1 call

  # given: synopsis

  package main;

  my $app = $os->is_win ? 'perl.exe' : 'perl';

  my $call = $os->call($app, '-V:osname');

  # "osname='linux';"

=cut

$test->for('example', 1, 'call', sub {
  $Venus::Os::TYPES{$^O} = $^O;
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "osname='$^O';";

  $result
});

=example-2 call

  # given: synopsis

  package main;

  my $app = $os->is_win ? 'perl.exe' : 'perl';

  my @call = $os->call($app, '-V:osname');

  # ("osname='linux';", 0)

=cut

$test->for('example', 2, 'call', sub {
  $Venus::Os::TYPES{$^O} = $^O;
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], ["osname='$^O';", 0];

  @result
});

=example-3 call

  # given: synopsis

  package main;

  my $call = $os->call('nowhere');

  # undef

=cut

$test->for('example', 3, 'call', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=example-4 call

  # given: synopsis

  package main;

  my @call = $os->call($^X, '-V:osname');

  # ("osname='linux';", 0)

=cut

$test->for('example', 4, 'call', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], ["osname='$^O';", 0];

  @result
});

=example-5 call

  # given: synopsis

  package main;

  my @call = $os->call($^X, 't/data/sun');

  # ("", 1)

=cut

$test->for('example', 5, 'call', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my @result = $tryable->result;
  is_deeply [@result], ["", 1];

  @result
});

=method find

The find method searches the paths provided for a file matching the name
provided and returns all the files found as an arrayref. Returns a list in list
context.

=signature find

  find(Str $name, Str @paths) (ArrayRef)

=metadata find

{
  since => '2.80',
}

=cut

=example-1 find

  # given: synopsis

  package main;

  my $find = $os->find('cmd', 't/path/user/bin');

  # ["t/path/user/bin/cmd"]

=cut

$test->for('example', 1, 'find', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}bin${fsds}cmd$/;

  $result
});

=example-2 find

  # given: synopsis

  package main;

  my $find = $os->find('cmd', 't/path/user/bin', 't/path/usr/bin');

  # ["t/path/user/bin/cmd", "t/path/usr/bin/cmd"]

=cut

$test->for('example', 2, 'find', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}bin${fsds}cmd$/;
  like $result->[1], qr/t${fsds}path${fsds}usr${fsds}bin${fsds}cmd$/;

  $result
});

=example-3 find

  # given: synopsis

  package main;

  my $find = $os->find('zzz', 't/path/user/bin', 't/path/usr/bin');

  # []

=cut

$test->for('example', 3, 'find', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  ok !@{$result};

  $result
});

=method is_bsd

The is_bsd method returns true if the OS is either C<"freebsd"> or
C<"openbsd">, and otherwise returns false.

=signature is_bsd

  is_bsd() (Bool)

=metadata is_bsd

{
  since => '2.80',
}

=cut

=example-1 is_bsd

  # given: synopsis

  package main;

  # on linux

  my $is_bsd = $os->is_bsd;

  # false

=cut

$test->for('example', 1, 'is_bsd', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_bsd

  # given: synopsis

  package main;

  # on freebsd

  my $is_bsd = $os->is_bsd;

  # true

=cut

$test->for('example', 2, 'is_bsd', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'freebsd';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_bsd

  # given: synopsis

  package main;

  # on openbsd

  my $is_bsd = $os->is_bsd;

  # true

=cut

$test->for('example', 2, 'is_bsd', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'openbsd';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_cyg

The is_cyg method returns true if the OS is either C<"cygwin"> or C<"msys">,
and otherwise returns false.

=signature is_cyg

  is_cyg() (Bool)

=metadata is_cyg

{
  since => '2.80',
}

=cut

=example-1 is_cyg

  # given: synopsis

  package main;

  # on linux

  my $is_cyg = $os->is_cyg;

  # false

=cut

$test->for('example', 1, 'is_cyg', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_cyg

  # given: synopsis

  package main;

  # on cygwin

  my $is_cyg = $os->is_cyg;

  # true

=cut

$test->for('example', 2, 'is_cyg', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'cygwin';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_cyg

  # given: synopsis

  package main;

  # on msys

  my $is_cyg = $os->is_cyg;

  # true

=cut

$test->for('example', 3, 'is_cyg', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'msys';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_dos

The is_dos method returns true if the OS is either C<"mswin32"> or C<"dos"> or
C<"os2">, and otherwise returns false.

=signature is_dos

  is_dos() (Bool)

=metadata is_dos

{
  since => '2.80',
}

=cut

=example-1 is_dos

  # given: synopsis

  package main;

  # on linux

  my $is_dos = $os->is_dos;

  # false

=cut

$test->for('example', 1, 'is_dos', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_dos

  # given: synopsis

  package main;

  # on mswin32

  my $is_dos = $os->is_dos;

  # true

=cut

$test->for('example', 2, 'is_dos', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'mswin32';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_dos

  # given: synopsis

  package main;

  # on dos

  my $is_dos = $os->is_dos;

  # true

=cut

$test->for('example', 3, 'is_dos', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'dos';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 is_dos

  # given: synopsis

  package main;

  # on os2

  my $is_dos = $os->is_dos;

  # true

=cut

$test->for('example', 4, 'is_dos', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'os2';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_lin

The is_lin method returns true if the OS is C<"linux">, and otherwise returns
false.

=signature is_lin

  is_lin() (Bool)

=metadata is_lin

{
  since => '2.80',
}

=cut

=example-1 is_lin

  # given: synopsis

  package main;

  # on linux

  my $is_lin = $os->is_lin;

  # true

=cut

$test->for('example', 1, 'is_lin', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-2 is_lin

  # given: synopsis

  package main;

  # on macos

  my $is_lin = $os->is_lin;

  # false

=cut

$test->for('example', 2, 'is_lin', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'macos';
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-3 is_lin

  # given: synopsis

  package main;

  # on mswin32

  my $is_lin = $os->is_lin;

  # false

=cut

$test->for('example', 3, 'is_lin', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'mswin32';
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=method is_mac

The is_mac method returns true if the OS is either C<"macos"> or C<"darwin">,
and otherwise returns false.

=signature is_mac

  is_mac() (Bool)

=metadata is_mac

{
  since => '2.80',
}

=cut

=example-1 is_mac

  # given: synopsis

  package main;

  # on linux

  my $is_mac = $os->is_mac;

  # false

=cut

$test->for('example', 1, 'is_mac', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_mac

  # given: synopsis

  package main;

  # on macos

  my $is_mac = $os->is_mac;

  # true

=cut

$test->for('example', 2, 'is_mac', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'macos';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_mac

  # given: synopsis

  package main;

  # on darwin

  my $is_mac = $os->is_mac;

  # true

=cut

$test->for('example', 3, 'is_mac', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'darwin';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_non

The is_non method returns true if the OS is not recognized, and if recognized
returns false.

=signature is_non

  is_non() (Bool)

=metadata is_non

{
  since => '2.80',
}

=cut

=example-1 is_non

  # given: synopsis

  package main;

  # on linux

  my $is_non = $os->is_non;

  # false

=cut

$test->for('example', 1, 'is_non', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_non

  # given: synopsis

  package main;

  # on aix

  my $is_non = $os->is_non;

  # true

=cut

$test->for('example', 2, 'is_non', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'aix';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_sun

The is_sun method returns true if the OS is either C<"solaris"> or C<"sunos">,
and otherwise returns false.

=signature is_sun

  is_sun() (Bool)

=metadata is_sun

{
  since => '2.80',
}

=cut

=example-1 is_sun

  # given: synopsis

  package main;

  # on linux

  my $is_sun = $os->is_sun;

  # false

=cut

$test->for('example', 1, 'is_sun', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_sun

  # given: synopsis

  package main;

  # on solaris

  my $is_sun = $os->is_sun;

  # true

=cut

$test->for('example', 2, 'is_sun', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'solaris';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_sun

  # given: synopsis

  package main;

  # on sunos

  my $is_sun = $os->is_sun;

  # true

=cut

$test->for('example', 3, 'is_sun', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'sunos';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_vms

The is_vms method returns true if the OS is C<"vms">, and otherwise returns
false.

=signature is_vms

  is_vms() (Bool)

=metadata is_vms

{
  since => '2.80',
}

=cut

=example-1 is_vms

  # given: synopsis

  package main;

  # on linux

  my $is_vms = $os->is_vms;

  # false

=cut

$test->for('example', 1, 'is_vms', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_vms

  # given: synopsis

  package main;

  # on vms

  my $is_vms = $os->is_vms;

  # true

=cut

$test->for('example', 2, 'is_vms', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'vms';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method is_win

The is_win method returns true if the OS is either C<"mswin32"> or C<"dos"> or
C<"os2">, and otherwise returns false.

=signature is_win

  is_win() (Bool)

=metadata is_win

{
  since => '2.80',
}

=cut

=example-1 is_win

  # given: synopsis

  package main;

  # on linux

  my $is_win = $os->is_win;

  # false

=cut

$test->for('example', 1, 'is_win', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, 0;

  !$result
});

=example-2 is_win

  # given: synopsis

  package main;

  # on mswin32

  my $is_win = $os->is_win;

  # true

=cut

$test->for('example', 2, 'is_win', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'mswin32';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-3 is_win

  # given: synopsis

  package main;

  # on dos

  my $is_win = $os->is_win;

  # true

=cut

$test->for('example', 3, 'is_win', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'dos';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=example-4 is_win

  # given: synopsis

  package main;

  # on os2

  my $is_win = $os->is_win;

  # true

=cut

$test->for('example', 4, 'is_win', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'os2';
  my $result = $tryable->result;
  is $result, 1;

  $result
});

=method name

The name method returns the OS name.

=signature name

  name() (Str)

=metadata name

{
  since => '2.80',
}

=cut

=example-1 name

  # given: synopsis

  package main;

  # on linux

  my $name = $os->name;

  # "linux"

  # same as $^O

=cut

$test->for('example', 1, 'name', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "linux";

  $result
});

$Venus::Os::TYPES{$^O} = $^O;
$ENV{PATH} = join((Venus::Os->is_win ? ';' : ':'),
  map Venus::Path->new($_)->absolute, qw(
    t/path/user/local/bin
    t/path/user/bin
    t/path/usr/bin
    t/path/usr/local/bin
    t/path/usr/local/sbin
    t/path/usr/sbin
  ));

=method paths

The paths method returns the paths specified by the C<"PATH"> environment
variable as an arrayref of unique paths. Returns a list in list context.

=signature paths

  paths() (ArrayRef)

=metadata paths

{
  since => '2.80',
}

=cut

=example-1 paths

  # given: synopsis

  package main;

  my $paths = $os->paths;

  # [
  #   "/root/local/bin",
  #   "/root/bin",
  #   "/usr/local/sbin",
  #   "/usr/local/bin",
  #   "/usr/sbin:/usr/bin",
  # ]

=cut

$test->for('example', 1, 'paths', sub {
  $Venus::Os::TYPES{$^O} = $^O;
  my ($tryable) = @_;
  my $result = $tryable->result;
  my $is_win = Venus::Os->is_win;
  my $paths = [($is_win ? '.' : ()), split(($is_win ? ';' : ':'), $ENV{PATH})];
  is_deeply $result, $paths;

  $result
});

=method type

The type method returns a string representing the "test" method, which
identifies the OS, that would return true if called, based on the name of the
OS.

=signature type

  type() (Str)

=metadata type

{
  since => '2.80',
}

=cut

=example-1 type

  # given: synopsis

  package main;

  # on linux

  my $type = $os->type;

  # "is_lin"

=cut

$test->for('example', 1, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is $result, "is_lin";

  $result
});

=example-2 type

  # given: synopsis

  package main;

  # on macos

  my $type = $os->type;

  # "is_mac"

=cut

$test->for('example', 2, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'macos';
  my $result = $tryable->result;
  is $result, "is_mac";

  $result
});

=example-3 type

  # given: synopsis

  package main;

  # on mswin32

  my $type = $os->type;

  # "is_win"

=cut

$test->for('example', 3, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'mswin32';
  my $result = $tryable->result;
  is $result, "is_win";

  $result
});

=example-4 type

  # given: synopsis

  package main;

  # on openbsd

  my $type = $os->type;

  # "is_bsd"

=cut

$test->for('example', 4, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'openbsd';
  my $result = $tryable->result;
  is $result, "is_bsd";

  $result
});

=example-5 type

  # given: synopsis

  package main;

  # on cygwin

  my $type = $os->type;

  # "is_cyg"

=cut

$test->for('example', 5, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'cygwin';
  my $result = $tryable->result;
  is $result, "is_cyg";

  $result
});

=example-6 type

  # given: synopsis

  package main;

  # on dos

  my $type = $os->type;

  # "is_win"

=cut

$test->for('example', 6, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'dos';
  my $result = $tryable->result;
  is $result, "is_win";

  $result
});

=example-7 type

  # given: synopsis

  package main;

  # on solaris

  my $type = $os->type;

  # "is_sun"

=cut

$test->for('example', 7, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'solaris';
  my $result = $tryable->result;
  is $result, "is_sun";

  $result
});

=example-8 type

  # given: synopsis

  package main;

  # on vms

  my $type = $os->type;

  # "is_vms"

=cut

$test->for('example', 8, 'type', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  local %Venus::Os::TYPES; $Venus::Os::TYPES{$^O} = 'vms';
  my $result = $tryable->result;
  is $result, "is_vms";

  $result
});

=method where

The where method searches the paths defined by the C<PATH> environment variable
for a file matching the name provided and returns all the files found as an
arrayref. Returns a list in list context. This method doesn't check (or care)
if the files found are actually executable.

=signature where

  where(Str $file) (ArrayRef)

=metadata where

{
  since => '2.80',
}

=cut

=example-1 where

  # given: synopsis

  package main;

  my $where = $os->where('cmd');

  # [
  #   "t/path/user/local/bin/cmd",
  #   "t/path/user/bin/cmd",
  #   "t/path/usr/bin/cmd",
  #   "t/path/usr/local/bin/cmd",
  #   "t/path/usr/local/sbin/cmd",
  #   "t/path/usr/sbin/cmd"
  # ]

=cut

$test->for('example', 1, 'where', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}cmd$/;
  like $result->[1], qr/t${fsds}path${fsds}user${fsds}bin${fsds}cmd$/;
  like $result->[2], qr/t${fsds}path${fsds}usr${fsds}bin${fsds}cmd$/;
  like $result->[3], qr/t${fsds}path${fsds}usr${fsds}local${fsds}bin${fsds}cmd$/;
  like $result->[4], qr/t${fsds}path${fsds}usr${fsds}local${fsds}sbin${fsds}cmd$/;
  like $result->[5], qr/t${fsds}path${fsds}usr${fsds}sbin${fsds}cmd$/;

  $result
});

=example-2 where

  # given: synopsis

  package main;

  my $where = $os->where('app1');

  # [
  #   "t/path/user/local/bin/app1",
  #   "t/path/usr/bin/app1",
  #   "t/path/usr/sbin/app1"
  # ]

=cut

$test->for('example', 2, 'where', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}app1$/;
  like $result->[1], qr/t${fsds}path${fsds}usr${fsds}bin${fsds}app1$/;
  like $result->[2], qr/t${fsds}path${fsds}usr${fsds}sbin${fsds}app1$/;

  $result
});

=example-3 where

  # given: synopsis

  package main;

  my $where = $os->where('app2');

  # [
  #   "t/path/user/local/bin/app2",
  #   "t/path/usr/bin/app2",
  # ]

=cut

$test->for('example', 3, 'where', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}app2$/;
  like $result->[1], qr/t${fsds}path${fsds}usr${fsds}bin${fsds}app2$/;

  $result
});

=example-4 where

  # given: synopsis

  package main;

  my $where = $os->where('app3');

  # [
  #   "t/path/user/bin/app3",
  #   "t/path/usr/sbin/app3"
  # ]

=cut

$test->for('example', 4, 'where', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}bin${fsds}app3$/;
  like $result->[1], qr/t${fsds}path${fsds}usr${fsds}sbin${fsds}app3$/;

  $result
});

=example-5 where

  # given: synopsis

  package main;

  my $where = $os->where('app4');

  # [
  #   "t/path/user/local/bin/app4",
  #   "t/path/usr/local/bin/app4",
  #   "t/path/usr/local/sbin/app4",
  # ]

=cut

$test->for('example', 5, 'where', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok ref $result eq 'ARRAY';
  like $result->[0], qr/t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}app4$/;
  like $result->[1], qr/t${fsds}path${fsds}usr${fsds}local${fsds}bin${fsds}app4$/;
  like $result->[2], qr/t${fsds}path${fsds}usr${fsds}local${fsds}sbin${fsds}app4$/;

  $result
});

=example-6 where

  # given: synopsis

  package main;

  my $where = $os->where('app5');

  # []

=cut

$test->for('example', 6, 'where', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  is_deeply $result, [];

  $result
});

=method which

The which method returns the first match from the result of calling the
L</where> method with the arguments provided.

=signature which

  which(Str $file) (Str)

=metadata which

{
  since => '2.80',
}

=cut

=example-1 which

  # given: synopsis

  package main;

  my $which = $os->which('cmd');

  # "t/path/user/local/bin/cmd",

=cut

$test->for('example', 1, 'which', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result =~ m{t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}cmd$};

  $result
});

=example-2 which

  # given: synopsis

  package main;

  my $which = $os->which('app1');

  # "t/path/user/local/bin/app1"

=cut

$test->for('example', 2, 'which', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result =~ m{t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}app1$};

  $result
});

=example-3 which

  # given: synopsis

  package main;

  my $which = $os->which('app2');

  # "t/path/user/local/bin/app2"

=cut

$test->for('example', 3, 'which', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result =~ m{t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}app2$};

  $result
});

=example-4 which

  # given: synopsis

  package main;

  my $which = $os->which('app3');

  # "t/path/user/bin/app3"

=cut

$test->for('example', 4, 'which', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result =~ m{t${fsds}path${fsds}user${fsds}bin${fsds}app3$};

  $result
});

=example-5 which

  # given: synopsis

  package main;

  my $which = $os->which('app4');

  # "t/path/user/local/bin/app4"

=cut

$test->for('example', 5, 'which', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok $result =~ m{t${fsds}path${fsds}user${fsds}local${fsds}bin${fsds}app4$};

  $result
});

=example-6 which

  # given: synopsis

  package main;

  my $which = $os->which('app5');

  # undef

=cut

$test->for('example', 6, 'which', sub {
  $Venus::Os::TYPES{$^O} = 'linux';
  my ($tryable) = @_;
  my $result = $tryable->result;
  ok !defined $result;

  !$result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Os.pod') if $ENV{RENDER};

ok 1 and done_testing;
