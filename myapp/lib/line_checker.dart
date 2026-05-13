import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class LineChecker {
  final String imagePath;
  img.Image? _image;

  LineChecker({required this.imagePath});

  Future<void> loadImage() async {
    final ByteData data = await rootBundle.load(imagePath);
    final List<int> bytes = data.buffer.asUint8List().toList();
    final decodedImage = img.decodeImage(Uint8List.fromList(bytes));
    if (decodedImage == null) {
      throw FormatException('Unable to decode line image asset: $imagePath');
    }
    _image = decodedImage;
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