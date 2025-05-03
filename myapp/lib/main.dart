import 'package:flutter/material.dart';

import 'colors.dart';
import 'home_page.dart';

// Entry point of the application
void main() {
  runApp(MagicalColoringApp());
}

// Main widget for the Magical Coloring App.
class MagicalColoringApp extends StatelessWidget {
  const MagicalColoringApp({super.key});

  // Build method to create the app's UI.
  // The MaterialApp is the base of the app.
  // The home page is set to the HomePage widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magical Coloring App',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            tertiary: AppColors.accent),
        useMaterial3: true,
      ),
      // Routes for navigation.
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}


