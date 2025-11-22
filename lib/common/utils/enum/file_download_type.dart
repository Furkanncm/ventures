import 'package:file_saver/file_saver.dart';

enum FileDownloadType {
  audio(ext: 'mp3', mimeType: MimeType.mp3),
  pdf(ext: 'pdf', mimeType: MimeType.pdf),
  image(ext: 'jpg', mimeType: MimeType.jpeg);

  const FileDownloadType({
    required this.ext,
    required this.mimeType,
  });
  final String ext;
  final MimeType mimeType;
}
