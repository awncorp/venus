{
  data => {
    ECHO => 1,
  },
  exec => {
    backup => "pg_backupcluster",
    restore => "pg_restorecluster",
  },
}
