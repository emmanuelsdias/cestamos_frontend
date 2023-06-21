import 'package:flutter/material.dart';

import './form_buton.dart';
import '../models/friendship.dart';
import '../helpers/http-requests/friendship.dart';

class AddNutricionistToShopListDialog extends StatefulWidget {
  const AddNutricionistToShopListDialog({
    required this.addFriend,
    Key? key,
  }) : super(key: key);

  final Function addFriend;

  @override
  State<AddNutricionistToShopListDialog> createState() => _AddNutricionistToShopListDialogState();
}

class _AddNutricionistToShopListDialogState extends State<AddNutricionistToShopListDialog> {
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
                "Nutricionistas",
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            child: ListTile(
                              title: Text(
                                friendship.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            _showConfirmDialog(context, friendship);
                          },
                        ),
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
                    "Quer adicionar o nutricionista ${friendship.username} à lista de compras?",
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
