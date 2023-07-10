{
  data => {
    ECHO => 1
  },
  exec => {
    brew => "perlbrew",
    cpan => "cpanm -llocal -qn",
    deps => "cpan --installdeps .",
    each => "\$PERL -MVenus=true,false,log -nE",
    eval => "\$PERL -MVenus=true,false,log -E",
    exec => "\$PERL",
    info => "\$PERL -V",
    okay => "\$PERL -c",
    repl => "\$PERL -dE0",
    says => "eval \"map log(\$_), map eval, \@ARGV\"",
    test => "\$PROVE"
  },
  find => {},
  libs => [
    "-Ilib",
    "-Ilocal/lib/perl5"
  ],
  load => [],
  path => [
    "./bin",
    "./dev",
    "./local/bin"
  ],
  perl => {
    perl => "perl",
    "perl-5.18.0" => "perlbrew exec --with perl-5.18.0 perl",
    prove => "prove",
    "prove-5.18.0" => "perlbrew exec --with perl-5.18.0 prove"
  },
  task => {},
  vars => {
    PERL => "perl",
    PROVE => "prove"
  },
  with => {
    psql => "t/conf/psql.perl",
  },
}
