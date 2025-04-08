class User {
  final int id;
  final String email;
  final String firstName;
  final String? lastName;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.token,
    required this.firstName,
    this.lastName,
  });
}
