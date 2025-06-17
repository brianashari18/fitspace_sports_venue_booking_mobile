class User {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? token;
  final DateTime? joinedAt;

  User(
      {this.id,
      this.email,
      this.token,
      this.firstName,
      this.lastName,
      this.joinedAt});

  factory User.empty() {
    return User(
        id: 0,
        email: '',
        token: '',
        firstName: '',
        lastName: '',
        joinedAt: DateTime.now());
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        token: json['token'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        joinedAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
      'first_name': firstName,
      'last_name': lastName,
      'created_at': joinedAt
    };
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName: $lastName, createdAt: $joinedAt)';
  }
}
