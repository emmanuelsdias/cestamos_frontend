import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/friendships.dart';
import '../models/friendship.dart';

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
  State<ShopCreateFriendSelectDialog> createState() =>
      _ShopCreateFriendSelectDialogState();
}

class _ShopCreateFriendSelectDialogState
    extends State<ShopCreateFriendSelectDialog> {
  bool _isInvited(Friendship friendship) {
    return widget.invitedFriendships.contains(friendship);
  }

  @override
  Widget build(BuildContext context) {
    final friendshipsData = Provider.of<Friendships>(context);
    final friendships = friendshipsData.friendships;
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
              child: ListView.builder(
                itemBuilder: (_, index) {
                  Friendship friendship = friendships[index];
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
                itemCount: friendships.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
