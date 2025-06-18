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
String _$bookDetailsHash() => r'dcc83bea579454ed83c2c5a350f14282af44bbb9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// A provider that fetches the details of a single book.
/// The `.family` modifier allows us to pass an argument, the `bookId`.
/// Riverpod will automatically cache the result, so if we ask for the same
/// book ID again, it will return the cached data instantly.
///
/// Copied from [bookDetails].
@ProviderFor(bookDetails)
const bookDetailsProvider = BookDetailsFamily();

/// A provider that fetches the details of a single book.
/// The `.family` modifier allows us to pass an argument, the `bookId`.
/// Riverpod will automatically cache the result, so if we ask for the same
/// book ID again, it will return the cached data instantly.
///
/// Copied from [bookDetails].
class BookDetailsFamily extends Family<AsyncValue<Book?>> {
  /// A provider that fetches the details of a single book.
  /// The `.family` modifier allows us to pass an argument, the `bookId`.
  /// Riverpod will automatically cache the result, so if we ask for the same
  /// book ID again, it will return the cached data instantly.
  ///
  /// Copied from [bookDetails].
  const BookDetailsFamily();

  /// A provider that fetches the details of a single book.
  /// The `.family` modifier allows us to pass an argument, the `bookId`.
  /// Riverpod will automatically cache the result, so if we ask for the same
  /// book ID again, it will return the cached data instantly.
  ///
  /// Copied from [bookDetails].
  BookDetailsProvider call(int bookId) {
    return BookDetailsProvider(bookId);
  }

  @override
  BookDetailsProvider getProviderOverride(
    covariant BookDetailsProvider provider,
  ) {
    return call(provider.bookId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bookDetailsProvider';
}

/// A provider that fetches the details of a single book.
/// The `.family` modifier allows us to pass an argument, the `bookId`.
/// Riverpod will automatically cache the result, so if we ask for the same
/// book ID again, it will return the cached data instantly.
///
/// Copied from [bookDetails].
class BookDetailsProvider extends AutoDisposeFutureProvider<Book?> {
  /// A provider that fetches the details of a single book.
  /// The `.family` modifier allows us to pass an argument, the `bookId`.
  /// Riverpod will automatically cache the result, so if we ask for the same
  /// book ID again, it will return the cached data instantly.
  ///
  /// Copied from [bookDetails].
  BookDetailsProvider(int bookId)
    : this._internal(
        (ref) => bookDetails(ref as BookDetailsRef, bookId),
        from: bookDetailsProvider,
        name: r'bookDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$bookDetailsHash,
        dependencies: BookDetailsFamily._dependencies,
        allTransitiveDependencies: BookDetailsFamily._allTransitiveDependencies,
        bookId: bookId,
      );

  BookDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookId,
  }) : super.internal();

  final int bookId;

  @override
  Override overrideWith(
    FutureOr<Book?> Function(BookDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BookDetailsProvider._internal(
        (ref) => create(ref as BookDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookId: bookId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Book?> createElement() {
    return _BookDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookDetailsProvider && other.bookId == bookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BookDetailsRef on AutoDisposeFutureProviderRef<Book?> {
  /// The parameter `bookId` of this provider.
  int get bookId;
}

class _BookDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Book?>
    with BookDetailsRef {
  _BookDetailsProviderElement(super.provider);

  @override
  int get bookId => (origin as BookDetailsProvider).bookId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
