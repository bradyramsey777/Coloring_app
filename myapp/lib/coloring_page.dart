import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for HapticFeedback
import 'package:myapp/app_button.dart';
import 'package:myapp/audio_manager.dart';
import 'package:myapp/widgets.dart';

import 'colors.dart'; // Import for AppColors

/// The page where the user can color an image.
class ColoringPage extends StatefulWidget {
  /// Image to be colored.
  final String linesImage;

  /// Constructor for the ColoringPage widget.
  const ColoringPage({super.key, required this.linesImage});

  @override
  State<ColoringPage> createState() => _ColoringPageState();
}

/// State class for the ColoringPage widget.
class _ColoringPageState extends State<ColoringPage> {
  final GlobalKey<DrawingCanvasState> _drawingCanvasKey =
      GlobalKey<DrawingCanvasState>();
  bool isComplete = false;

  @override
  void initState() {
    super.initState();
  }

  /// Callback function that is called when the drawing is completed.
  void onComplete() {
    setState(() {
      isComplete = true;
    });
  }

  /// Callback function that is called when the user selects a color.
  void onColorChanged(Color color) {
    _drawingCanvasKey.currentState?.setCurrentColor(color);
  }

  /// Resets the drawing canvas
  void onReset() {
    showDialog(
        // Show a dialog to confirm the reset action.
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Are you sure you want to reset?"),
            actions: [
              TextButton(
                child: const Text("No"), // Button to cancel the reset action.
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text("Yes"), // Button to confirm the reset action.
                onPressed: () {
                  // Reset the drawing canvas.
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main structure of the app with app bar and body.
      appBar: AppBar(
        title: const Text("Coloring"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: DrawingCanvas(
              key: _drawingCanvasKey,
              linesImage: widget.linesImage,
            ),
          ),

          // Row with the tool buttons.
          // Row with the tool buttons.
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: AppButton(
                  text: "Eraser",
                  icon: const Icon(Icons.clear),
                  onTap: () {
                    AudioManager().playSound("button_tap");
                    HapticFeedback.mediumImpact();
                  },
                ),
              ),
              Expanded(
                child: AppButton(
                  text: "Brush",
                  icon: const Icon(Icons.brush),
                  onTap: () {
                    AudioManager().playSound("button_tap");
                    HapticFeedback.mediumImpact();
                  },
                ),
              ),
            ],
          ),

          // Row with the color picker and the reset button
          Row(
            children: [
              Expanded(
                child: ColorPicker(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.accent
                  ],
                  onColorChanged: onColorChanged,
                ),
              ),
              AppButton(
                text: "Reset",
                icon: const Icon(Icons.refresh),
                onTap: () {
                  onReset();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
