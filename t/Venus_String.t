package main;

use 5.018;

use strict;
use warnings;

use lib 't/lib';

use Test::More;
use Test::Venus;

my $test = test(__FILE__);

=name

Venus::String

=cut

$test->for('name');

=tagline

String Class

=cut

$test->for('tagline');

=abstract

String Class for Perl 5

=cut

$test->for('abstract');

=includes

method: append
method: camelcase
method: chomp
method: chop
method: concat
method: contains
method: default
method: hex
method: index
method: lc
method: lcfirst
method: length
method: lines
method: lowercase
method: render
method: search
method: replace
method: reverse
method: rindex
method: snakecase
method: split
method: strip
method: titlecase
method: trim
method: uc
method: ucfirst
method: uppercase
method: words

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  # $string->camelcase;

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  $result
});

=description

This package provides methods for manipulating string data.

=cut

$test->for('description');

=inherits

Venus::Kind::Value

=cut

$test->for('inherits');

=method append

The append method appends arugments to the string using spaces.

=signature append

  append(Str @parts) (Str)

=metadata append

{
  since => '0.01',
}

=example-1 append

  # given: synopsis;

  my $append = $string->append('welcome');

  # "hello world welcome"

=cut

$test->for('example', 1, 'append', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world welcome";

  $result
});

=method append_with

The append_with method appends arugments to the string using the delimiter provided.

=signature append_with

  append_with(Str $delimiter, Str @parts) (Str)

=metadata append_with

{
  since => '0.01',
}

=example-1 append_with

  # given: synopsis;

  my $append = $string->append_with(', ', 'welcome');

  # "hello world, welcome"

=cut

$test->for('example', 1, 'append_with', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world, welcome";

  $result
});

=method camelcase

The camelcase method converts the string to camelcase.

=signature camelcase

  camelcase() (Str)

=metadata camelcase

{
  since => '0.01',
}

=example-1 camelcase

  # given: synopsis;

  my $camelcase = $string->camelcase;

  # "HelloWorld"

=cut

$test->for('example', 1, 'camelcase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HelloWorld";

  $result
});

=method chomp

The chomp method removes the newline (or the current value of $/) from the end
of the string.

=signature chomp

  chomp() (Str)

=metadata chomp

{
  since => '0.01',
}

=example-1 chomp

  package main;

  use Venus::String;

  my $string = Venus::String->new("name, age, dob, email\n");

  my $chomp = $string->chomp;

  # "name, age, dob, email"

=cut

$test->for('example', 1, 'chomp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "name, age, dob, email";

  $result
});

=example-2 chomp

  package main;

  use Venus::String;

  my $string = Venus::String->new("name, age, dob, email\n\n");

  my $chomp = $string->chomp;

  # "name, age, dob, email\n"

=cut

$test->for('example', 2, 'chomp', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "name, age, dob, email\n";

  $result
});

=method chop

The chop method removes and returns the last character of the string.

=signature chop

  chop() (Str)

=metadata chop

{
  since => '0.01',
}

=example-1 chop

  package main;

  use Venus::String;

  my $string = Venus::String->new("this is just a test.");

  my $chop = $string->chop;

  # "this is just a test"

=cut

$test->for('example', 1, 'chop', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "this is just a test";

  $result
});

=method concat

The concat method returns the string with the argument list appended to it.

=signature concat

  concat(Str @parts) (Str)

=metadata concat

{
  since => '0.01',
}

=example-1 concat

  package main;

  use Venus::String;

  my $string = Venus::String->new('ABC');

  my $concat = $string->concat('DEF', 'GHI');

  # "ABCDEFGHI"

=cut

$test->for('example', 1, 'concat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "ABCDEFGHI";

  $result
});

=method contains

The contains method searches the string for a substring or expression returns
true or false if found.

=signature contains

  contains(Str $expr) (Bool)

=metadata contains

{
  since => '0.01',
}

=example-1 contains

  package main;

  use Venus::String;

  my $string = Venus::String->new('Nullam ultrices placerat.');

  my $contains = $string->contains('trices');

  # 1

=cut

$test->for('example', 1, 'contains', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 contains

  package main;

  use Venus::String;

  my $string = Venus::String->new('Nullam ultrices placerat.');

  my $contains = $string->contains('itrices');

  # 0

=cut

$test->for('example', 2, 'contains', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result == 0;

  !$result
});

=example-3 contains

  package main;

  use Venus::String;

  my $string = Venus::String->new('Nullam ultrices placerat.');

  my $contains = $string->contains(qr/trices/);

  # 1

=cut

$test->for('example', 3, 'contains', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=method default

The default method returns the default value, i.e. C<''>.

=signature default

  default() (Str)

=metadata default

{
  since => '0.01',
}

=example-1 default

  # given: synopsis;

  my $default = $string->default;

  # ""

=cut

$test->for('example', 1, 'default', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  ok $result eq '';

  !$result
});

=method hex

The hex method returns the value resulting from interpreting the string as a
hex string.

=signature hex

  hex() (Str)

=metadata hex

{
  since => '0.01',
}

=example-1 hex

  package main;

  use Venus::String;

  my $string = Venus::String->new('0xaf');

  my $hex = $string->hex;

  # 175

=cut

$test->for('example', 1, 'hex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 175;

  $result
});

=method index

The index method searches for the argument within the string and returns the
position of the first occurrence of the argument.

=signature index

  index(Str $substr, Int $start) (Str)

=metadata index

{
  since => '0.01',
}

=example-1 index

  package main;

  use Venus::String;

  my $string = Venus::String->new('unexplainable');

  my $index = $string->index('explain');

  # 2

=cut

$test->for('example', 1, 'index', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
});

=example-2 index

  package main;

  use Venus::String;

  my $string = Venus::String->new('unexplainable');

  my $index = $string->index('explain', 1);

  # 2

=cut

$test->for('example', 2, 'index', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 2;

  $result
});

=example-3 index

  package main;

  use Venus::String;

  my $string = Venus::String->new('unexplainable');

  my $index = $string->index('explained');

  # -1

=cut

$test->for('example', 3, 'index', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == -1;

  $result
});

=method lc

The lc method returns a lowercased version of the string.

=signature lc

  lc() (Str)

=metadata lc

{
  since => '0.01',
}

=example-1 lc

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hello World');

  my $lc = $string->lc;

  # "hello world"

=cut

$test->for('example', 1, 'lc', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world";

  $result
});

=method lcfirst

The lcfirst method returns a the string with the first character lowercased.

=signature lcfirst

  lcfirst() (Str)

=metadata lcfirst

{
  since => '0.01',
}

=example-1 lcfirst

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hello World');

  my $lcfirst = $string->lcfirst;

  # "hello World"

=cut

$test->for('example', 1, 'lcfirst', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello World";

  $result
});

=method length

The length method returns the number of characters within the string.

=signature length

  length() (Int)

=metadata length

{
  since => '0.01',
}

=example-1 length

  # given: synopsis;

  my $length = $string->length;

  # 11

=cut

$test->for('example', 1, 'length', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 11;

  $result
});

=method lines

The lines method returns an arrayref of parts by splitting on 1 or more newline
characters.

=signature lines

  lines() (ArrayRef[Str])

=metadata lines

{
  since => '0.01',
}

=example-1 lines

  # given: synopsis;

  my $lines = $string->lines;

  # ["hello world"]

=cut

$test->for('example', 1, 'lines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["hello world"];

  $result
});

=example-2 lines

  package main;

  use Venus::String;

  my $string = Venus::String->new("who am i?\nwhere am i?\nhow did I get here");

  my $lines = $string->lines;

  # ["who am i?", "where am i?", "how did I get here"]

=cut

$test->for('example', 2, 'lines', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["who am i?", "where am i?", "how did I get here"];

  $result
});

=method prepend

The prepend method prepends arugments to the string using spaces.

=signature prepend

  prepend(Str @parts) (Str)

=metadata prepend

{
  since => '0.01',
}

=example-1 prepend

  # given: synopsis;

  my $prepend = $string->prepend('welcome');

  # "welcome hello world"

=cut

$test->for('example', 1, 'prepend', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "welcome hello world";

  $result
});

=method prepend_with

The prepend_with method prepends arugments to the string using the delimiter
provided.

=signature prepend_with

  prepend_with(Str $delimiter, Str @parts) (Str)

=metadata prepend_with

{
  since => '0.01',
}

=example-1 prepend_with

  # given: synopsis;

  my $prepend = $string->prepend_with(', ', 'welcome');

  # "welcome, hello world"

=cut

$test->for('example', 1, 'prepend_with', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "welcome, hello world";

  $result
});

=method lowercase

The lowercase method is an alias to the lc method.

=signature lowercase

  lowercase() (Str)

=metadata lowercase

{
  since => '0.01',
}

=example-1 lowercase

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hello World');

  my $lowercase = $string->lowercase;

  # "hello world"

=cut

$test->for('example', 1, 'lowercase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world";

  $result
});

=method repeat

The repeat method repeats the string value N times based on the number provided
and returns a new concatenated string. Optionally, a delimiter can be provided
and be place between the occurences.

=signature repeat

  repeat(Num $number, Str $delimiter) (Str)

=metadata repeat

{
  since => '0.01',
}

=example-1 repeat

  package main;

  use Venus::String;

  my $string = Venus::String->new('999');

  my $repeat = $string->repeat(2);

  # "999999"

=cut

$test->for('example', 1, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "999999";

  $result
});

=example-2 repeat

  package main;

  use Venus::String;

  my $string = Venus::String->new('999');

  my $repeat = $string->repeat(2, ',');

  # "999,999"

=cut

$test->for('example', 2, 'repeat', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "999,999";

  $result
});

=method render

The render method treats the string as a template and performs a simple token
replacement using the argument provided.

=signature render

  render(HashRef $tokens) (Str)

=metadata render

{
  since => '0.01',
}

=example-1 render

  package main;

  use Venus::String;

  my $string = Venus::String->new('Hi, {name}!');

  my $render = $string->render({name => 'Friend'});

  # "Hi, Friend!"

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Hi, Friend!";

  $result
});

=method search

The search method performs a search operation and returns the L<Venus::Search>
object.

=signature search

  search(Regexp $regexp) (Search)

=metadata search

{
  since => '0.01',
}

=example-1 search

  # given: synopsis;

  my $search = $string->search('world');

  # bless({
  #   ...,
  #   "flags"   => "",
  #   "regexp"  => "world",
  #   "string"  => "hello world",
  # }, "Venus::Search")

=cut

$test->for('example', 1, 'search', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Search');

  $result
});

=method replace

The replace method performs a search and replace operation and returns the
L<Venus::Replace> object.

=signature replace

  replace(Regexp $regexp, Str $replace, Str $flags) (Replace)

=metadata replace

{
  since => '0.01',
}

=example-1 replace

  # given: synopsis;

  my $replace = $string->replace('world', 'universe');

  # bless({
  #   ...,
  #   "flags"   => "",
  #   "regexp"  => "world",
  #   "string"  => "hello world",
  #   "substr"  => "universe",
  # }, "Venus::Replace")

=cut

$test->for('example', 1, 'replace', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Replace');

  $result
});

=method reverse

The reverse method returns a string where the characters in the string are in
the opposite order.

=signature reverse

  reverse() (Str)

=metadata reverse

{
  since => '0.01',
}

=example-1 reverse

  # given: synopsis;

  my $reverse = $string->reverse;

  # "dlrow olleh"

=cut

$test->for('example', 1, 'reverse', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "dlrow olleh";

  $result
});

=method rindex

The rindex method searches for the argument within the string and returns the
position of the last occurrence of the argument.

=signature rindex

  rindex(Str $substr, Int $start) (Str)

=metadata rindex

{
  since => '0.01',
}

=example-1 rindex

  package main;

  use Venus::String;

  my $string = Venus::String->new('explain the unexplainable');

  my $rindex = $string->rindex('explain');

  # 14

=cut

$test->for('example', 1, 'rindex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 14;

  $result
});

=example-2 rindex

  package main;

  use Venus::String;

  my $string = Venus::String->new('explain the unexplainable');

  my $rindex = $string->rindex('explained');

  # -1

=cut

$test->for('example', 2, 'rindex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == -1;

  $result
});

=example-3 rindex

  package main;

  use Venus::String;

  my $string = Venus::String->new('explain the unexplainable');

  my $rindex = $string->rindex('explain', 21);

  # 14

=cut

$test->for('example', 3, 'rindex', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 14;

  $result
});

=method snakecase

The snakecase method converts the string to snakecase.

=signature snakecase

  snakecase() (Str)

=metadata snakecase

{
  since => '0.01',
}

=example-1 snakecase

  # given: synopsis;

  my $snakecase = $string->snakecase;

  # "hello_world"

=cut

$test->for('example', 1, 'snakecase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello_world";

  $result
});

=method split

The split method returns an arrayref by splitting the string on the argument.

=signature split

  split(Str | Regexp $expr, Maybe[Int] $limit) (ArrayRef)

=metadata split

{
  since => '0.01',
}

=example-1 split

  package main;

  use Venus::String;

  my $string = Venus::String->new('name, age, dob, email');

  my $split = $string->split(', ');

  # ["name", "age", "dob", "email"]

=cut

$test->for('example', 1, 'split', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["name", "age", "dob", "email"];

  $result
});

=example-2 split

  package main;

  use Venus::String;

  my $string = Venus::String->new('name, age, dob, email');

  my $split = $string->split(', ', 2);

  # ["name", "age, dob, email"]

=cut

$test->for('example', 2, 'split', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["name", "age, dob, email"];

  $result
});

=example-3 split

  package main;

  use Venus::String;

  my $string = Venus::String->new('name, age, dob, email');

  my $split = $string->split(qr/\,\s*/);

  # ["name", "age", "dob", "email"]

=cut

$test->for('example', 3, 'split', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["name", "age", "dob", "email"];

  $result
});

=method strip

The strip method returns the string replacing occurences of 2 or more
whitespaces with a single whitespace.

=signature strip

  strip() (Str)

=metadata strip

{
  since => '0.01',
}

=example-1 strip

  package main;

  use Venus::String;

  my $string = Venus::String->new('one,  two,  three');

  my $strip = $string->strip;

  # "one, two, three"

=cut

$test->for('example', 1, 'strip', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "one, two, three";

  $result
});

=method substr

The substr method calls the core L</substr> function with the object's string
value. In list context returns the result and the subject.

=signature substr

  substr(Num $offset, Num $length, Str $replace) (Str)

=metadata substr

{
  since => '0.01',
}

=example-1 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my $substr = $string->substr(0, 5);

  # "hello"

=cut

$test->for('example', 1, 'substr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello";

  $result
});

=example-2 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my $substr = $string->substr(6, 5);

  # "world"

=cut

$test->for('example', 2, 'substr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "world";

  $result
});

=example-3 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my $substr = $string->substr(6, 5, 'universe');

  # "hello universe"

=cut

$test->for('example', 3, 'substr', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello universe";

  $result
});

=example-4 substr

  package main;

  use Venus::String;

  my $string = Venus::String->new('hello world');

  my ($result, $subject) = $string->substr(6, 5, 'universe');

  # ("world", "hello universe")

=cut

$test->for('example', 4, 'substr', sub {
  my ($tryable) = @_;
  ok my @result = $tryable->result;
  ok $result[0] eq "world";
  ok $result[1] eq "hello universe";

  @result
});

=method titlecase

The titlecase method returns the string capitalizing the first character of
each word.

=signature titlecase

  titlecase() (Str)

=metadata titlecase

{
  since => '0.01',
}

=example-1 titlecase

  # given: synopsis;

  my $titlecase = $string->titlecase;

  # "Hello World"

=cut

$test->for('example', 1, 'titlecase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Hello World";

  $result
});

=method trim

The trim method removes one or more consecutive leading and/or trailing spaces
from the string.

=signature trim

  trim() (Str)

=metadata trim

{
  since => '0.01',
}

=example-1 trim

  package main;

  use Venus::String;

  my $string = Venus::String->new('   system is   ready   ');

  my $trim = $string->trim;

  # "system is   ready"

=cut

$test->for('example', 1, 'trim', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "system is   ready";

  $result
});

=method uc

The uc method returns an uppercased version of the string.

=signature uc

  uc() (Str)

=metadata uc

{
  since => '0.01',
}

=example-1 uc

  # given: synopsis;

  my $uc = $string->uc;

  # "HELLO WORLD"

=cut

$test->for('example', 1, 'uc', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HELLO WORLD";

  $result
});

=method ucfirst

The ucfirst method returns a the string with the first character uppercased.

=signature ucfirst

  ucfirst() (Str)

=metadata ucfirst

{
  since => '0.01',
}

=example-1 ucfirst

  # given: synopsis;

  my $ucfirst = $string->ucfirst;

  # "Hello world"

=cut

$test->for('example', 1, 'ucfirst', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "Hello world";

  $result
});

=method uppercase

The uppercase method is an alias to the uc method.

=signature uppercase

  uppercase() (Str)

=metadata uppercase

{
  since => '0.01',
}

=example-1 uppercase

  # given: synopsis;

  my $uppercase = $string->uppercase;

  # "HELLO WORLD"

=cut

$test->for('example', 1, 'uppercase', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "HELLO WORLD";

  $result
});

=method words

The words method returns an arrayref by splitting on 1 or more consecutive
spaces.

=signature words

  words() (ArrayRef[Str])

=metadata words

{
  since => '0.01',
}

=example-1 words

  package main;

  use Venus::String;

  my $string = Venus::String->new(
    'is this a bug we\'re experiencing'
  );

  my $words = $string->words;

  # ["is", "this", "a", "bug", "we're", "experiencing"]

=cut

$test->for('example', 1, 'words', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, ["is", "this", "a", "bug", "we're", "experiencing"];

  $result
});

=operator (.)

This package overloads the C<.> operator.

=cut

$test->for('operator', '(.)');

=example-1 (.)

  # given: synopsis;

  my $text = $string . ', welcome';

  # "hello world, welcome"

=cut

$test->for('example', 1, '(.)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "hello world, welcome";

  $result
});

=operator (eq)

This package overloads the C<eq> operator.

=cut

$test->for('operator', '(eq)');

=example-1 (eq)

  # given: synopsis;

  my $result = $string eq 'hello world';

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (eq)

  package main;

  use Venus::String;

  my $string1 = Venus::String->new('hello world');
  my $string2 = Venus::String->new('hello world');

  my $result = $string1 eq $string2;

  # 1

=cut

$test->for('example', 1, '(eq)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (ne)

This package overloads the C<ne> operator.

=cut

$test->for('operator', '(ne)');

=example-1 (ne)

  # given: synopsis;

  my $result = $string ne 'Hello world';

  1;

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=example-2 (ne)

  package main;

  use Venus::String;

  my $string1 = Venus::String->new('hello world');
  my $string2 = Venus::String->new('Hello world');

  my $result = $string1 ne $string2;

  # 1

=cut

$test->for('example', 1, '(ne)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=operator (qr)

This package overloads the C<qr> operator.

=cut

$test->for('operator', '(qr)');

=example-1 (qr)

  # given: synopsis;

  my $test = 'hello world' =~ qr/$string/;

  # 1

=cut

$test->for('example', 1, '(qr)', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result == 1;

  $result
});

=license

Copyright (C) 2021, Cpanery

Read the L<"license"|https://github.com/cpanery/venus/blob/master/LICENSE> file.

=cut

=authors

Cpanery, C<cpanery@cpan.org>

=cut

# END

$test->render('lib/Venus/String.pod') if $ENV{RENDER};

ok 1 and done_testing;