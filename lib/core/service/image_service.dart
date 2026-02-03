import "package:image_picker/image_picker.dart";

sealed class ImageService {
  static Future<String?> pick(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    return file?.path;
  }
}
