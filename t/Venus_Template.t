package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Template

=cut

$test->for('name');

=tagline

Template Class

=cut

$test->for('tagline');

=abstract

Template Class for Perl 5

=cut

$test->for('abstract');

=includes

method: render

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Template;

  my $template = Venus::Template->new(
    'From: <{{ email }}>',
  );

  # $template->render;

  # "From: <>"

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Template');
  is $result->render, 'From: <>';
  $result->variables({email => 'noreply@example.com'});
  is $result->render, 'From: <noreply@example.com>';

  $result
});

=description

This package provides a templating system, and methods for rendering templates
using simple markup and minimal control structures. The default opening and
closing markers, denoting a template token, block, or control structure, are
C<{{> and C<}}>. A token takes the form of C<{{ foo }}> or C<{{ foo.bar }}>. A
block takes the form of C<{{ for foo.bar }}> where C<foo.bar> represents any
valid path, resolvable by L<Venus::Array/path> or L<Venus::Hash/path>, which
returns an arrayref or L<Venus::Array> object, and must be followed by
C<{{ end foo }}>. Control structures take the form of C<{{ if foo }}> or
C<{{ if not foo }}>, may contain a nested C<{{ else foo }}> control structure,
and must be followed by C<{{ end foo }}>. Leading and trailing whitespace is
automatically removed from all replacements.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Accessible
Venus::Role::Buildable
Venus::Role::Explainable
Venus::Role::Valuable

=cut

$test->for('integrates');

=attributes

variables: rw, opt, HashRef, C<{}>

=cut

$test->for('attributes');

=method render

The render method processes the template by replacing the tokens and control
structurs with the appropriate replacements and returns the result. B<Note:>
The rendering process expects variables to be hashrefs and sets (arrayrefs) of
hashrefs.

=signature render

  render(Str $template, HashRef $variables) (Str)

=metadata render

{
  since => '0.01',
}

=example-1 render

  # given: synopsis;

  my $result = $template->render;

  # "From: <>"

=cut

$test->for('example', 1, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'From: <>';

  $result
});

=example-2 render

  # given: synopsis;

  $template->value(
    'From: {{ if name }}{{ name }}{{ end name }} <{{ email }}>',
  );

  $template->variables({
    email => 'noreply@example.com',
  });

  my $result = $template->render;

  # "From:  <noreply@example.com>"

=cut

$test->for('example', 2, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'From:  <noreply@example.com>';

  $result
});

=example-3 render

  # given: synopsis;

  $template->value(
    'From: {{ if name }}{{ name }}{{ end name }} <{{ email }}>',
  );

  $template->variables({
    name => 'No-Reply',
    email => 'noreply@example.com',
  });

  my $result = $template->render;

  # "From: No-Reply <noreply@example.com>"

=cut

$test->for('example', 3, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 'From: No-Reply <noreply@example.com>';

  $result
});

=example-4 render

  package main;

  use Venus::Template;

  my $template = Venus::Template->new(q(
    {{ for chat.messages }}
    {{ user.name }}: {{ message }}
    {{ end chat.messages }}
  ));

  $template->variables({
    chat => { messages => [
      { user => { name => 'user1' }, message => 'ready?' },
      { user => { name => 'user2' }, message => 'ready!' },
      { user => { name => 'user1' }, message => 'lets begin!' },
    ]}
  });

  my $result = $template->render;

  # user1: ready?
  # user2: ready!
  # user1: lets begin!

=cut

$test->for('example', 4, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;

  is_deeply [map {s/^[\n\s]*|[\n\s]*$//gr} split /\n/, $result], [
    'user1: ready?',
    'user2: ready!',
    'user1: lets begin!',
  ];

  $result
});

=example-5 render

  package main;

  use Venus::Template;

  my $template = Venus::Template->new(q(
    {{ for chat.messages }}
    {{ if user.legal }}
    {{ user.name }} [18+]: {{ message }}
    {{ else user.legal }}
    {{ user.name }} [-18]: {{ message }}
    {{ end user.legal }}
    {{ end chat.messages }}
  ));

  $template->variables({
    chat => { messages => [
      { user => { name => 'user1', legal => 1 }, message => 'ready?' },
      { user => { name => 'user2', legal => 0 }, message => 'ready!' },
      { user => { name => 'user1', legal => 1 }, message => 'lets begin!' },
    ]}
  });

  my $result = $template->render;

  # user1 [18+]: ready?
  # user2 [-18]: ready!
  # user1 [18+]: lets begin!

=cut

$test->for('example', 5, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply [map {s/^[\n\s]*|[\n\s]*$//gr} split /\n/, $result], [
    'user1 [18+]: ready?',
    'user2 [-18]: ready!',
    'user1 [18+]: lets begin!',
  ];

  $result
});

=example-6 render

  package main;

  use Venus::Template;

  my $template = Venus::Template->new(q(
    {{ for chat.messages }}
    {{ if user.admin }}@{{ end user.admin }}{{ user.name }}: {{ message }}
    {{ end chat.messages }}
  ));

  $template->variables({
    chat => { messages => [
      { user => { name => 'user1', admin => 1 }, message => 'ready?' },
      { user => { name => 'user2', admin => 0 }, message => 'ready!' },
      { user => { name => 'user1', admin => 1 }, message => 'lets begin!' },
    ]}
  });

  my $result = $template->render;

  # @user1: ready?
  # user2: ready!
  # @user1: lets begin!

=cut

$test->for('example', 6, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply [map {s/^[\n\s]*|[\n\s]*$//gr} split /\n/, $result], [
    '@user1: ready?',
    'user2: ready!',
    '@user1: lets begin!',
  ];

  $result
});

=example-7 render

  package main;

  use Venus::Template;

  my $template = Venus::Template->new(q(
    {{ for chat.messages }}
    [{{ loop.place }}] {{ user.name }}: {{ message }}
    {{ end chat.messages }}
  ));

  $template->variables({
    chat => { messages => [
      { user => { name => 'user1' }, message => 'ready?' },
      { user => { name => 'user2' }, message => 'ready!' },
      { user => { name => 'user1' }, message => 'lets begin!' },
    ]}
  });

  my $result = $template->render;

  # [1] user1: ready?
  # [2] user2: ready!
  # [3] user1: lets begin!

=cut

$test->for('example', 7, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply [map {s/^[\n\s]*|[\n\s]*$//gr} split /\n/, $result], [
    '[1] user1: ready?',
    '[2] user2: ready!',
    '[3] user1: lets begin!',
  ];

  $result
});

=example-8 render

  package main;

  use Venus::Template;

  my $template = Venus::Template->new(q(
    {{ for chat.messages }}
    [{{ loop.index }}] {{ user.name }}: {{ message }}
    {{ end chat.messages }}
  ));

  $template->variables({
    chat => { messages => [
      { user => { name => 'user1' }, message => 'ready?' },
      { user => { name => 'user2' }, message => 'ready!' },
      { user => { name => 'user1' }, message => 'lets begin!' },
    ]}
  });

  my $result = $template->render;

  # [0] user1: ready?
  # [1] user2: ready!
  # [2] user1: lets begin!

=cut

$test->for('example', 8, 'render', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply [map {s/^[\n\s]*|[\n\s]*$//gr} split /\n/, $result], [
    '[0] user1: ready?',
    '[1] user2: ready!',
    '[2] user1: lets begin!',
  ];

  $result
});

=operator ("")

This package overloads the C<""> operator.

=cut

$test->for('operator', '("")');

=example-1 ("")

  # given: synopsis;

  my $result = "$template";

  # "From: <>"

=cut

$test->for('example', 1, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'From: <>';

  $result
});

=example-2 ("")

  # given: synopsis;

  my $result = "$template, $template";

  # "From: <>, From: <>"

=cut

$test->for('example', 2, '("")', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq 'From: <>, From: <>';

  $result
});

=operator (~~)

This package overloads the C<~~> operator.

=cut

$test->for('operator', '(~~)');

=example-1 (~~)

  # given: synopsis;

  my $result = $template ~~ 'From: <>';

  # 1

=cut

$test->for('example', 1, '(~~)', sub {
  1;
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Template.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
