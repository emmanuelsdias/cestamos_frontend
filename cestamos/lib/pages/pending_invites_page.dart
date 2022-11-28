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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convites Pendentes"),
      ),
      body: ListView(
        children: _getListInvitations(),
      ),
    );
  }

  List<Widget> _getListInvitations() => invitations
      .asMap()
      .map((i, invitation) => MapEntry(
          i,
          ListTile(
            title: Text(
              invitation.userName,
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: false,
              // // style: TextStyle(
              //   // decoration:
              //      // ? TextDecoration.lineThrough
              //       // : TextDecoration.none,
              //   // decorationThickness: 2,
              //   color: Colors.black,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          )))
      .values
      .toList();

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
