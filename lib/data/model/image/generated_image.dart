import 'package:cloud_firestore/cloud_firestore.dart';

class ImageItem {
  ImageItem({
    required this.id,
    required this.url,
    required this.prompt,
    required this.ownerId,
    required this.isPublic,
    this.createdAt,
  });

  factory ImageItem.fromMap(Map<String, dynamic> map) {
    return ImageItem(
      id: map['id'] as String,
      url: map['url'] as String,
      prompt: map['prompt'] as String,
      ownerId: map['ownerId'] as String,
      isPublic: map['isPublic'] as bool,
      createdAt: map['createdAt'] is Timestamp
          ? map['createdAt'] as Timestamp
          : null,
    );
  }
  final String id;
  final String url;
  final String prompt;
  final String ownerId;
  final bool isPublic;
  final Timestamp? createdAt;

  Map<String, dynamic> toMap() => {
    'id': id,
    'url': url,
    'prompt': prompt,
    'ownerId': ownerId,
    'isPublic': isPublic,
    'createdAt': createdAt ?? FieldValue.serverTimestamp(),
  };
}
