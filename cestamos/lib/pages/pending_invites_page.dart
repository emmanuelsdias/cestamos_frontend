import 'package:cestamos/models/invitation.dart';
import 'package:flutter/material.dart';

import '../helpers/http-requests/invitation.dart';

class PendingInvitesPage extends StatefulWidget {
  const PendingInvitesPage({super.key});
  static const pageRouteName = "/pendinginvites";

  @override
  State<PendingInvitesPage> createState() => _PendingInviteState();
}

class _PendingInviteState extends State<PendingInvitesPage> {
  bool _loaded = false;
  List<Invitation> _invitations = [];

  void _refresh() {
    setState(() {
      _loaded = false;
    });
  }

  Future<bool> _getInvitations() async {
    if (_loaded) return true;
    var response = InvitationHttpRequestHelper.getInvitations();
    return response.then((value) {
      var invitations = value.content;
      _invitations = [...invitations];
      _loaded = true;
      return value.success;
    });
  }

  Future<bool> _answerInvitation(int invitationId, bool accepted) async {
    var response =
        InvitationHttpRequestHelper.answerInvitation(invitationId, accepted);
    return response.then(
      (value) {
        setState(() {
          _loaded = false;
        });
        return value.success;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convites Pendentes"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _refresh();
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
          future: _getInvitations(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (_invitations.isEmpty) {
              return const Center(
                child: Text(
                  "Sem convites pendentes.",
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: _getListInvitations(),
              ),
            );
          }),
    );
  }

  List<Padding> _getListInvitations() => _invitations
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
                            _answerInvitation(invitation.id, true);
                          });
                        }), // icon-1

                    IconButton(
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Color.fromARGB(218, 245, 0, 0),
                        ),
                        onPressed: () {
                          _answerInvitation(invitation.id, false);
                        }), // icon-1
                    // icon-2
                  ],
                ),
              )))))
      .values
      .toList();
}
