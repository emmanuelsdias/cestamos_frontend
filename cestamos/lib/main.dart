import 'package:flutter/material.dart';

import 'pages/home_page.dart';
// import 'pages/landing_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/lists_page.dart';
// import 'pages/groups_page.dart';
// import 'pages/friends_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => const MyHomePage(title: 'Cestamos'),
    // LandingPage.pageRouteName: (BuildContext context) => const LandingPage(),
    RegisterPage.pageRouteName: (BuildContext context) => const RegisterPage(),
    LoginPage.pageRouteName: (BuildContext context) => const LoginPage(),
    ListsPage.pageRouteName: (BuildContext context) => const ListsPage(),
    // GroupsPage.pageRouteName:   (BuildContext context) => const GroupsPage(),
    // FriendsPage.pageRouteName:  (BuildContext context) => const FriendsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cestamos!',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF25548D),
          onPrimary: Colors.white,
          inversePrimary: Color(0xFFE9476D),
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.black,
          onError: Colors.red,
          background: Color(0xFFE4E4E4),
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        fontFamily: 'Nexa',
      ),
      routes: _routes,
    );
  }
}
