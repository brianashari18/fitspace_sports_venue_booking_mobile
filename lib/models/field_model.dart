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
      gallery: json['gallery'] != null
          ? List<Photo>.from(json['gallery'].map((e) => Photo.fromJson(e)))
          : [], // If gallery is null, return an empty list
      fieldSchedules: json['field_schedules'] != null
          ? List<FieldSchedule>.from(json['field_schedules'].map((e) => FieldSchedule.fromJson(e)))
          : [], // If field_schedules is null, return an empty list
      review: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((e) => Review.fromJson(e)))
          : [], // If reviews is null, return an empty list
      bookings: json['bookings'] != null
          ? List<Booking>.from(json['bookings'].map((e) => Booking.fromJson(e)))
          : [], // If bookings is null, return an empty list
    );
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
