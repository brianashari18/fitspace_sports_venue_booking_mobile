import 'package:cloud_firestore/cloud_firestore.dart';

class FieldScheduleModel {
  String id;
  String status;
  String fieldId;
  String scheduleId;

  FieldScheduleModel({
    required this.id,
    required this.status,
    required this.fieldId,
    required this.scheduleId,
  });

  factory FieldScheduleModel.fromJson(Map<String, Object?> json) {
    return FieldScheduleModel(
      id: json['id'] as String,
      status: json['status'] as String,
      fieldId: json['field_id'] as String,
      scheduleId: json['schedule_id'] as String,
    );
  }

  FieldScheduleModel copyWith({
    String? status,
    String? fieldId,
    String? scheduleId,
  }) {
    return FieldScheduleModel(
      id: id,
      status: status ?? this.status,
      fieldId: fieldId ?? this.fieldId,
      scheduleId: scheduleId ?? this.scheduleId,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "status": status,
      "field_id": fieldId,
      "schedule_id": scheduleId,
    };
  }
}
