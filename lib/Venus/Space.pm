package Venus::Space;

use 5.014;

use strict;
use warnings;

use Moo;

extends 'Venus::Name';

# METHODS

my %has;

sub all {
  my ($self, $name, @args) = @_;

  my $result = [];
  my $class = $self->class;

  for my $package ($self->package, @{$self->inherits}) {
    push @$result, [$package, $class->new($package)->$name(@args)];
  }

  return $result;
}

sub append {
  my ($self, @args) = @_;

  my $class = $self->class;

  my $path = join '/',
    $self->path, map $class->new($_)->path, @args;

  return $class->new($path);
}

sub array {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [@{"${class}::${name}"}];
}

sub arrays {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  my $arrays = [
    sort grep !!@{"${class}::$_"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];

  return $arrays;
}

sub authority {
  my ($self) = @_;

  return $self->scalar('AUTHORITY');
}

sub basename {
  my ($self) = @_;

  return $self->parse->[-1];
}

sub blessed {
  my ($self, $data) = @_;

  $data //= {};

  my $class = $self->load;

  return CORE::bless($data, $class);
}

sub build {
  my ($self, @args) = @_;

  my $class = $self->load;

  return $self->call('new', $class, @args);
}

sub call {
  my ($self, $func, @args) = @_;

  my $class = $self->load;

  unless ($func) {
    require Venus::Error;

    my $text = qq[Attempt to call undefined class method in package "$class"];

    Venus::Error->throw($text);
  }

  my $next = $class->can($func);

  unless ($next) {
    if ($class->can('AUTOLOAD')) {
      $next = sub { no strict 'refs'; &{"${class}::${func}"}(@args) };
    }
  }

  unless ($next) {
    require Venus::Error;

    my $text = qq[Unable to locate class method "$func" via package "$class"];

    Venus::Error->throw($text);
  }

  @_ = @args; goto $next;
}

sub chain {
  my ($self, @steps) = @_;

  my $result = $self;

  for my $step (@steps) {
    my ($name, @args) = (ref($step) eq 'ARRAY') ? @$step : ($step);

    $result = $result->$name(@args);
  }

  return $result;
}

sub child {
  my ($self, @args) = @_;

  return $self->append(@args);
}

sub children {
  my ($self) = @_;

  my %list;
  my $path;
  my $type;

  $path = quotemeta $self->path;
  $type = 'pm';

  my $regexp = qr/$path\/[^\/]+\.$type/;

  for my $item (keys %INC) {
    $list{$item}++ if $item =~ /$regexp$/;
  }

  my %seen;

  for my $dir (@INC) {
    next if $seen{$dir}++;

    my $re = quotemeta $dir;
    map { s/^$re\///; $list{$_}++ }
    grep !$list{$_}, glob "$dir/@{[$self->path]}/*.$type";
  }

  my $class = $self->class;

  return [
    map $class->new($_),
    map {s/(.*)\.$type$/$1/r}
    sort keys %list
  ];
}

sub cop {
  my ($self, $func, @args) = @_;

  my $class = $self->load;

  unless ($func) {
    require Venus::Error;

    my $text = qq[Attempt to cop undefined object method from package "$class"];

    Venus::Error->throw($text);
  }

  my $next = $class->can($func);

  unless ($next) {
    require Venus::Error;

    my $text = qq[Unable to locate object method "$func" via package "$class"];

    Venus::Error->throw($text);
  }

  return sub { $next->(@args ? (@args, @_) : @_) };
}

sub data {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  local $.;

  my $handle = \*{"${class}::DATA"};

  return '' if !fileno $handle;

  seek $handle, 0, 0;

  my $data = join '', <$handle>;

  $data =~ s/^.*\n__DATA__\r?\n/\n/s;
  $data =~ s/\n__END__\r?\n.*$/\n/s;

  return $data;
}

sub destroy {
  my ($self) = @_;

  require Symbol;

  Symbol::delete_package($self->package);

  my $c_re = quotemeta $self->package;
  my $p_re = quotemeta $self->path;

  map {delete $has{$_}} grep /^$c_re/, keys %has;
  map {delete $INC{$_}} grep /^$p_re/, keys %INC;

  return $self;
}

sub eval {
  my ($self, @args) = @_;

  local $@;

  my $result = eval join ' ', map "$_", "package @{[$self->package]};", @args;

  require Venus::Error;

  Venus::Error->throw($@) if $@;

  return $result;
}

sub explain {
  my ($self) = @_;

  return $self->package;
}

sub hash {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return {%{"${class}::${name}"}};
}

sub hashes {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [
    sort grep !!%{"${class}::$_"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];
}

sub id {
  my ($self) = @_;

  return $self->label;
}

sub init {
  my ($self) = @_;

  my $class = $self->package;

  if ($self->routine('import')) {
    return $class;
  }

  $class = $self->locate ? $self->load : $self->package;

  if ($self->routine('import')) {
    return $class;
  }
  else {
    my $import = sub { $class };

    $self->inject('import', $import);
    $self->load;

    return $class;
  }
}

sub inherits {
  my ($self) = @_;

  return $self->array('ISA');
}

sub included {
  my ($self) = @_;

  return $INC{$self->format('path', '%s.pm')};
}

sub inject {
  my ($self, $name, $coderef) = @_;

  my $class = $self->package;

  local $@;
  no strict 'refs';
  no warnings 'redefine';

  if (state $subutil = eval "require Sub::Util") {
    return *{"${class}::${name}"} = Sub::Util::set_subname(
      "${class}::${name}", $coderef || sub{$class}
    );
  }
  else {
    return *{"${class}::${name}"} = $coderef || sub{$class};
  }
}

sub load {
  my ($self) = @_;

  my $class = $self->package;

  return $class if $has{$class};

  if ($class eq "main") {
    return do { $has{$class} = 1; $class };
  }

  my $failed = !$class || $class !~ /^\w(?:[\w:']*\w)?$/;
  my $loaded;

  my $error = do {
    local $@;
    no strict 'refs';
    $loaded = !!$class->can('new');
    $loaded = !!$class->can('import') if !$loaded;
    $loaded = !!$class->can('meta') if !$loaded;
    $loaded = !!$class->can('with') if !$loaded;
    $loaded = eval "require $class; 1" if !$loaded;
    $@;
  }
  if !$failed;

  do {
    require Venus::Error;

    my $message = $error || 'cause unknown';

    Venus::Error->throw("Error attempting to load $class: $message");
  }
  if $error
  or $failed
  or not $loaded;

  $has{$class} = 1;

  return $class;
}

sub loaded {
  my ($self) = @_;

  my $class = $self->package;
  my $pexpr = $self->format('path', '%s.pm');

  my $is_loaded_eval = $has{$class};
  my $is_loaded_used = $INC{$pexpr};

  return ($is_loaded_eval || $is_loaded_used) ? 1 : 0;
}

sub locate {
  my ($self) = @_;

  my $found = '';

  my $file = $self->format('path', '%s.pm');

  for my $path (@INC) {
    do { $found = "$path/$file"; last } if -f "$path/$file";
  }

  return $found;
}

sub name {
  my ($self) = @_;

  return $self->package;
}

sub parent {
  my ($self) = @_;

  my @parts = @{$self->parse};

  pop @parts if @parts > 1;

  my $class = $self->class;

  return $class->new(join '/', @parts);
}

sub parse {
  my ($self) = @_;

  return [
    map ucfirst,
    map join('', map(ucfirst, split /[-_]/)),
    split /[^-_a-zA-Z0-9.]+/,
    $self->path
  ];
}

sub parts {
  my ($self) = @_;

  return $self->parse;
}

sub prepend {
  my ($self, @args) = @_;

  my $class = $self->class;

  my $path = join '/',
    (map $class->new($_)->path, @args), $self->path;

  return $class->new($path);
}

sub rebase {
  my ($self, @args) = @_;

  my $class = $self->class;

  my $path = join '/', map $class->new($_)->path, @args;

  return $class->new($self->basename)->prepend($path);
}

sub reload {
  my ($self) = @_;

  my $class = $self->package;

  delete $has{$class};

  my $path = $self->format('path', '%s.pm');

  delete $INC{$path};

  no strict 'refs';

  @{"${class}::ISA"} = ();

  return $self->load;
}

sub require {
  my ($self, $target) = @_;

  $target = "'$target'" if -f $target;

  return $self->eval("require $target");
}

sub root {
  my ($self) = @_;

  return $self->parse->[0];
}

sub routine {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return *{"${class}::${name}"}{"CODE"};
}

sub routines {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [
    sort grep *{"${class}::$_"}{"CODE"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];
}

sub scalar {
  my ($self, $name) = @_;

  no strict 'refs';

  my $class = $self->package;

  return ${"${class}::${name}"};
}

sub scalars {
  my ($self) = @_;

  no strict 'refs';

  my $class = $self->package;

  return [
    sort grep defined ${"${class}::$_"},
    grep /^[_a-zA-Z]\w*$/, keys %{"${class}::"}
  ];
}

sub sibling {
  my ($self, @args) = @_;

  return $self->parent->append(@args);
}

sub siblings {
  my ($self) = @_;

  my %list;
  my $path;
  my $type;

  $path = quotemeta $self->parent->path;
  $type = 'pm';

  my $regexp = qr/$path\/[^\/]+\.$type/;

  for my $item (keys %INC) {
    $list{$item}++ if $item =~ /$regexp$/;
  }

  my %seen;

  for my $dir (@INC) {
    next if $seen{$dir}++;

    my $re = quotemeta $dir;
    map { s/^$re\///; $list{$_}++ }
    grep !$list{$_}, glob "$dir/@{[$self->path]}/*.$type";
  }

  my $class = $self->class;

  return [
    map $class->new($_),
    map {s/(.*)\.$type$/$1/r}
    sort keys %list
  ];
}

sub tryload {
  my ($self) = @_;

  return do { local $@; eval { $self->load }; int!$@ };
}

sub use {
  my ($self, $target, @params) = @_;

  my $version;

  my $class = $self->package;

  ($target, $version) = @$target if ref $target eq 'ARRAY';

  $self->require($target);

  require Scalar::Util;

  my @statement = (
    'no strict "subs";',
    (
      Scalar::Util::looks_like_number($version)
        ? "${target}->VERSION($version);" : ()
    ),
    'sub{ my ($target, @params) = @_; $target->import(@params)}'
  );

  $self->eval(join("\n", @statement))->($target, $class, @params);

  return $self;
}

sub used {
  my ($self) = @_;

  my $class = $self->package;
  my $path = $self->path;
  my $regexp = quotemeta $path;

  return $path if $has{$class};

  for my $item (keys %INC) {
    return $path if $item =~ /$regexp\.pm$/;
  }

  return '';
}

sub variables {
  my ($self) = @_;

  return [map [$_, [sort @{$self->$_}]], qw(arrays hashes scalars)];
}

sub version {
  my ($self) = @_;

  return $self->scalar('VERSION');
}

1;
