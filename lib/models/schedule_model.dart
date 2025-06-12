import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/field_schedule_model.dart';

import 'booking_model.dart';

class Schedule {
  final int? id;
  final DateTime? date;
  final String? timeSlot;

  Schedule(
      {this.id, this.date, this.timeSlot});

  factory Schedule.empty() {
    return Schedule(
      id: null,
      date: null,
      timeSlot: null,
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['id'],
        date: DateTime.parse(json['date'] as String),
        timeSlot: json['time_slot']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date!.toIso8601String(),
      'time_slot': timeSlot,
    };
  }

  @override
  String toString() {
    return 'Schedule(id: $id, date: $date, timeSlot: $timeSlot)';
  }
}
