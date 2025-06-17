// lib/src/core/database/tables.dart

import 'package:drift/drift.dart';

// --------------- ENUMS --------------- //
// Using enums makes our database values more readable and less error-prone.

/// Defines the type of a note. A note can be a simple highlight
/// or a highlight with an attached user comment.
enum NoteType { highlight, note }

// --------------- TABLES --------------- //

/// The core table holding all imported books.
@DataClassName('Book')
class Books extends Table {
  /// The unique identifier for each book.
  IntColumn get id => integer().autoIncrement()();

  /// The title of the book. Non-nullable.
  TextColumn get title => text().withLength(min: 1, max: 255)();

  /// The author of the book. Can be null if not provided.
  TextColumn get author => text().nullable()();

  /// The absolute path to the book file on the device's storage.
  /// This is marked as unique to prevent importing the exact same file twice.
  TextColumn get filePath => text().unique()();

  /// The path to the book's cover image. Can be null if no cover is found or generated.
  TextColumn get coverPath => text().nullable()();

  /// Reading progress, stored as a value from 0.0 to 1.0.
  /// Defaults to 0 when a book is first added.
  RealColumn get progress => real().withDefault(const Constant(0.0))();

  /// A flag to mark a book as a favorite.
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  /// The timestamp of when the book was last opened.
  /// This is crucial for the "Recent" filter and sorting. Nullable for new books.
  DateTimeColumn get lastReadAt => dateTime().nullable()();

  /// The timestamp of when the book was first added to the library.
  DateTimeColumn get addedAt =>
      dateTime().withDefault(Constant(DateTime.now().toUtc()))();
}

/// Stores reading sessions to track time spent reading, for detailed statistics.
/// This is more robust than just storing a "total time" value.
@DataClassName('ReadingSession')
class ReadingSessions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// A foreign key linking this session to a specific book.
  /// `onDelete: KeyAction.cascade` means if the book is deleted,
  /// all its reading sessions are also automatically deleted.
  IntColumn get bookId =>
      integer().references(Books, #id, onDelete: KeyAction.cascade)();

  /// The timestamp when the reading session started (UTC).
  DateTimeColumn get sessionStart => dateTime()();

  /// The timestamp when the reading session ended (UTC).
  DateTimeColumn get sessionEnd => dateTime()();

  /// The reading progress at the start of the session.
  RealColumn get startProgress => real()();

  /// The reading progress at the end of the session.
  RealColumn get endProgress => real()();
}

/// Stores all user-created notes and highlights.
@DataClassName('Note')
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId =>
      integer().references(Books, #id, onDelete: KeyAction.cascade)();

  /// The user's written note content. This is nullable because a user
  /// might create a highlight without adding a specific comment.
  TextColumn get content => text().nullable()();

  /// The actual text from the book that was highlighted.
  TextColumn get highlightedText => text()();

  /// A string that identifies the location of the note within the book.
  /// For EPUB, this would ideally be a "CFI" (Content Fragment Identifier).
  /// For other formats, it could be a page or chapter number.
  TextColumn get locationIdentifier => text()();

  /// The type of the note (highlight-only or with a comment).
  /// We use a converter to store our Dart enum as an integer in the database.
  IntColumn get type => intEnum<NoteType>()();

  /// Timestamp for when the note was created.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now().toUtc()))();

  // You could add a 'color' column here for different highlight colors.
  // TextColumn get highlightColor => text().withDefault(const Constant('yellow'))();
}

/// Stores flashcards for spaced repetition studying.
@DataClassName('Flashcard')
class Flashcards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId =>
      integer().references(Books, #id, onDelete: KeyAction.cascade)();

  /// The "front" of the flashcard (the question or term).
  TextColumn get front => text()();

  /// The "back" of the flashcard (the answer or definition).
  TextColumn get back => text()();
  
  // --- Fields for Spaced Repetition System (SRS) ---

  /// The next date the card is scheduled for review.
  /// This is the most important field for finding cards "due today".
  DateTimeColumn get dueDate => dateTime()();

  /// The stability of the card's memory trace. Higher means you remember it better.
  /// A float value used in SRS algorithms.
  RealColumn get stability => real().withDefault(const Constant(0.0))();

  /// A measure of the card's difficulty.
  RealColumn get difficulty => real().withDefault(const Constant(0.0))();

  /// The number of times the card has been reviewed.
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();

  /// The last time this card was reviewed.
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
}