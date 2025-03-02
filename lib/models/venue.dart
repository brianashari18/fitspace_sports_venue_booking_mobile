import 'package:cloud_firestore/cloud_firestore.dart';

class VenueModel {
  String id;
  String ownerId;
  String name;
  String phoneNumber;
  String street;
  String district;
  String cityOrRegency;
  String province;
  String postalCode;
  double latitude;
  double longitude;
  double rating;
  Timestamp createdAt;
  Timestamp updatedAt;

  VenueModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.district,
    required this.cityOrRegency,
    required this.province,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VenueModel.fromJson(Map<String, Object?> json) {
    return VenueModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      street: json['street'] as String,
      district: json['district'] as String,
      cityOrRegency: json['city_or_regency'] as String,
      province: json['province'] as String,
      postalCode: json['postal_code'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  VenueModel copyWith({
    String? ownerId,
    String? name,
    String? phoneNumber,
    String? street,
    String? district,
    String? cityOrRegency,
    String? province,
    String? postalCode,
    double? latitude,
    double? longitude,
    double? rating,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return VenueModel(
      id: id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      district: district ?? this.district,
      cityOrRegency: cityOrRegency ?? this.cityOrRegency,
      province: province ?? this.province,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "owner_id": ownerId,
      "name": name,
      "phone_number": phoneNumber,
      "street": street,
      "district": district,
      "city_or_regency": cityOrRegency,
      "province": province,
      "postal_code": postalCode,
      "latitude": latitude,
      "longitude": longitude,
      "rating": rating,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
