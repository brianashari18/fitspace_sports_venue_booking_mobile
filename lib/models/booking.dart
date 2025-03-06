import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String id;
  String status;
  String customerId;
  String scheduleId;
  Timestamp createdAt;

  BookingModel({
    required this.id,
    required this.status,
    required this.customerId,
    required this.scheduleId,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, Object?> json) {
    return BookingModel(
      id: json['id'] as String,
      status: json['status'] as String,
      customerId: json['customer_id'] as String,
      scheduleId: json['schedule_id'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  BookingModel copyWith({
    String? status,
    String? customerId,
    String? scheduleId,
    Timestamp? createdAt,
  }) {
    return BookingModel(
      id: id,
      status: status ?? this.status,
      customerId: customerId ?? this.customerId,
      scheduleId: scheduleId ?? this.scheduleId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "status": status,
      "customer_id": customerId,
      "schedule_id": scheduleId,
      "created_at": createdAt,
    };
  }
}
