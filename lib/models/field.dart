import 'package:cloud_firestore/cloud_firestore.dart';

class FieldModel {
  String id;
  String venueId;
  double price;
  String type;
  Timestamp createdAt;
  Timestamp updatedAt;

  FieldModel({
    required this.id,
    required this.venueId,
    required this.price,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FieldModel.fromJson(Map<String, Object?> json) {
    return FieldModel(
      id: json['id'] as String,
      venueId: json['venue_id'] as String,
      price: (json['price'] as num).toDouble(),
      type: json['type'] as String,
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  FieldModel copyWith({
    String? venueId,
    double? price,
    String? type,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return FieldModel(
      id: id,
      venueId: venueId ?? this.venueId,
      price: price ?? this.price,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "venue_id": venueId,
      "price": price,
      "type": type,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
