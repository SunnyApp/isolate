## [3.0.3+5]
 * --

## [3.0.3+4]
 * Fixing errant dart:html import

## [3.0.3+3]
 * Adding RunnerBuilder
Adding isolate builder

## [3.0.3+2]
 * Fixing package names

## [3.0.3+1]
 * Adding build scripts
Separating variable and return for easier debugging
replace dynamic with complete generic parameters
remove redundant parenthesis
add singleCallbackPort variants tests
enable strong-mode for implicit casts
use singleResponseFuture variants with proper result nullability
catch errors in [onTimeout]
add singleCallbackPort and singleResponseFuture versions with proper nullability result
introduce variable instead of force unwrap
add use new [Capability] as fallback for isolate.resume
[Registry.add] always non-null Capability
fix a few usages of [singleCompletePort], callback argument isn't nullable
make [MultiError.waitUnordered] futures elements in not nullable
make [LoadBalancer.close] not nullable
remove redundant parenthesis
late port [IsolateRunner.errors] getter
unwrap id early in _multiplexResponse
late results, non-null errors
introduce local variable instead of force unwrap
introduce local variable instead of force unwrap
remove redundant `.then((value) => value)`
nullability in sendFutureResult
remove `!`
non-null run
enable null-safety
Migrate to GitHub Actions (#42)
* Migrate to GitHub Actions

* Delete .travis.yml

* Fix infos

* Fix formatting

* Update test-package.yml
fix pedantic lints (#37)

make private fields final (#34)

Fix bug in `IsolateRunner.kill`. (#33)
Fix bug in `IsolateRunner.kill`.

Update `LoadBalancer.runMultiple` to be properly generic.

Cleanups and tweaks.

Add example for registry.
3 cleanup commits (#31)
* Remove codereview.settings

* Test on oldest supported Dart SDK

* Enable and fix a number of lints
Delete analysis_options.yaml
Fix pkg:test dependency (#28)

## 2.0.3

* Update SDK requirements.
* Fix bug in `IsolateRunner.kill` with a zero duration.
* Update some type from `Future` to `Future<void>`.
* Make `LoadBalancer.runMultiple` properly generic.

## 2.0.1

* Use lower-case constants from dart:io.

## 2.0.0

* Make port functions generic so they can be used in a Dart 2 type-safe way.

## 1.1.0

* Add generic arguments to `run` in `LoadBalancer` and `IsolateRunner`.
* Add generic arguments to `singleCallbackPort` and `singleCompletePort`.

## 1.0.0

* Change to using `package:test` for testing.

## 0.2.3

* Fixed strong mode analysis errors.
* Migrated tests to package:test.

## 0.2.2

* Made `Isolate.kill` parameter `priority` a named parameter.

## 0.2.1

* Fixed spelling in a number of doc comments and the README.

## 0.2.0

* Renamed library `isolaterunner.dart` to `isolate_runner.dart`.
* Renamed library `loadbalancer.dart' to `load_balancer.dart`.

## 0.1.0

* Initial version
* Adds `IsolateRunner` as a helper around Isolate.
* Adds single-message port helpers and a load balancer.
