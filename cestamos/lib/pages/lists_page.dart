import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});
  static const pageRouteName = "/lists";

  // final String title;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  // int _counter = 0;

  // List<User> _users = [];
  // bool _usersAreLoaded = false;

  // void _loadUsers() async {
  //   var users = await UserHttpRequestHelper.getUsers();

  //   setState(() {
  //     _users = users;
  //     _usersAreLoaded = true;
  //   });
  // }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }
  int _selectedItemPosition = 2;

  @override
  Widget build(BuildContext context) {
    // if (!_usersAreLoaded) {
    //   _loadUsers();
    // }
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          '../assets/images/cestamos_logo_white.svg',
          // fit: BoxFit.contain,
          height: 28,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Minhas listas aqui!',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        elevation: 2,
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        snakeViewColor: Theme.of(context).colorScheme.inversePrimary,
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,

        // showUnselectedLabels: true,
        // showSelectedLabels: true,
        // selectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        // unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'listas'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'grupos'),
          BottomNavigationBarItem(icon: Icon(Icons.child_care), label: 'amigos'),
          // BottomNavigationBarItem(icon: Icon(Icons.cookie_outlined ), label: 'receitas')
          BottomNavigationBarItem(icon: Icon(Icons.liquor), label: 'receitas')
        ],
      ),
    );
  }
}
