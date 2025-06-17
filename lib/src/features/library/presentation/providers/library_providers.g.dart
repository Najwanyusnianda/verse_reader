// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookRepositoryHash() => r'9d5844572059075f202c02968ab04d4f2b56d324';

/// The provider for the [BookRepository].
///
/// This provider is responsible for creating an instance of our concrete
/// repository implementation, [DriftBookRepository]. It automatically
/// handles fetching the [BooksDao] dependency from its own provider.
///
/// Components in the app will depend on this provider to get a
/// [BookRepository] instance, without needing to know which concrete
/// implementation is being used.
///
/// Example usage:
/// ```dart
/// final bookRepository = ref.watch(bookRepositoryProvider);
/// final books = await bookRepository.watchAllBooks();
/// ```
///
/// Copied from [bookRepository].
@ProviderFor(bookRepository)
final bookRepositoryProvider = AutoDisposeProvider<BookRepository>.internal(
  bookRepository,
  name: r'bookRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookRepositoryRef = AutoDisposeProviderRef<BookRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
