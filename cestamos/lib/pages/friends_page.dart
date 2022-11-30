import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './add_friend_page.dart';
import './pending_invites_page.dart';

import '../providers/friendships.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/friendship_tile.dart';
import '../widgets/add_floating_button.dart';

import '../helpers/http-requests/friendship.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});
  static const pageRouteName = "/friends";

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  int _userId = 0;
  String _userName = "";
  String _email = "";

  bool _loaded = false;

  void _refresh() {
    setState(() {
      _loaded = false;
    });
  }

  Future<bool> _getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getInt('user_id') ?? 0;
    _userName = pref.getString('username') ?? "";
    _email = pref.getString('email') ?? "";
    return _userId != 0;
  }

  Future<bool> _getFriendships(Friendships frienshipsProvider) async {
    if (_loaded) return true;
    var response = FriendshipHttpRequestHelper.getFriendships();
    return response.then((value) {
      var friendships = value.content;
      frienshipsProvider.setFriendshipList(friendships);
      _loaded = true;
      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    final friendshipsData = Provider.of<Friendships>(context);
    final friendships = friendshipsData.friendships;
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          FutureBuilder<bool>(
            future: _getUserInfo(),
            builder: (ctx, _) => IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              onPressed: _refresh,
            ),
          ),
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Informações do Usuário'),
                    content: Text(
                      'ID: $_userId\nNome de usuário: $_userName\nemail: $_email',
                    ),
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
              } else if (result == 3) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Deseja mesmo desloggar do Cestamos?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Desloggar',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          // TO DO: implement the logout
                        },
                      ),
                      TextButton(
                        child: const Text('Cancelar'),
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
              const PopupMenuItem(
                value: 3,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<bool>(
        future: _getFriendships(friendshipsData),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return friendships.isEmpty
              ? const Center(
                  child: Text(
                    "Você não tem amigos",
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                );
        }),
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
