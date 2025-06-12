import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/field_model.dart';
import '../models/user_model.dart';

class BookingService {
  final _baseUrl = "http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}/api";

  Future<Map<String, dynamic>> create(User user, Venue venue, Field field,
      DateTime date, String timeSlot) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/${venue.id}/bookings/create'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          },
          body: json.encode({
            "date": date.toString(),
            "time_slot": timeSlot,
            "type": field.type
          }));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {
          'success': true,
          'data': body['data'],
        };
      } else if (response.statusCode == 400) {
        final body = json.decode(response.body);
        return {'success': false, 'error': body['errors']};
      } else {
        final body = json.decode(response.body);
        return {'success': false, 'error': body['errors']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }
}
