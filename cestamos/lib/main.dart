import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => const MyHomePage(title: 'Cestamos'),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cestamos!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _routes,
    );
  }
}
