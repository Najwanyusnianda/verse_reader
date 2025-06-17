import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:verse_reader/src/features/library/presentation/providers/library_providers.dart';

class PickAndAddBook {
  /// This method handles the entire book import process.
  static Future<void> pickAndAddBook(BuildContext context, WidgetRef ref) async {
    try {
      // 1. Pick a file using the file_picker package.
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub'],
        withData: false,
        withReadStream: false,
      );

      // 2. Handle the case where the user cancels the picker.
      if (result == null || result.files.single.path == null) {
        return;
      }

      // 3. Get the file path.
      final filePath = result.files.single.path!;

      // 4. Extract a title from the file name.
      final title = p.basenameWithoutExtension(filePath);

      // 5. Create a BooksCompanion to insert into the database.
      final bookData = BooksCompanion.insert(
        title: title,
        filePath: filePath,
        author: Value.absent(),
      );

      // 6. Use the repository to add the book.
      final repository = ref.read(bookRepositoryProvider);
      await repository.addBook(bookData);

      // 7. Show a success message.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"$title" added to library.'),
            backgroundColor: Colors.green[700],
          ),
        );
      }
    } catch (e) {
      // 8. Handle potential errors
      print("Error adding book: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error adding book: It might already be in your library.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}