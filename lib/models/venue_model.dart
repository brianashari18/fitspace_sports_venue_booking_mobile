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
  final List<String> fields;
  final List<double> price;


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
    required this.price
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
      fields: (json['fields'] as List)
          .map((item) => item['type'].toString())
          .toList(),
      price: (json['fields'] as List<dynamic>)
          .map<double>((item) => (item['price'] as num).toDouble())
          .toList(),
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
      'fields': fields.map((type) => {'type': type}).toList(),
    };
  }
}
