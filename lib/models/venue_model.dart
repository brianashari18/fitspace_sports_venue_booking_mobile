import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';

class Venue {
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? street;
  final String? district;
  final String? cityOrRegency;
  final String? province;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final List<Field>? fields;
  final User? owner;

  Venue({
    this.id,
    this.name,
    this.phoneNumber,
    this.street,
    this.district,
    this.cityOrRegency,
    this.province,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.rating,
    this.fields,
    this.owner,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      street: json['street'],
      district: json['district'],
      cityOrRegency: json['city_or_regency'],
      province: json['province'],
      postalCode: json['postal_code'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble() ?? 0,
      fields: json['fields'] != null
          ? List<Field>.from(json['fields'].map((e) => Field.fromJson(e)))
          : [],
      owner: json['owner'] != null ? User.fromJson(json['owner']) : User.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'street': street,
      'district': district,
      'city_or_regency': cityOrRegency,
      'province': province,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'fields': fields?.map((e) => Field().toJson(),).toList(),
      'owner': owner,
    };
  }

  @override
  String toString() {
    return 'Venue{id: $id, name: $name, phoneNumber: $phoneNumber, street: $street, district: $district, cityOrRegency: $cityOrRegency, province: $province, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, rating: $rating, owner: $owner, fields: $fields}';
  }
}
