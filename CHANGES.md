# Changelog

## Version: 2.90

- [feature] Implement Venus::Os
- [feature] Implement Venus::Path#{mktemp_dir,mktemp_file}
- [feature] Implement Venus::Path#{copy,move}
- [feature] Implement throw-via-dispatch errors
- [feature] Better document all Venus errors
- [feature] Implement POD for errors in Venus::Test

## Version: 2.80

- [feature] Implement Venus#array
- [feature] Implement Venus#boolean
- [feature] Implement Venus#code
- [feature] Implement Venus#config
- [feature] Implement Venus#data
- [feature] Implement Venus#float
- [feature] Implement Venus#hash
- [feature] Implement Venus#name
- [feature] Implement Venus#number
- [feature] Implement Venus#path
- [feature] Implement Venus#proto
- [feature] Implement Venus#string
- [feature] Implement Venus#template
- [feature] Implement Venus#vars
- [feature] Implement Venus::Assert#render
- [feature] Implement Venus::Array#range
- [feature] Enhance Venus::Throw
- [feature] Implement Venus#meta
- [feature] Implement Venus#opts
- [feature] Implement Venus#process
- [feature] Implement Venus#random
- [feature] Implement Venus#regexp
- [feature] Implement Venus#replace
- [feature] Implement Venus#search
- [feature] Implement Venus#test
- [feature] Implement Venus#throw
- [feature] Implement Venus#try
- [feature] Implement Venus#type
- [feature] Implement Venus::Schema
- [feature] Implement Venus::Path#extension
- [update] Resolve CPANTS issues
- [update] Add missing signature for Venus::Template#render
- [update] Implement Venus::Throw#{frame,capture}
- [update] Update Venus#date syntax
- [update] Fix Venus::Assert parser issue
- [update] Refactor Venus::Cli
- [update] Update Venus::Cli "opt" type logic and documentation

## Version: 2.55

- [feature] Implement Venus#date
- [feature] Implement Venus#match
- [feature] Implement Venus#gather
- [update] Make Venus::Unpack#{checks,validate} list context aware
- [update] Resolve Venus#unpack signature/caller issue
- [update] Update arguments passing in Venus#{json,perl,yaml}
- [update] Update {json,perl,yaml} behaviors and error conditions

## Version: 2.50

- [feature] Implement Venus#work
- [feature] Implement Venus#{check,assert}
- [feature] Implement Venus#unpack
- [feature] Implement Venus#venus
- [feature] Implement Venus::Process#alarm
- [feature] Export {json,yaml,perl} utility functions
- [feature] Implement "watching" in Venus::Process
- [update] Fix Venus::Random#range documentation
- [update] Support multiline type expressions
- [update] Fix Venus::Test subtest descriptions

## Version: 2.40

- [feature] Implement Venus::Role::Mockable
- [feature] Implement Venus::Assert#validator
- [feature] Implement Venus::Assert#checker
- [feature] Implement Venus::Path#{root,seek}
- [feature] Implement exportable utility functions in Venus
- [feature] Implement Venus#chain
- [update] Refactor Venus::Test
- [update] Update Venus::Unpack#signature naming
- [update] Update Venus::Unpack with {build_arg,build_args}
- [update] Update Venus::Try exception trapping
- [update] Update README.md, include testing

## Version: 2.32

- [update] Update attribute assert failure message in Venus::Role::Optional
- [update] Ignore attribute assertion in Venus::Role::Optional if not required

## Version: 2.30

- [feature] Implement Venus::Assert#attributes
- [feature] Implement Venus::Role::Unpackable
- [feature] Implement Venus::Unpack
- [feature] Implement Venus::Array#order
- [feature] Implement Venus::Unpack#signature
- [feature] Implement Venus::Assert#either
- [feature] Implement Venus::Process#ping
- [feature] Implement Venus::Assert#hashkeys
- [feature] Implement Venus::Assert#parse, update Venus::Assert#expression
- [feature] Implement Venus::Assert#{inherits,integrates}
- [feature] Implement Venus::Assert#yesno
- [update] Update Venus::Template
- [update] Strengthen Venus::Assert#enum
- [update] Enhance Venus::Assert#{tuple,within}
- [update] Update Venus::Assert type expression parser

## Version: 2.01

- [feature] Implement Venus::Test "partials" feature
- [feature] Implement Venus::Config
- [feature] Implement Venus#caught
- [feature] Support documentation of messages and exceptions
- [feature] Implement Venus::Space#swap
- [feature] Support documentation and testing of magic "attest" comment
- [update] Address CPAN report 9dabc3cc-a53c-11ed-8404-33246e8775ea
- [update] Fix "initial" in Venus::Role::Optional

## Version: 1.90

- [feature] Allow option_build to set value on read/write
- [feature] Allow option_build on object construction
- [feature] Test permutations of option_build, option_default, and option_coerce
- [feature] Implement lazy_build hook in Venus::Role::Optional
- [feature] Implement self_coerce hook in Venus::Role::Optional
- [feature] Implement self_assert hook in Venus::Role::Optional
- [feature] Use Venus::Assert#expression when asserting with option_assert

## Version: 1.85

- [feature] Implement Venus::Fault
- [feature] Implement Venus::Role::Comparable#{is,st}
- [feature] Implement Venus::Role::Deferrable
- [update] Update value class assertions to use "expression" syntax

## Version: 1.80

- [feature] Implement Venus::Role::Serializable
- [feature] Implement Venus::Role::Subscribable

## Version: 1.75

- [update] Replace Venus::Cli#{program,podfile} with "path" attribute
- [update] Convert Venus::Cli#init method to attribute
- [update] Implement Venus::Assert#expression, and add ref aliases
- [update] Update Venus::Assert to raise exceptions with expectation(s)

## Version: 1.71

- [feature] Implement Venus::Log
- [feature] Implement Venus::Cli

## Version: 1.68

- [feature] Implement Venus::Data#string

## Version: 1.67

- [feature] Allow envvars to control tracing in Venus::Error
- [feature] Add unused arguments to Venus::Opt

## Version: 1.66

- [feature] Cache Venus::Meta for better performance
- [update] Update Venus::Role::Optional

## Version: 1.65

- [feature] Implement Venus::Gather
- [feature] Implement Venus::Role::Optional
- [update] Deprecate Venus::Role::Coercible#coerce

## Version: 1.55

- [feature] Implement Venus::Prototype
- [feature] Support Venus::Role::Pluggable#construct

## Version: 1.50

- [feature] Implement Venus::Assert#accept
- [feature] Implement exportable "cast" function
- [feature] Implement Venus::Assert#format
- [feature] Support Venus::Assert#conditions
- [feature] Implement Venus::Assert $type methods
- [feature] Implement Venus::Assert#validator
- [feature] Implement Venus::Match#where
- [feature] Allow Venus::Match#result to accept/set a value
- [feature] Implement Venus::Assert#{clear,within}
- [feature] Implement Venus::Array#shuffle

## Version: 1.40

- [change] Update callback naming in Venus::Role::Coercible
- [feature] Implement Venus::Space#integrates
- [feature] Implement Venus::Role::Rejectable
- [feature] Implement Venus::Role::Unacceptable
- [feature] Implement Venus::Role::Defaultable
- [feature] Implement Venus::Role::Makeable
- [feature] Implement Venus::Space#{lfile,pfile,tfile}
- [update] Include examples in the distribution
- [update] Update Venus::Meta methods to return with wantarray
- [update] Update Venus::Test to support rendering the encoding tag

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

## Version: 1.10

- [change] Rename truncate_to_x methods to restart_x
- [feature] Cascade DESTROY from Core
- [feature] Implement Venus::Mixin to mix-in routines
- [feature] Venus::{Json,Yaml} engine override via ENV VAR
- [feature] Allow Venus::Meta to return configurations
- [feature] Allow attr override (prevent accessor install)
- [feature] Implement Venus::Error#{is,as} for better classification
- [feature] Implement Venus::Match#test
- [feature] Implement Venus::{Array,Hash}#call
- [update] Allow Meta to return local-only attrs, bases, roles, and subs
- [update] Improve Venus::Space algorithms, add additional methods
- [update] Add missing documentation in Venus::Date, Venus::String
- [update] Update Venus::Core to better handle non-hashref based objects
- [update] Update criteria on require of classes and roles

## Version: 1.01

- [feature] Test, validate, and generate attributes the same as methods
- [feature] Export (on-demand) catch, error, and raise from Venus::{Class,Role}
- [update] Unravel and flattern roles
- [update] Expose errors on require of classes and roles

## Version: 1.00

- [change] Replace Moo with Mars architecture
- [feature] Auto-generate VERSION from the main module
- [update] Fix Venus::Date#rfc822 test example 1 on Windows
- [update] Fix Venus::String#camelcase, add pascalcase

## Version: 0.09

- [feature] Include Venus::Test in the library
- [feature] Add splice to Venus::Space
- [feature] Add kebabcase to Venus::String
- [feature] Add truncate_to_x methods to Venus::Date
- [feature] Add print_string and say_string to Venus::Role::Printable
- [update] Cleanup documentation
- [update] Generate CHANGELOG from .changelog
- [update] Add "Ethic" to READMEs
- [update] Marker =cut being rendered twice

## Version: 0.08

- [defect] Fix inability to deduce floats
- [feature] Implement value casting
- [feature] Implement Venus::Kind#{safe,trap}
- [feature] Implement Venus::Role::Comparable
- [feature] Implement Venus::Role::Testable
- [update] Address test failures reported via CPAN testers issues
- [update] Document all exceptions and methods that throw them
- [update] Document Venus::{Class,Role} configurations
- [update] Fix operator overload documentation rendering
- [update] Refactor Venus::Role::Comparable
- [update] Reimplement Venus::Box#unbox as a virtual method

## Version: 0.07

- [defect] Fix Venus::Class attribute declaration issue
- [feature] Extend Venus::Role::Coercion with new abilities
- [feature] Implement Venus::Match#data
- [feature] Implement Venus::Match#expr
- [update] Update documentation

## Version: 0.06

- [defect] Fix Venus::Path#mkdirs empty rootdir issue
- [feature] Implement Venus::Process

## Version: 0.04

- [feature] Implement Venus::Role::Matchable
- [update] Address CPAN Testers reports

## Version: 0.03

- [feature] Implement Venus::Match
- [update] Address CPAN Testers reports

## Version: 0.02

- [defect] Fix Dumpable method calls in list context
- [feature] Implement String#append_with,prepend_with
- [feature] Implement String#prepend
- [feature] Implement String#repeat
- [feature] Implement String#substr
- [feature] Implement Venus::Role::Coercible
- [feature] Implement Venus::Role::Digestable
- [feature] Implement Venus::Template
- [feature] Support any JSON library via encode/decode callbacks
- [feature] Support any YAML library, deduce booleans
- [update] Document all proxyable methods
- [update] Document overrides, i.e. overloaded operators
- [update] Document overrides in Venus::Boolean
- [update] JSON::PP support requires 4.00
- [update] Minor refactors to source, documentation, and automation
- [update] Require Perl version 5.18+
- [update] Update CONTRIBUTING.md
- [update] Update String#render token syntax
- [update] Update Venus::Json to use encoder/decoder callbacks


