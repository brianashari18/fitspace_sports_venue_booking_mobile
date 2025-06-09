class Photo {
  final int? id;
  final int? fieldId;
  final String? photoUrl;
  final String? description;

  Photo({this.id, this.fieldId, this.photoUrl, this.description});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      fieldId: json['field_id'],
      photoUrl: json['photoUrl'],
      description: json['description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_id': fieldId,
      'photo_url': photoUrl,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Photo{id: $id, fieldId: $fieldId, photoUrl: $photoUrl, description: $description}';
  }
}