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

class UserList {
  int id;
  String userName;
  bool isAdm;
  bool isNutritionist;
  int userListId;

  UserList({
    this.id = 0,
    this.userName = "",
    this.isAdm = false,
    this.isNutritionist = false,
    this.userListId = 0,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['user_id'] ?? 0,
      userName: json['username'] ?? "",
      isAdm: json['is_adm'] ?? false,
      isNutritionist: json['is_nutritionist'] ?? false,
      userListId: json['user_list_id'] ?? 0,
    );
  }
}
