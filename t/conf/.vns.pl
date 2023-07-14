{
  data => {
    ECHO => 1,
  },
  exec => {
    brew => 'perlbrew',
    cpan => 'cpanm -llocal -qn',
    deps => 'cpan --installdeps .',
    each => '$PERL -MVenus=true,false,log -nE',
    eval => '$PERL -MVenus=true,false,log -E',
    exec => '$PERL',
    info => '$PERL -V',
    lint => 'perlcritic',
    okay => '$PERL -c',
    repl => '$PERL -dE0',
    reup => 'cpan Venus',
    says => 'eval "map log(eval), @ARGV"',
    step => 'eval "while(<>){log(eval)}"',
    tidy => 'perltidy',
    test => '$PROVE'
  },
  libs => [
    '-Ilib',
    '-Ilocal/lib/perl5',
  ],
  path => [
    './bin',
    './dev',
    './local/bin',
  ],
  perl => {
    perl => 'perl',
    prove => 'prove',
  },
  vars => {
    PERL => 'perl',
    PROVE => 'prove'
  },
}
