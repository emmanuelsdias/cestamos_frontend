import 'package:flutter/material.dart';
import '../models/user.dart';

import '../helpers/http-requests/user.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const pageRouteName = "/landing";

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _counter = 0;

  List<User> _users = [];
  bool _usersAreLoaded = false;

  void _loadUsers() async {
    var users = await UserHttpRequestHelper.getUsers();

    setState(() {
      _users = users;
      _usersAreLoaded = true;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_usersAreLoaded) {
      _loadUsers();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cestamos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (_usersAreLoaded)
              Text(
                'Número de usuários: ${_users[0].userName}',
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
