import 'dart:async';

import 'runner.dart';

/// Produces IsolateRunner instances, including any initialization to the isolate(s) created.
typedef IsolateRunnerFactory = Future<Runner> Function();

/// Given a newly created [IsolateRunner], ensures that the isolate(s) that back the [Runner] are
/// initialized properly
typedef IsolateInitializer = FutureOr Function(Runner runner);

/// Initializer that runs inside the isolate.
typedef RunInsideIsolateInitializer<P> = FutureOr Function(P param);

class InitializerWithParam<P> {
  final P Function() param;
  final RunInsideIsolateInitializer<P> init;

  InitializerWithParam(this.param, this.init);
  static InitializerWithParam noParam(FutureOr init()) {
    return InitializerWithParam(() => null, (param) => init());
  }

  static InitializerWithParam<P> of<P>(
      P static, RunInsideIsolateInitializer<P> init) {
    return InitializerWithParam(() => static, init);
  }

  static nullParam() => null;
}

/// Allows for setting parameters used to initialize IsolateRunner and their worker
/// instances
class RunnerBuilder {
  /// The number of times this builder has been used to spawn Isolates.  In the case of
  /// [LoadBalancer] runners, this will append an isolate number to the debugName for
  /// each isolate
  var _spawnCount = 1;

  /// Whether this isolate or pool should fail when an error is encountered.
  bool failOnError = false;

  /// The default timeout for commands sent to the [IsolateRunner]
  Duration? defaultTimeout = Duration(seconds: 30);

  /// The base name for spawned isolates.  If a [LoadBalancer] is used, then a number
  /// will be appended to this base value.  see [RunnerBuilder.debugName]
  String? get debugNameBase => _debugName;

  /// Removes any timeouts for [IsolateRunner] instances created from this builder
  void withoutTimeout() {
    defaultTimeout = null;
  }

  /// [RunnerBuilder.debugName]
  String? _debugName;

  /// What to name the isolate that gets created.  If using a pool, an integer will be appended to each isolate that's created
  set debugName(String? name) {
    _debugName = name;
  }

  /// Returns the next debugName for an [IsolateRunner] based on these settings.  If a [LoadBalancer] is used, a number
  /// will be appended and incremented
  String? get debugName {
    if (_debugName == null) return null;
    if (poolSize > 1) {
      return '$_debugName: ${_spawnCount++}';
    } else {
      return '$_debugName';
    }
  }

  /// How many isolates to create in the pool.  If this value is 1, then a single [IsolateRunner] will be created.  Otherwise,
  /// a [LoadBalancer] will be created.  Must be greater than 0
  int poolSize = 1;

  /// Whether to automatically close the underlying isolates then the calling isolate is destroyed.  Default is true.  If you
  /// set this to false, you must call [Runner.close] on your own.
  bool autoCloseChildren = true;

  RunnerBuilder._();

  RunnerBuilder.defaults()
      : _debugName = "isolateRunner",
        _spawnCount = 1;

  final onIsolateCreated = <IsolateInitializer>[];
  final isolateInitializers = <InitializerWithParam>[];

  /// Adds an initializer - this consumes the [IsolateRunner] and performs some action on it.
  ///
  /// This code will be executed in the parent isolate, ie. the isolate that did the spawning.
  void addOnIsolateCreated(IsolateInitializer init) {
    onIsolateCreated.add(init);
  }

  /// Adds an initializer - this is run on each isolate that's spawned, and contains any common setup.
  /// The parameter passed to the isolate must be a valid isolate message, but can be deferred until
  /// the time of isolate creation.
  ///
  /// Once the isolate is created, the value of P will not be resolved again.
  void addIsolateInitializerWithDeferredParam<P>(
      RunInsideIsolateInitializer<P> init, P param()) {
    isolateInitializers.add(InitializerWithParam<P>(param, init));
  }

  /// Adds an initializer - this is run on each isolate that's spawned, and contains any common setup.
  void addIsolateInitializerWithParam<P>(
      RunInsideIsolateInitializer<P> init, P param) {
    isolateInitializers.add(InitializerWithParam.of<P>(param, init));
  }

  /// Adds an initializer - this is run on each isolate that's spawned, and contains any common setup.
  void addIsolateInitializer(FutureOr init()) {
    isolateInitializers.add(InitializerWithParam.noParam(init));
  }
}
