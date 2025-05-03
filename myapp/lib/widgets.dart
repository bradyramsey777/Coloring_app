import 'package:flutter/material.dart';

import 'line_checker.dart';
import 'audio_manager.dart';

// Enumeration to define drawing tools
enum DrawingTool {
  brush,
  eraser, // Eraser tool
}

// AudioManager instance for playing sound effects
final _audioManager = AudioManager();

// A class to store the offset and paint properties of a point.
class DrawingPoint {
  final Offset offset;
  final Paint paint; // Stores the drawing properties for each point

  DrawingPoint({required this.offset, required this.paint});
}

// The widget used to draw the lines.
class DrawingPainter extends CustomPainter {
  // Stores the drawing points
  final List<DrawingPoint> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i].offset, points[i + 1].offset, points[i].paint);
    }
  }
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

/// A widget that allows the user to draw on a canvas
class DrawingCanvas extends StatefulWidget {
  final String linesImage; // Path to the image with the lines

  const DrawingCanvas({super.key, required this.linesImage}); // Requires an image

  @override
  State<DrawingCanvas> createState() => DrawingCanvasState();
}

/// The state for the DrawingCanvas widget
class DrawingCanvasState extends State<DrawingCanvas> {
  List<DrawingPoint> points = [];
  String currentTool = 'brush';
  Color currentColor = Colors.black;
  bool isComplete = false;
  late LineChecker lineChecker;

  @override
  void initState() {
    super.initState();
    currentColor = Colors.black;
    lineChecker = LineChecker(imagePath: widget.linesImage);
    lineChecker.loadImage();
  }

  void setCurrentColor(Color color) {    
    setState(() {
      currentColor = color;
    });
  }

  void setCurrentTool(DrawingTool tool) {
    setState(() {  
      currentTool = tool.name;      
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _audioManager.playSound("draw_start");
        if (mounted) {         
          setState(() {
             isComplete = true;
            points.add(DrawingPoint(
              offset: details.localPosition,
              paint: Paint()
                ..color = currentTool == DrawingTool.eraser.name
                    ? Colors.white // Use white as the color for the eraser
                    : currentColor// Use the current color for the brush
                ..strokeWidth = 5.0 // Adjust the stroke width for drawing
                ..strokeCap = StrokeCap.round// Round stroke cap
                ..isAntiAlias = true // Enable antialiasing for smoother lines
                ..blendMode = currentTool == DrawingTool.eraser.name
                    ? BlendMode.clear // Use clear blend mode for the eraser
                    : BlendMode.srcOver, // Use normal blend mode for the brush
            ));
          });
        }
      },
      onPanUpdate: (details) {
        if (lineChecker.isInsideLines(details.localPosition)) {
          setState(() {
            points.add(DrawingPoint(
              offset: details.localPosition,
              paint: Paint()
                ..color = currentTool == DrawingTool.eraser.name
                    ? Colors.white
                    : currentColor
                ..strokeWidth = 5.0
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round                
                ..blendMode = currentTool == DrawingTool.eraser.name              
                    ? BlendMode.clear
                    : BlendMode.srcOver,
            ));
          });
        } else if (mounted) {
          setState(() {
            points.add(DrawingPoint(
              offset: const Offset(-10, -10),
              paint: Paint()..color = Colors.transparent,
            ));
          });
        }
      },
      child: SizedBox(        
        height: double.infinity,
        child: CustomPaint(
            painter: DrawingPainter(points: points)),
      ),      
    );
  }
}

class ColorPicker extends StatelessWidget {
  final List<Color> colors;
  final Function(Color) onColorChanged;

  const ColorPicker({super.key, required this.colors, required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors
          .map((color) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _audioManager.playSound("color_change");
                  onColorChanged(color);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      )),
                ),
              )))
          .toList(),
    );
  }
}
