class Field {
  final int id;
  final int venueId;
  final int price;
  final String type;
  final List<Map<String, dynamic>> fieldSchedules;
  final List<Map<String, dynamic>> review;

  Field({
    required this.id,
    required this.venueId,
    required this.price,
    required this.type,
    required this.fieldSchedules,
    required this.review
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'],
      venueId: json['venueId'],
      price: json['price'],
      type: json['type'],
      fieldSchedules: List<Map<String, dynamic>>.from(json['fieldSchedules']),
      review: List<Map<String, dynamic>>.from(json['reviews'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'price': price,
      'type': type,
      'fieldSchedules': fieldSchedules,
    };
  }
}
