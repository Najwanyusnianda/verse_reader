// lib/src/features/library/domain/book_repository.dart

import 'package:verse_reader/src/core/database/app_database.dart';

/// The abstract repository for book-related data operations.
/// This defines the contract that any book repository implementation must follow.
/// The rest of the application will depend on this abstraction, not on a
/// concrete implementation.
abstract class BookRepository {
  /// Watches for all books in the library.
  /// Returns a stream that emits a new list of books whenever the data changes.
  Stream<List<Book>> watchAllBooks();

  /// Retrieves a single book by its unique ID.
  /// Returns the [Book] if found, or `null` if no book with the given ID exists.
  Future<Book?> getBookById(int id);

  /// Adds a new book to the library.
  /// 
  /// The [bookData] is a Drift-generated companion object containing the
  /// data for the new book.
  /// 
  /// Returns the ID of the newly created book.
  Future<int> addBook(BooksCompanion bookData);

  /// Updates an existing book's data.
  /// 
  /// The [bookData] should contain the updated book information including its ID.
  /// 
  /// Returns `true` if the update was successful, `false` otherwise.
  Future<bool> updateBook(BooksCompanion bookData);

  /// Deletes a book from the library by its ID.
  /// 
  /// Throws an exception if the deletion fails.
  Future<void> deleteBook(int id);
}
