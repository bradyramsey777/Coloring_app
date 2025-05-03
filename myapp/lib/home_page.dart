import 'package:flutter/material.dart';

import 'art_library_page.dart';
import 'app_button.dart';
import 'colors.dart';
import 'coloring_page.dart';
import 'widgets.dart';

/// The home page of the Magical Coloring App.
class HomePage extends StatelessWidget { 
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure for the app.
    return Scaffold(
      // AppBar displays the title of the app at the top.
      appBar: AppBar(
        title: const Text('Magical Coloring App'),
      ),
      // Center centers the child widgets in the middle of the screen.
      body: Center(
        // Column arranges the child widgets in a vertical line.
        child: Column(
          // Center the column vertically on the screen.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox provides space between the buttons.
            const SizedBox(height: 20),
            // AppButton for starting the coloring process.
            AppButton(
              text: 'Start Coloring',
              icon: const Icon(Icons.color_lens),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ColoringPage(linesImage: '',)),
                );
              },
            ),
            // SizedBox provides space between the buttons..
            const SizedBox(height: 20),
            // AppButton for navigating to the art gallery.
            AppButton(
              text: 'Art Gallery',
              icon: const Icon(Icons.photo_library),
              // Navigate to the ArtLibraryPage when tapped.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ArtLibraryPage()),
                );
              },
            ),
            // SizedBox provides space between the buttons..
            const SizedBox(height: 20),
            ColorPicker(
              colors: [
                AppColors.primary,
                AppColors.secondary,
                AppColors.accent,
              ],
              onColorChanged: (color) {}, // This was the error.
            )
            // Display the color picker at the bottom of the screen.
          ],
        ),
      ),
    );
  }
}
