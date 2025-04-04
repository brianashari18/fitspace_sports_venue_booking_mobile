import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id);
    prefs.setString('email', user.email);
    prefs.setString('token', user.token);
    prefs.setString('firstName', user.firstName);
    if(user.lastName != null) {
      prefs.setString('lastName', user.lastName!);
    }

  }
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    final email = prefs.getString('email');
    final token = prefs.getString('token');
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');

    if (id != null && email != null && token != null && firstName != null && lastName != null) {
      return User(id: id, email: email, token: token, firstName: firstName, lastName: lastName);
    }

    return null;
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('email');
    prefs.remove('token');
  }
}
