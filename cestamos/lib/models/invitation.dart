class Invitation {
  final int id;
  final int userId;
  final String userName;
  final String email;

  Invitation({
    this.id = 0,
    this.userId = 0,
    this.userName = "",
    this.email = "",
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['invitation_id'] as int,
      userId: json['user_id1'] as int,
      userName: json['username1'] as String,
    );
  }
}
