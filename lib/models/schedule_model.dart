import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/field_schedule_model.dart';

import 'booking_model.dart';

class Schedule {
  final int? id;
  final DateTime? date;
  final String? timeSlot;
  final List<Booking>? bookings;
  final List<FieldSchedule>? fieldSchedule;

  Schedule(
      {this.id, this.date, this.timeSlot, this.bookings, this.fieldSchedule});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['id'],
        date: DateTime.parse(json['date'] as String),
        timeSlot: json['time_slot'],
        bookings: List<Map<String, dynamic>>.from(json['bookings'])
            .map(
              (e) => Booking.fromJson(e),
            )
            .toList(),
        fieldSchedule: List<Map<String, dynamic>>.from(json['field_schedule'])
            .map(
              (e) => FieldSchedule.fromJson(e),
            )
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date!.toIso8601String(),
      'time_slot': timeSlot,
      'bookings': bookings
          ?.map(
            (e) => Booking().toJson(),
          )
          .toList(),
      'field_schedule': fieldSchedule
          ?.map(
            (e) => FieldSchedule().toJson(),
          )
          .toList()
    };
  }
}
