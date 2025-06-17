// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'1bf50e48da4f0dbb2eda65d3c927da7bce788e9b';

/// A Riverpod provider that manages the app's routing configuration.
///
/// This provider uses `go_router` for declarative routing in the app.
/// It's marked with `keepAlive: true` to maintain the router's state across rebuilds.
///
/// The router is configured with:
/// - An initial route of '/library'
/// - Named routes for each screen in the app
///
/// Copied from [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = Provider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
