{
  data => {
    ECHO => 1
  },
  exec => {
    brew => "perlbrew",
    cpan => "cpanm -llocal -qn",
    docs => "perldoc",
    each => "shim -nE",
    edit => "\$EDITOR \$VENUS_FILE",
    eval => "shim -E",
    exec => "\$PERL",
    info => "\$PERL -V",
    lint => "perlcritic",
    okay => "\$PERL -c",
    repl => "\$PERL -dE0",
    reup => "cpanm -qn Venus",
    says => "eval \"map log(eval), \@ARGV\"",
    shim => "\$PERL -MVenus=true,false,log",
    test => "\$PROVE",
    tidy => "perltidy"
  },
  flow => {
    deps => [
      "cpan Perl::Critic",
      "cpan Perl::Tidy",
      "cpan Pod::Perldoc"
    ],
    prep => [
      "deps",
      "reqs"
    ],
    reqs => [
      "which perlcritic",
      "which perldoc",
      "which perltidy"
    ]
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
    prove => "prove"
  },
  vars => {
    PERL => "perl",
    PROVE => "prove"
  }
}
