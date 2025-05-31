import 'dart:convert';
import 'dart:math';

import 'package:crypt/crypt.dart';
import 'package:fitspace_sports_venue_booking_mobile/services/user_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class GoogleService {
  final UserService _userService = UserService();
  final _baseUrl = "http://${dotenv.env["HOST"]}:${dotenv.env["PORT"]}/api";

  final _googleSignIn = GoogleSignIn(clientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'], scopes: [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
    'openid'
  ]);

  Future<Map<String, dynamic>> login() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      print(user);
      if (user != null) {
        final GoogleSignInAuthentication googleAuth = await user.authentication;
        final idToken = googleAuth.idToken;
        final accessToken = googleAuth.accessToken;
        final clientId = _googleSignIn.clientId!;

        if (accessToken != null && idToken != null) {
          final response = await _sendTokensToBackend(
              accessToken, idToken, clientId, user);
          return response;
        }
      }
      return {'success': false, 'message': 'User login failed'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> _sendTokensToBackend(String accessToken,
      String idToken, String clientId, GoogleSignInAccount user) async {
    final requestBody = <String, dynamic>{
      "access_token": accessToken,
      "id_token": idToken,
      "client_id": clientId
    };

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/google'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final user = body['data'];
        final token = user['token'];

        final responseUser = await http.get(
          Uri.parse('$_baseUrl/users/current'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (responseUser.statusCode == 200) {
          final userBody = json.decode(responseUser.body);
          final userData = userBody['data'];

          final user = User(
            id: userData['id'],
            email: userData['email'],
            token: token,
            firstName: userData['firstName'],
            lastName: userData['lastName'],
          );
          await _userService.saveUser(user);

          return {
            'success': true,
            'user': user
          };
        } else if (responseUser.statusCode == 400) {
          final body = json.decode(responseUser.body);
          return {'success': false, 'error': body['errors']};
        } else {
          final body = json.decode(responseUser.body);
          return {'success': false, 'error': body['errors']};
        }
      } else {
        return {
          'success': false,
          'error': 'Failed to authenticate with backend: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Error: $e'};
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
  }

  GoogleSignInAccount? getCurrentUser() => _googleSignIn.currentUser;

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  Future<void> disconnect() async {
    await _googleSignIn.disconnect();
  }
}
