import 'dart:io';

class RegisterModel {
  RegisterModel(
    this.profile_pic, {
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final File? profile_pic;

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        json['profile_pic']);
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'profile_pic': profile_pic,
    };
  }
}
