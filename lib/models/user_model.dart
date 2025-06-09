class User {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? token;

  User({
    this.id,
    this.email,
    this.token,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        token: json['token'],
        firstName: json['first_name'],
        lastName: json['last_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
      'first_name': firstName,
      'last_name': lastName
    };
  }
}
