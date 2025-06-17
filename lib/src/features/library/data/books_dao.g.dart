// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_dao.dart';

// ignore_for_file: type=lint
mixin _$BooksDaoMixin on DatabaseAccessor<AppDatabase> {
  $BooksTable get books => attachedDatabase.books;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$booksDaoHash() => r'9af74d45ebadba4f69293e2eaffa507c9b9323a1';

/// See also [booksDao].
@ProviderFor(booksDao)
final booksDaoProvider = AutoDisposeProvider<BooksDao>.internal(
  booksDao,
  name: r'booksDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$booksDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BooksDaoRef = AutoDisposeProviderRef<BooksDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
