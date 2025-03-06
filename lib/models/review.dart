import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String id;
  String fieldId;
  String userId;
  int rating;
  String? comment;
  Timestamp createdAt;
  Timestamp updatedAt;

  ReviewModel({
    required this.id,
    required this.fieldId,
    required this.userId,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, Object?> json) {
    return ReviewModel(
      id: json['id'] as String,
      fieldId: json['field_id'] as String,
      userId: json['user_id'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  ReviewModel copyWith({
    String? fieldId,
    String? userId,
    int? rating,
    String? comment,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return ReviewModel(
      id: id,
      fieldId: fieldId ?? this.fieldId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "field_id": fieldId,
      "user_id": userId,
      "rating": rating,
      "comment": comment,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
