import 'package:flutter/material.dart';
import '../models/friendship.dart';
import '../helpers/http-requests/friendship.dart';

class FriendshipTile extends StatelessWidget {
  const FriendshipTile({Key? key, required this.friendship}) : super(key: key);

  final Friendship friendship;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        title: Text(friendship.username),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Deseja mesmo deletar a amizade?'),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                        style: TextStyle(color: Colors.redAccent), 'Deletar'),
                    onPressed: () {
                      // TO DO: implement the logout
                      FriendshipHttpRequestHelper.deleteFriendship(
                          friendship.friendshipId,
                          friendship.userId,
                          friendship.username);
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
          },
        ),
      ),
    );
  }
}
