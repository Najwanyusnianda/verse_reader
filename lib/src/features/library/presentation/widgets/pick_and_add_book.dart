//lib/src/features/library/presentation/widgets/pick_and_add_book.dart

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:verse_reader/src/features/library/presentation/providers/library_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


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
      //final filePath = result.files.single.path!;

      // 4. Extract a title from the file name.
      //final title = p.basenameWithoutExtension(filePath);
      // 3. Get the file path from the picker.
      final filePath = result.files.single.path!;
      print('Attempting to add book at path: $filePath');
      // 3b. Copy the picked file to a stable, app-controlled location:
      final appDir = await getApplicationDocumentsDirectory();
      final booksDir = Directory('${appDir.path}/books');
      if (!await booksDir.exists()) await booksDir.create();

      // Generate the new destination path
      final newFilePath = p.join(booksDir.path, p.basename(filePath));

      // Only copy if it doesn't already exist (avoid overwriting)
      if (!await File(newFilePath).exists()) {
        await File(filePath).copy(newFilePath);
      }

      // Use `newFilePath` from here on out!
      print('Book copied to stable location: $newFilePath');

      // 4. Extract a title from the file name.
      final title = p.basenameWithoutExtension(filePath); // Or use newFilePath if you want
      // 5. Create a BooksCompanion to insert into the database.
      final bookData = BooksCompanion.insert(
        title: title,
        filePath: newFilePath,
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
    }catch (e) {
      print('📢 Showing error message: $e');

      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Unexpected error: $e';

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}