// lib/src/routing/app_router.dart

import 'package:flutter/material.dart'; // Import this
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verse_reader/src/features/library/presentation/screens/library_home_screen.dart';
import 'package:verse_reader/src/features/reader/presentation/screens/reader_screen.dart'; // Import new screen

part 'app_router.g.dart';

// 1. Define GlobalKeys for the navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
// The shell navigator key will be added later when we build the shell

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/library',
    navigatorKey: _rootNavigatorKey, // 2. Assign the root navigator key
    routes: [
      // We will wrap this in a ShellRoute in a future step.
      // For now, it's a simple top-level route.
      GoRoute(
        path: '/library',
        builder: (context, state) => const LibraryHomeScreen(),
      ),
      
      // 3. Define the full-screen reader route
      GoRoute(
        path: '/reader/:bookId', // A path with a parameter
        parentNavigatorKey: _rootNavigatorKey, // This is crucial for full-screen
        builder: (context, state) {
          // Extract the bookId from the path parameters.
          // We use a try-catch to be safe.
          try {
            final bookId = int.parse(state.pathParameters['bookId']!);
            return ReaderScreen(bookId: bookId);
          } catch (e) {
            // If the ID is invalid, return an error screen or redirect.
            return const Scaffold(
              body: Center(child: Text('Error: Invalid Book ID')),
            );
          }
        },
      ),
    ],
  );
}