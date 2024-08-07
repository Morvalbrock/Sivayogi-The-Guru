class UserModel {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String profile_pic;

  UserModel(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.password,
      required this.profile_pic});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      profile_pic: json['profile_pic'] ?? '',
    );
  }
}
