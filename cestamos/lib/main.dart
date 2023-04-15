import 'package:cestamos/pages/pending_invites_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/friendships.dart';
import 'pages/create_list_page.dart';
import 'pages/landing_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/recipe_detail_page.dart';
import 'pages/logged_screen.dart';
import 'pages/one_list_page.dart';
import 'pages/add_friend_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => const LoginPage(),
    // '/': (BuildContext context) => const LoggedScreen(),
    LandingPage.pageRouteName: (BuildContext context) => const LandingPage(),
    LoginPage.pageRouteName: (BuildContext context) => const LoginPage(),
    RegisterPage.pageRouteName: (BuildContext context) => const RegisterPage(),
    LoggedScreen.pageRouteName: (BuildContext context) => const LoggedScreen(),
    OneListPage.pageRouteName: (BuildContext context) => const OneListPage(),
    AddFriendPage.pageRouteName: (BuildContext context) =>
        const AddFriendPage(),
    CreateListPage.pageRouteName: (BuildContext context) =>
        const CreateListPage(),
    PendingInvitesPage.pageRouteName: (BuildContext context) =>
        const PendingInvitesPage(),
    RecipeDetailPage.pageRouteName: (BuildContext context) => const RecipeDetailPage(),
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Friendships(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}
