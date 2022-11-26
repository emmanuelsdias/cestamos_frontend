import 'package:cestamos/providers/friendships.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/friendship_tile.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});
  static const pageRouteName = "/friends";

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    final friendshipsData = Provider.of<Friendships>(context);
    final friendships = friendshipsData.friendships;
    return Scaffold(
      appBar: const CestamosBar(),
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
