import 'package:cestamos/pages/add_friend_page.dart';
import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
import '../widgets/friendship_tile.dart';
import '../widgets/add_floating_button.dart';
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
