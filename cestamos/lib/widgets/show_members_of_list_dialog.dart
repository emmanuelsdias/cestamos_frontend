import 'package:flutter/material.dart';

import '../models/user.dart';
import '../widgets/form_buton.dart';

class ShowMembersOfListDialog extends StatefulWidget {
  const ShowMembersOfListDialog({
    required this.listMembers,
    required this.selfUser,
    required this.expellUser,
    required this.changeUserStatus,
    Key? key,
  }) : super(key: key);

  final List<UserList> listMembers;
  final UserList selfUser;
  final Function expellUser;
  final Function changeUserStatus;

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
                                  color: Colors.white,
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
                        onTap: ((userList.id == widget.selfUser.id) ||
                                (!widget.selfUser.isAdm))
                            ? null
                            : () {
                                _showAdminChangeDialog(context, userList);
                              },
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

  void _showAdminChangeDialog(BuildContext context, UserList userList) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            color: Colors.white,
            // TODO: correct width, not changing anything (ta 0.7)
            width: MediaQuery.of(context).size.width * 0.6,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    userList.isAdm
                        ? "O usuário ${userList.userName} já é administrador. Deseja remover seu privilégio de administrador?"
                        : "O usuário ${userList.userName} não é administrador. Deseja torná-lo administrador?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  userList.isAdm
                      ? FormButton(
                          text: "Sim, remover",
                          icon: Icons.account_circle_rounded,
                          onPressed: () {
                            widget.changeUserStatus(userList.userListId, false);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          })
                      : FormButton(
                          text: "Sim, tornar ",
                          icon: Icons.star_rounded,
                          onPressed: () {
                            widget.changeUserStatus(userList.userListId, true);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }),
                  const SizedBox(
                    height: 20,
                  ),
                  FormButton(
                    text: "Cancelar",
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
