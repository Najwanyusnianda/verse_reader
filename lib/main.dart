// lib/main.dart

import 'package:drift/drift.dart' show Value; // <-- IMPORTANT: Add this import!
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verse_reader/src/app.dart';
import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:verse_reader/src/features/library/presentation/providers/library_providers.dart';
import 'package:drift/drift.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // We create a ProviderContainer to access providers outside the widget tree.
  final container = ProviderContainer();

  // A temporary function to add dummy data for testing the UI.
  // We only run this in debug mode.
  // assert(() {
  //   _addDummyData(container);
  //   return true;
  // }());

  runApp(
    // We pass the existing container to ProviderScope so it doesn't
    // re-create the providers.
    UncontrolledProviderScope(
      container: container,
      child: const VerseReaderApp(),
    ),
  );
}

// /// A debug-only function to populate the database with sample books.
// void _addDummyData(ProviderContainer container) async {
//   final repository = container.read(bookRepositoryProvider);
//   // Use `first` to get a single value from the stream and complete the future.
//   final books = await repository.watchAllBooks().first;

//   // Only add data if the database is empty to avoid duplicates on hot restart.
//   if (books.isEmpty) {
//     print('--- Adding dummy books for debugging ---');
//     await repository.addBook(BooksCompanion.insert(
//       title: 'The Hobbit',
//       author: Value('J.R.R. Tolkien'),
//       filePath: '/dummy/path/to/hobbit.epub',
//     ));
//     await repository.addBook(BooksCompanion.insert(
//       title: 'A Brief History of Time',
//       author: Value('Stephen Hawking'),
//       filePath: '/dummy/path/to/history.epub',
//     ));
//     await repository.addBook(BooksCompanion.insert(
//       title: 'Project Hail Mary',
//       author: Value('Andy Weir'),
//       filePath: '/dummy/path/to/phm.epub',
//     ));
//     await repository.addBook(BooksCompanion.insert(
//       title: 'The Odyssey',
//       // For nullable fields, we can use Value(null) to let the
//       // database handle it (which will be NULL as we didn't set a default).
//       author: Value(null),
//       filePath: '/dummy/path/to/odyssey.epub',
//     ));
//     print('--- Dummy data added. ---');
//   }
// }