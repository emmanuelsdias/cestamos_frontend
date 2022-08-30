class User {
  int? id;
  String? userName;
  String? email;

  User({
    this.id,
    this.userName,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
    );
  }
}
