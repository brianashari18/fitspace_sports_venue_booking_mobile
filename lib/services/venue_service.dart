import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class VenueService{
  final _baseUrl =
      "http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}/api/venues";

  // Create Venue
  Future<Map<String, dynamic>> create(User user, String name, String phoneNumber, String street, String district,
      String cityOrRegency, String province, String postalCode, double latitude, double longitude ) async{
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },

        body: json.encode({
          'name': name,
          'phone_number': phoneNumber,
          'street': street,
          'district': district,
          'city_or_regency': cityOrRegency,
          'province': province,
          'postal_code': postalCode,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {'success': 'true', 'data': body['data']};
      } else if (response.statusCode == 400) {
        final body = json.decode(response.body);
        return {'success': false, 'error': body['errors']};
      } else {
        final body = json.decode(response.body);
        return {'success': false, 'error': body['errors']};
      }
    }catch(e){
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  // Get All venue
Future<Map<String,dynamic>> loadVenue(User user) async {
    try {
      final response = await http.get(
          Uri.parse(_baseUrl),
          headers: {'Authorization': 'Bearer ${user.token}'}
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {'success': 'true', 'data': body['data']};
      } else if (response.statusCode == 400) {
        final body = json.decode(response.body);
        return {'success': false, 'error': body['errors']};
      } else {
        final body = json.decode(response.body);
        return {'success': false, 'error': body['errors']};
      }
    }catch (e){
      return {'success': false, 'error': 'Error: $e'};
    }
 }
}