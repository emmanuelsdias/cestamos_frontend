import 'package:cestamos/models/invitation.dart';
import 'package:flutter/material.dart';

class PendingInvitesPage extends StatefulWidget {
  const PendingInvitesPage({super.key});
  static const pageRouteName = "/pendinginvites";

  @override
  State<PendingInvitesPage> createState() => _PendingInviteState();
}

class _PendingInviteState extends State<PendingInvitesPage> {
  List<Invitation> invitations = [
    Invitation(id: 0, userId: 01, userName: "Ariel", email: "xyz@gmail.com"),
    Invitation(
        id: 1, userId: 02, userName: "Gandhi", email: "xyzgandhi@gmail.com"),
    Invitation(id: 2, userId: 2612, userName: "Supi", email: "supigmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convites Pendentes"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: _getListInvitations()),
      ),
    );
  }

  List<Padding> _getListInvitations() => invitations
      .asMap()
      .map((i, invitation) => MapEntry(
          i,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                  child: ListTile(
                leading: const Icon(Icons
                    .person), // O usuário deverá ser capaz de escolher um ícone dentre os disponíveis.
                title: Text(
                  invitation.userName,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    decorationThickness: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(
                          Icons.check_circle,
                          color: Color.fromARGB(255, 57, 245, 0),
                        ),
                        onPressed: () {
                          setState(() {
                            acceptInvitation();
                          });
                        }), // icon-1

                    IconButton(
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Color.fromARGB(218, 245, 0, 0),
                        ),
                        onPressed: () {
                          setState(() {
                            deleteInvitation();
                          });
                        }), // icon-1
                    // icon-2
                  ],
                ),
              )))))
      .values
      .toList();

  void deleteInvitation() {
    // TO DO: INTEGRATION WITH BACKEND
  }
  void acceptInvitation() {
    // TO DO: INTEGRATION WITH BACKEND
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      Invitation invitation = invitations[oldIndex];

      invitations.removeAt(oldIndex);
      invitations.insert(newIndex, invitation);
    });
  }
}
