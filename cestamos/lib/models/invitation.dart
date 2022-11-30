class Invitation {
  final int id;
  final int userId;
  final String userName;
  final String email;

  Invitation({
    required this.id,
    required this.userId,
    required this.userName,
    required this.email,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'] as int,
      userId: json['userId'] as int,
      userName: json['username'] as String,
      email: json['email'] as String,
    );
  }
}
