// lib/src/core/database/app_database.dart

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// We import the tables file we just created.
import 'package:verse_reader/src/core/database/tables.dart';

// Import the future DAO files
import 'package:verse_reader/src/features/library/data/books_dao.dart';
import 'package:verse_reader/src/features/notes/data/notes_dao.dart';

// This is a special Drift-generated file. It doesn't exist yet.
// We will run a command to create it in the next step.
// The name is derived from this file's name (`app_database.dart`).
part 'app_database.g.dart';

// The @DriftDatabase annotation tells Drift to build all the necessary code.
// We list all the tables we want to include in our database.
@DriftDatabase(
  tables: [Books, ReadingSessions, Notes, Flashcards],
  daos: [BooksDao, NotesDao], // <-- THIS IS THE NEW LINE
  
  )
class AppDatabase extends _$AppDatabase {
  // This constructor is required. We'll define _openConnection below.
  AppDatabase() : super(_openConnection());

  /// The schemaVersion is a critical part of database migrations.
  /// When you change your tables (e.g., add a column), you must
  /// increment this version and provide a migration strategy.
  /// We start at version 1.
  @override
  int get schemaVersion => 1;
}

/// This private function is responsible for creating the connection
/// to the database file on the device.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      
      // Add logging to see what's happening
      return NativeDatabase.createInBackground(
        file,
        logStatements: true, // This will log all SQL statements
      );
    } catch (e) {
      print('Error opening database: $e');
      rethrow;
    }
  });
}