// lib/src/features/library/presentation/screens/library_home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:verse_reader/src/features/library/presentation/providers/library_providers.dart';
import 'package:verse_reader/src/features/library/presentation/widgets/book_grid_item.dart';
import 'package:verse_reader/src/features/library/presentation/widgets/pick_and_add_book.dart';

/// The main screen for browsing and managing the user's book library.
///
/// This screen displays a grid of books with a floating action button to add new books.
/// It handles various states including loading, error, empty, and data states.
class LibraryHomeScreen extends ConsumerWidget {
  /// Creates a [LibraryHomeScreen] widget.
  const LibraryHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the book repository provider to get the latest instance
    final bookRepository = ref.watch(bookRepositoryProvider);
    
    // Get a stream of all books from the repository
    final booksStream = bookRepository.watchAllBooks();

    return Scaffold(
      // Use CustomScrollView for smooth scrolling with a collapsible app bar
      body: CustomScrollView(
        slivers: [
          // Large app bar that collapses when scrolling
          SliverAppBar.large(
            title: const Text('Library'),
            floating: true, // App bar appears on scroll up
            snap: true,     // Snaps into view when scrolling up
            // Optional: Add actions like search, sort, etc.
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.search),
            //     onPressed: () { /* TODO: Implement search */ },
            //   ),
            // ],
          ),
          
          // StreamBuilder to handle the books stream
          StreamBuilder<List<Book>>(
            stream: booksStream,
            builder: (context, snapshot) {
              // 1. Handle Loading State
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              
              // 2. Handle Error State
              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load books',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${snapshot.error}',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
              
              // 3. Handle Empty State
              final books = snapshot.data;
              if (books == null || books.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_outlined, size: 60, color: Colors.grey),
                        Gap(16),
                        Text(
                          'Your library is empty',
                          style: TextStyle(fontSize: 18),
                        ),
                        Gap(8),
                        Text(
                          'Tap the + button to add your first book.',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // 4. Handle Data State - Display books in a grid
              return SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 books per row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65, // Aspect ratio for book covers
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => BookGridItem(book: books[index]),
                    childCount: books.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      
      // Floating action button to add new books
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement import book flow
          // This will be connected to the book import functionality
          // add loader to indicate the import process
          // and handle any errors that may occur.
          // For now, we will call the pickAndAddBook method.

           PickAndAddBook.pickAndAddBook(context, ref);
           // Show a loading indicator while the book is being added
 

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
