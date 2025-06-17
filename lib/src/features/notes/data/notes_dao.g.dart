// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_dao.dart';

// ignore_for_file: type=lint
mixin _$NotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $BooksTable get books => attachedDatabase.books;
  $NotesTable get notes => attachedDatabase.notes;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notesDaoHash() => r'61a2515bcde7c49bf7d6c9672f080be50d9120b6';

/// See also [notesDao].
@ProviderFor(notesDao)
final notesDaoProvider = AutoDisposeProvider<NotesDao>.internal(
  notesDao,
  name: r'notesDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesDaoRef = AutoDisposeProviderRef<NotesDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
