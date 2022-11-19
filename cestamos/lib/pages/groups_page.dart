import 'package:flutter/material.dart';

// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});
  static const pageRouteName = "/groups";

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Meus grupos aqui!',
            ),
          ],
        ),
      ),
    );
  }
}
