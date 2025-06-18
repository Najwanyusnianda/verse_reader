// lib/src/features/library/data/book_repository_impl.dart

import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:verse_reader/src/features/library/data/books_dao.dart';
import 'package:verse_reader/src/features/library/domain/book_repository.dart';
import 'package:drift/drift.dart';
/// The concrete implementation of [BookRepository] that uses the Drift DAO.
/// This class knows how to talk to the local database via the [BooksDao].
class DriftBookRepository implements BookRepository {
  /// The DAO that provides access to the books table.
  final BooksDao _booksDao;

  /// Creates a new instance of [DriftBookRepository].
  /// 
  /// Requires a [BooksDao] instance to be provided.
  /// This is how we inject our database dependency, making the code more testable.
  const DriftBookRepository({required BooksDao booksDao}) : _booksDao = booksDao;

  @override
  Stream<List<Book>> watchAllBooks() {
    return _booksDao.watchAllBooks();
  }

  @override
  Future<Book?> getBookById(int id) async {
    try {
      return await _booksDao.getBook(id);
    } catch (e) {
      // getSingle() throws an exception if no item is found.
      // We catch it and return null for a cleaner API.
      return null;
    }
  }

@override
Future<int> addBook(BooksCompanion bookData) async {
  try {
    return await _booksDao.addBook(bookData);
  } on DriftWrappedException catch (e) {
    final message = e.toString().toLowerCase();

    if (message.contains('unique')) {
      throw Exception('This book is already in your library.');
    }
    if (message.contains('not null')) {
      throw Exception('Required book information is missing.');
    }

    print('Database error: $e');
    rethrow;
  } catch (e) {
    print('Unexpected error adding book: $e');
    rethrow;
  }
}

  @override
  Future<bool> updateBook(BooksCompanion bookData) {
    return _booksDao.updateBook(bookData);
  }

  @override
  Future<void> deleteBook(int id) async {
    await _booksDao.deleteBook(id);
  }
}
