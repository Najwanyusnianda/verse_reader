// lib/src/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verse_reader/src/routing/app_router.dart';

// Import the generated provider
export 'package:verse_reader/src/routing/app_router.dart' show goRouter;

/// The root widget of the Verse Reader application.
///
/// This widget sets up the app's theme and routing configuration.
/// It uses `MaterialApp.router` for navigation and provides a consistent
/// theme throughout the app.
class VerseReaderApp extends ConsumerWidget {
  /// Creates a [VerseReaderApp] widget.
  const VerseReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We watch the goRouterProvider to get the router configuration.
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      // Router configuration
      routerConfig: router,
      
      // App title shown in the task switcher
      title: 'Verse Reader',
      
      // Theme configuration
      theme: ThemeData(
        // Use a purple color scheme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Enable Material 3 design
        useMaterial3: true,
        // Apply the Inter font family from Google Fonts
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      
      // Remove the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,
    );
  }
}
