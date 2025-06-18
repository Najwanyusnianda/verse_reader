// lib/src/features/library/presentation/widgets/book_grid_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:verse_reader/src/core/database/app_database.dart';
import 'package:go_router/go_router.dart';

class BookGridItem extends StatelessWidget {
  const BookGridItem({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        // Navigate to the reader screen, passing the book's ID in the path.
        context.go('/reader/${book.id}');
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover Placeholder
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias, // Ensures the child respects the border radius
              child: Container(
                // A simple placeholder with the book's initial.
                // Later, this will show the actual cover image.
                alignment: Alignment.center,
                color: colorScheme.secondaryContainer,
                child: Text(
                  book.title.isNotEmpty ? book.title[0].toUpperCase() : '?',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),

          // Book Title
          Text(
            book.title,
            style: textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(2),

          // Book Author
          Text(
            book.author ?? 'Unknown Author',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2); // Simple, elegant animation
  }
}