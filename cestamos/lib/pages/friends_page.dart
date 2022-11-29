import 'package:cestamos/pages/add_friend_page.dart';
import 'package:cestamos/pages/pending_invites_page.dart';
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
          IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              onPressed: () {
                setState(() {
                  refreshFriendsList();
                });
              }),
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
              } else if (result == 1) {
                Navigator.of(context).pushNamed(AddFriendPage.pageRouteName);
              } else if (result == 2) {
                Navigator.of(context)
                    .pushNamed(PendingInvitesPage.pageRouteName);
              }
            },
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: Text('Informações do usuário'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('Adicionar amigo'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Convites pendentes'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: friendships.isEmpty
          ? const Center(
              child: Text(
                "Você não tem amigos",
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Meus Amigos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => {},
                          child: Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FriendshipTile(
                                friendship: friendships[index],
                              ),
                            ),
                          ));
                    },
                    itemCount: friendships.length,
                  ),
                ),
              ],
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

  void refreshFriendsList() {
    // TO DO: IMPLEMENT THE REFRESH WITH THE BACKEND
  }
}
