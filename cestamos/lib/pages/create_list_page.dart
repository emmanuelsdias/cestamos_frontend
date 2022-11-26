import 'package:flutter/material.dart';

import '../models/friendship.dart';
import '../widgets/friendship_tile.dart';
import '../widgets/cestamos_bar.dart';
import '../widgets/shop_create_friend_select_dialog.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({Key? key}) : super(key: key);

  static const pageRouteName = "/create_list";

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Friendship> _invitedFriendships = [];
  String _listName = "";

  bool isInvited(Friendship friendship) {
    return _invitedFriendships.contains(friendship);
  }

  void addToInvited(Friendship friendship) {
    setState(() {
      if (!isInvited(friendship)) _invitedFriendships.add(friendship);
    });
  }

  void removeFromInvited(Friendship friendship) {
    setState(() {
      if (isInvited(friendship)) {
        _invitedFriendships.removeWhere(
          (element) => element.userId == friendship.userId,
        );
      }
    });
  }

  void createList() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_listName.isNotEmpty) {
      // criar lista
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Criar nova lista",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Nome da lista",
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Dê um nome à sua lista!";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                onChanged: (listName) {
                  if (listName.isNotEmpty) {
                    _listName = listName;
                  }
                },
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Amigos convidados:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (_invitedFriendships.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => FriendshipTile(
                    friendship: _invitedFriendships[index],
                  ),
                  itemCount: _invitedFriendships.length,
                ),
              ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return ShopCreateFriendSelectDialog(
                        invitedFriendships: _invitedFriendships,
                        addFriend: addToInvited,
                        removeFriend: removeFromInvited);
                  },
                );
              },
              child: const Text("Editar convidados"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: createList,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 56),
                  maximumSize: const Size(200, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadowColor: Colors.transparent,
                  primary: Theme.of(context).colorScheme.inversePrimary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Criar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.add,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
