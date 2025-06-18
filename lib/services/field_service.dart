import 'dart:io';

import 'package:fitspace_sports_venue_booking_mobile/models/photo_model.dart';
import 'package:fitspace_sports_venue_booking_mobile/models/venue_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import '../models/field_model.dart';
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

  Future<Map<String, dynamic>> create(User user, Venue venue, String type, int price, List<File> files) async {
    try {
      final uri = Uri.parse('$_baseUrl/${venue.id}/fields/create');
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer ${user.token}',
      });

      request.fields['field'] = json.encode({
        'type': type,
        'price': price,
      });

      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
          'files',
          file.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();


      if (response.statusCode == 202) {
        final body = await response.stream.bytesToString();
        final data = json.decode(body);
        return {
          'success': true,
          'data': data['data'],
        };
      } else if (response.statusCode == 400) {
        final body = await response.stream.bytesToString();
        final data = json.decode(body);
        return {'success': false, 'error': data['errors']};
      } else {
        final body = await response.stream.bytesToString();
        final data = json.decode(body);
        return {'success': false, 'error': data['errors']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> update(User user, Venue venue, Field field, String type, int price, List<File> files, List<String> removedImages) async {
    try {
      final uri = Uri.parse('$_baseUrl/${venue.id}/fields/${field.id}/update');
      var request = http.MultipartRequest('PATCH', uri);

      request.headers.addAll({
        'Authorization': 'Bearer ${user.token}',
      });

      request.fields['field'] = json.encode({
        'type': type,
        'price': price,
        'removedImages': removedImages
      });

      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
          'files',
          file.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();


      if (response.statusCode == 202) {
        final body = await response.stream.bytesToString();
        final data = json.decode(body);
        return {
          'success': true,
          'data': data['data'],
        };
      } else if (response.statusCode == 400) {
        final body = await response.stream.bytesToString();
        final data = json.decode(body);
        return {'success': false, 'error': data['errors']};
      } else {
        final body = await response.stream.bytesToString();
        final data = json.decode(body);
        return {'success': false, 'error': data['errors']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> delete(User user, Venue venue, Field field) async {
    try {

      final response = await http.delete(
          Uri.parse('$_baseUrl/${venue.id}/fields/${field.id}/delete'),
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