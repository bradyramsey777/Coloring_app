import 'package:flutter/services.dart';
import 'package:image/image.dart' as img; 

class LineChecker {
  final String imagePath;
  img.Image? _image;

  LineChecker({required this.imagePath});

  Future<void> loadImage() async {
    final ByteData data = await rootBundle.load(imagePath);
    final List<int> bytes = data.buffer.asUint8List().toList();
    _image = img.decodeImage(Uint8List.fromList(bytes));
  }

  bool isInsideLines(Offset point) {
    if (_image == null) return false;
    if (point.dx < 0 ||
        point.dy < 0 ||        
        point.dx >= _image!.width ||        
        point.dy >= _image!.height) {
      return false;
    }

    final pixel = _image!.getPixelSafe(point.dx.toInt(), point.dy.toInt());
    final int red = pixel.r.toInt();
    return red > 128;
  }
}