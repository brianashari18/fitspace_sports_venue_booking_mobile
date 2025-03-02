import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String firstName;
  String? lastName;
  String password;
  String role;
  String? token;
  Timestamp? tokenExpiredAt;
  String? otp;
  Timestamp? otpExpiredAt;
  String? resetToken;
  Timestamp? resetTokenExpiredAt;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    this.lastName,
    required this.password,
    required this.role,
    this.token,
    this.tokenExpiredAt,
    this.otp,
    this.otpExpiredAt,
    this.resetToken,
    this.resetTokenExpiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, Object?> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      password: json['password'] as String,
      role: json['role'] as String,
      token: json['token'] as String?,
      tokenExpiredAt: json['token_expired_at'] as Timestamp?,
      otp: json['otp'] as String?,
      otpExpiredAt: json['otp_expired_at'] as Timestamp?,
      resetToken: json['reset_token'] as String?,
      resetTokenExpiredAt: json['reset_token_expired_at'] as Timestamp?,
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? role,
    String? token,
    Timestamp? tokenExpiredAt,
    String? otp,
    Timestamp? otpExpiredAt,
    String? resetToken,
    Timestamp? resetTokenExpiredAt,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      role: role ?? this.role,
      token: token ?? this.token,
      tokenExpiredAt: tokenExpiredAt ?? this.tokenExpiredAt,
      otp: otp ?? this.otp,
      otpExpiredAt: otpExpiredAt ?? this.otpExpiredAt,
      resetToken: resetToken ?? this.resetToken,
      resetTokenExpiredAt: resetTokenExpiredAt ?? this.resetTokenExpiredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "role": role,
      "token": token,
      "token_expired_at": tokenExpiredAt,
      "otp": otp,
      "otp_expired_at": otpExpiredAt,
      "reset_token": resetToken,
      "reset_token_expired_at": resetTokenExpiredAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
