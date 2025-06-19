import 'package:fitspace_sports_venue_booking_mobile/models/schedule_model.dart';

class FieldSchedule {
  final int? id;
  final String? status;
  final int? fieldId;
  final int? scheduleId;
  final Schedule? schedule;

  FieldSchedule({this.id, this.status, this.fieldId, this.scheduleId, this.schedule});

  factory FieldSchedule.fromJson(Map<String, dynamic> json) {
    return FieldSchedule(
      id: json['id'],
      status: json['status'],
      fieldId: json['field_id'],
      scheduleId: json['schedule_id'],
      schedule: json['schedule'] != null ? Schedule.fromJson(json['schedule']) : Schedule.empty()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'field_id': fieldId,
      'schedule_id': scheduleId,
      'schedule': schedule!.toJson()
    };
  }

  @override
  String toString() {
    return 'FieldSchedule(id: $id, status: $status, fieldId: $fieldId, scheduleId: $scheduleId, schedule: $schedule)';
  }
}
