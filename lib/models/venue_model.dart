class Venue {
  final int id;
  final String name;
  final String phoneNumber;
  final String street;
  final String district;
  final String cityOrRegency;
  final String province;
  final String postalCode;
  final double latitude;
  final double longitude;

  Venue({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.district,
    required this.cityOrRegency,
    required this.province,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
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
    };
  }
}
