import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthService {
  final _baseUrl =
      "http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}/api/users";
  final UserService _userService = UserService();

  Map<String, dynamic> _handleError(http.Response response) {
    final body = json.decode(response.body);
    return {'success': false, 'error': body['errors']};
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final responseLogin = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (responseLogin.statusCode == 200) {
        final body = json.decode(responseLogin.body);
        final token = body['token'];

        final responseUser = await http.get(
          Uri.parse('$_baseUrl/current'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (responseUser.statusCode == 200) {
          final userBody = json.decode(responseUser.body);
          final userData = userBody['data'];

          final user = User(
            id: userData['id'],
            email: email,
            token: token,
            firstName: userData['firstName'],
            lastName: userData['lastName'],
          );
          await _userService.saveUser(user);

          return {'success': 'true', 'user': user};

        } else if (responseUser.statusCode == 400) {
          return _handleError(responseUser);

        } else {
          return _handleError(responseUser);
        }

      } else if (responseLogin.statusCode == 401) {
        return {'success': false, 'error': 'Wrong username or password'};

      } else {
        return {
          'success': false,
          'error': 'Failed to login. Please try again.'
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> register(String email, String firstName, String lastName, String password, String confirmPassword) async {
    try {
      final responseRegister = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'password': password,
          'confirmPassword': confirmPassword
        }),
      );

      if (responseRegister.statusCode == 200) {
        final body = json.decode(responseRegister.body);
        return {
          'success': 'true',
          'id': body['data']['id'],
          'email': email,
        };
      } else if (responseRegister.statusCode == 400) {
        return _handleError(responseRegister);
      } else {
        return _handleError(responseRegister);
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {
          'success': 'true',
          'message': body['message'],
        };
      } else if (response.statusCode == 400) {
        return _handleError(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> validateOTP(int otp) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/validate-otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'otp': otp}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {
          'success': 'true',
          'message': body['message'],
        };
      } else if (response.statusCode == 400) {
        return _handleError(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String newPassword, String confirmPassword, String email) async {
    try {

      final response = await http.post(
        Uri.parse('$_baseUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
          'email': email
        }),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {
          'success': 'true',
          'message': body['message'],
        };
      } else if (response.statusCode == 400) {
        return _handleError(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> changeUsername(User user, String firstName, String lastName) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/changeUsername/${user.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
        body: json.encode({
          'firstName': firstName,
          'lastName' : lastName
        }),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {'success': 'true', 'data': body['data']};
      } else if (response.statusCode == 400) {
        return _handleError(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> changePassword(
      User user, String password, String confirmPassword) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/changePassword/${user.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.token}'
        },
        body: json.encode({
          'password' : password,
          'confirmPassword' : confirmPassword
        }),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return {'success': 'true', 'data': body['data']};
      } else if (response.statusCode == 400) {
        return _handleError(response);
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }
}


