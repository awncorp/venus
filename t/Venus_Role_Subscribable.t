package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

use Venus 'catch';

my $test = test(__FILE__);

=name

Venus::Role::Subscribable

=cut

$test->for('name');

=tagline

Subscribable Role

=cut

$test->for('tagline');

=abstract

Subscribable Role for Perl 5

=cut

$test->for('abstract');

=includes

method: publish
method: subscribe
method: subscribers
method: unsubscribe

=cut

$test->for('includes');

=synopsis

  package Example;

  use Venus::Class;

  with 'Venus::Role::Subscribable';

  sub execute {
    $_[0]->publish('on.execute');
  }

  package main;

  my $example = Example->new;

  # $example->subscribe('on.execute', sub{...});

  # bless(..., 'Example')

  # $example->publish('on.execute');

  # bless(..., 'Example')

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok $result->does('Venus::Role::Subscribable');
  isa_ok $result->execute, 'Example';

  $result
});

=description

This package provides a mechanism for publishing and subscribing to events.

=cut

$test->for('description');

=method publish

The publish method notifies all subscribers for a given event and returns the
invocant.

=signature publish

  publish(Str $name, Any @args) (Self)

=metadata publish

{
  since => '1.75',
}

=example-1 publish

  # given: synopsis

  package main;

  $example = $example->publish;

  # bless(..., 'Example')

=cut

$test->for('example', 1, 'publish', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok !keys %{$result->{'$subscriptions'}};

  $result
});

=example-2 publish

  # given: synopsis

  package main;

  $example = $example->publish('on.execute');

  # bless(..., 'Example')

=cut

$test->for('example', 2, 'publish', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is_deeply $result->{'$subscriptions'}, {on_execute=>[]};

  $result
});

=example-3 publish

  # given: synopsis

  package main;

  $example->subscribe('on.execute', sub {$example->{emitted} = [@_]});

  $example = $example->publish('on.execute');

  # bless(..., 'Example')

=cut

$test->for('example', 3, 'publish', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is_deeply $result->{emitted}, [];

  $result
});

=example-4 publish

  # given: synopsis

  package main;

  $example->subscribe('on.execute', sub {$example->{emitted} = [@_]});

  $example = $example->publish('on.execute', [1..4]);

  # bless(..., 'Example')

=cut

$test->for('example', 4, 'publish', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is_deeply $result->{emitted}, [[1..4]];

  $result
});

=method subscribe

The subscribe method registers a subscribers (i.e. callbacks) for a given event,
and returns the invocant.

=signature subscribe

  subscribe(Str $name, CodeRef $code) (Self)

=metadata subscribe

{
  since => '1.75',
}

=example-1 subscribe

  # given: synopsis

  package main;

  $example = $example->subscribe('on.execute', sub {$example->{emitted} = [@_]});

  # bless(..., 'Example')

=cut

$test->for('example', 1, 'subscribe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is +keys %{$result->{'$subscriptions'}}, 1;
  is @{$result->{'$subscriptions'}{on_execute}}, 1;

  $result
});

=example-2 subscribe

  # given: synopsis

  package main;

  $example = $example->subscribe('on.execute', sub {$example->{emitted_1} = [@_]});

  # bless(..., 'Example')

  $example = $example->subscribe('on.execute', sub {$example->{emitted_2} = [@_]});

  # bless(..., 'Example')

  $example = $example->subscribe('on.execute', sub {$example->{emitted_3} = [@_]});

  # bless(..., 'Example')

  # $example->publish('on.execute');

  # bless(..., 'Example')

=cut

$test->for('example', 2, 'subscribe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  is +keys %{$result->{'$subscriptions'}}, 1;
  is @{$result->{'$subscriptions'}{on_execute}}, 3;
  ok !exists $result->{emitted_1};
  ok !exists $result->{emitted_2};
  ok !exists $result->{emitted_3};
  isa_ok $result->publish('on.execute'), 'Example';
  ok exists $result->{emitted_1};
  ok exists $result->{emitted_2};
  ok exists $result->{emitted_3};

  $result
});

=method subscribers

The subscribers method returns the number of subscribers (i.e. callbacks) for a
given event.

=signature subscribers

  subscribers(Str $name) (Int)

=metadata subscribers

{
  since => '1.75',
}

=example-1 subscribers

  # given: synopsis

  package main;

  $example = $example->subscribers;

  # 0

=cut

$test->for('example', 1, 'subscribers', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-2 subscribers

  # given: synopsis

  package main;

  $example = $example->subscribers('on.execute');

  # 0

=cut

$test->for('example', 2, 'subscribers', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);
  is $result, 0;

  !$result
});

=example-3 subscribers

  # given: synopsis

  package main;

  $example = $example->subscribe('on.execute', sub {$example->{emitted_1} = [@_]});

  $example = $example->subscribe('on.execute', sub {$example->{emitted_2} = [@_]});

  $example = $example->subscribe('on.execute', sub {$example->{emitted_3} = [@_]});

  $example = $example->subscribers('on.execute');

  # 3

=cut

$test->for('example', 3, 'subscribers', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, 3;

  $result
});

=method unsubscribe

The unsubscribe method deregisters all subscribers (i.e. callbacks) for a given
event, or a specific callback if provided, and returns the invocant.

=signature unsubscribe

  unsubscribe(Str $name, CodeRef $code) (Self)

=metadata unsubscribe

{
  since => '1.75',
}

=example-1 unsubscribe

  # given: synopsis

  package main;

  $example = $example->unsubscribe;

  # bless(..., 'Example')

=cut

$test->for('example', 1, 'unsubscribe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok !exists $result->{'$subscriptions'};

  $result
});

#$test->for('example', 1, 'unsubscribe', sub {
#  my ($tryable) = @_;
#  ok !(my $result = $tryable->error(\my $error)->result);
#  ok $error->isa('Venus::Error');
#
#  !$result
#});

=example-2 unsubscribe

  # given: synopsis

  package main;

  $example = $example->unsubscribe('on.execute');

  # bless(..., 'Example')

=cut

$test->for('example', 2, 'unsubscribe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok exists $result->{'$subscriptions'};
  is +keys %{$result->{'$subscriptions'}}, 0;

  $result
});

=example-3 unsubscribe

  # given: synopsis

  package main;

  $example = $example->subscribe('on.execute', sub {$example->{emitted_1} = [@_]});

  $example = $example->subscribe('on.execute', sub {$example->{emitted_2} = [@_]});

  $example = $example->subscribe('on.execute', sub {$example->{emitted_3} = [@_]});

  $example = $example->unsubscribe('on.execute');

  # bless(..., 'Example')

=cut

$test->for('example', 3, 'unsubscribe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  ok exists $result->{'$subscriptions'};
  is +keys %{$result->{'$subscriptions'}}, 0;

  $result
});

=example-4 unsubscribe

  # given: synopsis

  package main;

  my $execute = sub {$example->{execute} = [@_]};

  $example = $example->subscribe('on.execute', $execute);

  $example = $example->unsubscribe('on.execute', $execute);

  # bless(..., 'Example')

=cut

$test->for('example', 4, 'unsubscribe', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Example');
  my $execute_1 = sub {$result->{execute} = [@_]};
  ok $result->subscribe('on.execute', $execute_1);
  is +keys %{$result->{'$subscriptions'}}, 1;
  is @{$result->{'$subscriptions'}{on_execute}}, 1;
  my $execute_2 = sub {$result->{execute} = [@_]};
  ok $result->subscribe('on.execute', $execute_2);
  is @{$result->{'$subscriptions'}{on_execute}}, 2;
  ok $result->unsubscribe('on.execute', $execute_2);
  is @{$result->{'$subscriptions'}{on_execute}}, 1;
  ok $result->unsubscribe('on.execute', $execute_1);
  is @{$result->{'$subscriptions'}{on_execute}}, 0;

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Role/Subscribable.pod') if $ENV{VENUS_RENDER};

ok 1 and done_testing;
