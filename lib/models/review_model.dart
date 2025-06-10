import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';

class Review {
  final int? id;
  final int? fieldId;
  final int? userId;
  final int? rating;
  final String? comment;

  Review({this.id, this.fieldId, this.userId, this.rating, this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'],
        fieldId: json['field_id'],
        userId: json['user_id'],
        rating: json['rating'],
        comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_id': fieldId,
      'user_id': userId,
      'rating': rating,
      'comment': comment,
    };
  }
}
