import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  String id;
  String date;
  String timeSlot;
  Timestamp createdAt;
  Timestamp updatedAt;

  ScheduleModel({
    required this.id,
    required this.date,
    required this.timeSlot,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleModel.fromJson(Map<String, Object?> json) {
    return ScheduleModel(
      id: json['id'] as String,
      date: json['date'] as String,
      timeSlot: json['time_slot'] as String,
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  ScheduleModel copyWith({
    String? date,
    String? timeSlot,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return ScheduleModel(
      id: id,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "date": date,
      "time_slot": timeSlot,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
