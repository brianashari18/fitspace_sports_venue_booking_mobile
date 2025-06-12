import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class FieldService {
  final _baseUrl =
      "http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}/api";

  Future<Map<String, dynamic>> loadFieldByVenueId(User user, int venueId) async {
    try {

      final response = await http.get(
          Uri.parse('$_baseUrl/$venueId/fields'),
          headers: {'Authorization': 'Bearer ${user.token}'}
      );

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

  Future<Map<String, dynamic>> loadField(User user, int fieldId) async {
    try {

      final response = await http.get(
          Uri.parse('$_baseUrl/venues/fields/$fieldId'),
          headers: {'Authorization': 'Bearer ${user.token}'}
      );

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