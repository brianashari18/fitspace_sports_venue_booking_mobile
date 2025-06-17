import 'package:fitspace_sports_venue_booking_mobile/models/field_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/schedule_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/user_model.dart';

class Booking {
  final int? id;
  final String? status;
  final User? customer;
  final Field? field;
  final Schedule? schedule;

  Booking({this.id,
    this.status,
    this.field,
    this.customer,
    this.schedule});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        id: json['id'],
        status: json['status'],
        field: json['field'] != null ? Field.fromJson(json['field']) : Field.empty(),
        customer: json['customer'] != null ? User.fromJson(json['customer']) : User.empty(),
        schedule: json['schedule'] != null ? Schedule.fromJson(json['schedule']) : Schedule.empty());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'field': field,
      'customer': customer,
      'schedule': schedule,
    };
  }

  @override
  String toString() {
    return 'Booking(id: $id, status: $status, field: $field, customer: $customer, schedule: $schedule)';
  }
}
