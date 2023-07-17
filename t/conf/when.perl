{
  data => {
    ECHO => 1,
  },
  exec => {
    name => "echo \$OSNAME"
  },
  when => {
    is_lin => {
      data => {
        OSNAME => "LINUX",
      },
    },
    is_win => {
      data => {
        OSNAME => "WINDOWS",
      },
    },
  },
}
