# Release

## Version: 1.30

- [change] Remove Venus::Role::Testable#{istrue,isfalse}
- [feature] Implement Venus::Path#lines
- [feature] Implement Venus::Role::Assertable
- [feature] Implement Venus::Assert, Venus::Type#coded
- [feature] Implement math methods for Venus::Number
- [feature] Port applicable methods in Venus::String to Venus::Number
- [feature] Implement Venus::Type#identify
- [feature] Implement Venus::Array#{head,tail}
- [feature] Implement Venus::Kind#{renew,self}
- [feature] Move {class,meta,space,type} into Venus::Role::Reflectable
- [feature] Implement Venus::Role::Valuable#mutate
- [feature] Implement Venus::Role::Assertable#{check,assert,coerce}
- [feature] Implement Venus::Role::Coercible#coerce_attr
- [feature] Support dispatching from Venus::Box#unbox
- [feature] Implement Venus::Role::Reflectable#reify
- [update] Fix overloaded interpolation issue
- [update] Update Venus::Role::{Accessible,Valuable}
- [update] Rename Venus::Error#origin to frame
- [update] Prevent bad symbols on imports
- [update] Support overloaded "empty" invocants in Venus::Try
- [update] Ensure true/false is returned over 1/0
- [update] Reset srand on fork in Venus::Process
- [update] Skip t/Venus_Random.t if rand is undeterministic
- [update] Implement Venus::Role::Accessible#assign


