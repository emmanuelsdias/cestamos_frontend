import 'package:flutter/material.dart';

import '../models/friendship.dart';
import '../helpers/http-requests/friendship.dart';

class ShopCreateFriendSelectDialog extends StatefulWidget {
  const ShopCreateFriendSelectDialog({
    required this.invitedFriendships,
    required this.addFriend,
    required this.removeFriend,
    Key? key,
  }) : super(key: key);

  final List<Friendship> invitedFriendships;
  final Function removeFriend;
  final Function addFriend;

  @override
  State<ShopCreateFriendSelectDialog> createState() => _ShopCreateFriendSelectDialogState();
}

class _ShopCreateFriendSelectDialogState extends State<ShopCreateFriendSelectDialog> {
  bool _isInvited(Friendship friendship) {
    return widget.invitedFriendships.contains(friendship);
  }

  List<Friendship> _friendships = [];

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
    return Dialog(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Convidados",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<bool>(
                future: _getFriendships(),
                builder: (ctx, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var success = snapshot.data!;
                  if (!success) {
                    return const Center(
                      child: Text("Algo de errado aconteceu. Tente novamente mais tarde!"),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      Friendship friendship = _friendships[index];
                      return ListTile(
                        leading: Checkbox(
                          value: _isInvited(friendship),
                          onChanged: (value) {
                            setState(() {
                              if (value != null && value) {
                                widget.addFriend(friendship);
                              } else {
                                widget.removeFriend(friendship);
                              }
                            });
                          },
                        ),
                        title: Text(friendship.username),
                      );
                    },
                    itemCount: _friendships.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
