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
  final double rating;
  final List<Map<String, dynamic>> fields;
  final Map<String, dynamic> owner;// Store the owner as a map

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
    required this.rating,
    required this.fields,
    required this.owner,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      street: json['street'],
      district: json['district'],
      cityOrRegency: json['cityOrRegency'],
      province: json['province'],
      postalCode: json['postalCode'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble() ?? 0,
      fields: List<Map<String, dynamic>>.from(json['fields'] as List),
      owner: json['owner'],  // Directly assign the owner map
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'district': district,
      'cityOrRegency': cityOrRegency,
      'province': province,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'fields': fields,
      'owner': owner,  // Directly assign the owner map to JSON
    };
  }
}
