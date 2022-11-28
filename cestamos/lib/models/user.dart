class User {
  int? id;
  String? userName;
  String? email;
  String? token;
  String? password;

  User({
    this.id,
    this.userName,
    this.email,
    this.token,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'] as int?,
      userName: json['username'] as String?,
      email: json['email'] as String?,
      token: json['token'] ?? "",
      password: json['password'] ?? "",
    );
  }
}
