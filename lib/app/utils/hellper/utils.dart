import 'package:image/image.dart' as img;
import 'dart:io';

class Utils {
  static Future<List<int>> compressImage(File file, int quality) async {
    final img.Image? originalImage = img.decodeImage(file.readAsBytesSync());
    final resizedImage = img.encodeJpg(originalImage!, quality: quality);
    return resizedImage;
  }
}
