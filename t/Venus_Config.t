package main;

use 5.018;

use strict;
use warnings;

use Test::More;
use Venus::Test;

my $test = test(__FILE__);

=name

Venus::Config

=cut

$test->for('name');

=tagline

Config Class

=cut

$test->for('tagline');

=abstract

Config Class for Perl 5

=cut

$test->for('abstract');

=includes

method: from_file
method: from_json
method: from_json_file
method: from_perl
method: from_perl_file
method: from_yaml
method: from_yaml_file
method: metadata
method: reify
method: resolve
method: services

=cut

$test->for('includes');

=synopsis

  package main;

  use Venus::Config;

  my $config = Venus::Config->new;

  # $config = $config->from_file('app.pl');

  # my $name = $config->resolve('name');

  # "..."

=cut

$test->for('synopsis', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');

  $result
});

=description

This package provides methods for loading Perl, YAML, and JSON configuration
files, fetching configuration information, and building objects with dependency
injection.

=cut

$test->for('description');

=inherits

Venus::Kind::Utility

=cut

$test->for('inherits');

=integrates

Venus::Role::Buildable
Venus::Role::Valuable

=cut

$test->for('integrates');

=method from_file

The from_file method load a Perl, YAML, or JSON configuration file, based on
the file extension, and returns a new L<Venus::Config> object.

=signature from_file

  from_file(Str $path) (Config)

=metadata from_file

{
  since => '1.95',
}

=example-1 from_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->from_file('t/conf/test.perl');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 1, 'from_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  ok $result->value;
  ok exists $result->value->{'$metadata'};
  ok exists $result->value->{'$services'};

  $result
});

=example-2 from_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->from_file('t/conf/test.json');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 2, 'from_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found';
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    ok exists $result->value->{'$metadata'};
    ok exists $result->value->{'$services'};
  }

  $result
});

=example-3 from_file

  package main;

  use Venus::Config;

  my $config = Venus::Config->from_file('t/conf/test.yaml');

  # bless(..., 'Venus::Config')

=cut

$test->for('example', 3, 'from_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found';
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    ok $result->value;
    ok exists $result->value->{'$metadata'};
    ok exists $result->value->{'$services'};
  }

  $result
});

=method from_json

The from_json method returns a new L<Venus::Config> object based on the JSON
string provided.

=signature from_json

  from_json(Str $data) (Config)

=metadata from_json

{
  since => '1.95',
}

=example-1 from_json

  # given: synopsis

  package main;

  $config = $config->from_json(q(
  {
    "$metadata": {
      "tmplog": "/tmp/log"
    },
    "$services": {
      "log": { "package": "Venus/Path", "argument": { "$metadata": "tmplog" } }
    }
  }
  ));

  # bless(..., 'Venus::Config')

  # my $log = $config->resolve('log');

=cut

$test->for('example', 1, 'from_json', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found';
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $return = $result->resolve('log');
    ok $return->isa('Venus::Path');
    ok $return->value eq '/tmp/log';
  }

  $result
});

=method from_json_file

The from_json_file method uses L<Venus::Path> to return a new L<Venus::Config>
object based on the file provided.

=signature from_json_file

  from_json_file(Str $file) (Config)

=metadata from_json_file

{
  since => '1.95',
}

=example-1 from_json_file

  # given: synopsis

  package main;

  $config = $config->from_json_file('t/conf/test.json');

  # bless(..., 'Venus::Config')

  # my $log = $config->resolve('log');

=cut

$test->for('example', 1, 'from_json_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Json && not Venus::Json->package) {
    diag 'No suitable JSON library found';
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $return = $result->resolve('log');
    ok $return->isa('Venus::Path');
    ok $return->value eq '/tmp/log';
  }

  $result
});

=method from_perl

The from_perl method returns a new L<Venus::Config> object based on the Perl
string provided.

=signature from_perl

  from_perl(Str $data) (Config)

=metadata from_perl

{
  since => '1.95',
}

=example-1 from_perl

  # given: synopsis

  package main;

  $config = $config->from_perl(q(
  {
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  }
  ));

  # bless(..., 'Venus::Config')

  # my $log = $config->resolve('log');

=cut

$test->for('example', 1, 'from_perl', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('log');
  ok $return->isa('Venus::Path');
  ok $return->value eq '/tmp/log';

  $result
});

=method from_perl_file

The from_perl_file method uses L<Venus::Path> to return a new L<Venus::Config>
object based on the file provided.

=signature from_perl_file

  from_perl_file(Str $file) (Config)

=metadata from_perl_file

{
  since => '1.95',
}

=example-1 from_perl_file

  # given: synopsis

  package main;

  $config = $config->from_perl_file('t/conf/test.perl');

  # bless(..., 'Venus::Config')

  # my $log = $config->resolve('log');

=cut

$test->for('example', 1, 'from_perl_file', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('log');
  ok $return->isa('Venus::Path');
  ok $return->value eq '/tmp/log';

  $result
});

=method from_yaml

The from_yaml method returns a new L<Venus::Config> object based on the YAML
string provided.

=signature from_yaml

  from_yaml(Str $data) (Config)

=metadata from_yaml

{
  since => '1.95',
}

=example-1 from_yaml

  # given: synopsis

  package main;

  $config = $config->from_yaml(q(
  '$metadata':
    tmplog: /tmp/log
  '$services':
    log:
      package: "Venus/Path"
      argument:
        '$metadata': tmplog
  ));

  # bless(..., 'Venus::Config')

  # my $log = $config->resolve('log');

=cut

$test->for('example', 1, 'from_yaml', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found';
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $return = $result->resolve('log');
    ok $return->isa('Venus::Path');
    ok $return->value eq '/tmp/log';
  }

  $result
});

=method from_yaml_file

The from_yaml_file method uses L<Venus::Path> to return a new L<Venus::Config>
object based on the YAML string provided.

=signature from_yaml_file

  from_yaml_file(Str $file) (Config)

=metadata from_yaml_file

{
  since => '1.95',
}

=example-1 from_yaml_file

  # given: synopsis

  package main;

  $config = $config->from_yaml_file('t/conf/test.yaml');

  # bless(..., 'Venus::Config')

  # my $log = $config->resolve('log');

=cut

$test->for('example', 1, 'from_yaml_file', sub {
  my ($tryable) = @_;
  my $result;
  if (require Venus::Yaml && not Venus::Yaml->package) {
    diag 'No suitable YAML library found';
    $result = Venus::Config->new;
    ok 1;
  }
  else {
    ok $result = $tryable->result;
    ok $result->isa('Venus::Config');
    my $return = $result->resolve('log');
    ok $return->isa('Venus::Path');
    ok $return->value eq '/tmp/log';
  }

  $result
});

=method metadata

The metadata method returns the C<$metadata> section of the configuration data
if no name is provided, otherwise returning the specific metadata keyed on the
name provided.

=signature metadata

  metadata(Str $name) (Any)

=metadata metadata

{
  since => '1.95',
}

=example-1 metadata

  # given: synopsis

  package main;

  my $metadata = $config->metadata;

  # {}

=cut

$test->for('example', 1, 'metadata', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=example-2 metadata

  # given: synopsis

  package main;

  $config = $config->from_perl(q(
  {
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  }
  ));

  my $metadata = $config->metadata;

  # {
  #   tmplog => "/tmp/log"
  # }

=cut

$test->for('example', 2, 'metadata', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {
    tmplog => "/tmp/log"
  };

  $result
});

=example-3 metadata

  # given: synopsis

  package main;

  $config = $config->from_perl(q(
  {
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  }
  ));

  my $metadata = $config->metadata("tmplog");

  # "/tmp/log"

=cut

$test->for('example', 3, 'metadata', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is $result, "/tmp/log";

  $result
});

=method reify

The reify method resolves and returns an object or value based on the service
name provided.

=signature reify

  reify(Str $name) (Any)

=metadata reify

{
  since => '1.95',
}

=example-1 reify

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => {
          '$metadata' => "tmplog"
        }
      }
    }
  });

  my $reify = $config->reify('tmp');

  # undef

=cut

$test->for('example', 1, 'reify', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 reify

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => {
          '$metadata' => "tmplog"
        }
      }
    }
  });

  my $reify = $config->reify('log');

  # bless({value => '/tmp/log'}, 'Venus::Path')

=cut

$test->for('example', 2, 'reify', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->value eq '/tmp/log';

  $result
});

=example-3 reify

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => {
          '$metadata' => "tmplog"
        }
      }
    }
  });

  my $reify = $config->reify('log', '.');

  # bless({value => '.'}, 'Venus::Path')

=cut

$test->for('example', 3, 'reify', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->value eq '.';

  $result
});

=example-4 reify

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => {
          '$metadata' => "tmplog"
        }
      }
    }
  });

  my $reify = $config->reify('log', {value => '.'});

  # bless({value => '.'}, 'Venus::Path')

=cut

$test->for('example', 4, 'reify', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->value eq '.';

  $result
});

=method resolve

The resolve method resolves and returns an object or value based on the
configuration key or service name provided.

=signature resolve

  resolve(Str $name) (Any)

=metadata resolve

{
  since => '1.95',
}

=example-1 resolve

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    name => 'app',
    log => '/tmp/log/app.log',
    '$metadata' => {
      tmplog => "/tmp/log",
      varlog => "/var/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => '.'
      },
      tmp_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "tmplog"
        }
      },
      var_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "varlog"
        }
      }
    }
  });

  my $result = $config->resolve;

  # undef

=cut

$test->for('example', 1, 'resolve', sub {
  my ($tryable) = @_;
  ok !(my $result = $tryable->result);

  !$result
});

=example-2 resolve

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    name => 'app',
    log => '/tmp/log/app.log',
    '$metadata' => {
      tmplog => "/tmp/log",
      varlog => "/var/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => '.'
      },
      tmp_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "tmplog"
        }
      },
      var_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "varlog"
        }
      }
    }
  });

  my $result = $config->resolve('log');

  # "/tmp/log/app.log"

=cut

$test->for('example', 2, 'resolve', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result eq "/tmp/log/app.log";

  $result
});

=example-3 resolve

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    name => 'app',
    log => '/tmp/log/app.log',
    '$metadata' => {
      tmplog => "/tmp/log",
      varlog => "/var/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => '.'
      },
      tmp_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "tmplog"
        }
      },
      var_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "varlog"
        }
      }
    }
  });

  my $result = $config->resolve('tmp_log');

  # bless({value => '/tmp/log'}, 'Venus::Path')

=cut

$test->for('example', 3, 'resolve', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->value eq '/tmp/log';

  $result
});

=example-4 resolve

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    name => 'app',
    log => '/tmp/log/app.log',
    '$metadata' => {
      tmplog => "/tmp/log",
      varlog => "/var/log"
    },
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => '.'
      },
      tmp_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "tmplog"
        }
      },
      var_log => {
        package => "Venus/Path",
        extends => 'log',
        argument => {
          '$metadata' => "varlog"
        }
      }
    }
  });

  my $result = $config->resolve('var_log');

  # bless({value => '/var/log'}, 'Venus::Path')

=cut

$test->for('example', 4, 'resolve', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Path');
  ok $result->value eq '/var/log';

  $result
});

=method services

The services method returns the C<$services> section of the configuration data
if no name is provided, otherwise returning the specific service keyed on the
name provided.

=signature services

  services(Str $name) (Any)

=metadata services

{
  since => '1.95',
}

=example-1 services

  # given: synopsis

  package main;

  my $services = $config->services;

  # {}

=cut

$test->for('example', 1, 'services', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {};

  $result
});

=example-2 services

  # given: synopsis

  package main;

  $config = $config->from_perl(q(
  {
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  }
  ));

  my $services = $config->services;

  # {
  #   log => {
  #     package => "Venus/Path",
  #     argument => {'$metadata' => "tmplog"}
  #   }
  # }

=cut

$test->for('example', 2, 'services', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {
    log => {
      package => "Venus/Path",
      argument => {'$metadata' => "tmplog"}
    }
  };

  $result
});

=example-3 services

  # given: synopsis

  package main;

  $config = $config->from_perl(q(
  {
    '$metadata' => {
      tmplog => "/tmp/log"
    },
    '$services' => {
      log => { package => "Venus/Path", argument => { '$metadata' => "tmplog" } }
    }
  }
  ));

  my $services = $config->services('log');

  # {
  #   package => "Venus/Path",
  #   argument => {'$metadata' => "tmplog"}
  # }

=cut

$test->for('example', 3, 'services', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  is_deeply $result, {
    package => "Venus/Path",
    argument => {'$metadata' => "tmplog"}
  };

  $result
});

=feature $callback

This package supports resolving services as callbacks to be passed around
and/or resolved by other services. The C<$callback> directive is used to
specify the name of a service to be resolved and passed as an argument.

=metadata $callback

{
  since => '1.95',
}

=example-1 $callback

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      log => {
        package => "Venus/Path",
        argument => '.',
      },
      lazy_log => {
        package => "Venus/Code",
        argument => {
          '$callback' => 'log',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('lazy_log');

  # bless(..., 'Venus::Code')

  # my $return = $result->call;

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$callback', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  $result = $result->resolve('lazy_log');
  ok $result->isa('Venus::Code');
  my $return = $result->call;
  ok $return->isa('Venus::Path');
  ok $return->value eq '.';

  $result
});

=feature $envvar

This package supports inlining environment variables as arguments to services.
The C<$envvar> directive is used to specify the name of an environment variable,
and can also be used in metadata for reusability.

=metadata $envvar

{
  since => '1.95',
}

=example-1 $envvar

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      home => {
        package => "Venus/Path",
        argument => {
          '$envvar' => 'home',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('home');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$envvar', sub {
  my ($tryable) = @_;
  local $ENV{HOME} = '/home';
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('home');
  ok $return->isa('Venus::Path');
  ok $return->value eq '/home';

  $result
});

=example-2 $envvar

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      home => {
        '$envvar' => 'home',
      }
    },
    '$services' => {
      home => {
        package => "Venus/Path",
        argument => {
          '$metadata' => 'home',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('home');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 2, '$envvar', sub {
  my ($tryable) = @_;
  local $ENV{HOME} = '/home';
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('home');
  ok $return->isa('Venus::Path');
  ok $return->value eq '/home';

  $result
});

=feature $function

This package supports inlining the result of a service resolution and function
call as arguments to services. The C<#> delimited C<$function> directive is
used to specify the name of an existing service on the right-hand side, and an
arbitrary function to be call on the result on the left-hand side.

=metadata $function

{
  since => '1.95',
}

=example-1 $function

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      filespec => {
        package => 'File/Spec/Functions',
      },
      tempdir => {
        package => "Venus/Path",
        argument => {
          '$function' => 'filespec#tmpdir',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('tempdir');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$function', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('tempdir');
  ok $return->isa('Venus::Path');

  $result
});

=feature $metadata

This package supports inlining configuration data as arguments to services. The
C<$metadata> directive is used to specify the name of a stashed configuration
value or data structure.

=metadata $metadata

{
  since => '1.95',
}

=example-1 $metadata

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      home => '/home/ubuntu',
    },
    '$services' => {
      home => {
        package => "Venus/Path",
        argument => {
          '$metadata' => 'home',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('home');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$metadata', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('home');
  ok $return->isa('Venus::Path');

  $result
});

=feature $method

This package supports inlining the result of a service resolution and method
call as arguments to services. The C<#> delimited C<$method> directive is used
to specify the name of an existing service on the right-hand side, and an
arbitrary method to be call on the result on the left-hand side.

=metadata $method

{
  since => '1.95',
}

=example-1 $method

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      filespec => {
        package => 'File/Spec',
      },
      tempdir => {
        package => "Venus/Path",
        argument => {
          '$method' => 'filespec#tmpdir',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('tempdir');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$method', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('tempdir');
  ok $return->isa('Venus::Path');

  $result
});

=feature $routine

This package supports inlining the result of a service resolution and routine
call as arguments to services. The C<#> delimited C<$routine> directive is used
to specify the name of an existing service on the right-hand side, and an
arbitrary routine to be call on the result on the left-hand side.

=metadata $routine

{
  since => '1.95',
}

=example-1 $routine

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      filespec => {
        package => 'File/Spec',
      },
      tempdir => {
        package => "Venus/Path",
        argument => {
          '$routine' => 'filespec#tmpdir',
        }
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('tempdir');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$routine', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('tempdir');
  ok $return->isa('Venus::Path');

  $result
});

=feature $service

This package supports inlining resolved services as arguments to other
services. The C<$service> directive is used to specify the name of a service to
be resolved and passed as an argument.

=metadata $service

{
  since => '1.95',
}

=example-1 $service

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      'path' => {
        'package' => 'Venus/Path',
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('path');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '$service', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('path');
  ok $return->isa('Venus::Path');

  $result
});

=feature #argument

This package supports providing static and/or dynamic arguments during object
construction from metadata or other services.

=metadata #argument

{
  since => '1.95',
}

=example-1 #argument

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      'date' => {
        'package' => 'Venus/Date',
        'argument' => 570672000,
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('date');

  # bless(..., 'Venus::Date')

=cut

$test->for('example', 1, '#argument', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('date');
  ok $return->isa('Venus::Date');
  ok $return->month eq 2;
  ok $return->day eq 1;
  ok $return->year eq 1988;

  $result
});

=example-2 #argument

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      'date' => {
        'package' => 'Venus/Date',
        'argument' => {
          year => 1988,
          month => 2,
          day => 1,
        },
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('date');

  # bless(..., 'Venus::Date')

=cut

$test->for('example', 2, '#argument', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('date');
  ok $return->isa('Venus::Date');
  ok $return->month eq 2;
  ok $return->day eq 1;
  ok $return->year eq 1988;

  $result
});

=feature #argument_as

This package supports transforming the way static and/or dynamic arguments are
passed to the operation during object construction. Acceptable options are
C<array> or C<arrayref> (which provides an arrayref), C<hash> or C<hashref>
(which provides a hashref), or C<list> (which provides a flattened list of
arguments).

=metadata #argument_as

{
  since => '1.95',
}

=example-1 #argument_as

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      'date' => {
        'package' => 'Venus/Date',
        'argument' => {
          year => 1988,
          month => 2,
          day => 1,
        },
        argument_as => 'list',
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('date');

  # bless(..., 'Venus::Date')

=cut

$test->for('example', 1, '#argument_as', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('date');
  ok $return->isa('Venus::Date');
  ok $return->month eq 2;
  ok $return->day eq 1;
  ok $return->year eq 1988;

  $result
});

=example-2 #argument_as

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      'date' => {
        'package' => 'Venus/Date',
        'argument' => {
          year => 1988,
          month => 2,
          day => 1,
        },
        argument_as => 'hash',
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('date');

  # bless(..., 'Venus::Date')

=cut

$test->for('example', 2, '#argument_as', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('date');
  ok $return->isa('Venus::Date');
  ok $return->month eq 2;
  ok $return->day eq 1;
  ok $return->year eq 1988;

  $result
});

=feature #builder

This package supports specifying multiple build steps as C<function>,
C<method>, and C<routine> calls and chaining them together. Each build step
supports any directive that can be used outside of a build step. Each build
step can be configured, with the C<return> directive, to use a particular value
to chain the next subroutine call. Acceptable C<return> values are C<class>
(package name string), C<result> (scalar return value from the current build
step), and C<self> (instantiated package). Additionally, you can use the
C<inject> directive (with any value accepted by C<argument_as>) to override the
default arguments using the arguments provided to the L</reify> or L</resolve>
method.

=metadata #builder

{
  since => '1.95',
}

=example-1 #builder

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      datetime => {
        package => "Venus/Date",
        builder => [
          {
            method => 'new',
            argument => 570672000,
            return => 'self',
          },
          {
            method => 'string',
            return => 'result',
          }
        ],
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('datetime');

  # "1988-02-01T00:00:00Z"

=cut

$test->for('example', 1, '#builder', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('datetime');
  ok $return eq "1988-02-01T00:00:00Z";

  $result
});

=example-2 #builder

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      datetime => {
        package => "Venus/Date",
        builder => [
          {
            method => 'new',
            argument => 570672000,
            return => 'self',
            inject => 'list',
          },
          {
            method => 'string',
            return => 'result',
          }
        ],
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('datetime', 604945074);

  # "1989-03-03T16:17:54Z"

=cut

$test->for('example', 2, '#builder', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('datetime', 604945074);
  ok $return eq "1989-03-03T16:17:54Z";

  $result
});

=feature #config

This package supports configuring services and metadata in the service of
building objects and values.

=metadata #config

{
  since => '1.95',
}

=example-1 #config

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    'name' => 'app',
    'secret' => '...',
    '$metadata' => {
      home => {
        '$envvar' => 'home',
      }
    },
    '$services' => {
      date => {
        package => "Venus/Date",
      },
      path => {
        package => "Venus/Path",
        argument => {
          '$metadata' => 'home',
        },
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $path = $config->resolve('path');

  # bless(..., 'Venus::Path')

  # my $name = $config->resolve('name');

  # "app"

=cut

$test->for('example', 1, '#config', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('path');
  ok $return->isa('Venus::Path');
  ok $return->value ne '.';
  $return = $result->resolve('name');
  ok $return eq 'app';

  $result
});

=feature #constructor

This package supports specifying constructors other than the traditional C<new>
routine. A constructor is always called with the package name as the invocant.

=metadata #constructor

{
  since => '1.95',
}

=example-1 #constructor

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      path => {
        package => "Venus/Path",
        constructor => "new",
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('path');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '#constructor', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('path');
  ok $return->isa('Venus::Path');

  $result
});

=feature #extends

This package supports extending services in the definition of other services,
recursively compiling service configurations and eventually executing the
requested compiled service.

=metadata #extends

{
  since => '1.95',
}

=example-1 #extends

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      log => {
        package => "Venus/Log",
        argument => {
          level => "trace",
        },
      },
      development_log => {
        package => "Venus/Log",
        extends => "log",
        builder => [
          {
            method => "new",
            return => "self",
            inject => "hash",
          }
        ],
      },
      production_log => {
        package => "Venus/Log",
        extends => "log",
        argument => {
          level => "error",
        },
        builder => [
          {
            method => "new",
            return => "self",
            inject => "hash",
          }
        ],
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('development_log');

  # bless(..., 'Venus::Log')

  # my $level = $result->level;

  # "trace"

  # $result = $config->resolve('production_log');

  # bless(..., 'Venus::Log')

  # $level = $result->level;

  # "error"

=cut

$test->for('example', 1, '#extends', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('development_log');
  ok $return->isa('Venus::Log');
  ok $return->level eq 'trace';
  $return = $result->resolve('production_log');
  ok $return->isa('Venus::Log');
  ok $return->level eq 'error';

  $result
});

=feature #function

This package supports specifying construction as a function call, which when
called does not provide an invocant.

=metadata #function

{
  since => '1.95',
}

=example-1 #function

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      foo_hex => {
        package => "Digest/MD5",
        function => "md5_hex",
        argument => "foo",
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('foo_hex');

  # "acbd18db4cc2f85cedef654fccc4a4d8"

=cut

$test->for('example', 1, '#function', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('foo_hex');
  ok $return eq "acbd18db4cc2f85cedef654fccc4a4d8";

  $result
});

=feature #lifecycle

This package supports different lifecycle options which determine when services
are built and whether they're persisted. Acceptable lifecycle values are
C<singleton> (which caches the result once encountered) and C<eager> (which
caches the service upon the first execution of any service).

=metadata #lifecycle

{
  since => '1.95',
}

=example-1 #lifecycle

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      match => {
        package => "Venus/Match",
        argument => {
          'a'..'h'
        },
        builder => [
          {
            method => "new",
            return => "result",
          },
          {
            method => "data",
            return => "result",
            inject => "hash",
          }
        ],
        lifecycle => 'eager',
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('thing');

  # undef

  # my $result = $config->resolve('match');

  # bless(..., 'Venus::Match')

=cut

$test->for('example', 1, '#lifecycle', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return_0 = $result->resolve('thing');
  ok !defined $return_0;
  ok exists $result->{'$cache'};
  ok $result->{'$cache'}->{'match'};
  my $cached = $result->{'$cache'}->{'match'};
  my $return_1 = $result->resolve('match');
  ok $return_1->isa('Venus::Match');
  ok $return_1->result('a') eq 'b';
  my $return_2 = $result->resolve('match');
  ok $return_2->isa('Venus::Match');
  ok $return_2->result('a') eq 'b';
  require Scalar::Util;
  ok Scalar::Util::refaddr($cached) eq Scalar::Util::refaddr($return_1) eq
  Scalar::Util::refaddr($return_2);

  $result
});

=example-2 #lifecycle

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      match => {
        package => "Venus/Match",
        argument => {
          'a'..'h'
        },
        builder => [
          {
            method => "new",
            return => "result",
          },
          {
            method => "data",
            return => "result",
            inject => "hash",
          }
        ],
        lifecycle => 'singleton',
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('match');

  # bless(..., 'Venus::Match')

=cut

$test->for('example', 2, '#lifecycle', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return_1 = $result->resolve('match');
  ok $return_1->isa('Venus::Match');
  ok $return_1->result('a') eq 'b';
  my $return_2 = $result->resolve('match');
  ok $return_2->isa('Venus::Match');
  ok $return_2->result('a') eq 'b';
  require Scalar::Util;
  ok Scalar::Util::refaddr($return_1) eq Scalar::Util::refaddr($return_2);

  $result
});

=feature #metadata

This package supports specifying data and structures which can be used in the
construction of multiple services.

=metadata #metadata

{
  since => '1.95',
}

=example-1 #metadata

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$metadata' => {
      'homedir' => '/home',
      'tempdir' => '/tmp',
    },
    '$services' => {
      home => {
        package => "Venus/Path",
        argument => {
          '$metadata' => 'homedir',
        },
      },
      temp => {
        package => "Venus/Path",
        argument => {
          '$metadata' => 'tempdir',
        },
      },
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('home');

  # bless(..., 'Venus::Path')

  # my $result = $config->resolve('temp');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '#metadata', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('home');
  ok $return->isa('Venus::Path');
  ok $return->value eq '/home';
  $return = $result->resolve('temp');
  ok $return->isa('Venus::Path');
  ok $return->value eq '/tmp';

  $result
});

=feature #method

This package supports specifying construction as a method call, which when
called provides the package or object instance as the invocant.

=metadata #method

{
  since => '1.95',
}

=example-1 #method

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      date => {
        package => "Venus/Date",
        argument => 570672000,
        method => "new",
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('date');

  # bless(..., 'Venus::Date')

=cut

$test->for('example', 1, '#method', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('date');
  ok $return->isa('Venus::Date');
  ok $return->string eq '1988-02-01T00:00:00Z';

  $result
});

=feature #routine

This package supports specifying construction as a function call, which when
called provides the package as the invocant.

=metadata #routine

{
  since => '1.95',
}

=example-1 #routine

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      date => {
        package => "Venus/Date",
        argument => 570672000,
        routine => "new",
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('date');

  # bless(..., 'Venus::Date')

=cut

$test->for('example', 1, '#routine', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('date');
  ok $return->isa('Venus::Date');
  ok $return->string eq '1988-02-01T00:00:00Z';

  $result
});

=feature #service

This package supports defining services to be constructed on-demand or
automatically on instantiation.

=metadata #service

{
  since => '1.95',
}

=example-1 #service

  package main;

  use Venus::Config;

  my $config = Venus::Config->new({
    '$services' => {
      path => {
        package => "Venus/Path",
      }
    }
  });

  # bless(..., 'Venus::Config')

  # my $result = $config->resolve('path');

  # bless(..., 'Venus::Path')

=cut

$test->for('example', 1, '#service', sub {
  my ($tryable) = @_;
  ok my $result = $tryable->result;
  ok $result->isa('Venus::Config');
  my $return = $result->resolve('path');
  $return->isa('Venus::Path');

  $result
});

=partials

t/Venus.t: pdml: authors
t/Venus.t: pdml: license

=cut

$test->for('partials');

# END

$test->render('lib/Venus/Config.pod') if $ENV{RENDER};

ok 1 and done_testing;
