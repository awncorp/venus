package Venus::Cli;

use 5.018;

use strict;
use warnings;

use Venus::Class 'attr', 'base', 'with';

base 'Venus::Kind::Utility';

with 'Venus::Role::Optional';

require POSIX;

# ATTRIBUTES

attr 'args';
attr 'data';
attr 'logs';
attr 'opts';
attr 'vars';

# BUILDERS

sub build_arg {
  my ($self, $data) = @_;

  return {
    init => $data,
  };
}

# DEFAULTS

sub default_args {
  my ($self) = @_;

  require Venus::Args;

  return Venus::Args->new($self->init);
}

sub default_data {
  my ($self) = @_;

  require Venus::Data;

  return Venus::Data->new($self->podfile);
}

sub default_logs {
  my ($self) = @_;

  require Venus::Log;

  return Venus::Log->new('info');
}

sub default_opts {
  my ($self) = @_;

  require Venus::Opts;

  return Venus::Opts->new(value => $self->init, specs => $self->options);
}

sub default_vars {
  my ($self) = @_;

  require Venus::Vars;

  return Venus::Vars->new;
}

# HOOKS

sub _exit {
  POSIX::_exit(shift);
}

# METHODS

sub init {
  my ($self) = @_;

  return [@ARGV];
}

sub arg {
  my ($self, $item) = @_;

  return defined $item ? $self->opts->unused->[$item] : undef;
}

sub execute {
  my ($self) = @_;

  return $self->opt('help') ? $self->okay : $self->fail;
}

sub exit {
  my ($self, $code, $method, @args) = @_;

  $self->$method(@args) if $method;

  $code ||= 0;

  _exit($code);
}

sub fail {
  my ($self, $method, @args) = @_;

  return $self->exit(1, $method, @args);
}

sub help {
  my ($self, @data) = @_;

  my $content = $self->data->string(@data ? @data : ('head1', 'OPTIONS'));

  my ($space) = $content =~ /(^\s+)/;

  return (defined $space) ? $content =~ s/^$space//mgr : $content;
}

sub log_debug {
  my ($self, @data) = @_;

  return $self->logs->debug(@data);
}

sub log_error {
  my ($self, @data) = @_;

  return $self->logs->error(@data);
}

sub log_fatal {
  my ($self, @data) = @_;

  return $self->logs->fatal(@data);
}

sub log_info {
  my ($self, @data) = @_;

  return $self->logs->info(@data);
}

sub log_trace {
  my ($self, @data) = @_;

  return $self->logs->trace(@data);
}

sub log_warn {
  my ($self, @data) = @_;

  return $self->logs->warn(@data);
}

sub okay {
  my ($self, $method, @args) = @_;

  return $self->exit(0, $method, @args);
}

sub opt {
  my ($self, $item) = @_;

  return defined $item ? $self->opts->get($item) : undef;
}

sub options {
  my ($self) = @_;

  return ['help|h'];
}

sub podfile {
  my ($self) = @_;

  require Venus::Space;

  return Venus::Space->new(ref $self)->included;
}

sub program {
  my ($self) = @_;

  require Venus::Space;

  return Venus::Space->new(ref $self)->included;
}

1;

=encoding utf8

=head1 NAME

faker

=head1 ABSTRACT

Fake Data Generation Tool

=head1 SYNOPSIS

  Faker - Fake Data Generator

  Usage: faker <command> [options]

  Commands:
  address_lines     Generate address lines
  company_name      Generate company name
  company_tagline   Generate company tagline
  lorem_paragraphs  Generate lorem paragraphs
  lorem_sentences   Generate lorem sentences
  lorem_words       Generate lorem words
  person_name       Generate person name
  software_name     Generate software name
  software_semver   Generate software semver
  software_version  Generate software version
  telephone_number  Generate telephone number
  user_login        Generate user login
  user_password     Generate user password
  ...

  Options:
  -l --locales      Specify the locale(s), e.g. en-us, ja-jp, es-es
  -r --repeats      Specify the number of repetitions, e.g. 10

=head1 DESCRIPTION

This tool lets you generate faker data, using the L<Faker> framework.

=head1 AUTHOR

Al Newkirk, C<awncorp@cpan.org>

=head1 LICENSE

See L<Faker>

=cut
