# Release

## Version: 2.80

- [feature] Implement Venus#array

```
package main;

use Venus 'array';

my $array = array [1..4], 'push', 5..9;

# [1..9]
```
- [feature] Implement Venus#boolean

```
package main;

use Venus 'bool';

my $bool = bool 1_000;

# bless({value => 1}, 'Venus::Boolean')
```
- [feature] Implement Venus#code

```
package main;

use Venus 'code';

my $code = code sub {[1, @_]}, 'curry', 2,3,4;

# sub {...}
```
- [feature] Implement Venus#config

```
package main;

use Venus 'config';

my $config = config {}, 'from_perl', '{"data"=>1}';

# bless({...}, 'Venus::Config')
```
- [feature] Implement Venus#data

```
package main;

use Venus 'data';

my $data = data 't/data/sections', 'string', undef, 'name';

# "Example #1
Example #2"
```
- [feature] Implement Venus#float

```
package main;

use Venus 'float';

my $float = float 1.23, 'int';

# 1
```
- [feature] Implement Venus#hash

```
package main;

use Venus 'hash';

my $hash = hash {1..8}, 'pairs';

# [[1, 2], [3, 4], [5, 6], [7, 8]]
```
- [feature] Implement Venus#name

```
package main;

use Venus 'name';

my $name = name 'Foo/Bar', 'package';

# "Foo::Bar"
```
- [feature] Implement Venus#number

```
package main;

use Venus 'number';

my $number = number 1_000, 'prepend', 1;

# 11_000
```
- [feature] Implement Venus#path

```
package main;

use Venus 'path';

my $path = path 't/data/planets', 'absolute';

# bless({...}, 'Venus::Path')
```
- [feature] Implement Venus#proto

```
package main;

use Venus 'proto';

my $proto = proto { '$counter' => 0 }, 'apply', {
  '&decrement' => sub { $_[0]->counter($_[0]->counter - 1) },
  '&increment' => sub { $_[0]->counter($_[0]->counter + 1) },
};

# bless({...}, 'Venus::Prototype')
```
- [feature] Implement Venus#string

```
package main;

use Venus 'string';

my $string = string 'hello world', 'camelcase';

# "helloWorld"
```
- [feature] Implement Venus#template

```
package main;

use Venus 'template';

my $template = template 'Hi {{name}}', 'render', undef, {
  name => 'stranger',
};

# "Hi stranger"
```
- [feature] Implement Venus#vars

```
package main;

use Venus 'vars';

my $path = vars {}, 'home';

# "/root"
```
- [feature] Implement Venus::Assert#render

```
package main;

use Venus::Assert;

my $assert = Venus::Assert->new('Example');

my $expression = $assert->render('hashkeys', {id => 'number', name => 'string'});

# 'hashkeys["id", number, "name", string]'
```
- [feature] Implement Venus::Array#range

```
package main;

use Venus::Array;

my $array = Venus::Array->new([1..9]);

my $range_1 = $array->range('0:');

# [1..9]

my $range_2 = $array->range(':4');

# [1..5]
```
- [feature] Enhance Venus::Throw

```
package Example;

use Venus::Class;

with 'Venus::Role::Throwable';

package main;

my $example = Example->new;

my $throw = $example->throw({
  name => 'on.example',
  capture => [$example],
  stash => {
    time => time,
  },
});

# bless({ "package" => "Example::Error", ..., }, "Venus::Throw")

# $throw->error;
```
- [feature] Implement Venus#meta

```
package main;

use Venus 'meta';

my $result = meta 'Venus', 'sub', 'meta';

# 1
```
- [feature] Implement Venus#opts

```
package main;

use Venus 'opts';

my $opts = opts ['--resource', 'users'], 'reparse', ['resource|r=s', 'help|h'];

# bless({...}, 'Venus::Opts')

# my $resource = $opts->get('resource');

# "users"
```
- [feature] Implement Venus#process

```
package main;

use Venus 'process';

my $process = process 'do', 'alarm', 10;

# bless({...}, 'Venus::Process')


```
- [feature] Implement Venus#random

```
package main;

use Venus 'random';

my $random = random 'collect', 10, 'letter';

# "ryKUPbJHYT"
```
- [feature] Implement Venus#regexp

```
package main;

use Venus 'regexp';

my $replace = regexp '[0-9]', 'replace', 'ID 12345', '0', 'g';

# bless({...}, 'Venus::Replace')

# $replace->get;

# "ID 00000"
```
- [feature] Implement Venus#replace

```
package main;

use Venus 'replace';

my $replace = replace ['hello world', 'world', 'universe'], 'get';

# "hello universe"
```
- [feature] Implement Venus#search

```
package main;

use Venus 'search';

my $search = search ['hello world', 'world'], 'count';

# 1
```
- [feature] Implement Venus#test

```
package main;

use Venus 'test';

my $test = test 't/Venus.t', 'for', 'synopsis';

# bless({...}, 'Venus::Test')
```
- [feature] Implement Venus#throw

```
package main;

use Venus 'throw';

my $throw = throw {
  name => 'on.execute',
  package => 'Example::Error',
  capture => ['...'],
  stash => {
    time => time,
  },
};

# bless({...}, 'Venus::Throw')
```
- [feature] Implement Venus#try

```
package main;

use Venus 'try';

my $try = try sub { die }, 'maybe';

# bless({...}, 'Venus::Try')

# my $result = $try->result;

# undef
```
- [feature] Implement Venus#type

```
package main;

use Venus 'type';

my $type = type [1..4], 'deduce';

# bless({...}, 'Venus::Array')
```
- [feature] Implement Venus::Schema

```
package main;

use Venus::Schema;

my $schema = Venus::Schema->new;

$schema->definition({
  name => 'string',
  role => {
    title => 'string',
    level => 'number',
  },
});

my $value = $schema->validate({
  name => 'someone',
  role => {
    title => 'engineer',
    level => 1,
  },
});

# {name => 'someone', role => {title => 'engineer', level => 1,},}
```
- [feature] Implement Venus::Path#extension

```
package main;

use Venus::Path;

my $path = Venus::Path->new('t/data');

my $extension = $path->extension('txt');

# bless({ value => "t/data.txt"}, "Venus::Path")
```
- [update] Resolve CPANTS issues

> See http://www.cpantesters.org/cpan/report/756bb4fe-6c96-1014-bcad-95e4efaa1848
- [update] Add missing signature for Venus::Template#render
- [update] Implement Venus::Throw#{frame,capture}
- [update] Update Venus#date syntax
- [update] Fix Venus::Assert parser issue
- [update] Refactor Venus::Cli

```
package main;

use Venus::Cli;

my $cli = Venus::Cli->new(['--help']);

$cli->set('opt', 'help', {
  help => 'Show help information',
});

# $cli->opt('help');

# [1]

# $cli->data;

# {help => 1}

# $cli->say_string('help');

# Usage: application [<option>]
#
# Options:
#
#   --help
#     Show help information
#     (optional)
```
- [update] Update Venus::Cli "opt" type logic and documentation


