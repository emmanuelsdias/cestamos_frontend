import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  static const pageRouteName = "/recipes";

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(
        title: "Receitas",
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Minhas receitas aqui!',
            ),
          ],
        ),
      ),
    );
  }
}
