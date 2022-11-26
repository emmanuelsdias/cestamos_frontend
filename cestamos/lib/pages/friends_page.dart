import 'package:cestamos/pages/add_friend_page.dart';
import 'package:cestamos/providers/friendships.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/friendship_tile.dart';
import '../widgets/add_floating_button.dart';
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
      appBar: CestamosBar(
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Informações do Usuário'),
                    content: const Text('Seu ID é 33'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: Text('Aqui aparecera suas informacoes'),
              ),
            ],
          ),
        ],
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
      floatingActionButton: AddFloatingButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddFriendPage.pageRouteName),
      ),

      // FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.of(context).pushNamed(AddFriendPage.pageRouteName),
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   tooltip: 'Add Friend',
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
