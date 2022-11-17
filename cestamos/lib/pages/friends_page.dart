import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
import '../widgets/friendship_tile.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';
import '../models/friendship.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});
  static const pageRouteName = "/friends";

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final friendships = <Friendship>[
    Friendship(
      friendshipId: 1,
      userId: 1,
      username: "Gandhi",
    ),
    Friendship(
      friendshipId: 2,
      userId: 2,
      username: "Educado",
    ),
    Friendship(
      friendshipId: 3,
      userId: 3,
      username: "MM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(
        title: "Amigos",
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: friendships.isEmpty
          ? const Center(
              child: Text(
                "Você não tem listas",
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {},
                  child: FriendshipTile(
                    friendship: friendships[index],
                  ),
                );
              },
              itemCount: friendships.length,
            ),
    );
  }
}
