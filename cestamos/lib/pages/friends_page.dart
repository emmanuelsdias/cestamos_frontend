import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import './add_friend_page.dart';
import './pending_invites_page.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/friendship_tile.dart';
import '../widgets/add_floating_button.dart';

import '../helpers/http-requests/friendship.dart';
import '../models/friendship.dart';

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

  List<Friendship> _friendships = [];

  Future<bool> _getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getInt('user_id') ?? 0;
    _userName = pref.getString('username') ?? "";
    _email = pref.getString('email') ?? "";
    return _userId != 0;
  }

  Future<void> _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<bool> _getFriendships() async {
    var response = FriendshipHttpRequestHelper.getFriendships();
    return response.then((value) {
      var friendships = value.content;
      setState(() {
        _friendships = friendships;
      });
      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          FutureBuilder<bool>(
            future: _getUserInfo(),
            builder: (ctx, _) => IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              onPressed: _getFriendships,
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
                Navigator.of(context).pushNamed(PendingInvitesPage.pageRouteName);
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
                          _logout();
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacementNamed('/');
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
        future: _getFriendships(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return _friendships.isEmpty
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
                            child: FriendshipTile(
                              friendship: _friendships[index],
                            ),
                          );
                        },
                        itemCount: _friendships.length,
                      ),
                    ),
                  ],
                );
        }),
      ),
      floatingActionButton: AddFloatingButton(
        onPressed: () => Navigator.of(context).pushNamed(AddFriendPage.pageRouteName),
      ),
    );
  }
}
