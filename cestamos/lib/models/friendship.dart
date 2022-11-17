class Friendship {
  Friendship({
    required this.friendshipId,
    required this.userId,
    required this.username,
  });
  final String username;
  final int userId;
  final int friendshipId;

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      friendshipId: json['friendship_id'] as int,
      userId: json['user_id2'] as int,
      username: json['username2'] as String,
    );
  }
}
