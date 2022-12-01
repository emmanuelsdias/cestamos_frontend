import 'package:flutter/material.dart';

import '../models/friendship.dart';

import '../helpers/http-requests/shop_list.dart';

import '../widgets/friendship_create_list_tile.dart';
import '../widgets/cestamos_bar.dart';
import '../widgets/form_buton.dart';
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

  Future<bool> _createList() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    var userIds = _invitedFriendships.map((e) => e.userId).toList();
    var response = ShopListHttpRequestHelper.createList(_listName, userIds);
    return response.then((value) {
      return value.success;
    });
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
        child: SingleChildScrollView(
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: _invitedFriendships.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) => FriendshipCreateListTile(
                            friendship: _invitedFriendships[index],
                          ),
                          itemCount: _invitedFriendships.length,
                        ),
                      )
                    : Expanded(
                        child: Container(),
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
              FormButton(
                text: "Criar",
                icon: Icons.add,
                onPressed: () {
                  _createList();
                  Navigator.of(context).pop();
                },
                option: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              FormButton(
                text: "Cancelar",
                icon: Icons.cancel,
                onPressed: () => Navigator.of(context).pop(),
                option: 2,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
