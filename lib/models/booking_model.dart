import 'package:fitspace_sports_venue_booking_mobile/models/schedule_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';

class Booking {
  final int? id;
  final String? status;
  final int? customerId;
  final int? scheduleId;
  final int? fieldId;
  final User? customer;
  final Schedule? schedule;

  Booking({this.id,
    this.status,
    this.customerId,
    this.scheduleId,
    this.fieldId,
    this.customer,
    this.schedule});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        id: json['id'],
        status: json['status'],
        customerId: json['customer_id'],
        scheduleId: json['schedule_id'],
        fieldId: json['field_id'],
        customer: json['customer'],
        schedule: json['schedule']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'customer_id': customerId,
      'schedule_id': scheduleId,
      'field_id': fieldId,
      'customer': customer,
      'schedule': schedule,
    };
  }
}
