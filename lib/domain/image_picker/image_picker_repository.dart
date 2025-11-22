import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickedFileResult {

  PickedFileResult({
    required this.bytes,
    required this.mimeType,
    required this.name,
  });
  final Uint8List bytes;
  final String mimeType;
  final String name;
}

abstract class IImagePickerRepository {
  Future<PickedFileResult?> pickImage({required bool fromCamera});
  Future<PickedFileResult?> pickFile();
}

class ImagePickerRepository implements IImagePickerRepository {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<PickedFileResult?> pickImage({required bool fromCamera}) async {
      final image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 85,
      );

    if (image != null) {
        final bytes = await image.readAsBytes();
        return PickedFileResult(
          bytes: bytes, 
          mimeType: 'image/jpeg',
          name: image.name, 
        );
      }
      return null;
  
  }

  @override
  Future<PickedFileResult?> pickFile() async {
         final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], 
        withData: true,
      );

     if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.bytes != null) {
          return PickedFileResult(
            bytes: file.bytes!,
            mimeType: 'application/pdf',
            name: file.name,
          );
        }
      }
      return null;
  }
}
