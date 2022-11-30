import 'package:flutter/material.dart';

import '../models/user.dart';

class ShowMembersOfListDialog extends StatefulWidget {
  const ShowMembersOfListDialog({
    required this.listMembers,
    required this.selfUser,
    required this.expellUser,
    Key? key,
  }) : super(key: key);

  final List<UserList> listMembers;
  final UserList selfUser;
  final Function expellUser;

  @override
  State<ShowMembersOfListDialog> createState() =>
      _ShowMembersOfListDialogState();
}

class _ShowMembersOfListDialogState extends State<ShowMembersOfListDialog> {
  @override
  Widget build(BuildContext context) {
    // final friendshipsData = Provider.of<Friendships>(context);
    // final friendships = friendshipsData.friendships;
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
                "Membros da lista",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  UserList userList = widget.listMembers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: ListTile(
                        title: Text(
                          userList.userName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        leading: userList.isAdm
                            ? const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.account_circle_rounded,
                                color: Colors.white,
                              ),
                        trailing: ((userList.id == widget.selfUser.id) ||
                                (!widget.selfUser.isAdm))
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Tirar usuário da lista?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              widget.expellUser(
                                                userList.userListId,
                                              );
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "Tirar",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text(
                                              "Cancelar",
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              ),
                      ),
                    ),
                  );
                },
                itemCount: widget.listMembers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
