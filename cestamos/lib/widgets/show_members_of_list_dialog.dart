import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './form_buton.dart';
import '../providers/friendships.dart';

import '../models/user.dart';
import '../models/friendship.dart';

class ShowMembersOfListDialog extends StatefulWidget {
  const ShowMembersOfListDialog({
    required this.listMembers,
    required this.selfUser,
    Key? key,
  }) : super(key: key);

  final List<UserList> listMembers;
  final UserList selfUser;

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
                                onPressed: null,
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
