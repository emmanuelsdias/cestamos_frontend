class Friendship {
  Friendship({
    this.friendshipId = 0,
    this.userId = 0,
    this.username = "",
  });
  final String username;
  final int userId;
  final int friendshipId;

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      friendshipId: json['friendship_id'] as int,
      userId: json['user_id'] as int,
      username: json['username'] as String,
    );
  }
}
