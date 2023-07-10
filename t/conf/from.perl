{
  from => [
    "t/conf/.vns.pl",
  ],
  exec => {
    mypan => "cpan -M https://pkg.myapp.com"
  },
}
