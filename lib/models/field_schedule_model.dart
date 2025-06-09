class FieldSchedule {
  final int? id;
  final String? status;
  final int? fieldId;
  final int? scheduleId;

  FieldSchedule({this.id, this.status, this.fieldId, this.scheduleId});

  factory FieldSchedule.fromJson(Map<String, dynamic> json) {
    return FieldSchedule(
      id: json['id'],
      status: json['status'],
      fieldId: json['field_id'],
      scheduleId: json['schedule_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'field_id': fieldId,
      'schedule_id': scheduleId
    };
  }
}
