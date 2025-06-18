// lib/src/features/reader/presentation/screens/reader_screen.dart

import 'dart:io';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verse_reader/src/features/library/presentation/providers/library_providers.dart';

// We now use a ConsumerStatefulWidget to manage the EpubController.
class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key, required this.bookId});

  final int bookId;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  late EpubController _epubController;

  // We will load the book data once in initState.
  @override
  void initState() {
    super.initState();
    
    // Fetch book details from the provider.
    final bookAsync = ref.read(bookDetailsProvider(widget.bookId));
    
    // The `whenData` callback is perfect for handling the result of a FutureProvider
    // inside initState. It executes only when the data is successfully loaded.
    bookAsync.whenData((book) {
      if (book != null) {
        _epubController = EpubController(
          // Load the book from a file path.
          document: EpubDocument.openFile(File(book.filePath)),
          // Optionally, you can specify a starting location.
          // epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
        );
      }
    });
  }

  @override
  void dispose() {
    // Always dispose of controllers to free up resources.
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We watch the provider again in the build method.
    // This ensures the widget rebuilds if the book data ever changes.
    final bookAsync = ref.watch(bookDetailsProvider(widget.bookId));

    return bookAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error loading book: $err')),
      ),
      data: (book) {
        if (book == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Book not found.')),
          );
        }

        // This is the main UI. We build our own Scaffold.
        return Scaffold(
          appBar: AppBar(
            title: EpubViewActualChapter(
              controller: _epubController,
              builder: (chapterValue) => Text(
                // Display the current chapter's title or the book title.
                chapterValue?.chapter?.Title ?? book.title,
                textAlign: TextAlign.start,
              ),
            ),
            // You can add more actions to the AppBar here.
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  // TODO: Show reading settings panel
                },
              ),
            ],
          ),
          // We embed the EpubView widget directly in our Scaffold body.
          body: EpubView(
            controller: _epubController,
            // You can customize the look and feel here.
            builders: EpubViewBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              chapterDividerBuilder: (_) => const Divider(),
            ),
            // These callbacks are powerful for saving progress.
            onChapterChanged: (chapter) {
              print('Current chapter: ${chapter?.chapter?.Title}');
              // TODO: Save last read chapter
            },
            onDocumentLoaded: (document) {
              print('Book loaded.');
            },
          ),
        );
      },
    );
  }
}