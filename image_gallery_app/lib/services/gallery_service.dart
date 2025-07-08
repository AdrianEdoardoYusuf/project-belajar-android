import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryService {
  static Future<List<XFile>> pickImages() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      throw Exception('Izin akses galeri ditolak');
    }
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    return images;
  }
} 