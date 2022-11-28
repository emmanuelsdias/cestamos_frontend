import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './form_buton.dart';
import '../providers/friendships.dart';
import '../models/friendship.dart';

class AddFriendToShopListDialog extends StatefulWidget {
  const AddFriendToShopListDialog({
    required this.addFriend,
    Key? key,
  }) : super(key: key);

  final Function addFriend;

  @override
  State<AddFriendToShopListDialog> createState() =>
      _AddFriendToShopListDialogState();
}

class _AddFriendToShopListDialogState extends State<AddFriendToShopListDialog> {
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
                "Amigos",
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
                  return GestureDetector(
                    child: ListTile(
                      title: Text(friendship.username),
                    ),
                    onTap: () {
                      _showConfirmDialog(context, friendship);
                    },
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

  void _showConfirmDialog(BuildContext context, Friendship friendship) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            color: Colors.white,
            // TODO: correct width, not changing anything (ta 0.7)
            width: MediaQuery.of(context).size.width * 0.6,
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Quer adicionar ${friendship.username} à lista de compras?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  FormButton(
                      text: "Sim",
                      icon: Icons.person_add,
                      onPressed: () {
                        widget.addFriend(friendship);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  FormButton(
                    text: "Não",
                    icon: Icons.cancel,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    option: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
