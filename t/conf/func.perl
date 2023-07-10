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
  func => {
    "dump" => "./t/path/etc/dump.pl",
  },
  libs => [
    "-Ilib",
    "-Ilocal/lib/perl5"
  ],
  path => [
    "./bin",
    "./dev",
    "./local/bin"
  ],
  perl => {
    perl => "perl",
    prove => "prove",
  },
  vars => {
    PERL => "perl",
    PROVE => "prove"
  },
}
