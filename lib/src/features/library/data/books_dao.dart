// lib/src/features/library/data/books_dao.dart

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:verse_reader/src/core/database/database_provider.dart';
import 'package:verse_reader/src/core/database/tables.dart';

// This generated file will contain the mixin
part 'books_dao.g.dart';

// The @DriftAccessor annotation tells Drift to generate a mixin for this DAO.
// We specify which tables this DAO will access.
@DriftAccessor(tables: [Books])
class BooksDao extends DatabaseAccessor<AppDatabase> with _$BooksDaoMixin {
  // The constructor is required. It takes the main database class as a parameter.
  BooksDao(AppDatabase db) : super(db);

  /// --- READ operations ---

  /// Watches the entire books table for changes and returns a stream of all books.
  /// The list is sorted by the most recently read book first, with unread
  /// books (null lastReadAt) appearing at the end.
  Stream<List<Book>> watchAllBooks() {
    return (select(books)
          ..orderBy([
            (b) => OrderingTerm(
                expression: b.lastReadAt, mode: OrderingMode.desc, nulls: NullsOrder.last)
          ]))
        .watch();
  }
  
  /// Fetches a single book by its ID. Returns a Future.
  Future<Book> getBook(int id) {
    return (select(books)..where((b) => b.id.equals(id))).getSingle();
  }

  /// --- WRITE operations ---

  /// Inserts a new book into the database.
  /// `BooksCompanion` is a Drift-generated class used for inserts and updates.
  /// It returns the auto-incremented ID of the new book.
  Future<int> addBook(BooksCompanion entry) {
    return into(books).insert(entry);
  }

  /// Updates an existing book. This is a full replacement operation.
  /// Returns true if the update was successful.
  Future<bool> updateBook(BooksCompanion entry) {
    return update(books).replace(entry);
  }

  /// Deletes a book from the database by its ID.
  /// Returns the number of rows deleted (should be 1).
  Future<int> deleteBook(int id) {
    return (delete(books)..where((b) => b.id.equals(id))).go();
  }
}

@riverpod
BooksDao booksDao(Ref ref) {
  // Watch the appDatabaseProvider to get the database instance
  final db = ref.watch(appDatabaseProvider);
  // Return an instance of our DAO, passing the database instance to it
  return BooksDao(db);
}