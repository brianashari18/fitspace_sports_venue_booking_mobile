import 'package:fitspace_sports_venue_booking_mobile/models/photo_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/review_model.dart';

import 'booking_model.dart';
import 'field_schedule_model.dart';

class Field {
  final int? id;
  final int? venueId;
  final int? price;
  final String? type;
  final List<Photo>? gallery;
  final List<FieldSchedule>? fieldSchedules;
  final List<Review>? review;
  final List<Booking>? bookings;

  Field(
      {this.id,
      this.venueId,
      this.price,
      this.type,
      this.gallery,
      this.fieldSchedules,
      this.review,
      this.bookings});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
        id: json['id'],
        venueId: json['venueId'],
        price: json['price'],
        type: json['type'],
        gallery: List<Map<String, dynamic>>.from(json['gallery'])
            .map(
              (e) => Photo.fromJson(e),
            )
            .toList(),
        fieldSchedules: List<Map<String, dynamic>>.from(json['fieldSchedules'])
            .map(
              (e) => FieldSchedule.fromJson(e),
            )
            .toList(),
        review: List<Map<String, dynamic>>.from(json['reviews'])
            .map(
              (e) => Review.fromJson(e),
            )
            .toList(),
        bookings: List<Map<String, dynamic>>.from(json['bookings'])
            .map(
              (e) => Booking.fromJson(e),
            )
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venue_id': venueId,
      'price': price,
      'type': type,
      'gallery': gallery
          ?.map(
            (e) => Photo().toJson(),
          )
          .toList(),
      'field_schedules': fieldSchedules
          ?.map(
            (e) => FieldSchedule().toJson(),
          )
          .toList(),
      'review': review
          ?.map(
            (e) => Review().toJson(),
          )
          .toList(),
      'bookings': bookings
          ?.map(
            (e) => Booking().toJson(),
          )
          .toList(),
    };
  }
}
