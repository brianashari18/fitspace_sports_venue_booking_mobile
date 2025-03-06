import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryModel {
  String id;
  String fieldId;
  String photoUrl;
  String? description;
  Timestamp createdAt;
  Timestamp updatedAt;

  GalleryModel({
    required this.id,
    required this.fieldId,
    required this.photoUrl,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GalleryModel.fromJson(Map<String, Object?> json) {
    return GalleryModel(
      id: json['id'] as String,
      fieldId: json['field_id'] as String,
      photoUrl: json['photo_url'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  GalleryModel copyWith({
    String? fieldId,
    String? photoUrl,
    String? description,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return GalleryModel(
      id: id,
      fieldId: fieldId ?? this.fieldId,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "field_id": fieldId,
      "photo_url": photoUrl,
      "description": description,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
