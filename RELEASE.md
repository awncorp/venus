# Release

## Version: 1.23

- [change] Replace Venus::Role::Testable#{istrue,isfalse} with {is_true,is_false}
- [change] Resolve cross-platform float precision test failures
- [feature] Allow Venus::Class to IMPORT and EXPORT using FROM
- [feature] Add caller info to Venus::Error stacktrace
- [feature] Allow Venus::Error#{is,as} to fallback to name
- [feature] Implement Venus:Random
- [feature] Implement Venus::Error#of
- [update] Set "srand" on fork in Venus::Process
- [update] Include names (for Venus::Error#{as,is}) in all exceptions
- [update] Update Venus::Box#unbox as alias to __handle__unbox
- [update] Make all Venus imports strict


